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
	reg [2:0] i;
	//Contador para la escritura ()
	reg [3:0] j;


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
		/*Lee el banco de 2 en 2 (en paralelo) para verificar la inicialización
		previa de la memoria con el archivo Reg8.mem*/
		$display("\nLectura de la inicializacion previa:");
		for (i = 0; i < 4; i = i + 1) begin
			addrA = i; //Lee del Reg_0 al Reg_4
			addrB = i + 4; //Lee del Reg_4 al Reg_8
			#2 $display("El Valor de Registro %d = %d  y %d = %d", addrA, SSeg, addrB, An);
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
			addrA = i;
			addrB = i + 4;
			#2 $display("El Valor de Registro %d = %d  y %d = %d", addrA, SSeg, addrB, An);
    end
		#1 rst = 0; //Borra el banco (Lo deja todo en 0000)
		$display("\nLectura luego del reset:");
		//Lee el banco de 2 en 2 para verificar el efecto del reset
		for (i = 0; i < 4; i = i + 1) begin
			addrA = i;
			addrB = i + 4;
			#2 $display("El Valor de Registro %d = %d  y %d = %d", addrA, SSeg, addrB, An);
    end
	end
	//Emulación de los pulsos de reloj para que todo funcione
	always #1 clk = ~clk;
	initial begin: TEST_CASE
		$dumpfile("TestBench.vcd");
		#(55) $stop;
 	end
endmodule

