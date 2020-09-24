`timescale 1ns/10ps

module nnctrl_tb ;
	reg clock, reset ;
	reg [7:0] in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19,  in20, count, tmp ;
	wire category ;
	wire [7:0] output_data_test, ram_dout1_test, weight_dout1_test ;
	
	nnctrl t ( reset, clock, count, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19,  in20, category, output_data_test, ram_dout1_test, weight_dout1_test ) ;

	initial // reset、clock
	begin
		clock = 0 ;
		reset = 0 ;
		#10
		reset = 1 ;
		#10
		reset = 0 ;
		#10 ;
		count = 0 ;
		in1 = 8'h00 ; in2 = 8'h00 ; in3 = 8'h00 ; in4 = 8'h00 ; in5 = 8'h00 ; in6 = 8'h00 ; in7 = 8'h00 ; in8 = 8'h00 ; in9 = 8'h00 ; in10 = 8'h00 ; in11 = 8'h00 ; in12 = 8'h00 ; in13 = 8'h00 ; in14 = 8'h00 ; in15 = 8'h00 ; in16 = 8'h00 ; in17 = 8'h00 ; in18 = 8'h00 ; in19 = 8'h00 ;  in20 = 8'h00 ;
		for ( tmp = 0 ; tmp < 25 ; tmp = tmp+1 ) begin
			#20 ; 
			count = tmp+tmp ;
			in1 = 8'h00 ; in2 = 8'h00 ; in3 = 8'h01 ; in4 = 8'h01 ; in5 = 8'h00 ; in6 = 8'h00 ; in7 = 8'h00 ; in8 = 8'h00 ; in9 = 8'h00 ; in10 = 8'h00 ; in11 = 8'h00 ; in12 = 8'h00 ; in13 = 8'h00 ; in14 = 8'h00 ; in15 = 8'h00 ; in16 = 8'h00 ; in17 = 8'h00 ; in18 = 8'h00 ; in19 = 8'h00 ;  in20 = 8'h00 ;
			#200 ;
			// first input data
			count = tmp+tmp+1 ;
			in1 = 8'h01 ; in2 = 8'h01 ; in3 = 8'h00 ; in4 = 8'h00 ; in5 = 8'h00 ; in6 = 8'h00 ; in7 = 8'h00 ; in8 = 8'h00 ; in9 = 8'h00 ; in10 = 8'h00 ; in11 = 8'h00 ; in12 = 8'h00 ; in13 = 8'h00 ; in14 = 8'h00 ; in15 = 8'h00 ; in16 = 8'h00 ; in17 = 8'h00 ; in18 = 8'h00 ; in19 = 8'h00 ;  in20 = 8'h00 ;
		end
		#20 ;
		// last input data
		count = 0 ;
		in1 = 8'h00 ; in2 = 8'h00 ; in3 = 8'h01 ; in4 = 8'h01 ; in5 = 8'h00 ; in6 = 8'h00 ; in7 = 8'h00 ; in8 = 8'h00 ; in9 = 8'h00 ; in10 = 8'h00 ; in11 = 8'h00 ; in12 = 8'h00 ; in13 = 8'h00 ; in14 = 8'h00 ; in15 = 8'h00 ; in16 = 8'h00 ; in17 = 8'h00 ; in18 = 8'h00 ; in19 = 8'h00 ;  in20 = 8'h00 ;
		// ---------------------------weight---------------------
		#20 ;
		count = 0 ;
		in1 = 8'h10 ; in2 = 8'h10 ; in3 = 8'h10 ; in4 = 8'h10 ; in5 = 8'h10 ; in6 = 8'h10 ; in7 = 8'h10 ; in8 = 8'h10 ; in9 = 8'h10 ; in10 = 8'h10 ; in11 = 8'h10 ; in12 = 8'h10 ; in13 = 8'h10 ; in14 = 8'h10 ; in15 = 8'h10 ; in16 = 8'h10 ; in17 = 8'h10 ; in18 = 8'h10 ; in19 = 8'h10 ;  in20 = 8'h10 ;
		for ( tmp = 0 ; tmp < 100 ; tmp = tmp+1 ) begin
			#20 ; count = 1 ;
			#20 ; count = 2 ;
			#20 ; count = 3 ;
			#20 ; count = 4 ;
			#20 ; count = 5 ;
			#20 ; count = 6 ;
			#20 ; count = 7 ;
			#20 ; count = 8 ;
			#20 ; count = 9 ;
			#20 ; count = 10 ;
			#20 ; count = 11 ;
			#20 ; count = 12 ;
			#20 ; count = 13 ;
			#20 ; count = 14 ;
			#20 ; count = 15 ;
			#20 ; count = 16 ;
			#20 ; count = 17 ;
			#20 ; count = 18 ;
			#20 ; count = 19 ;
			#20 ; count = 20 ;
			#20 ; count = 21 ;
			#20 ; count = 22 ;
			#20 ; count = 23 ;
			#20 ; count = 24 ;
			#20 ; count = 25 ;
			#20 ; count = 26 ;
			#20 ; count = 27 ;
			#20 ; count = 28 ;
			#20 ; count = 29 ;
			#20 ; count = 30 ;
			#20 ; count = 31 ;
			#20 ; count = 32 ;
			#20 ; count = 33 ;
			#20 ; count = 34 ;
			#20 ; count = 35 ;
			#20 ; count = 36 ;
			#20 ; count = 37 ;
			#20 ; count = 38 ;
			#20 ; count = 39 ;
			#20 ; count = 40 ;
			#20 ; count = 41 ;
			#20 ; count = 42 ;
			#20 ; count = 43 ;
			#20 ; count = 44 ;
			#20 ; count = 45 ;
			#20 ; count = 46 ;
			#20 ; count = 47 ;
			#20 ; count = 48 ;
			#20 ; count = 49 ;
			#20 ; count = 50 ;
			#60 ; count = 0 ;
			#1000 ; count = 0 ;
		end
		#20 ; count = 1 ;
		#20 ; count = 2 ;
		#20 ; count = 3 ;
		#20 ; count = 4 ;
		#20 ; count = 5 ;
		#60 ; count = 0 ;
		#100 ; count = 0 ;
		#20 ; count = 1 ;
		#20 ; count = 2 ;
		#20 ; count = 3 ;
		#20 ; count = 4 ;
		#20 ; count = 5 ;
		#60 ; count = 0 ;
		#100 ; #60 $stop ;
	end
	always #10 clock = clock + 1; 


endmodule