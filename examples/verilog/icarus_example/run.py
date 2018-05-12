# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2014-2015, Lars Asplund lars.anders.asplund@gmail.com
# Copyright (c) 2017, Christian Haettich feddischson@gmail.com

from os.path import join, dirname
from vunit.verilog import VUnit

ui = VUnit.from_argv()

src_path = join(dirname(__file__), "src")

adder_lib = ui.add_library("adder_lib")
adder_lib.add_source_files(join(src_path, "*.v"))

tb_adder_lib = ui.add_library("tb_adder_lib")
tb_adder_lib.add_source_files(join(src_path, "tb", "*.sv"))

ui.set_parameter("D_WIDTH", 10)

ui.main()
