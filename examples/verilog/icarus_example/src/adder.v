
module adder(
  clk,
  rst,
  a,
  b,
  c
);

parameter D_WIDTH   = 16;

input                         clk;
input                         rst;
input      [D_WIDTH  -1:0]      a;
input      [D_WIDTH  -1:0]      b;
output reg [D_WIDTH+1-1:0]      c;

always @(posedge clk) 
  if(rst) begin
    c <= 0;
  end else begin
    c <= a + b;
  end
endmodule
