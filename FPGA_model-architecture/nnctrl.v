`timescale 1ns/10ps
`define WIDTH 32

module nnctrl ( reset, clk, count, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, category, output_data, ram_dout1, weight_dout1  ) ;
	
	input reset, clk ;
	input[7:0] count, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20 ;
	output category ;
	reg layer, fin ;
	reg [9:0] n, i, base ;
	reg enRam, enRam2, r_w, r_w2, zero, insign, insign2, isbias, startsign, storeweight ;
	wire [7:0] ram_dout2, ram_dout3, ram_dout4, ram_dout5, ram_dout6, ram_dout7, ram_dout8, ram_dout9, ram_dout10, ram_dout11, ram_dout12, ram_dout13, ram_dout14, ram_dout15, ram_dout16, ram_dout17, ram_dout18, ram_dout19,  ram_dout20 ;
	wire [7:0] weight_dout2, weight_dout3, weight_dout4, weight_dout5, weight_dout6, weight_dout7, weight_dout8, weight_dout9, weight_dout10, weight_dout11, weight_dout12, weight_dout13, weight_dout14, weight_dout15, weight_dout16, weight_dout17, weight_dout18, weight_dout19,  weight_dout20 ;
	// wire [7:0] output_data ;
	output [7:0] output_data, ram_dout1, weight_dout1 ;	// test here wire->output
	reg [15:0] abus, abus2 ;
	
	memory ram1 ( reset, clk, enRam, r_w, abus, insign, output_data, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19,  in20, ram_dout1, ram_dout2, ram_dout3, ram_dout4, ram_dout5, ram_dout6, ram_dout7, ram_dout8, ram_dout9, ram_dout10, ram_dout11, ram_dout12, ram_dout13, ram_dout14, ram_dout15, ram_dout16, ram_dout17, ram_dout18, ram_dout19,  ram_dout20 ) ;
	
	memory ram2 ( reset, clk, enRam2, r_w2, abus2, insign2, output_data, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19,  in20, weight_dout1, weight_dout2, weight_dout3, weight_dout4, weight_dout5, weight_dout6, weight_dout7, weight_dout8, weight_dout9, weight_dout10, weight_dout11, weight_dout12, weight_dout13, weight_dout14, weight_dout15, weight_dout16, weight_dout17, weight_dout18, weight_dout19,  weight_dout20 ) ;
	
	neural n1 ( reset, zero, clk, output_data, isbias, ram_dout1, ram_dout2, ram_dout3, ram_dout4, ram_dout5, ram_dout6, ram_dout7, ram_dout8, ram_dout9, ram_dout10, ram_dout11, ram_dout12, ram_dout13, ram_dout14, ram_dout15, ram_dout16, ram_dout17, ram_dout18, ram_dout19,  ram_dout20, weight_dout1, weight_dout2, weight_dout3, weight_dout4, weight_dout5, weight_dout6, weight_dout7, weight_dout8, weight_dout9, weight_dout10, weight_dout11, weight_dout12, weight_dout13, weight_dout14, weight_dout15, weight_dout16, weight_dout17, weight_dout18, weight_dout19,  weight_dout20, output_data ) ;
	
	classfier c ( reset, fin, ram_dout1, ram_dout2, category ) ;
	
	always@( posedge reset or posedge clk ) begin
		// excute next
		if ( reset ) begin
			layer = 0 ;
			base = 0 ;
			enRam = 0 ;
			enRam2 = 0 ;
			zero = 1 ;
			r_w = 0 ;
			r_w2 = 0 ;
			n = 0 ;
			i = 0 ;
			abus = 0 ;
			abus2 = 0 ;
			insign = 0 ;
			isbias = 0 ;
			startsign = 0 ;
			storeweight = 0 ;
			// enRam = 1 ;
			// r_w = 1 ;
			// enRom = 1 ;
		end
		// get data
		else if ( startsign == 0 ) begin
			// store input data to ram 50 data per clock
			// 1000 input needs 20 clocks
			r_w = 0 ;	// write
			enRam = 1 ;
			abus = 20*count ;
			// i = i+1 ;
			if ( count == 49 ) begin
				startsign = 1 ;
				// abus = 0 ;
				// enRam = 1 ;
				// enRam2 = 1 ;
				// r_w = 1 ;
			end
		end
		else if ( layer == 0 ) begin
			if ( n == 100 ) begin
				// next layer
				// base = addr+1 ;
				layer = 1 ;
				n = 0 ;
				i = 0 ;
				insign = 0 ;
				enRam = 0 ;
				enRam2 = 1 ;
				abus = 1001 ;
				abus2 = 0 ;
				r_w = 1 ;
				r_w2 = 0 ;
				// enRom = 0 ;
				isbias = 0 ;
			end
			else if ( storeweight == 0  ) begin
				r_w2 = 0 ;	// write
				enRam = 0 ;
				enRam2 = 1 ;
				abus2 = 20*count ;
				// i = i+1 ;
				if ( count == 50 ) begin
					// 50 -> bias
					storeweight = 1 ;
					abus = 0 ;
					abus2 = 0 ;
					enRam = 1 ;
					r_w = 1 ;
					r_w2 = 1 ;
				end
			end
			else if ( i == 51 ) begin
				// write back ram
				enRam = 1 ;
				r_w = 0 ;
				enRam2 = 1 ;
				// r_w2 = 0 ;
				abus = n+1001 ;
				n = n+1 ;
				i = 0 ;
				insign = 1 ;
				isbias = 0 ;
				storeweight = 0 ;
			end
			else begin
				if ( i == 0 )
					zero = 1 ;
				else
					zero = 0 ;
				i = i+1 ;
				abus = i*20 ;
				// addr = i*50+n*1001 ;
				abus2 = i*20 ;
				enRam = 1 ;
				r_w = 1 ;
				enRam2 = 1 ;
				r_w2 = 1 ;
				insign = 0 ;
				isbias = 0 ;
				if ( i == 51 )				// 50? 51?
					isbias = 1 ;
			end
		end
		else if ( layer == 1 ) begin
			if ( fin == 1 ) begin
				layer = 0 ;
				base = 0 ;
				enRam = 0 ;
				enRam2 = 0 ;
				zero = 1 ;
				r_w = 0 ;
				r_w2 = 0 ;
				n = 0 ;
				i = 0 ;
				abus = 0 ;
				abus2 = 0 ;
				insign = 0 ;
				isbias = 0 ;
				startsign = 0 ;
				storeweight = 0 ;
				fin = 0 ;
			end
			else if ( n == 2 ) begin
				n = 0 ;
				i = 0 ;
				insign = 0 ;
				isbias = 0 ;
				enRam = 1 ;
				abus = 0 ;
				r_w = 1 ;		// read
				fin = 1 ;
				// $stop ;
			end
			else if ( storeweight == 0  ) begin
				r_w2 = 0 ;	// write
				enRam = 0 ;
				enRam2 = 1 ;
				abus2 = 20*count ;
				// i = i+1 ;
				if ( count == 5 ) begin
					storeweight = 1 ;
					// abus2 = 0 ;
					// enRam2 = 0 ;
					// r_w2 = 1 ;
					storeweight = 1 ;
					abus = 1001 ;
					abus2 = 0 ;
					enRam = 1 ;
					enRam2 = 1 ;
					r_w = 1 ;
					r_w2 = 1 ;
				end
			end
			else if ( i == 6 ) begin
				enRam = 1 ;
				r_w = 0 ;
				enRam2 = 0 ;
				r_w2 = 0 ;
				abus = n ;
				n = n+1 ;
				i = 0 ;
				insign = 1 ;
				isbias = 0 ;
				storeweight = 0 ;
			end
			else begin
				if ( i == 0 )
					zero = 1 ;
				else
					zero = 0 ;
				abus = i*20+1001 ;
				// addr = i*50+n*101+100100 ;
				abus2 = i*20 ;
				i = i+1 ;
				enRam = 1 ;
				r_w = 1 ;
				enRam2 = 1 ;
				r_w2 = 1 ;
				insign = 0 ;
				isbias = 0 ;
				if ( i == 6 )
					isbias = 1 ;
			end
		end
	end
	
endmodule