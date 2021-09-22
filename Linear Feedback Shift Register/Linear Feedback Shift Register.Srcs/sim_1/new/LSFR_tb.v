module LSFR_tb;

reg clk = 1'b0;
wire [7:0] randNum;
wire DoneFlag;

LSFR l1(clk,1,8'hab,randNum,DoneFlag);

always #5 clk = ~clk;
endmodule