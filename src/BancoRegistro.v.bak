`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    09:55:28 10/12/2019
// Design Name: 	 ferney alberto beltran
// Module Name:    BancoRegistro
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module BancoRegistro #(      		 //   #( Parametros
         parameter BIT_ADDR = 8,  // BIT_ADDR Número de bits para la dirección
         parameter BIT_DATO = 4  // BIT_DATO  Número de bits para el dato
	)
	(
    input [BIT_ADDR-1:0] addrRa, //Recibe la dirección para leer el dato A
    input [BIT_ADDR-1:0] addrRb, //Recibe la dirección para leer el dato B

	  output [BIT_DATO-1:0] datOutRa, /*Entrega el dato A, guardado en la posición
                                      addrRa*/
    output [BIT_DATO-1:0] datOutRb, /*Entrega el dato A, guardado en la posición
                                      addrRb*/

	  input [BIT_ADDR-1:0] addrW, //Recibe la dirección en la cual cargará el dato
    input [BIT_DATO-1:0] datW, //Recibe el dato a cargar

	  input RegWrite, //Habilita la carga o lectura
    input clk,
    input rst
    );

// La cantidad de registros es igual a:
localparam NREG = 2 ** BIT_ADDR; /*Es decir, 2^BIT_ADDR. Esto es así porque por
                                   n bits que se tengan para indicar la
                                   dirección, se pueden elegir 2^n direcciones
                                   diferentes*/

//Configuración del banco de registro
reg [BIT_DATO-1:0] breg [NREG-1:0]; /*Crea NREG registros en total, cada uno de
                                       BIT_DATO bits*/

reg [BIT_DATO-1:0] cont = 0; //Contador para el reset

assign datOutRa = breg [addrRa]; /*Envía el dato guardado en addrRa a la salida
                                   datOutRa*/
assign datOutRb = breg [addrRb]; /*Envía el dato guardado en addrRb a la salida
                                   datOutRb*/

initial begin
$readmemh("Reg8.mem", breg); //Carga los números impares HEX del archivo Reg16
end

always @(posedge clk) begin
  if (rst == 0) begin
    for (cont = 0; cont < NREG; cont = cont + 1) begin
      breg [cont] <= 0;
    end
  end else if (RegWrite == 1) /*Si vale 1, carga el dato en la posición indicada
                                y si vale 0, lee el dato guardado en la posición
                                indicada*/
      breg [addrW] <= datW;
end

endmodule
