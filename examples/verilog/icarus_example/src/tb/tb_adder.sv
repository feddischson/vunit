`include "vunit_defines.svh"


module tb_adder;

   localparam integer clk_period = 20;
   parameter integer D_WIDTH  = 32;
   reg                       clk = 0;
   logic                     rst;
   logic [D_WIDTH  -1:0]      a;
   logic [D_WIDTH  -1:0]      b;
   logic [D_WIDTH+1-1:0]      c;

   `TEST_SUITE begin

      `TEST_SUITE_SETUP begin
         rst = 1;
         @(posedge clk);
         @(posedge clk);
         rst = 0;
      end

      `TEST_CASE("positive_example") begin
         a = 2;
         b = 3;
         @(posedge clk);
         @(negedge clk);
         `CHECK_EQUAL( c, 5 );
         a = 0;
         b = 0;
         @(posedge clk);
         @(negedge clk);
         `CHECK_EQUAL( c, 0 );
      end

      `TEST_CASE("another_test") begin
         a = 5;
         b = 10;
         @(posedge clk);
         @(negedge clk);
         `CHECK_EQUAL( c, 15 );
         a = 20;
         b = 20;
         @(posedge clk);
         @(negedge clk);
         `CHECK_EQUAL( c, 40 );
      end

      `TEST_CASE("negative_example") begin
         a = 2;
         b = 3;
         @(posedge clk);
         @(negedge clk);
         `CHECK_EQUAL( c, 8 );
      end
   end

  always #(clk_period/2) clk = !clk;

   adder #(
     .D_WIDTH( D_WIDTH )
   ) dut( .* );

endmodule
