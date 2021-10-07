# 4 Bit ALU
This folder contains source codes and testbenches for a simple 4 bit ALU implemented in Verilog.<br>
This was created to test combinational circuit on an FPGA.
## LOGIC
The logic of ALU is controlled by 3-Bit Select lines called Sel. There are 2 4-bit inputs.
| Select Line Value | Operation |
| ------------ | --------- |
|  000         | A         |
|  001         | A+B       |
|  010         | A-B       |
|  011         | A/B       |
|  100         | A % B     |
|  101         | A <<1     |
|  110         | A >>1     |
|  111         | A >B      |

Also contains a XDC file for Basys 3 FPGA board


![ schematic](https://github.com/sanathNU/Verilog-Projects/blob/528e074816381da27b3dfaac603f4e3cc41b949b/4%20Bit%20Arithmetic%20Logic%20Unit/image.png)
