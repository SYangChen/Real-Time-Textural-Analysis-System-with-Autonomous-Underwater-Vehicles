`define WIDTH 32

module neural50 ( rst, zero, clk, last_data, isbias, input_data1, input_data2, input_data3, input_data4, input_data5, input_data6, input_data7, input_data8, input_data9, input_data10, input_data11, input_data12, input_data13, input_data14, input_data15, input_data16, input_data17, input_data18, input_data19, input_data20, input_data21, input_data22, input_data23, input_data24, input_data25, input_data26, input_data27, input_data28, input_data29, input_data30, input_data31, input_data32, input_data33, input_data34, input_data35, input_data36, input_data37, input_data38, input_data39, input_data40, input_data41, input_data42, input_data43, input_data44, input_data45, input_data46, input_data47, input_data48, input_data49, input_data50, weight_data1, weight_data2, weight_data3, weight_data4, weight_data5, weight_data6, weight_data7, weight_data8, weight_data9, weight_data10, weight_data11, weight_data12, weight_data13, weight_data14, weight_data15, weight_data16, weight_data17, weight_data18, weight_data19,  weight_data20, weight_data21, weight_data22, weight_data23, weight_data24, weight_data25, weight_data26, weight_data27, weight_data28, weight_data29, weight_data30, weight_data31, weight_data32, weight_data33, weight_data34, weight_data35, weight_data36, weight_data37, weight_data38, weight_data39, weight_data40, weight_data41, weight_data42, weight_data43, weight_data44, weight_data45, weight_data46, weight_data47, weight_data48, weight_data49, weight_data50, output_data ) ;

	input rst, zero, clk, isbias ;
	input [7:0] last_data ;
	input [7:0] input_data1, input_data2, input_data3, input_data4, input_data5, input_data6, input_data7, input_data8, input_data9, input_data10, input_data11, input_data12, input_data13, input_data14, input_data15, input_data16, input_data17, input_data18, input_data19,  input_data20, input_data21, input_data22, input_data23, input_data24, input_data25, input_data26, input_data27, input_data28, input_data29, input_data30, input_data31, input_data32, input_data33, input_data34, input_data35, input_data36, input_data37, input_data38, input_data39, input_data40, input_data41, input_data42, input_data43, input_data44, input_data45, input_data46, input_data47, input_data48, input_data49, input_data50 ;
	input [7:0] weight_data1, weight_data2, weight_data3, weight_data4, weight_data5, weight_data6, weight_data7, weight_data8, weight_data9, weight_data10, weight_data11, weight_data12, weight_data13, weight_data14, weight_data15, weight_data16, weight_data17, weight_data18, weight_data19,  weight_data20, weight_data21, weight_data22, weight_data23, weight_data24, weight_data25, weight_data26, weight_data27, weight_data28, weight_data29, weight_data30, weight_data31, weight_data32, weight_data33, weight_data34, weight_data35, weight_data36, weight_data37, weight_data38, weight_data39, weight_data40, weight_data41, weight_data42, weight_data43, weight_data44, weight_data45, weight_data46, weight_data47, weight_data48, weight_data49, weight_data50 ;
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
				output_temp = input_data1*weight_data1+input_data2*weight_data2+input_data3*weight_data3+input_data4*weight_data4+input_data5*weight_data5+input_data6*weight_data6+input_data7*weight_data7+input_data8*weight_data8+input_data9*weight_data9+input_data10*weight_data10+input_data11*weight_data11+input_data12*weight_data12+input_data13*weight_data13+input_data14*weight_data14+input_data15*weight_data15+input_data16*weight_data16+input_data17*weight_data17+input_data18*weight_data18+input_data19*weight_data19+input_data20*weight_data20+input_data21*weight_data21+input_data22*weight_data22+input_data23*weight_data23+input_data24*weight_data24+input_data25*weight_data25+input_data26*weight_data26+input_data27*weight_data27+input_data28*weight_data28+input_data29*weight_data29+input_data30*weight_data30+input_data31*weight_data31+input_data32*weight_data32+input_data33*weight_data33+input_data34*weight_data34+input_data35*weight_data35+input_data36*weight_data36+input_data37*weight_data37+input_data38*weight_data38+input_data39*weight_data39+input_data40*weight_data40+input_data41*weight_data41+input_data42*weight_data42+input_data43*weight_data43+input_data44*weight_data44+input_data45*weight_data45+input_data46*weight_data46+input_data47*weight_data47+input_data48*weight_data48+input_data49*weight_data49+input_data50*weight_data50 ;
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