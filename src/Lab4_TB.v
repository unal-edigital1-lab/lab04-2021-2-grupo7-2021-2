`timescale 1ns / 1ps

module Lab4_TB;

	// Inputs
reg [2:0] addrA;
reg [2:0] addrB;
reg [2:0] addrW;
reg [3:0] datW;
reg RegWrite;
reg clk;
reg rst;

	// Outputs
wire [0:6] SSeg;
wire [3:0] An;


  //Contador para la lectura (Del tamaño de las direcciones)
	//reg [2:0] i;
	//Contador para la escritura ()
	//reg [3:0] j;


	// Instantiate the Unit Under Test (UUT)
	Lab4 uut (
		.addrA(addrA),
		.addrB(addrB),
		.addrW(addrW),
		.datW(datW),
		.RegWrite(RegWrite),
		.clk(clk),
		.rst(rst),
		.SSeg(SSeg),
		.An(An)
	);

	initial begin
		// Initialize Inputs
		addrA = 0;
		addrB = 0;
		addrW = 0;
		datW = 0;
		RegWrite = 0;
		clk = 0;
		rst = 1;
		/*Lee dos direcciones para verificar la inicialización previa de la memoria
		  con el archivo Reg8.mem*/

			addrA = 1;
			addrB = 6;
			#1000000;

		RegWrite = 1; //Habilita la carga
		#100000;
		//Carga datos en las mismas posiciones previamente leídas

			addrW = 6;
			datW = 5;
			#500000;
			addrW = 1;
			datW = 11;
			#500000;

		RegWrite = 0;  //Habilita la lectura
		//Lee las posiciones recién cargadas

			addrA = 1;
			addrB = 6;
			#1050000;

		rst = 0; //Borra el banco y se lee de una vez su efecto
		#50000;
		rst = 1;
	end
	//Emulación de los pulsos de reloj para que todo funcione
	always #1 clk = ~clk;
	initial begin: TEST_CASE
		$dumpfile("TestBench.vcd");
		#(4300000) $stop;
 	end
endmodule
