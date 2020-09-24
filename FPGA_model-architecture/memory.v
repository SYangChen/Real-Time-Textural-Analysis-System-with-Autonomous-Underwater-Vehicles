`timescale 1ns/10ps
module memory( reset, clk, en, r_w, abus, dbus_in1, dbus_out1, stored ) ;
	input reset, clk, en, r_w ;
	input [7:0] abus ;
	input [15:0] dbus_in1 ;
	output reg [15:0] dbus_out1 ;
	output reg stored ;
	
	reg [15:0] m [0:128] ;
	reg [15:0] data ;
	reg [7:0] idx ;

    always @( posedge clk or posedge reset ) 
    begin
        if ( reset == 1 )
        begin
			for( idx = 0 ; idx < 128 ; idx = idx+1 ) begin
			  m[idx] <= 0 ;
			end
            // m[1000] = 8'h10 ;
			// m[1101] = 8'h10 ;
			dbus_out1 <= 16'h0000 ;
			stored = 1'b0 ;
        end
        else if ( en == 1 && r_w == 0 ) // r_w==0:write
        begin
            // data = dbus_in ;
			m[abus] <= dbus_in1 ;
			dbus_out1 <= dbus_in1 ;
			stored <= 1'b1 ;
			end
        end
        else if ( en == 1 && r_w == 1 ) // r_w==1:read
		begin
            // data = m[abus] ;
			dbus_out1 <= m[abus] ;
		end
        else
		begin
            // data = 8'hZZ ;
			dbus_out1 <= 8'hzz ;
			stored <= 1'b0 ;
		end
    end
endmodule