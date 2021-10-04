`timescale 1ns / 1ps

module transmit_debouncing #(parameter threshold = 250000)// set parameter thresehold to guage how long button pressed
(
input Clock, //clock signal
input button, //input button for transmit
output reg transmit //transmit signal
    );
    
reg button_ff1 = 0; //button flip-flop for synchronization. Initialize it to 0
reg button_ff2 = 0; //button flip-flop for synchronization. Initialize it to 0
reg [17:0]count = 0; //20 bits count for increment & decrement when button is pressed or released. Initialize it to 0 
reg flag=0;


always @(posedge Clock)begin
button_ff1 <= button;
button_ff2 <= button_ff1;
end

// When the push-button is pushed or released, we increment or decrement the counter
// The counter has to reach threshold before we decide that the push-button state has changed
always @(posedge Clock) begin 
 if (button_ff2) //if button_ff2 is 1
     begin
        if (~&count)//if it isn't at the count limit. Make sure won't count up at the limit. First AND all count and then not the AND
            count <= count+1; // when btn pressed, count up
     end 
 else 
 begin
    flag=0;
    if (|count)//if count has at least 1 in it. Make sure no subtraction when count is 0 
        count <= count-1; //when btn relesed, count down
 end
 if (count > threshold && flag==0)//if the count is greater the threshold 
    begin
        transmit <= 1; //debounced signal is 1
        flag =1;
    end
 else
    transmit <= 0; //debounced signal is 0
end


endmodule
