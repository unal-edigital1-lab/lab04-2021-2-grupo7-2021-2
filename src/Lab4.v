module Lab4 ( //Preguntarle al profe si los param se definen acá o son los de BancoRegistro.v y "edfinirlos" se refiere a re-definirlos en la instanciacion
input addrA [3:0],
input addrB [3:0],
input addrW [3:0],
input datW [3:0],
input regWrite,
input clk,
input rst,
output SSeg [6:0],
output An [3:0]
);

wire datA [3:0];
wire datB [3:0];

BancoRegistro #(8,4) registro (
  .addrRa(addrA),
  .addrRb(addrB),
  .addrW(addrW), .datW(datW),
  .RegWrite(regWrite),
  .clk(clk),
  .rst(rst),
  .datOutRa(datA),
  .datOutRb(datB)); /*Instanciamos un submódulo BancoRegistro y redefinimos sus
                      parámetros*/
BCD4bitsWreg visualizacion (.num1(datA),
.num2(datB),
.clk(clk),
.sseg(SSeg),
.an(An),
.rst(rst)); //Instanciamos un submódulo BCD4bitsWreg para hacer la visualización

endmodule
