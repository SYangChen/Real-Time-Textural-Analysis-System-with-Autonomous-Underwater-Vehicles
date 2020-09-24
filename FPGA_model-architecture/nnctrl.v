`timescale 1ns/10ps
`define WIDTH 32

module nnctrl ( reset, clk, in, weib, category, count ) ;
	
	input reset, clk ;
	input[15:0] in, weib ;
	output category ;
	output[9:0] count ;
	
	reg enRam, r_w, zero, isbias, layer ;
	wire [15:0] output_data, ram_out ;	// test here wire->output
	wire store, stored ;
	reg [15:0] abus, dataA, dataB, sum ;// dataA can store in to memory
	reg[7:0] n ;
	reg[9:0] count ;
	
	memory ram1 ( reset, clk, enRam, r_w, abus, output_data, ram_out, stored ) ;
	neural n1 ( reset, clk, zero, sum, isbias, dataA, dataB, output_data ) ;
	classfier c ( reset, fin, dataA, dataB, category ) ;
	
	always@( posedge reset or posedge clk ) begin
		// excute next
		if ( reset ) begin
			enRam <= 0 ;
			r_w <= 0 ;
			zero <= 0 ;
			isbias <= 0 ;
			abus <= 0 ;
			dataA <= 0 ;
			dataB <= 0 ;
			layer <= 0 ;
			n <= 0 ;
			count <= 0 ;
		end
		else if ( layer == 1'b0 ) begin
			if ( stored == 1'b1 ) begin
				enRam <= 1'b0 ;
				n <= n+1 ;
				count <= 0 ;
			end
			else if ( count == 1000 ) begin
				enRam <= 1'b1 ;
				r_w <= 0 ;
				abus <= n ;
			end
			else begin
				sum <= output_data ;
				dataA <= in ;
				dataB <= weib ;
				count <= count+1 ;
			end
		end
		else begin
		
		end
	end
	
endmodule