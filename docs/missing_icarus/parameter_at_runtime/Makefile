
.PHONY: all
all: parameter_example

parameter_example: parameter_example.sv
	iverilog -o parameter_example parameter_example.sv -g2012

clean:
	rm parameter_example

