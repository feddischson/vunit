module parameter_example;

//
// It shall be possible to set `my_param` during runtime
// and not during compile-time.
//
parameter my_param = "";

initial begin
  if( my_param == "" ) begin
     $error("my_param is empty");
  end else begin
    $display("my_param is %s", my_param);
  end
end



endmodule
