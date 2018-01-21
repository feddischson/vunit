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
    sim_options = [
        ListOfStringOption("icarus.vvp_flags")
    ]


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


        self._basic_command = [ join(self._prefix, 'iverilog'), '-tvvp', '-g2012', '-c' ]


    def compile_source_files(self, project, printer, continue_on_error=False):
        """
        """
        self._toplevel_units = {}
        self._dependency_graph = project.create_dependency_graph()
        all_ok = True
        failures = []
        source_files = project.get_files_in_compile_order(dependency_graph=self._dependency_graph)

        for source_file in source_files:
            dependent_nodes = self._dependency_graph.get_dependent( [source_file] ) 
            if len( dependent_nodes ) == 1 and source_file in dependent_nodes:
                # This must be a root-node because nothing depends on this

                for unit in source_file.design_units:
                    self._toplevel_units[ unit.name ] = source_file


    def simulate(self, output_path, test_suite_name, config, elaborate_only):

        # Ensure that the unit exists in our top-files.
        if not ( config.design_unit_name in self._toplevel_units ):
            LOGGER.error( "Unit {0} can't be found in {1}".format( 
                config.design_unit_name, self._toplevel_units.keys() ) )
            raise CompileError( "Unit {0} can't be found.".format(
                config.design_unit_name )  )

        # the top source-file which contains the `TEST_CASE` statement
        # of this simulation run
        top_src      = self._toplevel_units[ config.design_unit_name ]

        # All dependent file of `top_src`.
        source_files = self._dependency_graph.get_dependencies( [ top_src ] )

        # All sorted source files (including all top-files)
        all_sorted_source_files = self._dependency_graph.toposort( )

        # All top-files (which usually but not necessary contain the test-benches)
        all_top_src = self._toplevel_units.values()

        # Get a sorted list where only one top-file is at the end.
        sorted_source_files = []
        for s in all_sorted_source_files:

            # Note: the second part `or s not in all_top_src` is
            # required because vunit doesn't detect situations where
            # a module is used within generate.
            # With this, we ensure, that all non-top sources are 
            # considered.
            # TODO fix the issue in Vunit (parser.py) and remove
            # the `or` part
            if s in source_files or s not in all_top_src:
                sorted_source_files.append( s )

        # ensure, that the output-folder exists
        if not run_command( ["mkdir", output_path] ):
            LOGGER.error("Failed to create output-directory " + output_path)
            raise OSError("Failed to create output-directory " + output_path)

        # path of the verilog cf file, where all required verilog files are written
        cf_path = join( output_path, "vunit.cf" )

        compile_cmd  = [];
        with open( cf_path, "w+" ) as vunit_cf:

            compile_cmd = [join(self._prefix, 'iverilog'), '-tvvp', '-g2012', '-c', cf_path ]

            for library in self._libraries:
                compile_cmd += ["-l%s" % library.name]

            added_include_paths = []
            added_defines       = []
            for source_file in sorted_source_files:

                if not source_file.is_any_verilog:
                    LOGGER.error("Unknown file type: %s", source_file.file_type)
                    raise CompileError

                vunit_cf.write( source_file.name + "\n" )
                LOGGER.info('Adding %s to compilation file ...' % (simplify_path(source_file.name) ) )

                # TODO: this is not nice! Can this be handled better?
                # vunit has includes and defines individually for each file,
                # icarus takes it together
                for include_dir in source_file.include_dirs:
                    if not include_dir in added_include_paths:
                        compile_cmd += ["-I%s" % include_dir]
                        added_include_paths.append( include_dir )
                for key, value in source_file.defines.items():
                    if not key in added_defines:
                        compile_cmd += ["-D%s=%s" % (key, value)]
                        added_defines.append( key )


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
        success = run_command( compile_cmd + output_args + param_args, cwd=output_path, env=self.get_env() )
        if not success:
            LOGGER.error("Failed to compile sources")
            raise CompileError

        # run the simulation command within `output_path`
        if not elaborate_only:
            try:
                sim_options = config.sim_options.get('icarus.vvp_flags' ) or [];
                args = [join(self._prefix, "vvp"), "-n", "-lxt2" ] + sim_options + [ bin_path ]
                success = run_command( args, cwd=output_path, env=self.get_env() )
            except Exception as e:
                LOGGER.error(e)
                LOGGER.error("Failed to run simulation")
                return False
        return True


