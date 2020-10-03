`timescale 1ns/10ps
`define WIDTH 32

module nnctrl ( reset, clk, input_signal, in, category ) ;
	
	input 		reset, clk ;
	input		input_signal ;
	input[15:0] in ;
	output 		category ;
	
	wire[15:0]	doutin ;	// wire
	reg			ena, wea ;
	reg[10:0]	addrRAM ;
	
	wire[15:0]	doutweib ;
	reg[16:0]	addrROM ;
	
	wire[15:0]	curResult ;	// wire
	reg			isBias ;
	
	reg 		enClassfy, zero, isInput ;
	reg[15:0]	dataA, dataB ;
	reg[2:0]	layer ;
	reg[6:0]	count ;
	reg[2:0]	delay ;
	
	BMG_RAM ram ( .clka(clk), .ena(ena), .wea(wea), .addra(addrRAM), .dina(dataA), .douta(doutin) ) ;
	BMG_ROM rom ( .clka(clk), .addra(addrROM), .douta(doutweib) ) ;
	neural aNeural ( reset, clk, zero, curResult, isBias, doutin, doutweib, curResult ) ;
	classfier classfier ( reset, enClassfy, dataA, dataB, category ) ;
	/*
	always@( input_signal or posedge reset ) begin
	// store 1000 input data
		if ( reset )
			addrRAM <= 11'd0 ;
		addrRAM <= addrRAM+1'b1 ;
		if ( addrRAM == 1000 )
			layer <= 2'd1 ;
	end
	*/
	always@( posedge reset or posedge clk ) begin
		// excute next
		if ( reset ) begin
			ena <= 1'b1 ;		// enable
			wea <= 1'b1 ;		// write
			addrRAM <= 11'd0 ;
			addrROM <= 17'd0 ;
			isBias <= 1'b0 ;
			enClassfy <= 1'b0 ;
			zero <= 1'b1 ;
			dataA <= 16'd0 ;
			dataB <= 16'd0 ;
			layer <= 2'd0 ;
			isInput <= 1'b0 ;
			count <= 10'd0 ;
			delay <= 3'b000 ;
		end
		else if ( layer == 0 ) begin
			if ( input_signal && isInput == 1'b0 ) begin
				isInput <= 1'b1 ;
				dataA <= in ;
			end
			if ( input_signal == 1'b0 && isInput == 1'b1 ) begin
				isInput <= 1'b0 ;
				addrRAM <= addrRAM+1 ;
			end
			if ( addrRAM == 1000 ) begin
				layer <= 2'd1 ;
				addrRAM <= 11'd0 ;
				addrROM <= 17'd0 ;
				// zero <= 1'b0 ;
				wea <= 1'b0 ;		// read
			end
		end
		else if ( layer == 1 ) begin
			if ( addrRAM == 1 )
				// two clock delay start
				zero <= 1'b0 ;
			if ( delay > 0 ) begin
				delay <= delay-1 ;
				if ( delay == 6 || delay == 4 || delay == 2 ) ;
				else if ( delay == 5 )
					isBias <= 1'b1 ;
				else if ( delay == 3 ) begin
					addrRAM <= count+1000 ;
					isInput <= 1'b1 ;
					wea <= 1'b1 ;			// write
					dataA <= curResult ;	// store data
					isBias <= 1'b0 ;
				end
				else begin
					addrRAM <= 0 ;
					wea <= 1'b0 ;
					isInput <= 1'b0 ;
					zero <= 1'b1 ;
					count <= count+1 ;		// done neural count
				end
			end
			else if ( count == 100 ) begin
				// layer 1 complete
				layer <= 2 ;
				addrRAM <= 1000 ;
				wea <= 1'b0 ;
				count <= 0 ;
			end
			else if ( addrRAM == 999 ) begin
				// isBias <= 1'b1 ;
				delay <= 3'b110 ; 
				addrRAM <= addrRAM+1 ;
				addrROM <= addrROM+1 ;
			end
			else begin
				addrRAM <= addrRAM+1 ;
				addrROM <= addrROM+1 ;
			end
		end
		else if ( layer == 2 ) begin
			if ( addrRAM == 1001 )
				// two clock delay start
				zero <= 1'b0 ;
			if ( delay > 0 ) begin
				delay <= delay-1 ;
				if ( delay == 6 || delay == 4 || delay == 2 ) ;
				else if ( delay == 5 )
					isBias <= 1'b1 ;
				else if ( delay == 3 ) begin
					addrRAM <= count ;
					isInput <= 1'b1 ;
					wea <= 1'b1 ;			// write
					dataA <= curResult ;	// store data
					isBias <= 1'b0 ;
				end
				else begin
					addrRAM <= 1000 ;
					wea <= 1'b0 ;
					isInput <= 1'b0 ;
					zero <= 1'b1 ;
					count <= count+1 ;		// done neural count
				end
			end
			else if ( count == 2 ) begin
				// layer 2 complete
				layer <= 3 ;
				addrRAM <= 0 ;
				addrROM <= 0 ;
				wea <= 1'b0 ;
				count <= 0 ;
				delay <= 3'b100 ;
			end
			else if ( addrRAM == 1099 ) begin
				// isBias <= 1'b1 ;
				delay <= 3'b110 ; 
				addrRAM <= addrRAM+1 ;
				addrROM <= addrROM+1 ;
			end
			else begin
				addrRAM <= addrRAM+1 ;
				addrROM <= addrROM+1 ;
			end
		end
		else begin
			if ( count == 0 ) begin
				if ( delay > 0 ) begin
					delay <= delay-1 ;
				end
				else begin
					dataA <= doutin ;
					addrRAM <= 1 ;
					delay <= 3'b100 ;
					count <= 1 ;
				end
			end
			else if ( count == 1 ) begin
				if ( delay > 0 ) begin
					delay <= delay-1 ;
				end
				else begin
					dataB <= doutin ;
					addrRAM <= 1 ;
					delay <= 3'b100 ;
					count <= 2 ;
				end
			end
			else if ( count == 2 ) begin
				enClassfy <= 1'b1 ;
				count <= 3 ;
				delay <= 2 ;
			end
			else begin
				// reset
				if ( delay > 0 )
					delay <= delay-1 ;
				else begin
					$stop ;
					ena <= 1'b1 ;		// enable
					wea <= 1'b1 ;		// write
					addrRAM <= 11'd0 ;
					addrROM <= 17'd0 ;
					isBias <= 1'b0 ;
					enClassfy <= 1'b0 ;
					zero <= 1'b1 ;
					dataA <= 16'd0 ;
					dataB <= 16'd0 ;
					layer <= 2'd0 ;
					isInput <= 1'b0 ;
					count <= 10'd0 ;
					delay <= 3'b000 ;
				end
			end
		end
		
	end
	
endmodule