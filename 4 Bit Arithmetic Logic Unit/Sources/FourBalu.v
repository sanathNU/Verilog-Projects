`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2021 21:27:25
// Design Name: 
// Module Name: FourBalu
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


module FourBalu(
    input [3:0] A,
    input [3:0] B,
    input [2:0] Sel,
    input clk,
    output [4:0] Out
    );
    reg [4:0] Out;
    
    initial Out=5'b0;
    always @(*)
    case(Sel)
    
    3'b000 :  Out = A;
    3'b001 :  Out = A+B;
    3'b010 :  Out = A-B;
    3'b011 :  Out = A/B;
    3'b100 :  Out = A%B;
    3'b101 :  Out = A<<1;
    3'b110 :  Out = A>>1;
    3'b111 :  Out =(A>B);
    endcase
    
endmodule
