module tb();

reg [3:0] a,b;
reg [2:0] s;
wire [4:0] O;

initial begin
a = 4'd6;
b = 4'd4;
s = 3'd0;
end

FourBalu uut(a,b,s,O);

always #5 s <= (s+1);

endmodule