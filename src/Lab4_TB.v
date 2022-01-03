`timescale 1ns / 1ps

module Lab4_TB;

	// Inputs

	// Outputs

	// Instantiate the Unit Under Test (UUT)
	Lab4 uut (
		.addrA(),
		.addrB(),
		.addrW(),
		.datW(),
		.regWrite(),
		.clk(),
		.rst(),
		.SSeg(),
		.An()
	);

	initial begin
		// Initialize Inputs //(Editar esto tambien)//
		addrRa = 0;
		addrRb = 0;
		addrW = 0;
		datW = 0;
		RegWrite = 0;
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish //(Y esto)//
		#100;
      for (addrRa = 0; addrRa < 8; addrRa = addrRa + 1) begin
			#5 addrRb=addrRa+8;
			 $display("el valor de registro %d =  %d y %d = %d", addrRa,datOutRa,addrRb,datOutRb) ;
    end

	end

endmodule
