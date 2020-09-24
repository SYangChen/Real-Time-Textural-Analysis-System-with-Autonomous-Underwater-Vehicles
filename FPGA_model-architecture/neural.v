`define WIDTH 32

module neural ( rst, zero, clk, last_data, isbias, input_data1, input_data2, input_data3, input_data4, input_data5, input_data6, input_data7, input_data8, input_data9, input_data10, input_data11, input_data12, input_data13, input_data14, input_data15, input_data16, input_data17, input_data18, input_data19, input_data20, weight_data1, weight_data2, weight_data3, weight_data4, weight_data5, weight_data6, weight_data7, weight_data8, weight_data9, weight_data10, weight_data11, weight_data12, weight_data13, weight_data14, weight_data15, weight_data16, weight_data17, weight_data18, weight_data19,  weight_data20, output_data ) ;

	input rst, zero, clk, isbias ;
	input [7:0] last_data ;
	input [7:0] input_data1, input_data2, input_data3, input_data4, input_data5, input_data6, input_data7, input_data8, input_data9, input_data10, input_data11, input_data12, input_data13, input_data14, input_data15, input_data16, input_data17, input_data18, input_data19,  input_data20 ;
	input [7:0] weight_data1, weight_data2, weight_data3, weight_data4, weight_data5, weight_data6, weight_data7, weight_data8, weight_data9, weight_data10, weight_data11, weight_data12, weight_data13, weight_data14, weight_data15, weight_data16, weight_data17, weight_data18, weight_data19,  weight_data20 ;
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
			if ( isbias ) begin
				output_temp = input_data1*weight_data1 ;
			end
			else begin
				output_temp = input_data1*weight_data1+input_data2*weight_data2+input_data3*weight_data3+input_data4*weight_data4+input_data5*weight_data5+input_data6*weight_data6+input_data7*weight_data7+input_data8*weight_data8+input_data9*weight_data9+input_data10*weight_data10+input_data11*weight_data11+input_data12*weight_data12+input_data13*weight_data13+input_data14*weight_data14+input_data15*weight_data15+input_data16*weight_data16+input_data17*weight_data17+input_data18*weight_data18+input_data19*weight_data19+input_data20*weight_data20 ;
			end
			if ( zero )
				output_data = output_temp[11:4] ;
			else
				output_data = output_temp[11:4]+last_data ;
				// output_data = last_data ;
				// { a, output_data, b } = input_data*weight_data+{ a, last_data, b } ;
		end
	end

endmodule