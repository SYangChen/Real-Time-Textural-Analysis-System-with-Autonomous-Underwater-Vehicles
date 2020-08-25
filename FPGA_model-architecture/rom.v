module ROM( rst, addr, dataOUT, enRead ) ;

	input rst ;
	input [7:0] addr ;	// address to access
	input enRead ;		// enable to read
	output reg [7:0] dataOUT ;	// output data
	reg[7:0] data [127:0] ;	// weight
 
	always @(*) begin
		if ( rst ) begin
			data[0] <= 8'h10 ;
			data[1] <= 8'h20 ;
			data[2] <= 8'h30 ;
			data[3] <= 8'h10 ;
			data[4] <= 8'h20 ;
			data[5] <= 8'h10 ;
			data[6] <= 8'h10 ;
			data[7] <= 8'h20 ;
			data[8] <= 8'h30 ;
			data[9] <= 8'h10 ;
			data[10] <= 8'h20 ;
			data[11] <= 8'h10 ;
			data[12] <= 8'h10 ;
			data[13] <= 8'h20 ;
			data[14] <= 8'h30 ;
			data[15] <= 8'h10 ;
			data[16] <= 8'h20 ;
			data[17] <= 8'h10 ;
			data[18] <= 8'h00 ;
			data[19] <= 8'h08 ;
			data[20] <= 8'h08 ;
			data[21] <= 8'h10 ;
			data[22] <= 8'h00 ;
			data[23] <= 8'h08 ;
			data[24] <= 8'h08 ;
			data[25] <= 8'h10 ;
			data[26] <= 8'h00 ;
			data[27] <= 8'h08 ;
			data[28] <= 8'h08 ;
			data[29] <= 8'h10 ;
		end
		
		if ( enRead )
		begin
			dataOUT <= data[addr];
		end 
		else 
		begin 
			dataOUT <= 8'bzzzz_zzzz;
		end 
	end 
   
endmodule