// code to generate 8 bit pesuedo random numbers....let's see how this goes
module LFSR(
input clk,
input Enable,
input  [7:0] Seed_Data,
input seed_en,
output [7:0] RandNum,
output Gen_done
);

reg [8:1] intNum;
reg Xnor_bit;
reg clk_out;
reg [25:0] count=0;
 
always @(posedge clk)
    begin
    count<=count+1;
    if (count==50_000_00)
    begin
    count<=0;
    clk_out = ~clk_out;
    end
    end



always @(posedge clk_out)
begin
    if(seed_en)
        intNum <=Seed_Data;
    else
        if(Enable == 1'b1)
            intNum <= {intNum[7:1],Xnor_bit};

end

always @(*)
Xnor_bit <= intNum[8] ^~ intNum[6] ^~ intNum[5] ^~ intNum[4];

assign RandNum = intNum;
assign Gen_done = (intNum == Seed_Data) ? 1'b1: 1'b0;
endmodule
