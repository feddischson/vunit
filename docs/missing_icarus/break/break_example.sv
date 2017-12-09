module break_example;
integer i;
initial begin
  for( integer i=0; i < 5; i=i+1 ) begin
    $display( "%d\n", i);
    break;
  end
end
endmodule
