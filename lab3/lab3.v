//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/28 15:34:04
// Design Name: 
// Module Name: top
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

`timescale 1ns / 1ps
module top(
    input CLK100MHZ,//clk
    input [15:0]SW,
    input BTNC,
    output [5:0]LED
    );
    wire [3:0] a, b, c, d;
    wire [5:0] sum;
    reg  [5:0] temp;
     assign a = SW[3:0];
     assign b = SW[7:4];
     assign c = SW[11:8];
     assign d = SW[15:12];
     assign LED = temp;
    /*****your design******/
    always @(posedge CLK100MHZ)begin
     if(BTNC) temp <= a + b + c + d;
     end
    /**********************/
endmodule
