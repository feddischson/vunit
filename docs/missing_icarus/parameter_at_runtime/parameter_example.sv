module parameter_example;

//
// It shall be possible to set `my_param` during runtime
// and not during compile-time.
//
// This is not possible at the moment, but a workaround
// is using $value$plusargs:
//
// vpp parameter_example +MY_PARAM_2=abc
//
parameter my_param = "";


initial begin

  string my_param_2 = "";
  $value$plusargs( "MY_PARAM_2=%s", my_param_2);

  if( my_param == "" ) begin

     if( my_param_2 != "" ) begin
       $error("my_param is empty, but my_param_2 is set: %s", my_param_2);
     end else begin
       $error("my_param is empty");
    end

  end else begin
    $display("my_param is %s", my_param);
  end
end



endmodule
