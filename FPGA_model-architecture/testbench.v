`timescale 1ns/10ps

module nnctrl_tb ;
	reg			clock, reset ;
	reg			input_signal ;
	reg[15:0]	in ;
	wire		category ;
	// wire[15:0]	cur ;
	
	reg[15:0]	i ;
	
	nnctrl nn ( reset, clock, input_signal, in, category ) ;

	initial // reset、clock
	begin
		clock = 1'b0 ;
		reset = 1'b0 ;
		input_signal = 1'b0 ;
		i = 16'd0 ;
		#10
		reset = 1'b1 ;
		#10
		reset = 1'b0 ;
		
		#100 ;
		for ( i = 0 ; i < 1000 ; i = i+1 ) begin
			in = i ;
			input_signal = 1'b1 ;
			#40 ;
			input_signal = 1'b0 ;
			#40 ;
		end
		#1000 ;
		// $stop ;
	end
	always #10 clock = clock + 1'b1; 


endmodule