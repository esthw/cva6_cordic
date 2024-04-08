module sin_cos
    import ariane_pkg::*;
#(
    parameter config_pkg::cva6_cfg_t CVA6Cfg = config_pkg::cva6_cfg_empty
) (
    input  logic                             clk_i,
    input  logic                             rst_ni,
    input  logic                             flush_i,
    input  logic         [TRANS_ID_BITS-1:0] trans_id_i,
    input  logic                             valid_i,
    input  fu_op                             operation_i,
    input logic                       [63:0] fix64_in,
    output logic                      [63:0] fix64_out,
    output logic                             valid_o,
    output logic                             ready_o,
    output logic         [TRANS_ID_BITS-1:0] trans_id_o
);


    logic              [4 :0] cnt;
    logic                     triangle_flag;
    logic signed       [63:0] sin;
    logic signed       [63:0] cos;


    logic signed 	    [63:0] x0=0,y0=0,z0=0;
    logic signed 	   	[63:0] x1=0,y1=0,z1=0;
    logic signed 	   	[63:0] x2=0,y2=0,z2=0;
    logic signed 	   	[63:0] x3=0,y3=0,z3=0;
    logic signed 	   	[63:0] x4=0,y4=0,z4=0;
    logic signed 	   	[63:0] x5=0,y5=0,z5=0;
    logic signed 	   	[63:0] x6=0,y6=0,z6=0;
    logic signed 	   	[63:0] x7=0,y7=0,z7=0;
    logic signed 	   	[63:0] x8=0,y8=0,z8=0;
    logic signed	   	[63:0] x9=0,y9=0,z9=0;
    logic signed 	   	[63:0] x10=0,y10=0,z10=0;
    logic signed 	   	[63:0] x11=0,y11=0,z11=0;
    logic signed 	   	[63:0] x12=0,y12=0,z12=0;
    logic signed 	   	[63:0] x13=0,y13=0,z13=0;
    logic signed 	   	[63:0] x14=0,y14=0,z14=0;
    logic signed 	   	[63:0] x15=0,y15=0,z15=0;
    logic signed 	   	[63:0] x16=0,y16=0,z16=0;

    

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x0    <= 1'b0; 						
		y0    <= 1'b0;
		z0    <= 1'b0;
	end
	else 
	begin
		x0    <= `k;
		y0    <=  64'd0;
		z0    <= fix64_in;
	end

end


always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x1 <= 1'b0; 						
		y1 <= 1'b0;
		z1 <= 1'b0;
	end
	else
	begin
        if(z0[`sign_bit])
        begin
          x1 <= x0 + y0;
          y1 <= y0 - x0;
          z1 <= z0 + `rot0;
        end
        else
        begin
          x1 <= x0 - y0;
          y1 <= y0 + x0;
          z1 <= z0 - `rot0;
        end
	end

end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x2 <= 1'b0; 						
		y2 <= 1'b0;
		z2 <= 1'b0;
	end
	else 
	begin
	   if(z1[`sign_bit])
        begin
            x2 <= x1 + (y1 >>> 1);
            y2 <= y1 - (x1 >>> 1);
            z2 <= z1 + `rot1;
        end
        else
        begin
           x2 <= x1 - (y1 >>> 1);
           y2 <= y1 + (x1 >>> 1);
           z2 <= z1 - `rot1;
        end
    end
    
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x3 <= 1'b0; 						
		y3 <= 1'b0;
		z3 <= 1'b0;
	end
	else 
	begin
        if(z2[`sign_bit])
        begin
            x3 <= x2 + (y2 >>> 2);
            y3 <= y2 - (x2 >>> 2);
            z3 <= z2 + `rot2;
        end
        else
        begin
           x3 <= x2 - (y2 >>> 2);
           y3 <= y2 + (x2 >>> 2);
           z3 <= z2 - `rot2;
        end
    end
   
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x4 <= 1'b0; 						
		y4 <= 1'b0;
		z4 <= 1'b0;
	end
    else 
    begin
        if(z3[`sign_bit])
        begin
            x4 <= x3 + (y3 >>> 3);
            y4 <= y3 - (x3 >>> 3);
            z4 <= z3 + `rot3;
        end
        else
        begin
           x4 <= x3 - (y3 >>> 3);
           y4 <= y3 + (x3 >>> 3);
           z4 <= z3 - `rot3;
        end
    end
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x5 <= 1'b0; 						
		y5 <= 1'b0;
		z5 <= 1'b0;
	end
    else
    begin
        if(z4[`sign_bit])
        begin
            x5 <= x4 + (y4 >>> 4);
            y5 <= y4 - (x4 >>> 4);
            z5 <= z4 + `rot4;
        end
        else
        begin
           x5 <= x4 - (y4 >>> 4);
           y5 <= y4 + (x4 >>> 4);
           z5 <= z4 - `rot4;
        end
    end
    
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x6 <= 1'b0; 						
		y6 <= 1'b0;
		z6 <= 1'b0;
	end
    else
    begin
        if(z5[`sign_bit])
        begin
            x6 <= x5 + (y5 >>> 5);
            y6 <= y5 - (x5 >>> 5);
            z6 <= z5 + `rot5;
        end
        else
        begin
           x6 <= x5 - (y5 >>> 5);
           y6 <= y5 + (x5 >>> 5);
           z6 <= z5 - `rot5;
        end
    end
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x7 <= 1'b0; 						
		y7 <= 1'b0;
		z7 <= 1'b0;
	end
    else 
    begin
        if(z6[`sign_bit])
        begin
            x7 <= x6 + (y6 >>> 6);
            y7 <= y6 - (x6 >>> 6);
            z7 <= z6 + `rot6;
        end
        else
        begin
           x7 <= x6 - (y6 >>> 6);
           y7 <= y6 + (x6 >>> 6);
           z7 <= z6 - `rot6;
        end
    end
    
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x8 <= 1'b0; 						
		y8 <= 1'b0;
		z8 <= 1'b0;
	end
    else 
    begin
        if(z7[`sign_bit])
        begin
            x8 <= x7 + (y7 >>> 7);
            y8 <= y7 - (x7 >>> 7);
            z8 <= z7 + `rot7;
        end
        else
        begin
           x8 <= x7 - (y7 >>> 7);
           y8 <= y7 + (x7 >>> 7);
           z8 <= z7 - `rot7;
        end
    end
   
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x9 <= 1'b0; 						
		y9 <= 1'b0;
		z9 <= 1'b0;
	end
    else 
    begin
        if(z8[`sign_bit])
        begin
            x9 <= x8 + (y8 >>> 8);
            y9 <= y8 - (x8 >>> 8);
            z9 <= z8 + `rot8;
        end
        else
        begin
           x9 <= x8 - (y8 >>> 8);
           y9 <= y8 + (x8 >>> 8);
           z9 <= z8 - `rot8;
        end
    end
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x10 <= 1'b0; 						
		y10 <= 1'b0;
		z10 <= 1'b0;
	end
    else
    begin
        if(z9[`sign_bit])
        begin
            x10 <= x9 + (y9 >>> 9);
            y10 <= y9 - (x9 >>> 9);
            z10 <= z9 + `rot9;
        end
        else
        begin
           x10 <= x9 - (y9 >>> 9);
           y10 <= y9 + (x9 >>> 9);
           z10 <= z9 - `rot9;
        end
    end
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x11 <= 1'b0; 						
		y11 <= 1'b0;
		z11 <= 1'b0;
	end
    else 
    begin
        if(z10[`sign_bit])
        begin
            x11 <= x10 + (y10 >>> 10);
            y11 <= y10 - (x10 >>> 10);
            z11 <= z10 + `rot10;
        end
        else
        begin
           x11 <= x10 - (y10 >>> 10);
           y11 <= y10 + (x10 >>> 10);
           z11 <= z10 - `rot10;
        end
    end
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x12 <= 1'b0; 						
		y12 <= 1'b0;
		z12 <= 1'b0;
	end
    else 
    begin
        if(z11[`sign_bit])
        begin
            x12 <= x11 + (y11 >>> 11);
            y12 <= y11 - (x11 >>> 11);
            z12 <= z11 + `rot11;
        end
        else
        begin
           x12 <= x11 - (y11 >>> 11);
           y12 <= y11 + (x11 >>> 11);
           z12 <= z11 - `rot11;
        end
    end
    
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x13 <= 1'b0; 						
		y13 <= 1'b0;
		z13 <= 1'b0;
	end
    else
    begin
        if(z12[`sign_bit])
        begin
            x13 <= x12 + (y12 >>> 12);
            y13 <= y12 - (x12 >>> 12);
            z13 <= z12 + `rot12;
        end
        else
        begin
           x13 <= x12 - (y12 >>> 12);
           y13 <= y12 + (x12 >>> 12);
           z13 <= z12 - `rot12;
        end
    end
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x14 <= 1'b0; 						
		y14 <= 1'b0;
		z14 <= 1'b0;
	end
	else 
    begin
        if(z13[`sign_bit])
        begin
            x14 <= x13 + (y13 >>> 13);
            y14 <= y13 - (x13 >>> 13);
            z14 <= z13 + `rot13;
        end
        else
        begin
           x14 <= x13 - (y13 >>> 13);
           y14 <= y13 + (x13 >>> 13);
           z14 <= z13 - `rot13;
        end
    end
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x15 <= 1'b0; 						
		y15 <= 1'b0;
		z15 <= 1'b0;
	end
	else
    begin
        if(z14[`sign_bit])
        begin
            x15 <= x14 + (y14 >>> 14);
            y15 <= y14 - (x14 >>> 14);
            z15 <= z14 + `rot14;
        end
        else
        begin
           x15 <= x14 - (y14 >>> 14);
           y15 <= y14 + (x14 >>> 14);
           z15 <= z14 - `rot14;
        end
    end
end

always_ff @(posedge clk_i or negedge rst_ni)
begin
	if(!rst_ni || flush_i)
	begin
		x16 <= 1'b0; 						
		y16 <= 1'b0;
		z16 <= 1'b0;
		cnt <= 0;
		triangle_flag <= 1'b0;
		
	end
	else 
    begin
        if(z15[`sign_bit])
        begin
            x16 <= x15 + (y15 >>> 15);
            y16 <= y15 - (x15 >>> 15);
            z16 <= z15 + `rot15;
        end
        else
        begin
           x16 <= x15 - (y15 >>> 15);
           y16 <= y15 + (x15 >>> 15);
           z16 <= z15 - `rot15;
        end  
        
        cnt <= cnt + 1;
        if (cnt == 16)
        begin
            triangle_flag <= 1'b1;
            trans_id_o <= trans_id_i; // ?
        end
        else
        begin
            triangle_flag <= 1'b0;
        end
            
    end
end


assign fix64_out = (operation_i==SIN) ? y16 : ((operation_i==COS) ? x16 : 'd0) ;
assign ready_o = triangle_flag ;
assign valid_o = ~flush_i && valid_i && (operation_i inside {SIN, COS}) && triangle_flag ;


// always_comb begin

//     cos = x16; 						
// 	sin = y16;
   
    
//     if(operation_i == SIN)
//     begin
//         fix64_out = sin;  
//     end
//     else
//     begin
//          fix64_out = cos; 
//     end
// end
    
endmodule
