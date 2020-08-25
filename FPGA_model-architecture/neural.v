`define WIDTH 32

module neural ( rst, zero, clk, last_data, input_data, weight_data, output_data ) ;

	input rst, zero, clk ;
	input [7:0] last_data, input_data, weight_data ;
	reg [15:0] output_temp ;
	// reg [3:0] a, b ;
	output reg [7:0] output_data ;

	always@( posedge clk or posedge rst ) begin
		// a = 4'b0 ;
		// b = 4'b0 ;
		if ( rst )
			output_data = 0 ;
		else
		begin
			output_temp = input_data*weight_data ;
			if ( zero )
				output_data = output_temp[11:4] ;
			else
				output_data = output_temp[11:4]+last_data ;
				// output_data = last_data ;
				// { a, output_data, b } = input_data*weight_data+{ a, last_data, b } ;
		end
	end

endmodule