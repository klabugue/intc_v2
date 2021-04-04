`timescale 1ns / 1ps

module intc(
input wire clk,
input wire iack,
input wire rst,
input wire done1,
input wire done2,
input wire done3,
input wire done4,
output [31:0] PC_handler,
output irq

    );
    
    wire done1_out, done2_out, done3_out, done4_out;
    wire iack_out;
    wire [3:0] done_main;
    wire [3:0] rst_main;
    wire [3:0] reset_link;
    assign rst_main[0] = reset_link[0] & iack_out;
    assign rst_main[1] = reset_link[1] & iack_out;
    assign rst_main[2] = reset_link[2] & iack_out;
    assign rst_main[3] = reset_link[3] & iack_out;
    assign done_main = {done4_out, done3_out, done2_out, done1_out};
    
    pr_enc pr_enc(
        .clk (clk),
        .rst (rst),
        .done (done_main),
        .PC_handler(PC_handler),
        .acc_reset (reset_link),
        .irq(irq)
    );
    
    dreg_en # (1) done1_reg(
        .clk(clk),
        .en(done1),
        .d(done1),
        .q(done1_out)
    );
    
     dreg_en # (1) done2_reg(
        .clk(clk),
        .en(done2),
        .d(done2),
        .q(done2_out)
    );
    
    dreg_en # (1) done3_reg(
        .clk(clk),
        .en(done3),
        .d(done3),
        .q(done3_out)
   );
   
   dreg_en # (1) done4_reg(
        .clk(clk),
        .en(done4),
        .d(done4),
        .q(done4_out)
  );
  
  ff iack_reg(
       .clk(clk),
       .rst(rst),
       .en(iack),
       .q(iack_out)
 );

endmodule