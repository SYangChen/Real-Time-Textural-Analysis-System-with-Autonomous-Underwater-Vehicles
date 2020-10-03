`timescale 1ns/10ps
`define WIDTH 32

module classfier ( rst, enable, data1, data2, category ) ;

	input rst, enable ;
	input signed [15:0] data1, data2 ;
	output reg category ;

	always@( posedge enable or posedge rst ) begin
		if ( rst )
			category <= 1'bz ;
		else
		begin
			if ( data1 > data2 )
				category <= 1'b0 ;
			else
				category <= 1'b1 ;
		end
	end

endmodule