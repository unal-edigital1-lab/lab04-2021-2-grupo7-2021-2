`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   21:29:15 10/17/2019
// Design Name:   BancoRegistro
// Module Name:   C:/Users/UECCI/Documents/GitHub/SPARTAN6-ATMEGA-MAX5864/lab/lab07-BancosRgistro/bancoreg/src/TestBench.v
// Project Name:  lab07-BancosRgistro
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: BancoRegistro
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module TestBench;

	// Inputs
	reg [2:0] addrRa;
	reg [2:0] addrRb;
	reg [2:0] addrW;
	reg [3:0] datW;
	reg RegWrite;
	reg clk;
	reg rst;

	// Outputs
	wire [3:0] datOutRa;
	wire [3:0] datOutRb;

  //Contador para la lectura (De 8 bits por el tamaño de addrRa y addrRb)
	reg [2:0] i;

	// Instantiate the Unit Under Test (UUT)
	BancoRegistro uut (
		.addrRa(addrRa),
		.addrRb(addrRb),
		.datOutRa(datOutRa),
		.datOutRb(datOutRb),
		.addrW(addrW),
		.datW(datW),
		.RegWrite(RegWrite),
		.clk(clk),
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		addrRa = 0;
		addrRb = 0;
		addrW = 0;
		datW = 0;
		RegWrite = 1; //Habilita la carga
		clk = 0;
		rst = 0;

		//Carga algunos datos sucesivos
		for (addrW = 0; addrW < 8; addrW = addrW +1) begin
			#2 datW = datW + 1;
		end
		#2 RegWrite = 0; //Habilita la lectura
		//Lee los primeros 16 registros (en paralelo)
		for (i = 0; i < 4; i = i + 1) begin
			addrRa = i; //Lee del Reg_0 al Reg_7
			addrRb = i + 4; //Lee del Reg_7 al Reg_15
			#2 $display("El Valor de Registro %d = %d  y %d = %d", addrRa, datOutRa, addrRb, datOutRb);
    end
	end
	//Emulación de los pulsos de reloj para que todo funcione
	always #1 clk = ~clk;
	initial begin: TEST_CASE
		$dumpfile("TestBench.vcd");
		#(56) $stop;
 	end
endmodule
