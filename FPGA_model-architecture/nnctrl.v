`define WIDTH 32

module nnctrl50 ( reset, clk, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19,  in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31, in32, in33, in34, in35, in36, in37, in38, in39, in40, in41, in42, in43, in44, in45, in46, in47, in48, in49, in50 ) ;
	
	input reset, clk ;
	input[7:0] in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19,  in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31, in32, in33, in34, in35, in36, in37, in38, in39, in40, in41, in42, in43, in44, in45, in46, in47, in48, in49, in50 ;
	reg layer, fin ;
	reg [9:0] n, i, base ;
	reg enRam, r_w, enRom, zero, insign, isbias, startsign ;
	wire [7:0] ram_dout1, ram_dout2, ram_dout3, ram_dout4, ram_dout5, ram_dout6, ram_dout7, ram_dout8, ram_dout9, ram_dout10, ram_dout11, ram_dout12, ram_dout13, ram_dout14, ram_dout15, ram_dout16, ram_dout17, ram_dout18, ram_dout19,  ram_dout20, ram_dout21, ram_dout22, ram_dout23, ram_dout24, ram_dout25, ram_dout26, ram_dout27, ram_dout28, ram_dout29, ram_dout30, ram_dout31, ram_dout32, ram_dout33, ram_dout34, ram_dout35, ram_dout36, ram_dout37, ram_dout38, ram_dout39, ram_dout40, ram_dout41, ram_dout42, ram_dout43, ram_dout44, ram_dout45, ram_dout46, ram_dout47, ram_dout48, ram_dout49, ram_dout50 ;
	wire [7:0] rom_dout1, rom_dout2, rom_dout3, rom_dout4, rom_dout5, rom_dout6, rom_dout7, rom_dout8, rom_dout9, rom_dout10, rom_dout11, rom_dout12, rom_dout13, rom_dout14, rom_dout15, rom_dout16, rom_dout17, rom_dout18, rom_dout19,  rom_dout20, rom_dout21, rom_dout22, rom_dout23, rom_dout24, rom_dout25, rom_dout26, rom_dout27, rom_dout28, rom_dout29, rom_dout30, rom_dout31, rom_dout32, rom_dout33, rom_dout34, rom_dout35, rom_dout36, rom_dout37, rom_dout38, rom_dout39, rom_dout40, rom_dout41, rom_dout42, rom_dout43, rom_dout44, rom_dout45, rom_dout46, rom_dout47, rom_dout48, rom_dout49, rom_dout50 ;
	wire [7:0] output_data ;
	reg [15:0] abus ;
	reg [31:0] addr ;
	
	memory50 ram ( reset, enRam, r_w, abus, insign, output_data, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19,  in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31, in32, in33, in34, in35, in36, in37, in38, in39, in40, in41, in42, in43, in44, in45, in46, in47, in48, in49, in50, ram_dout1, ram_dout2, ram_dout3, ram_dout4, ram_dout5, ram_dout6, ram_dout7, ram_dout8, ram_dout9, ram_dout10, ram_dout11, ram_dout12, ram_dout13, ram_dout14, ram_dout15, ram_dout16, ram_dout17, ram_dout18, ram_dout19,  ram_dout20, ram_dout21, ram_dout22, ram_dout23, ram_dout24, ram_dout25, ram_dout26, ram_dout27, ram_dout28, ram_dout29, ram_dout30, ram_dout31, ram_dout32, ram_dout33, ram_dout34, ram_dout35, ram_dout36, ram_dout37, ram_dout38, ram_dout39, ram_dout40, ram_dout41, ram_dout42, ram_dout43, ram_dout44, ram_dout45, ram_dout46, ram_dout47, ram_dout48, ram_dout49, ram_dout50 ) ;
	
	ROM50 rom ( reset, addr, rom_dout1, rom_dout2, rom_dout3, rom_dout4, rom_dout5, rom_dout6, rom_dout7, rom_dout8, rom_dout9, rom_dout10, rom_dout11, rom_dout12, rom_dout13, rom_dout14, rom_dout15, rom_dout16, rom_dout17, rom_dout18, rom_dout19,  rom_dout20, rom_dout21, rom_dout22, rom_dout23, rom_dout24, rom_dout25, rom_dout26, rom_dout27, rom_dout28, rom_dout29, rom_dout30, rom_dout31, rom_dout32, rom_dout33, rom_dout34, rom_dout35, rom_dout36, rom_dout37, rom_dout38, rom_dout39, rom_dout40, rom_dout41, rom_dout42, rom_dout43, rom_dout44, rom_dout45, rom_dout46, rom_dout47, rom_dout48, rom_dout49, rom_dout50, enRom ) ;
	
	neural50 n1 ( reset, zero, clk, output_data, isbias, ram_dout1, ram_dout2, ram_dout3, ram_dout4, ram_dout5, ram_dout6, ram_dout7, ram_dout8, ram_dout9, ram_dout10, ram_dout11, ram_dout12, ram_dout13, ram_dout14, ram_dout15, ram_dout16, ram_dout17, ram_dout18, ram_dout19,  ram_dout20, ram_dout21, ram_dout22, ram_dout23, ram_dout24, ram_dout25, ram_dout26, ram_dout27, ram_dout28, ram_dout29, ram_dout30, ram_dout31, ram_dout32, ram_dout33, ram_dout34, ram_dout35, ram_dout36, ram_dout37, ram_dout38, ram_dout39, ram_dout40, ram_dout41, ram_dout42, ram_dout43, ram_dout44, ram_dout45, ram_dout46, ram_dout47, ram_dout48, ram_dout49, ram_dout50, rom_dout1, rom_dout2, rom_dout3, rom_dout4, rom_dout5, rom_dout6, rom_dout7, rom_dout8, rom_dout9, rom_dout10, rom_dout11, rom_dout12, rom_dout13, rom_dout14, rom_dout15, rom_dout16, rom_dout17, rom_dout18, rom_dout19,  rom_dout20, rom_dout21, rom_dout22, rom_dout23, rom_dout24, rom_dout25, rom_dout26, rom_dout27, rom_dout28, rom_dout29, rom_dout30, rom_dout31, rom_dout32, rom_dout33, rom_dout34, rom_dout35, rom_dout36, rom_dout37, rom_dout38, rom_dout39, rom_dout40, rom_dout41, rom_dout42, rom_dout43, rom_dout44, rom_dout45, rom_dout46, rom_dout47, rom_dout48, rom_dout49, rom_dout50, output_data ) ;
	
	always@( posedge clk ) begin
		// excute next
		if ( reset ) begin
			layer = 0 ;
			base = 0 ;
			enRam = 0 ;
			enRom = 0 ;
			zero = 1 ;
			r_w = 0 ;
			n = 0 ;
			i = 0 ;
			abus = 0 ;
			addr = 0 ;
			insign = 0 ;
			isbias = 0 ;
			startsign = 0 ;
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
			abus = 50*i ;
			i = i+1 ;
			if ( i == 22 ) begin
				startsign = 1 ;
				abus = 0 ;
				i = 0 ;
				enRam = 0 ;
				r_w = 1 ;
			end
		end
		else if ( layer == 0 ) begin
			if ( n == 100 ) begin
				// next layer
				base = addr+1 ;
				layer = 1 ;
				n = 0 ;
				i = 0 ;
				insign = 0 ;
				enRam = 0 ;
				r_w = 1 ;
				enRom = 0 ;
				isbias = 0 ;
			end
			else if ( i == 21 ) begin
				// write back ram
				enRam = 1 ;
				r_w = 0 ;
				enRom = 0 ;
				abus = n+1001 ;
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
				abus = i*50 ;
				addr = i*50+n*1001 ;
				i = i+1 ;
				enRam = 1 ;
				r_w = 1 ;
				enRom = 1 ;
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
				$stop ;
			end
			else if ( i == 3 ) begin
				enRam = 1 ;
				r_w = 0 ;
				enRom = 0 ;
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
				addr = i*50+n*101+100100 ;
				i = i+1 ;
				enRam = 1 ;
				r_w = 1 ;
				enRom = 1 ;
				insign = 0 ;
				isbias = 0 ;
				if ( i == 3 )
					isbias = 1 ;
			end
		end
	end
	
endmodule