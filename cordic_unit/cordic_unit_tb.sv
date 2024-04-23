`timescale 1ns/1ps

module cordic_unit_tb;

import ariane_pkg::*;
localparam config_pkg::cva6_cfg_t CVA6Cfg = cva6_config_pkg::cva6_cfg;

logic                             clk_i;
logic                             rst_ni;
logic                             flush_i;
fu_data_t                         fu_data_i;
logic                             cordic_valid_i;
riscv::xlen_t                     result_o;
logic                             cordic_valid_o;
logic                             cordic_ready_o;
logic         [TRANS_ID_BITS-1:0] cordic_trans_id_o;



initial 
begin
    #0
    clk_i = 0;
    rst_ni = 0;
    flush_i = 0;
    cordic_valid_i = 0;
    fu_data_i.operand_a = 'b0;
    fu_data_i.operation = 'b0;
    fu_data_i.trans_id = 'b0;

    #2
    rst_ni = 1;
    
    #20
    cordic_valid_i = 1;    
    fu_data_i.operand_a = 32'hbf00_0000;
    fu_data_i.operation = COS;
    fu_data_i.trans_id = 8'b0000_0001;
    
    #10 
    cordic_valid_i = 0;
    fu_data_i.operand_a = 'b0;
    fu_data_i.operation = 'b0;
    fu_data_i.trans_id = 'b0;
    
    #60
    cordic_valid_i = 1;    
    fu_data_i.operand_a = 32'h3f06_0a92;
    fu_data_i.operation = SIN;
    fu_data_i.trans_id = 8'b0000_0010;
    
    #10 
    cordic_valid_i = 0;
    fu_data_i.operand_a = 'b0;
    fu_data_i.operation = 'b0;
    fu_data_i.trans_id = 'b0;
    
    //#20
    //fu_data_i.trans_id = 8'b0000_0010;

    #300
    $stop;
end

always #5 clk_i = ~clk_i ;

cordic_unit dut(
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .flush_i(flush_i),
    .fu_data_i(fu_data_i),
    .cordic_valid_i(cordic_valid_i),
    .result_o(result_o),
    .cordic_valid_o(cordic_valid_o),
    .cordic_ready_o(cordic_ready_o),
    .cordic_trans_id_o(cordic_trans_id_o)

);

//`ifdef FSDB
 //   initial
 //   begin
//	    $fsdbDumpfile("cordic_unit_tb.fsdb");
//	    $fsdbDumpvars(0,cordic_unit_tb);
//    end
//`endif
initial begin
	$vcdpluson;
end



endmodule
