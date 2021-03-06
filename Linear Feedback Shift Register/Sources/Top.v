module top(
input clk, //clock signal
input Enable,
input btn1,
input btn0, //input buttons for reset
input [7:0] data, // data transmitted
input seed_en,
output TxD,
//output  transmit,//transmit signal
output DoneFlag,
output [7:0]RandNum
    );

    wire transmit;
    Db D2(clk,btn1,transmit);
    transmitter T1 (clk,btn0,transmit,RandNum,TxD);
    LFSR L1(clk,Enable,data,seed_en,RandNum,DoneFlag);
endmodule    
    
