`timescale 1ns / 1ps

module intc_top(
  input [1:0] A, //ADDRESS PORT
  input rst, clk, WE,
  input [31:0] WD,
  input done1, done2, done3, done4, //connections go into intc
  //input iack [3:0],//connections go into intc
  
  output [31:0] Eaddr,
  output [3:0] irq,
  output [31:0] RD  //iack_reg output to MIPS
);
 
 wire WE1;
 wire [3:0] iack; 
 wire [31:0] iack_out;
 assign iack = WD[3:0];

  
//Add instances of all modules used in the design

//address decoder for intc
 intc_ad intc_ad(
    .A(A), //3b  connects A of intc_ad to module in this file intc_top
    .WE(WE),//1b
    .WE1(WE1)//IACK 1b
    
    //.RdSel(RdSel)   //3b
  );

//route signals from wrapper directly to INTC
  intc intc (
      //.INTC module external module port (internal module relative to intc_top)
      .sys_clk (clk),
      .rst (rst),
      .iack (WD[3:0]),
      .done1 (done1),
      .done2 (done2),
      .done3 (done3),
      .done4 (done4),
      .PC_handler (Eaddr),
      .irq (irq)

  );
  

//memory map from helper.v
  dreg_en iack_reg(
    .clk(clk),
    .rst(rst),
    .en(WE1),
    .d(WD),
    .q(RD)
  );
  
   //assign RD = iack_out;


  /*mux4 #32 mux_4_1(
    .sel(RdSel),
    .a({28'b0, n}),
    .b({31'b0, Go}),
    .c({30'b0, ResErr, ResDone}),
    .d(Result),
    .y(RD)
  );*/

endmodule
