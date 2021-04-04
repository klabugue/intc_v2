`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2021 04:17:55 PM
// Design Name: 
// Module Name: 4to32Encoder
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


module pr_enc(
input clk,
input rst,
input [3:0]			done,
output reg [31:0] 	PC_handler,
output reg [3:0] 	acc_reset, 
output reg			irq
    );
    
  always @ (posedge clk) begin
    if(done[0]) begin
        PC_handler <= 32'h00000000;  //Should this be 32'h00003000
        acc_reset <= 4'b0001;
        irq <= 1'b1;
    end
    else if (done[1]) begin
        PC_handler = 32'h00000004;
        acc_reset = 4'b0010;
        irq = 1'b1;
    end
    else if(done[2]) begin 
        PC_handler = 32'h00000008;
        acc_reset = 4'b0100;
        irq = 1'b1;
    end
    else if(done[3]) begin
        PC_handler = 32'h0000000c;
        acc_reset = 4'b1000;
        irq = 1'b1;
    end
    else
        begin
            irq = 0;
            PC_handler = 32'hxxxxxxxx;
            acc_reset = 4'b0000;
        end
    end
endmodule
