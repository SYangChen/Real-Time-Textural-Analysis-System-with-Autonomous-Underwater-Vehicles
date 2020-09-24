`timescale 1ns/10ps
module memory( reset, clk, en, r_w, abus, insign, indata, dbus_in1, dbus_in2, dbus_in3, dbus_in4, dbus_in5, dbus_in6, dbus_in7, dbus_in8, dbus_in9, dbus_in10, dbus_in11, dbus_in12, dbus_in13, dbus_in14, dbus_in15, dbus_in16, dbus_in17, dbus_in18, dbus_in19,  dbus_in20, dbus_out1, dbus_out2, dbus_out3, dbus_out4, dbus_out5, dbus_out6, dbus_out7, dbus_out8, dbus_out9, dbus_out10, dbus_out11, dbus_out12, dbus_out13, dbus_out14, dbus_out15, dbus_out16, dbus_out17, dbus_out18, dbus_out19,  dbus_out20 ) ;
	input reset, clk, en, r_w, insign ;
	input [15:0] abus ;
	input [7:0] indata, dbus_in1, dbus_in2, dbus_in3, dbus_in4, dbus_in5, dbus_in6, dbus_in7, dbus_in8, dbus_in9, dbus_in10, dbus_in11, dbus_in12, dbus_in13, dbus_in14, dbus_in15, dbus_in16, dbus_in17, dbus_in18, dbus_in19,  dbus_in20 ;
	output reg [7:0] dbus_out1, dbus_out2, dbus_out3, dbus_out4, dbus_out5, dbus_out6, dbus_out7, dbus_out8, dbus_out9, dbus_out10, dbus_out11, dbus_out12, dbus_out13, dbus_out14, dbus_out15, dbus_out16, dbus_out17, dbus_out18, dbus_out19,  dbus_out20 ;
	
	reg [7:0] m [0:1200] ;
	reg [7:0] data ;
	reg [7:0] i ;

    always @( posedge clk ) 
    begin
        if ( reset == 1 )
        begin
            m[1000] = 8'h10 ;
			m[1101] = 8'h10 ;
			dbus_out1 = 8'hzz ;
        end
        else if ( en == 1 && r_w == 0 ) // r_w==0:write
        begin
            // data = dbus_in ;
			if ( insign ) begin
				m[abus] = indata ;
				dbus_out1 = indata ;
			end
			else begin
				m[abus] = dbus_in1 ;
				m[abus+1] = dbus_in2 ;
				m[abus+2] = dbus_in3 ;
				m[abus+3] = dbus_in4 ;
				m[abus+4] = dbus_in5 ;
				m[abus+5] = dbus_in6 ;
				m[abus+6] = dbus_in7 ;
				m[abus+7] = dbus_in8 ;
				m[abus+8] = dbus_in9 ;
				m[abus+9] = dbus_in10 ;
				m[abus+10] = dbus_in11 ;
				m[abus+11] = dbus_in12 ;
				m[abus+12] = dbus_in13 ;
				m[abus+13] = dbus_in14 ;
				m[abus+14] = dbus_in15 ;
				m[abus+15] = dbus_in16 ;
				m[abus+16] = dbus_in17 ;
				m[abus+17] = dbus_in18 ;
				m[abus+18] = dbus_in19 ;
				m[abus+19] = dbus_in20 ;
				dbus_out1 = dbus_in1 ;
			end
        end
        else if ( en == 1 && r_w == 1 ) // r_w==1:read
		begin
            // data = m[abus] ;
			dbus_out1 = m[abus] ;
			dbus_out2 = m[abus+1] ;
			dbus_out3 = m[abus+2] ;
			dbus_out4 = m[abus+3] ;
			dbus_out5 = m[abus+4] ;
			dbus_out6 = m[abus+5] ;
			dbus_out7 = m[abus+6] ;
			dbus_out8 = m[abus+7] ;
			dbus_out9 = m[abus+8] ;
			dbus_out10 = m[abus+9] ;
			dbus_out11 = m[abus+10] ;
			dbus_out12 = m[abus+11] ;
			dbus_out13 = m[abus+12] ;
			dbus_out14 = m[abus+13] ;
			dbus_out15 = m[abus+14] ;
			dbus_out16 = m[abus+15] ;
			dbus_out17 = m[abus+16] ;
			dbus_out18 = m[abus+17] ;
			dbus_out19 = m[abus+18] ;
			dbus_out20 = m[abus+19] ;
		end
        else
		begin
            // data = 8'hZZ ;
			dbus_out1 = 8'hzz ;
			dbus_out2 = 8'hzz ;
			dbus_out3 = 8'hzz ;
			dbus_out4 = 8'hzz ;
			dbus_out5 = 8'hzz ;
			dbus_out6 = 8'hzz ;
			dbus_out7 = 8'hzz ;
			dbus_out8 = 8'hzz ;
			dbus_out9 = 8'hzz ;
			dbus_out10 = 8'hzz ;
			dbus_out11 = 8'hzz ;
			dbus_out12 = 8'hzz ;
			dbus_out13 = 8'hzz ;
			dbus_out14 = 8'hzz ;
			dbus_out15 = 8'hzz ;
			dbus_out16 = 8'hzz ;
			dbus_out17 = 8'hzz ;
			dbus_out18 = 8'hzz ;
			dbus_out19 = 8'hzz ;
			dbus_out20 = 8'hzz ;
		end
    end
endmodule