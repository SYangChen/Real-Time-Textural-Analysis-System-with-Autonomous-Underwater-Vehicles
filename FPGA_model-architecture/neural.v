`define WIDTH 32

module neural ( rst, clk, zero, last_data, isbias, input_data, weight_data, output_data ) ;

	input rst, clk, isbias, zero ;
	input [15:0] last_data ;
	input [15:0] input_data ;
	input [15:0] weight_data ;
	output reg [15:0] output_data ;

	reg a ;
	reg [14:0] b ;

	always@( posedge clk or posedge rst ) begin
		// a = 4'b0 ;
		// b = 4'b0 ;
		if ( rst ) begin
			output_data <= 0 ;
			a = 1'b0 ;
			b = 15'd0 ;
		end
		else
		begin
			if ( zero == 1'b1 )
				output_data <= 0 ;
			else if ( isbias == 1'b1 ) begin
				output_data <= last_data+weight_data ;
				// output_temp = input_data1*weight_data1 ;
			end
			else begin
				{ a, output_data, b } <= input_data*weight_data+{ a, last_data, b } ;
				// output_temp = input_data1*weight_data1 ;
			end
			// output_data = output_temp[11:4]+last_data ;
				// output_data = last_data ;
				// { a, output_data, b } = input_data*weight_data+{ a, last_data, b } ;
		end
	end

endmodule