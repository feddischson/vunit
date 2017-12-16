
Missing Features
==================
Missing Icarus (10.2) features required for vunit:
 - break statements (see `vunit/verilog/vunit_defines.svh` `\`define CHECK_EQUAL` )
 - Simple immediate assertion statements (see `vunit/verilog/vunit_defines.svh` `\`define CHECK_EQUAL` )
 - Enums within classes (see `vunit/verilog/vunit_pkg.sv`, https://github.com/steveicarus/iverilog/issues/177)
 - SV queues inside classes (see `vunit/verilog/vunit_pkg.sv`)
 - An command line option to set or override parameters of a device when calling `vvp`
