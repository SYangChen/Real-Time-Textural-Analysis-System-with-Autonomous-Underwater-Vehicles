module memory( rst, clk, en, r_w, abus, insign, indata, dbus_in1, dbus_in2, dbus_in3, dbus_in4, dbus_in5, dbus_in6, dbus_in7, dbus_in8, dbus_in9, dbus_in10, dbus_in11, dbus_in12, dbus_in13, dbus_in14, dbus_in15, dbus_in16, dbus_in17, dbus_in18, dbus_in19,  dbus_in20, dbus_in21, dbus_in22, dbus_in23, dbus_in24, dbus_in25, dbus_in26, dbus_in27, dbus_in28, dbus_in29, dbus_in30, dbus_in31, dbus_in32, dbus_in33, dbus_in34, dbus_in35, dbus_in36, dbus_in37, dbus_in38, dbus_in39, dbus_in40, dbus_in41, dbus_in42, dbus_in43, dbus_in44, dbus_in45, dbus_in46, dbus_in47, dbus_in48, dbus_in49, dbus_in50, dbus_out1, dbus_out2, dbus_out3, dbus_out4, dbus_out5, dbus_out6, dbus_out7, dbus_out8, dbus_out9, dbus_out10, dbus_out11, dbus_out12, dbus_out13, dbus_out14, dbus_out15, dbus_out16, dbus_out17, dbus_out18, dbus_out19,  dbus_out20, dbus_out21, dbus_out22, dbus_out23, dbus_out24, dbus_out25, dbus_out26, dbus_out27, dbus_out28, dbus_out29, dbus_out30, dbus_out31, dbus_out32, dbus_out33, dbus_out34, dbus_out35, dbus_out36, dbus_out37, dbus_out38, dbus_out39, dbus_out40, dbus_out41, dbus_out42, dbus_out43, dbus_out44, dbus_out45, dbus_out46, dbus_out47, dbus_out48, dbus_out49, dbus_out50 ) ;
	input rst, clk, en, r_w, insign ;
	input [15:0] abus ;
	input [7:0] indata, dbus_in1, dbus_in2, dbus_in3, dbus_in4, dbus_in5, dbus_in6, dbus_in7, dbus_in8, dbus_in9, dbus_in10, dbus_in11, dbus_in12, dbus_in13, dbus_in14, dbus_in15, dbus_in16, dbus_in17, dbus_in18, dbus_in19,  dbus_in20, dbus_in21, dbus_in22, dbus_in23, dbus_in24, dbus_in25, dbus_in26, dbus_in27, dbus_in28, dbus_in29, dbus_in30, dbus_in31, dbus_in32, dbus_in33, dbus_in34, dbus_in35, dbus_in36, dbus_in37, dbus_in38, dbus_in39, dbus_in40, dbus_in41, dbus_in42, dbus_in43, dbus_in44, dbus_in45, dbus_in46, dbus_in47, dbus_in48, dbus_in49, dbus_in50 ;
	output reg [7:0] dbus_out1, dbus_out2, dbus_out3, dbus_out4, dbus_out5, dbus_out6, dbus_out7, dbus_out8, dbus_out9, dbus_out10, dbus_out11, dbus_out12, dbus_out13, dbus_out14, dbus_out15, dbus_out16, dbus_out17, dbus_out18, dbus_out19,  dbus_out20, dbus_out21, dbus_out22, dbus_out23, dbus_out24, dbus_out25, dbus_out26, dbus_out27, dbus_out28, dbus_out29, dbus_out30, dbus_out31, dbus_out32, dbus_out33, dbus_out34, dbus_out35, dbus_out36, dbus_out37, dbus_out38, dbus_out39, dbus_out40, dbus_out41, dbus_out42, dbus_out43, dbus_out44, dbus_out45, dbus_out46, dbus_out47, dbus_out48, dbus_out49, dbus_out50 ;
	
	reg [7:0] m [0:2047] ;
	reg [7:0] data ;

    always @( posedge clk or posedge rst or posedge en or abus ) 
    begin
        if ( rst == 1 )
        begin
            m[1000] = 8'h10 ;
			m[1101] = 8'h10 ;
			dbus_out1 = 8'h00 ;
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
				m[abus+20] = dbus_in21 ;
				m[abus+21] = dbus_in22 ;
				m[abus+22] = dbus_in23 ;
				m[abus+23] = dbus_in24 ;
				m[abus+24] = dbus_in25 ;
				m[abus+25] = dbus_in26 ;
				m[abus+26] = dbus_in27 ;
				m[abus+27] = dbus_in28 ;
				m[abus+28] = dbus_in29 ;
				m[abus+29] = dbus_in30 ;
				m[abus+30] = dbus_in31 ;
				m[abus+31] = dbus_in32 ;
				m[abus+32] = dbus_in33 ;
				m[abus+33] = dbus_in34 ;
				m[abus+34] = dbus_in35 ;
				m[abus+35] = dbus_in36 ;
				m[abus+36] = dbus_in37 ;
				m[abus+37] = dbus_in38 ;
				m[abus+38] = dbus_in39 ;
				m[abus+39] = dbus_in40 ;
				m[abus+40] = dbus_in41 ;
				m[abus+41] = dbus_in42 ;
				m[abus+42] = dbus_in43 ;
				m[abus+43] = dbus_in44 ;
				m[abus+44] = dbus_in45 ;
				m[abus+45] = dbus_in46 ;
				m[abus+46] = dbus_in47 ;
				m[abus+47] = dbus_in48 ;
				m[abus+48] = dbus_in49 ;
				m[abus+49] = dbus_in50 ;
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
			dbus_out21 = m[abus+20] ;
			dbus_out22 = m[abus+21] ;
			dbus_out23 = m[abus+22] ;
			dbus_out24 = m[abus+23] ;
			dbus_out25 = m[abus+24] ;
			dbus_out26 = m[abus+25] ;
			dbus_out27 = m[abus+26] ;
			dbus_out28 = m[abus+27] ;
			dbus_out29 = m[abus+28] ;
			dbus_out30 = m[abus+29] ;
			dbus_out31 = m[abus+30] ;
			dbus_out32 = m[abus+31] ;
			dbus_out33 = m[abus+32] ;
			dbus_out34 = m[abus+33] ;
			dbus_out35 = m[abus+34] ;
			dbus_out36 = m[abus+35] ;
			dbus_out37 = m[abus+36] ;
			dbus_out38 = m[abus+37] ;
			dbus_out39 = m[abus+38] ;
			dbus_out40 = m[abus+39] ;
			dbus_out41 = m[abus+40] ;
			dbus_out42 = m[abus+41] ;
			dbus_out43 = m[abus+42] ;
			dbus_out44 = m[abus+43] ;
			dbus_out45 = m[abus+44] ;
			dbus_out46 = m[abus+45] ;
			dbus_out47 = m[abus+46] ;
			dbus_out48 = m[abus+47] ;
			dbus_out49 = m[abus+48] ;
			dbus_out50 = m[abus+49] ;
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
			dbus_out21 = 8'hzz ;
			dbus_out22 = 8'hzz ;
			dbus_out23 = 8'hzz ;
			dbus_out24 = 8'hzz ;
			dbus_out25 = 8'hzz ;
			dbus_out26 = 8'hzz ;
			dbus_out27 = 8'hzz ;
			dbus_out28 = 8'hzz ;
			dbus_out29 = 8'hzz ;
			dbus_out30 = 8'hzz ;
			dbus_out31 = 8'hzz ;
			dbus_out32 = 8'hzz ;
			dbus_out33 = 8'hzz ;
			dbus_out34 = 8'hzz ;
			dbus_out35 = 8'hzz ;
			dbus_out36 = 8'hzz ;
			dbus_out37 = 8'hzz ;
			dbus_out38 = 8'hzz ;
			dbus_out39 = 8'hzz ;
			dbus_out40 = 8'hzz ;
			dbus_out41 = 8'hzz ;
			dbus_out42 = 8'hzz ;
			dbus_out43 = 8'hzz ;
			dbus_out44 = 8'hzz ;
			dbus_out45 = 8'hzz ;
			dbus_out46 = 8'hzz ;
			dbus_out47 = 8'hzz ;
			dbus_out48 = 8'hzz ;
			dbus_out49 = 8'hzz ;
			dbus_out50 = 8'hzz ;
		end
    end
endmodule