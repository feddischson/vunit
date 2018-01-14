# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2017, Christian Haettich (feddischson@gmail.com)
"""
Interface towards Icarus Verilog simulator
"""


from __future__ import print_function

import logging
import sys
import io
import os
from tempfile import NamedTemporaryFile
from os.path import join, dirname, abspath
from vunit.ostools import simplify_path

try:
    # Python 3
    from configparser import RawConfigParser
except ImportError:
    # Python 2
    from ConfigParser import RawConfigParser  # pylint: disable=import-error

from vunit.ostools import Process, file_exists
from vunit.simulator_interface import (SimulatorInterface,
                                       ListOfStringOption,
                                       StringOption,
                                       run_command)
from vunit.exceptions import CompileError

LOGGER = logging.getLogger(__name__)


class IcarusInterface(SimulatorInterface):  # pylint: disable=too-many-instance-attributes
    """
    Icarus interface

    The interface supports....
    """
    name = "vsim"
    supports_gui_flag = False
    package_users_depend_on_bodies = False

    compile_options = [ ]

    sim_options = [ ]


    @classmethod
    def from_args(cls, output_path, args):
        """
        Create new instance from command line arguments object
        """

        return cls( prefix=cls.find_prefix() )

    @classmethod
    def find_prefix_from_path(cls):
        """
        Find first valid icarus toolchain prefix
        """

        return cls.find_toolchain(["iverilog"],
                                  constraints=[])


    def __init__(self, prefix ):
        SimulatorInterface.__init__(self)
        self._prefix = prefix
        self._libraries = []


        self._compile_cmd = [];



    def compile_source_files(self, project, printer, continue_on_error=False):
        """
        This prepares the compilation by creating a `vunit.cf` file
        and by setting self._compile_cmd.
        Both are later used in `simulate` to compile the design before running
        the simulation. 
        This is different to other simulators due to Icarus internal structure,
        where the elaboration is done within the `iverilog` call. 
        Due to paramter-overwriting and the `runner_cfg` parameter, the elaboration
        must be done in vunit's `simulate` step.
        """
        dependency_graph = project.create_dependency_graph()
        all_ok = True
        failures = []
        source_files = project.get_files_in_compile_order(dependency_graph=dependency_graph)
        source_files_to_skip = set()
        has_sv = False
        self._compile_cmd = [];

        cf_path = join( self._output_path, "vunit.cf" )

        with open( cf_path, "w+" ) as vunit_cf:

            self._compile_cmd = [join(self._prefix, 'iverilog'), '-tvvp', '-c', cf_path ]

            for library in self._libraries:
                self._compile_cmd += ["-l%s" % library.name]


            max_source_file_name = 0
            if source_files:
                max_source_file_name = max(len(simplify_path(source_file.name)) for source_file in source_files)

            for source_file in source_files:
                printer.write('Checking for compilation %s' 
                        % (simplify_path(source_file.name)+":").ljust(max_source_file_name+2) )

                if source_file in source_files_to_skip:
                    LOGGER.info("Skipping %s due to failed dependencies" % simplify_path(source_file.name))
                    printer.write("skipped", fg="rgi")
                    printer.write("\n")
                    continue


                if not source_file.is_any_verilog:
                    printer.write("failed (unknown file type)", fg="ri")
                    LOGGER.error("Unknown file type: %s", source_file.file_type)
                    raise CompileError

                printer.write("added", fg="gi")
                printer.write("\n")
                vunit_cf.write( source_file.name + "\n" )
                LOGGER.info('Adding %s to compilation file ...' % (simplify_path(source_file.name) ) )


                if source_file.is_system_verilog:
                    has_sv = True

                # TODO: this is not nice! Can this be handled better?
                # vunit has includes and defines individually for each file,
                # icarus takes it together
                for include_dir in source_file.include_dirs:
                    self._compile_cmd += ["-I%s" % include_dir]
                for key, value in source_file.defines.items():
                    self._compile_cmd += ["-D%s=%s" % (key, value)]


        # use the '-g2012' flag if there is any SystemVerilog file
        if has_sv:
            self._compile_cmd += ["-g2012"]


    def simulate(self, output_path, test_suite_name, config, elaborate_only):

        # ensure, that the output-folder exists
        if not run_command( ["mkdir", output_path] ):
            LOGGER.error("Failed to create output-directory " + output_path)
            raise OSError("Failed to create output-directory " + output_path)

        # path of the binary after calling `iverilog` (compilation+elaboration) 
        bin_path = join( output_path, self.name )

        # parameter-args and output-args as lists
        param_args = []
        for name, value in config.generics.items():

            # runner_cfg gets an extra treatment:
            if name == 'runner_cfg':
                param_args += [ '-P', "%s.%s=\"%s\"" % (config.entity_name, name, value) ]
            else:
                param_args += [ '-P', "%s.%s=%s" % (config.entity_name, name, value) ]
        output_args = [ "-o", bin_path ]

        # run the compilation command within `output_path`
        success = run_command( self._compile_cmd + output_args + param_args, cwd=output_path, env=self.get_env() )
        if not success:
            LOGGER.error("Failed to compile sources")
            raise CompileError

        # run the simulation command within `output_path`
        if not elaborate_only:
            try:
                args = [join(self._prefix, "vvp"), "-n", bin_path, "-lxt2" ]

                success = run_command( args, cwd=output_path, env=self.get_env() )
            except:
                LOGGER.error("Failed to run simulation")
                return False
        return True


