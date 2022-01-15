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

  //Contador para la lectura
	reg [2:0] i;
	//Contador para la escritura
	reg [3:0] j;

	// Instantiate the Unit Under Test (UUT)
	BancoRegistro #(3,4) uut (
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
		RegWrite = 0;
		clk = 0;
		rst = 1;
		/*Lee el banco de 2 en 2 (en paralelo) para verificar la inicialización
		previa de la memoria con el archivo Reg8.mem*/
		$display("\nLectura de la inicializacion previa:");
		for (i = 0; i < 4; i = i + 1) begin
			addrRa = i; //Lee del Reg_0 al Reg_4
			addrRb = i + 4; //Lee del Reg_4 al Reg_8
			#2 $display("El Valor de Registro %d = %d  y %d = %d", addrRa, datOutRa, addrRb, datOutRb);
    end
		#2 RegWrite = 1; //Habilita la carga
		//Carga algunos datos sucesivos
		for (j = 0; j < 8; j = j + 1) begin
			addrW = j;
			datW = j;
			#2;
		end
		#2 RegWrite = 0; //Habilita la lectura
		$display("\nLectura luego de la carga:");
		//Lee el banco de 2 en 2
		for (i = 0; i < 4; i = i + 1) begin
			addrRa = i;
			addrRb = i + 4;
			#2 $display("El Valor de Registro %d = %d  y %d = %d", addrRa, datOutRa, addrRb, datOutRb);
    end
		#1 rst = 0; #1 rst = 1; //Borra el banco (Lo deja todo en 0000)
		$display("\nLectura luego del reset:");
		//Lee el banco de 2 en 2 para verificar el efecto del reset
		for (i = 0; i < 4; i = i + 1) begin
			addrRa = i;
			addrRb = i + 4;
			#2 $display("El Valor de Registro %d = %d  y %d = %d", addrRa, datOutRa, addrRb, datOutRb);
    end
	end
	//Emulación de los pulsos de reloj para que todo funcione
	always #1 clk = ~clk;
	initial begin: TEST_CASE
		$dumpfile("TestBench.vcd");
		#(47) $stop;
 	end
endmodule
