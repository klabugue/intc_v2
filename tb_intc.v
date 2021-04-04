`timescale 1ns / 1ps

module tb_intc();
    reg clk, rst, done1, done2, done3, done4;
    reg iack;
    wire [31:0] PC_handler;
    wire irq;
    
    intc intc (
    .clk(clk),
    .iack(iack),
    .rst(rst),
    .done1(done1),
    .done2(done2),
    .done3(done3),
    .done4(done4), 
    .PC_handler(PC_handler),
    .irq(irq)
    );
    
    always begin
        #5 clk = ~clk;
    end
    
    initial begin
    clk = 0; rst = 0; 
    #5 rst = 1; iack = 0;
    #10 rst = 0; done1 = 1'b1; done2 = 1'b1; done3 = 1'b1; done4 = 1'b1;
    #10 done1 = 1'b0; done2 = 1'b0; done3 = 1'b0; done4 = 1'b0;
    #10 iack = 1;
    #10 iack = 0;
    #10;
    done1 = 1'b0; done2 = 1'b1; done3 = 1'b1; done4 = 1'b1;
    #10 iack = 1;
    #10 iack = 0;
    #10;
    #10 iack = 1;
    #10 iack = 0;
    #10;
    #10 iack = 1;
    #10 iack = 0;
    #10;
    #10 iack = 1;
    #10 iack = 0;
    #10;
    end
    
endmodule
