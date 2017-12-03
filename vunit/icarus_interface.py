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


    def compile_source_file_command(self, source_file):
        """
        Returns the command to compile a single source file
        """
        if source_file.is_any_verilog:
            return self.compile_verilog_file_command(source_file)

        LOGGER.error("Unknown file type: %s", source_file.file_type)
        raise CompileError

    def compile_verilog_file_command(self, source_file):
        """
        Returns the command to compile a verilog file
        """
        args = [join(self._prefix, 'iverilog'), '-tvvp' ]
        if source_file.is_system_verilog:
            args += ["-g2012"]

        args += ['-work', source_file.library.name, source_file.name]

        for library in self._libraries:
            args += ["-l%s" % library.name]
        for include_dir in source_file.include_dirs:
            args += ["-I%s" % include_dir]
        for key, value in source_file.defines.items():
            args += ["-D%s=%s" % (key, value)]
        return args


    def compile_source_files(self, project, continue_on_error=False):
        """
        Use compile_source_file_command to compile all source_files
        """
        dependency_graph = project.create_dependency_graph()
        all_ok = True
        failures = []
        source_files = project.get_files_in_compile_order(dependency_graph=dependency_graph)
        source_files_to_skip = set()
        t = NamedTemporaryFile( delete=False )
        args = [join(self._prefix, 'iverilog'), '-tvvp', '-c', t.name ]
        has_sv = False
        LOGGER.debug( "Creating temporary compilation file %s " %  t.name )

        for library in self._libraries:
            args += ["-l%s" % library.name]

        for source_file in source_files:
            if source_file in source_files_to_skip:
                LOGGER.info("Skipping %s due to failed dependencies" % simplify_path(source_file.name))
                continue


            if not source_file.is_any_verilog:
                LOGGER.error("Unknown file type: %s", source_file.file_type)
                raise CompileError

            t.write( bytes( source_file.name + "\n", 'UTF-8'  ) )
            LOGGER.info('Adding %s to compilation file ...' % (simplify_path(source_file.name) ) )


            if source_file.is_system_verilog:
                has_sv = True

            # TODO: this is not nice! Can this be handled better?
            # vunit has includes and defines individually for each file,
            # icarus takes it together
            for include_dir in source_file.include_dirs:
                args += ["-I%s" % include_dir]
            for key, value in source_file.defines.items():
                args += ["-D%s=%s" % (key, value)]

        t.close()

        # use the '-g2012' flag if there is any SystemVerilog file
        if has_sv:
            args += ["-g2012"]

        try:
            success = run_command( args, env=self.get_env() )
        except:
            LOGGER.error("Unexpected compilation error")

        LOGGER.debug( "Removing temporary compilation file %s " %  t.name )
        os.unlink(t.name)
        if not success:
            LOGGER.error("Failed to compile sources")
            raise CompileError


