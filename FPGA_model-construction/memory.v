module memory( reset, en, r_w, abus, dbus_in, dbus_out ) ;
	input reset, en, r_w ;
	input [7:0] abus ;
	input [7:0] dbus_in ;
	output reg [7:0] dbus_out ;
	
	reg [7:0] m [0:128] ;
	reg [7:0] data ;
	reg [7:0] i ;

    always @( * ) 
    begin
        if ( reset == 1 )
        begin
            m[0] <= 8'h20 ;
            m[1] <= 8'h10 ;
            m[2] <= 8'h20 ;
            m[3] <= 8'h10 ;
            m[4] <= 8'h10 ;
			m[5] <= 8'h10 ;
			m[6] <= 8'h10 ;
			m[7] <= 8'h10 ;
			m[8] <= 8'h10 ;
			m[9] <= 8'h10 ;
			m[10] <= 8'h10 ;
			dbus_out = 8'h00 ;
        end
        else if ( en == 1 && r_w == 0 ) // r_w==0:write
        begin
            // data = dbus_in ;
            m[abus] = dbus_in ;
			dbus_out = dbus_in ;
        end
        else if ( en == 1 && r_w == 1 ) // r_w==1:read
		begin
            // data = m[abus] ;
			dbus_out = m[abus] ;
		end
        else
		begin
            // data = 8'hZZ ;
			dbus_out = 8'hzz ;
		end
    end
endmodule