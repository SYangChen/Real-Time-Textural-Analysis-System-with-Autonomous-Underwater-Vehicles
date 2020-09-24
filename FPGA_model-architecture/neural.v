`define WIDTH 32

module neural ( rst, clk, zero, last_data, isbias, input_data1, weight_data1, output_data ) ;

	input rst, clk, isbias, zero ;
	input [15:0] last_data ;
	input [15:0] input_data1 ;
	input [15:0] weight_data1 ;
	reg [31:0] output_temp ;
	reg [7:0] a, b ;
	output reg [15:0] output_data ;

	always@( posedge clk or posedge rst ) begin
		// a = 4'b0 ;
		// b = 4'b0 ;
		if ( rst )
			output_data <= 0 ;
		else
		begin
			if ( zero == 1'b1 )
				output_data <= 0 ;
			if ( isbias == 1'b1 ) begin
				{ a, output_data, b } <= 16'b0100*weight_data+{ a, last_data, b } ;
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