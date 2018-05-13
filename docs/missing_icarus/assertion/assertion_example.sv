module assertion_example;
integer i;
initial begin
  integer i;
  assert( 1==1 ) else
  begin
    $display( "something went wrong");
  end
end
endmodule
