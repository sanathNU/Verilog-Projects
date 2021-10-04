module Top(
input [7:0]Switch, //input data from switches of fpga board
input button0,     // reset button stops transmission as long as this button is pressed
input button1,     // transmit button
input Flag1,       // Switch to control, dataflow to the transmitter
input Clock,       // Clock which is routed to board clock
input Rx_D,        // Serial UART reciever.
output TxD,        // Serial UART transmitter
output [7:0] RxData,// Output of receiver which is mapped to LEDs
output flag,        // flag variable to debug wheather the byte is received or not
output transmit     // flag variablet to debug wheather the byte is transmitted
); 

wire transmit;       
wire [7:0] temp;     //internal temp variable to decide dataflow depending on the input Flag1

// Note: Both transmitter and receiver work in parallel
assign temp = Flag1 ? Switch : RxData;  //data assign logic
transmit_debouncing m1 (.Clock(Clock), .button(button1), .transmit(transmit));  //button debouncer for transmitting
Transmitter T1(.Clock(Clock), .reset(button0),.transmit(transmit),.TxD(TxD),.data(temp)); //the actual transmitter
Receiver R1(.Clock(Clock),.reset(btn0),.RxD(Rx_D),.RxData(RxData),.flag(flag));   //the actual receiver

endmodule