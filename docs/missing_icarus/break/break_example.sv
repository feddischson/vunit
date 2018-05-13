module break_example;
integer i;
initial begin
  integer i;
  for( i=0; i < 5; i=i+1 ) begin
    $display( "%d\n", i);
    if (i==2) begin
      continue;
    end
  end
end
endmodule
