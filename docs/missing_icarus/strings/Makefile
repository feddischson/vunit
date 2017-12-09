
.PHONY: all
all: string_example

string_example: string_example.sv
	iverilog -o string_example string_example.sv -g2012

clean:
	rm string_example

