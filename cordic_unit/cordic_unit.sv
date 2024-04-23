module cordic_unit
    import ariane_pkg::*;
#(
    parameter config_pkg::cva6_cfg_t CVA6Cfg = config_pkg::cva6_cfg_empty
) (
    input  logic                             clk_i,
    input  logic                             rst_ni,
    input  logic                             flush_i,
    input  fu_data_t                         fu_data_i,
    input  logic                             cordic_valid_i,
    output riscv::xlen_t                     result_o,
    output logic                             cordic_valid_o,
    output logic                             cordic_ready_o,
    output logic         [TRANS_ID_BITS-1:0] cordic_trans_id_o
);

    logic                [             63:0] fix64_in;
    logic                [             63:0] fix64_out;
    
    // logic        [7 :0] overflow_flag;

  
    
    float2fix64     u_float2fix64(
                                    .float_in(fu_data_i.operand_a),
                                    .fix64_out(fix64_in),
                                    .overflow_flag()
                                    );

     sin_cos         u_sin_cos(     
                                    .clk_i          (clk_i),
                                    .rst_ni          (rst_ni),
                                    .flush_i        (flush_i),
                                    .trans_id_i     (fu_data_i.trans_id),
                                    .valid_i        (cordic_valid_i),
                                    .operation_i    (fu_data_i.operation),           //mode : 1->sin    0->cos
                                    .fix64_in       (fix64_in),
                                    .fix64_out      (fix64_out),
                                    .valid_o        (cordic_valid_o),
                                    .ready_o        (cordic_ready_o),
                                    .trans_id_o     (cordic_trans_id_o)               
                                    );

     fix642float     u_fix642float(
                                    .fix64_in(fix64_out),
                                    .float_out(result_o)
                                    );



endmodule
