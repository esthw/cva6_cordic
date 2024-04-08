
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/27 17:55:54
// Design Name: 
// Module Name: float2fix64
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

module float2fix64
   import ariane_pkg::*;
#(
    parameter config_pkg::cva6_cfg_t CVA6Cfg = config_pkg::cva6_cfg_empty
) (
    input  riscv::xlen_t                   float_in,
    output logic    [`FIX64_LEN-1     : 0] fix64_out,
    output logic                   [7 : 0] overflow_flag               //overflow
);

    logic        [`FIX64_LEN-1   : 0] fix64_true;    //True form of fix point
    
    
    logic                             sign;                           // sign bit of float
    logic        [`E_LEN-1       : 0] e_b;      // exponent with bias of float
    logic        [`FIX64_LEN-1   : 0] m;        // mantissa of float
    
always_comb begin
 
   if(float_in == 32'h0000_0000)
   begin
        fix64_out = 64'h0000_0000_0000_0000;
   end
   else 
   begin
        m = {8'h00, 1'b1, float_in[`M_LEN-1:0]};
        e_b = float_in[(`FLOAT_LEN-1-`S_LEN):(`FLOAT_LEN-1-`E_LEN)];
        //e_b = float_in[30 : 23];
        if(e_b > (`E_BIAS-(`FIX64INT_LEN-`M_LEN)))  // `E_BIAS-(`FXI64INT_LEN-`M_LEN) = 118
        begin
             if (e_b > (`FIX64INT_LEN+`E_BIAS))  
             begin
                fix64_true = 64'hffff_ffff_ffff_ffff;  // overflow
                overflow_flag = 1;
             end
             else         
             begin
                fix64_true = (m << (e_b-(`E_BIAS-`FIX64INT_LEN+`M_LEN)));  // e_b-(`E_BIAS-`FXI64INT_LEN+`M_LEN) = e_b-118
                overflow_flag = 0;
             end
        end
        else
        begin
             if (e_b < (`E_BIAS-`FIX64INT_LEN))  
             begin
                fix64_true = 64'h0000_0000_0000_0000;   // overflow  
                overflow_flag = 2;
             end
             else
             begin
                fix64_true = (m >> (`E_BIAS+`M_LEN-`FIX64INT_LEN-e_b));  // `E_BIAS+`M_LEN-`FXI64INT_LEN-e_b = 118 - e_b
                overflow_flag = 0;
             end
        end
        
        if (float_in[`FLOAT_LEN-1] == 1'b0)
        begin
            fix64_out = fix64_true;
        end
        else
        begin
            fix64_out = (~fix64_true) + 1;
        end
     end     
end

endmodule
