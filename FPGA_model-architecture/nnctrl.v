`define WIDTH 32

module nnctrl ( reset, clk, count, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19,  in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31, in32, in33, in34, in35, in36, in37, in38, in39, in40, in41, in42, in43, in44, in45, in46, in47, in48, in49, in50, category ) ;
	
	input reset, clk ;
	input[7:0] count, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19,  in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31, in32, in33, in34, in35, in36, in37, in38, in39, in40, in41, in42, in43, in44, in45, in46, in47, in48, in49, in50 ;
	output category ;
	reg layer, fin ;
	reg [9:0] n, i, base ;
	reg enRam, enRam2, r_w, r_w2, zero, insign, insign2, isbias, startsign, storeweight ;
	wire [7:0] ram_dout1, ram_dout2, ram_dout3, ram_dout4, ram_dout5, ram_dout6, ram_dout7, ram_dout8, ram_dout9, ram_dout10, ram_dout11, ram_dout12, ram_dout13, ram_dout14, ram_dout15, ram_dout16, ram_dout17, ram_dout18, ram_dout19,  ram_dout20, ram_dout21, ram_dout22, ram_dout23, ram_dout24, ram_dout25, ram_dout26, ram_dout27, ram_dout28, ram_dout29, ram_dout30, ram_dout31, ram_dout32, ram_dout33, ram_dout34, ram_dout35, ram_dout36, ram_dout37, ram_dout38, ram_dout39, ram_dout40, ram_dout41, ram_dout42, ram_dout43, ram_dout44, ram_dout45, ram_dout46, ram_dout47, ram_dout48, ram_dout49, ram_dout50 ;
	wire [7:0] weight_dout1, weight_dout2, weight_dout3, weight_dout4, weight_dout5, weight_dout6, weight_dout7, weight_dout8, weight_dout9, weight_dout10, weight_dout11, weight_dout12, weight_dout13, weight_dout14, weight_dout15, weight_dout16, weight_dout17, weight_dout18, weight_dout19,  weight_dout20, weight_dout21, weight_dout22, weight_dout23, weight_dout24, weight_dout25, weight_dout26, weight_dout27, weight_dout28, weight_dout29, weight_dout30, weight_dout31, weight_dout32, weight_dout33, weight_dout34, weight_dout35, weight_dout36, weight_dout37, weight_dout38, weight_dout39, weight_dout40, weight_dout41, weight_dout42, weight_dout43, weight_dout44, weight_dout45, weight_dout46, weight_dout47, weight_dout48, weight_dout49, weight_dout50 ;
	wire [7:0] output_data ;
	reg [15:0] abus, abus2 ;
	
	memory ram1 ( reset, enRam, r_w, abus, insign, output_data, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19,  in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31, in32, in33, in34, in35, in36, in37, in38, in39, in40, in41, in42, in43, in44, in45, in46, in47, in48, in49, in50, ram_dout1, ram_dout2, ram_dout3, ram_dout4, ram_dout5, ram_dout6, ram_dout7, ram_dout8, ram_dout9, ram_dout10, ram_dout11, ram_dout12, ram_dout13, ram_dout14, ram_dout15, ram_dout16, ram_dout17, ram_dout18, ram_dout19,  ram_dout20, ram_dout21, ram_dout22, ram_dout23, ram_dout24, ram_dout25, ram_dout26, ram_dout27, ram_dout28, ram_dout29, ram_dout30, ram_dout31, ram_dout32, ram_dout33, ram_dout34, ram_dout35, ram_dout36, ram_dout37, ram_dout38, ram_dout39, ram_dout40, ram_dout41, ram_dout42, ram_dout43, ram_dout44, ram_dout45, ram_dout46, ram_dout47, ram_dout48, ram_dout49, ram_dout50 ) ;
	
	memory ram2 ( reset, enRam2, r_w2, abus2, insign2, output_data, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19,  in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31, in32, in33, in34, in35, in36, in37, in38, in39, in40, in41, in42, in43, in44, in45, in46, in47, in48, in49, in50, weight_dout1, weight_dout2, weight_dout3, weight_dout4, weight_dout5, weight_dout6, weight_dout7, weight_dout8, weight_dout9, weight_dout10, weight_dout11, weight_dout12, weight_dout13, weight_dout14, weight_dout15, weight_dout16, weight_dout17, weight_dout18, weight_dout19,  weight_dout20, weight_dout21, weight_dout22, weight_dout23, weight_dout24, weight_dout25, weight_dout26, weight_dout27, weight_dout28, weight_dout29, weight_dout30, weight_dout31, weight_dout32, weight_dout33, weight_dout34, weight_dout35, weight_dout36, weight_dout37, weight_dout38, weight_dout39, weight_dout40, weight_dout41, weight_dout42, weight_dout43, weight_dout44, weight_dout45, weight_dout46, weight_dout47, weight_dout48, weight_dout49, weight_dout50 ) ;
	
	neural n1 ( reset, zero, clk, output_data, isbias, ram_dout1, ram_dout2, ram_dout3, ram_dout4, ram_dout5, ram_dout6, ram_dout7, ram_dout8, ram_dout9, ram_dout10, ram_dout11, ram_dout12, ram_dout13, ram_dout14, ram_dout15, ram_dout16, ram_dout17, ram_dout18, ram_dout19,  ram_dout20, ram_dout21, ram_dout22, ram_dout23, ram_dout24, ram_dout25, ram_dout26, ram_dout27, ram_dout28, ram_dout29, ram_dout30, ram_dout31, ram_dout32, ram_dout33, ram_dout34, ram_dout35, ram_dout36, ram_dout37, ram_dout38, ram_dout39, ram_dout40, ram_dout41, ram_dout42, ram_dout43, ram_dout44, ram_dout45, ram_dout46, ram_dout47, ram_dout48, ram_dout49, ram_dout50, weight_dout1, weight_dout2, weight_dout3, weight_dout4, weight_dout5, weight_dout6, weight_dout7, weight_dout8, weight_dout9, weight_dout10, weight_dout11, weight_dout12, weight_dout13, weight_dout14, weight_dout15, weight_dout16, weight_dout17, weight_dout18, weight_dout19,  weight_dout20, weight_dout21, weight_dout22, weight_dout23, weight_dout24, weight_dout25, weight_dout26, weight_dout27, weight_dout28, weight_dout29, weight_dout30, weight_dout31, weight_dout32, weight_dout33, weight_dout34, weight_dout35, weight_dout36, weight_dout37, weight_dout38, weight_dout39, weight_dout40, weight_dout41, weight_dout42, weight_dout43, weight_dout44, weight_dout45, weight_dout46, weight_dout47, weight_dout48, weight_dout49, weight_dout50, output_data ) ;
	
	classfier c ( reset, fin, ram_dout1, ram_dout2, category ) ;
	
	always@( posedge clk ) begin
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
			abus = 50*count ;
			// i = i+1 ;
			if ( count == 19 ) begin
				startsign = 1 ;
				// abus = 0 ;
				// enRam = 0 ;
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
				enRam2 = 0 ;
				r_w = 1 ;
				r_w2 = 1 ;
				// enRom = 0 ;
				isbias = 0 ;
			end
			else if ( storeweight == 0  ) begin
				r_w2 = 0 ;	// write
				enRam = 0 ;
				enRam2 = 1 ;
				abus2 = 50*count ;
				// i = i+1 ;
				if ( count == 20 ) begin
					storeweight = 1 ;
					// abus2 = 0 ;
					// enRam2 = 0 ;
					// r_w2 = 1 ;
				end
			end
			else if ( i == 21 ) begin
				// write back ram
				enRam = 1 ;
				r_w = 0 ;
				enRam2 = 0 ;
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
				abus = i*50 ;
				// addr = i*50+n*1001 ;
				abus2 = i*50 ;
				i = i+1 ;
				enRam = 1 ;
				r_w = 1 ;
				enRam2 = 1 ;
				r_w2 = 1 ;
				insign = 0 ;
				isbias = 0 ;
				if ( i == 21 )
					isbias = 1 ;
			end
		end
		else if ( layer == 1 ) begin
			if ( n == 2 ) begin
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
				abus2 = 50*count ;
				// i = i+1 ;
				if ( count == 2 ) begin
					storeweight = 1 ;
					// abus2 = 0 ;
					// enRam2 = 0 ;
					// r_w2 = 1 ;
				end
			end
			else if ( i == 3 ) begin
				enRam = 1 ;
				r_w = 0 ;
				enRam2 = 0 ;
				r_w2 = 0 ;
				abus = n ;
				n = n+1 ;
				i = 0 ;
				insign = 1 ;
				isbias = 0 ;
			end
			else begin
				if ( i == 0 )
					zero = 1 ;
				else
					zero = 0 ;
				abus = i*50+1001 ;
				// addr = i*50+n*101+100100 ;
				abus2 = i*50 ;
				i = i+1 ;
				enRam = 1 ;
				r_w = 1 ;
				enRam2 = 1 ;
				r_w2 = 1 ;
				insign = 0 ;
				isbias = 0 ;
				if ( i == 3 )
					isbias = 1 ;
			end
		end
	end
	
endmodule