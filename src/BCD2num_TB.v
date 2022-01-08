`timescale 1ns / 1ps
module BCD2num_TB;
  //Inputs
  reg [3:0] num1;
  reg [3:0] num2;
  reg clk;
  reg rst;
  //Outputs
  wire [0:6] sseg;
  wire [3:0] an;
  //Instantiate the Unit Under Test (UUT)
  BCD4bitsWreg uut (
    .num1(num1),
    .num2(num2),
    .clk(clk),
    .sseg(sseg),
    .an(an),
	  .rst(rst)
  );
  initial begin
  //Initialize Inputs
  clk = 0;
  rst = 0;
  num1 = 5;
  num2 = 15;
  rst = 1; //Habilita el divisor de frecuencia para la visualización
  end
  //Emulación de los pulsos de reloj para que todo funcione
  always #1 clk = ~clk;
  initial begin: TEST_CASE
		$dumpfile("TestBench.vcd");
		#(1000000) $stop;
 	end
endmodule
