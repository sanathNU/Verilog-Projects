`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2021 18:39:25
// Design Name: 
// Module Name: tb
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


module tb();

reg j,k, clk;
wire q, qbar;

initial clk = 0;

always #5 clk = ~clk;

JKff j1(j,k,clk,q,qbar);

initial begin
j <= 0; k <= 0;
#10 j <= 0; k <= 1;
#10 j <= 1; k <= 0;
#10 j <= 1; k <= 1;
#20 $stop;
end

endmodule
