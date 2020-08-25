`timescale 1ns/10ps

module nnctrl_tb ;
	reg clock, reset ;

	nnctrl t ( reset, clock );

	initial // reset、clock
	begin
	  clock = 0 ;
	  reset = 0 ;
	  #10
	  reset = 1 ;
	  #10
	  reset = 0 ;
	  #10 ;
	end
	always #10 clock = clock + 1; 


endmodule