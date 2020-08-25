`define WIDTH 32

module nnctrl ( reset, clk ) ;
	
	input reset, clk ;
	reg layer, fin ;
	reg [9:0] n, i, base ;
	reg enRam, r_w, enRom, zero ;
	wire [7:0] ram_dout,  rom_dout, output_data ;
	reg [7:0] abus, addr ;
	
	memory ram ( reset, enRam, r_w, abus, output_data, ram_dout ) ;
	ROM rom ( reset, addr, rom_dout, enRom ) ;
	neural n1 ( reset, zero, clk, output_data, ram_dout, rom_dout, output_data ) ;
	
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
			// enRam = 1 ;
			// r_w = 1 ;
			// enRom = 1 ;
		end
		// get data
		else if ( layer == 0 ) begin
			if ( n == 3 ) begin
				base = addr+1 ;
				layer = 1 ;
				n = 0 ;
				i = 0 ;
				enRam = 0 ;
				r_w = 1 ;
				enRom = 0 ;
			end
			else if ( i == 6 ) begin
				enRam = 1 ;
				r_w = 0 ;
				enRom = 0 ;
				abus = n+6 ;
				n = n+1 ;
				i = 0 ;
			end
			else begin
				if ( i == 0 )
					zero = 1 ;
				else
					zero = 0 ;
				abus = i ;		// 1001
				addr = i+n*6 ;
				i = i+1 ;
				enRam = 1 ;
				r_w = 1 ;
				enRom = 1 ;
			end
		end
		else if ( layer == 1 ) begin
			if ( n == 2 ) begin
				n = 0 ;
				i = 0 ;
				$stop ;
			end
			else if ( i == 4 ) begin
				enRam = 1 ;
				r_w = 0 ;
				enRom = 0 ;
				abus = n ;
				n = n+1 ;
				i = 0 ;
			end
			else begin
				if ( i == 0 )
					zero = 1 ;
				else
					zero = 0 ;
				abus = i+6 ;		// 1001
				addr = i+n*4+18 ;
				i = i+1 ;
				enRam = 1 ;
				r_w = 1 ;
				enRom = 1 ;
			end
		end
	end
	
endmodule