
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/27 21:01:53
// Design Name: 
// Module Name: fix642float
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



/*

fix 64bit  :  
integer   :  32bit
decimal   :  32bit

*/

module fix642float
    import ariane_pkg::*;
#(
    parameter config_pkg::cva6_cfg_t CVA6Cfg = config_pkg::cva6_cfg_empty
) (
    input         [`FIX64_LEN-1:0] fix64_in,
    output riscv::xlen_t           float_out
);


    logic     [`FIX64_LEN-1:0]       fix64_ture;
    logic     [`MSB_LEN-1:0]         msb_position;
    logic     [31:0]                 dat_32;
    logic     [15:0]                 dat_16;
    logic     [7 :0]                 dat_8;  
    logic     [3 :0]                 dat_4;  
    logic     [1 :0]                 dat_2;
    logic     [`E_LEN-1 :0]           e;
    logic     [`FIX32_LEN-1 :0]       m;

    always_comb
begin

            if (!fix64_in[`FIX64_LEN-1])
            begin
                 
                fix64_ture   = fix64_in; 
                float_out[`FLOAT_LEN-1] = 1'b0;                                    
            end
            else
            begin
                
                fix64_ture   = ~(fix64_in-1); 
                float_out[`FLOAT_LEN-1] = 1'b1;
            end
            /*******************  reference : https://blog.csdn.net/wangn1633/article/details/108074727  *****************/
            msb_position[5]  =| fix64_ture[63:32];
            dat_32           =| msb_position[5] ? fix64_ture[63:32] : fix64_ture[31:0];
            msb_position[4]  =| dat_32[31:16];
            dat_16           =  msb_position[4] ? dat_32[31:16] : dat_32[15:0];         
            msb_position[3]  =| dat_16[15:8];
            dat_8            =  msb_position[3] ? dat_16[15:8]  : dat_16[7:0];            
            msb_position[2]  =| dat_8[7:4];
            dat_4            =  msb_position[2] ? dat_8[7:4]  : dat_8[3:0]; 
            msb_position[1]  =| dat_4[3:2];
            dat_2            =  msb_position[1] ? dat_4[3:2]  : dat_4[1:0];      
            msb_position[0]  =  dat_2[1];          
            /*************************************************************************************************************/
            
            if(msb_position==`MSB_LEN'b000000)
            begin
                if(fix64_ture[0])  // when msb_position=0, lsb of m reg can be 0 or 1;
                begin
                    e = `E_BIAS  - `FIX64INT_LEN;
                end
                else
                begin
                    e = 0;
                end
            end
            else
            begin
                e = `E_BIAS  - `FIX64INT_LEN + {2'b00, msb_position};
            end

            //mantissa[msb_position-1:0] = dat_ture[msb_position-1:0];
            case(msb_position)
            `MSB_LEN'b000000 : begin  m[`M_LEN-1:0] = {{23{1'b0}}};    end    // when msb_position=0, lsb of m reg can be 0 or 1;
            `MSB_LEN'b000001 : begin  m[`M_LEN-1:0] = {fix64_ture[0],{22{1'b0}}};    end
            `MSB_LEN'b000010 : begin  m[`M_LEN-1:0] = {fix64_ture[1:0],{21{1'b0}}};  end
            `MSB_LEN'b000011 : begin  m[`M_LEN-1:0] = {fix64_ture[2:0],{20{1'b0}}};  end
            `MSB_LEN'b000100 : begin  m[`M_LEN-1:0] = {fix64_ture[3:0],{19{1'b0}}};  end
            `MSB_LEN'b000101 : begin  m[`M_LEN-1:0] = {fix64_ture[4:0],{18{1'b0}}};  end            
            `MSB_LEN'b000110 : begin  m[`M_LEN-1:0] = {fix64_ture[5:0],{17{1'b0}}};  end
            `MSB_LEN'b000111 : begin  m[`M_LEN-1:0] = {fix64_ture[6:0],{16{1'b0}}};  end
            
            `MSB_LEN'b001000 : begin   m[`M_LEN-1:0] = {fix64_ture[7:0], {15{1'b0}}};  end
            `MSB_LEN'b001001 : begin   m[`M_LEN-1:0] = {fix64_ture[8:0], {14{1'b0}}};  end
            `MSB_LEN'b001010 : begin   m[`M_LEN-1:0] = {fix64_ture[9:0], {13{1'b0}}};  end            
            `MSB_LEN'b001011 : begin   m[`M_LEN-1:0] = {fix64_ture[10:0],{12{1'b0}}};  end
            `MSB_LEN'b001100 : begin   m[`M_LEN-1:0] = {fix64_ture[11:0],{11{1'b0}}};  end
            `MSB_LEN'b001101 : begin   m[`M_LEN-1:0] = {fix64_ture[12:0],{10{1'b0}}};  end
            `MSB_LEN'b001110 : begin   m[`M_LEN-1:0] = {fix64_ture[13:0],{9{1'b0}}};   end
            `MSB_LEN'b001111 : begin   m[`M_LEN-1:0] = {fix64_ture[14:0],{8{1'b0}}};   end
            
            `MSB_LEN'b010000 : begin   m[`M_LEN-1:0] = {fix64_ture[15:0],{7{1'b0}}}; end
            `MSB_LEN'b010001 : begin   m[`M_LEN-1:0] = {fix64_ture[16:0],{6{1'b0}}}; end
            `MSB_LEN'b010010 : begin   m[`M_LEN-1:0] = {fix64_ture[17:0],{5{1'b0}}}; end            
            `MSB_LEN'b010011 : begin   m[`M_LEN-1:0] = {fix64_ture[18:0],{4{1'b0}}}; end
            `MSB_LEN'b010100 : begin   m[`M_LEN-1:0] = {fix64_ture[19:0],{3{1'b0}}}; end
            `MSB_LEN'b010101 : begin   m[`M_LEN-1:0] = {fix64_ture[20:0],{2{1'b0}}}; end
            `MSB_LEN'b010110 : begin   m[`M_LEN-1:0] = {fix64_ture[21:0],{1{1'b0}}}; end
            `MSB_LEN'b010111 : begin   m[`M_LEN-1:0] = {fix64_ture[22:0]};           end
            
            `MSB_LEN'b011000 : begin   m[`M_LEN-1:0] = {fix64_ture[23:1]}; end
            `MSB_LEN'b011001 : begin   m[`M_LEN-1:0] = {fix64_ture[24:2]}; end
            `MSB_LEN'b011010 : begin   m[`M_LEN-1:0] = {fix64_ture[25:3]}; end            
            `MSB_LEN'b011011 : begin   m[`M_LEN-1:0] = {fix64_ture[26:4]}; end
            `MSB_LEN'b011100 : begin   m[`M_LEN-1:0] = {fix64_ture[27:5]}; end
            `MSB_LEN'b011101 : begin   m[`M_LEN-1:0] = {fix64_ture[28:6]}; end
            `MSB_LEN'b011110 : begin   m[`M_LEN-1:0] = {fix64_ture[29:7]}; end
            `MSB_LEN'b011111 : begin   m[`M_LEN-1:0]  ={fix64_ture[30:8]}; end
            
            `MSB_LEN'b100000 : begin   m[`M_LEN-1:0] = {fix64_ture[31:9]};  end
            `MSB_LEN'b100001 : begin   m[`M_LEN-1:0] = {fix64_ture[32:10]}; end
            `MSB_LEN'b100010 : begin   m[`M_LEN-1:0] = {fix64_ture[33:11]}; end            
            `MSB_LEN'b100011 : begin   m[`M_LEN-1:0] = {fix64_ture[34:12]}; end
            `MSB_LEN'b100100 : begin   m[`M_LEN-1:0] = {fix64_ture[35:13]}; end
            `MSB_LEN'b100101 : begin   m[`M_LEN-1:0] = {fix64_ture[36:14]}; end
            `MSB_LEN'b100110 : begin   m[`M_LEN-1:0] = {fix64_ture[37:15]}; end
            `MSB_LEN'b100111 : begin   m[`M_LEN-1:0]  ={fix64_ture[38:16]}; end
            
            `MSB_LEN'b101000 : begin   m[`M_LEN-1:0] = {fix64_ture[39:17]};  end
            `MSB_LEN'b101001 : begin   m[`M_LEN-1:0] = {fix64_ture[40:18]};  end
            `MSB_LEN'b101010 : begin   m[`M_LEN-1:0] = {fix64_ture[41:19]};  end            
            `MSB_LEN'b101011 : begin   m[`M_LEN-1:0] = {fix64_ture[42:20]};  end
            `MSB_LEN'b101100 : begin   m[`M_LEN-1:0] = {fix64_ture[43:21]};  end
            `MSB_LEN'b101101 : begin   m[`M_LEN-1:0] = {fix64_ture[44:22]};  end
            `MSB_LEN'b101110 : begin   m[`M_LEN-1:0] = {fix64_ture[45:23]};  end
            `MSB_LEN'b101111 : begin   m[`M_LEN-1:0]  ={fix64_ture[46:24]};  end
            
            `MSB_LEN'b110000 : begin   m[`M_LEN-1:0] = {fix64_ture[47:25]};  end
            `MSB_LEN'b110001 : begin   m[`M_LEN-1:0] = {fix64_ture[48:26]};  end
            `MSB_LEN'b110010 : begin   m[`M_LEN-1:0] = {fix64_ture[49:27]};  end            
            `MSB_LEN'b110011 : begin   m[`M_LEN-1:0] = {fix64_ture[50:28]};  end
            `MSB_LEN'b110100 : begin   m[`M_LEN-1:0] = {fix64_ture[51:29]};  end
            `MSB_LEN'b110101 : begin   m[`M_LEN-1:0] = {fix64_ture[52:30]};  end
            `MSB_LEN'b110110 : begin   m[`M_LEN-1:0] = {fix64_ture[53:31]};  end
            `MSB_LEN'b110111 : begin   m[`M_LEN-1:0]  ={fix64_ture[54:32]};  end
            
            `MSB_LEN'b111000 : begin   m[`M_LEN-1:0] = {fix64_ture[55:33]};  end
            `MSB_LEN'b111001 : begin   m[`M_LEN-1:0] = {fix64_ture[56:34]};  end
            `MSB_LEN'b111010 : begin   m[`M_LEN-1:0] = {fix64_ture[57:35]};  end            
            `MSB_LEN'b111011 : begin   m[`M_LEN-1:0] = {fix64_ture[58:36]};  end
            `MSB_LEN'b111100 : begin   m[`M_LEN-1:0] = {fix64_ture[59:37]};  end
            `MSB_LEN'b111101 : begin   m[`M_LEN-1:0] = {fix64_ture[60:38]};  end
            `MSB_LEN'b111110 : begin   m[`M_LEN-1:0] = {fix64_ture[61:39]};  end
            `MSB_LEN'b111111 : begin   m[`M_LEN-1:0]  ={fix64_ture[62:40]};  end
            default: m = 0;
            endcase
            
            float_out[30:0] = {{e[`E_LEN-1:0]},{m[`M_LEN-1:0]}};    
    
end


endmodule
