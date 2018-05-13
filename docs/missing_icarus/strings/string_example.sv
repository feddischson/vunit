module string_example;
  function int example( string my_string );
    if( my_string[0] ) begin
      return 1;
    end else begin
      return 0;
    end
  endfunction
endmodule
