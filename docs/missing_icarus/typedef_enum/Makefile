
.PHONY: all
all: class_example 

class_example: class_example.sv
	iverilog -o class_example class_example.sv -g2012

clean:
	rm class_example

