# Laboratorio 04: Diseño de banco de Registro

### Autores
- Deimy Xiomara Murcia Chavarría
- Delwin José Padilla Padilla
- Diego Alejandro Sánchez Mendoza

### Palabras Clave:
Banco de registro, Memoria, Flip flops

### Objetivo:
El presente laboratorio buscar crear un banco de registro en el cual se puedan leer y escribir registro de 4 bits; el ingreso de la informacion se realizara por medio de interruptores y este debe ser capaz de permitir la lectura de 2 registros simultaneamente adicionalmente debe permitir la escritura de registros acorde a la señal de control.

### Marco Teórico:
- Banco de registros: Esta formado por un numero n de registros que pueden ser capaces de ser seleccionados mediante una señal de control para ser leidos o escritos. Por lo generar el banco de registro tiene un puerto de salida de datos y uno de entrada.

- Flip - Flops: Son dispositivos biestables **(2 estados)**, que sirven como memoria básica para las operaciones de logica secuencial. Estos son ampliamente usados para el almacenamiento y transferencia de datos digitales  se usan normalmente en unidades llamadas “registros” , para el almacenamiento de datos numéricos binarios, estos son los tipos de flip - flops mas utilizados:
    * Flip-Flop tipo S/R: Mantiene el dato hasta que ocurre un reset, se representan de la siguiente manera:

    ![Flip-Flop tipo S/R](/img/flip_flop_S_R.png  "Flip-Flop tipo S/R")

    * Flip-Flop tipo J/K: A diferencia del flip flop RS, en el caso de activarse ambas entradas a la vez, la salida adquiere el estado contrario al que tenía., se representa de la siguiente manera:
    
    ![Flip-Flop tipo J/K](/img/flip_flop_J_K.png  "Flip-Flop tipo J/K")

    * Flip-Flop tipo D: Su función es dejar pasar lo que entra por D, a la salida Q, después de un pulso del reloj.

    ![Flip-Flop tipo D](/img/flip_flop_D.png  "Flip-Flop tipo D")

- Circuito Secuencial Síncrono: Un circuito secuencial síncrono utiliza señales que modifican su estado solo en instantes discretos de tiempo. La sincronización se logra a través de un dispositivo de sincronización llamado generador de señales de reloj que produce una sucesión periódica de pulsos de reloj. Estos se distribuyen en todo el sistema de tal manera que los elementos de almacenamiento sólo sean afectados a la llegada de cada pulso

- Circuito de memoria: Se dice memoria un circuito en condiciones de mantener una información y hacerla disponible cuando se necesita. Se distinguen dos tipos de memorias: 
    * La memoria secuencial: Permite leer o escribir mediante la organización de los datos uno tras otro. Para leer un dato es necesario leer todos los almacenados previamente en el mismo orden de almacenamiento; para escribir un dato es necesario escribir después de el último previamente escrito.
    * La memoria aleatoria o random: Es un tipo de memoria en la que los datos se leen o se escriben datos en la posición deseada, por supuesto que necesitamos una codificación antes del almacenamiento de todas las direcciones de memoria, por lo que los datos se pueden almacenar a la deseada, sin orden secuencia; los datos pueden ser leídos directamente por conocer la dirección donde se almacena.

- Display 7 segmentos: Son dispositivos electrónicos de visualización, los cuales se componen de varios segmentos que se encienden y apagan según los niveles de voltaje que reciban en cada uno de sus pines para dar la apariencia del glifo deseado. Los segmentos generalmente son LED individuales o cristales líquidos.

![Display 7 Segmentos](http://www.micropic.es/mpblog/wp-content/uploads/2007/07/7seg_pinouts.png "Display 7 Segmentos")

### Desarrollo:

#### 2numBCD:
<!-- Revisar luego si vale la pena volver a poner los módulos de labs anteriores o solo decir como "esto lo explicamos en tal lab" -->
```verilog
`timescale 1ns / 1ps
module BCD4bitsWreg(
    input [3:0] num1,
    input [3:0] num2,
    input clk,
    output [0:6] sseg,
    output reg [3:0] an,
	  input rst
    );

reg [3:0]bcd=0;
//wire [15:0] num1=16'h4321;

BCDtoSSeg bcdtosseg(.BCD(bcd), .SSeg(sseg));//El módulo visto en el lab anterior

reg [26:0] cfreq=0;
wire enable;

// Divisor de frecuecia

assign enable = cfreq[16];
always @(posedge clk) begin
  if(rst==0) begin
		cfreq <= 0;
	end else begin
		cfreq <=cfreq+1;
	end
end

reg [1:0] count =0;
always @(posedge enable) begin
  if(rst==0) begin
	count<= 0;
	an<=4'b1111;
  end else begin
    count<= count+1;
    an<=4'b1101;
    case (num1)
      4'ha:
        case (count)
          2'h2: begin bcd <= 4'h0;   an<=4'b1011; end
          2'h3: begin bcd <= 4'h1;   an<=4'b0111; end
        endcase
      4'hb:
        case (count)
          2'h2: begin bcd <= 4'h1;   an<=4'b1011; end
          2'h3: begin bcd <= 4'h1;   an<=4'b0111; end
        endcase
      4'hc:
        case (count)
          2'h2: begin bcd <= 4'h2;   an<=4'b1011; end
          2'h3: begin bcd <= 4'h1;   an<=4'b0111; end
        endcase
      4'hd:
        case (count)
          2'h2: begin bcd <= 4'h3;   an<=4'b1011; end
          2'h3: begin bcd <= 4'h1;   an<=4'b0111; end
        endcase
      4'he:
        case (count)
          2'h2: begin bcd <= 4'h4;   an<=4'b1011; end
          2'h3: begin bcd <= 4'h1;   an<=4'b0111; end
        endcase
      4'hf:
        case (count)
          2'h2: begin bcd <= 4'h5;   an<=4'b1011; end
          2'h3: begin bcd <= 4'h1;   an<=4'b0111; end
        endcase
      default:
        case (count)
          2'h2: begin bcd <= num1[3:0];   an<=4'b1011; end
          2'h3: begin bcd <= 4'b0000;   an<=4'b0111; end
        endcase
    endcase
    case (num2)
      4'ha:
        case (count)
          2'h0: begin bcd <= 4'h0;   an<=4'b1110; end
          2'h1: begin bcd <= 4'h1;   an<=4'b1101; end
        endcase
      4'hb:
        case (count)
          2'h0: begin bcd <= 4'h1;   an<=4'b1110; end
          2'h1: begin bcd <= 4'h1;   an<=4'b1101; end
        endcase
      4'hc:
        case (count)
          2'h0: begin bcd <= 4'h2;   an<=4'b1110; end
          2'h1: begin bcd <= 4'h1;   an<=4'b1101; end
        endcase
      4'hd:
        case (count)
          2'h0: begin bcd <= 4'h3;   an<=4'b1110; end
          2'h1: begin bcd <= 4'h1;   an<=4'b1101; end
        endcase
      4'he:
        case (count)
          2'h0: begin bcd <= 4'h4;   an<=4'b1110; end
          2'h1: begin bcd <= 4'h1;   an<=4'b1101; end
        endcase
      4'hf:
        case (count)
          2'h0: begin bcd <= 4'h5;   an<=4'b1110; end
          2'h1: begin bcd <= 4'h1;   an<=4'b1101; end
        endcase
      default:
        case (count)
          2'h0: begin bcd <= num2[3:0];   an<=4'b1110; end
          2'h1: begin bcd <= 4'b0000;   an<=4'b1101; end
        endcase
    endcase
  end
end

endmodule
```

##### Simulación:

```verilog
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
```

![Resultado de la simulación para BCD2num](/src/Sim_2numBCD.jpg "Resultado de la simulación para BCD2num")

#### BReg:

```verilog
`timescale 1ns / 1ps
module BancoRegistro #(      		 // Parámetros
         parameter BIT_ADDR = 8, // BIT_ADDR Número de bits para la dirección
         parameter BIT_DATO = 4  // BIT_DATO  Número de bits para el dato
	)( //Entradas y salidas
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
  $readmemh("Reg8.mem", breg); //Carga los números impares HEX del archivo Reg8
end

always @(posedge clk) begin
  if (rst == 0) begin
    for (cont = 0; cont < NREG; cont = cont + 1) begin
    //NOTA:Poner el numero de registros en vez de NREG para probar solo el banco
      breg [cont] <= 0;
    end
  end else if (RegWrite == 1) /*Si vale 1, carga el dato en la posición indicada
                                y si vale 0, lee el dato guardado en la posición
                                indicada*/
      breg [addrW] <= datW;
end
endmodule
```

##### Simulación:

```verilog
`timescale 1ns / 1ps
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
  //Contador para la lectura (Del tamaño de las direcciones)
	reg [2:0] i;
	//Contador para la escritura ()
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
		#1 rst = 0; //Borra el banco (Lo deja todo en 0000)
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
```

![Resultado de la simulación para BancoRegistro](/src/Sim_Test_BReg.jpg "Resultado de la simulación para BancoRegistro")

![Lecturas de los registros para explorar las funciones del banco](/src/Consola_Test_BReg.jpg "Lecturas de los registros para explorar las funciones del banco")

#### Lab4:

```verilog
module Lab4 (addrA, addrB, addrW, datW, RegWrite, clk, rst, SSeg, An);
//Inputs y Outputs
input [2:0] addrA;
input [2:0] addrB;
input [2:0] addrW;
input[3:0] datW;
input RegWrite;
input clk;
input rst;
output [0:6] SSeg;
output [3:0] An;

wire [3:0] datA;
wire [3:0] datB;

BancoRegistro #(3,4) registro (
  .addrRa(addrA),
  .addrRb(addrB),
  .addrW(addrW),
  .datW(datW),
  .RegWrite(RegWrite),
  .clk(clk),
  .rst(rst),
  .datOutRa(datA),
  .datOutRb(datB)
); /*Instanciamos un submódulo BancoRegistro y redefinimos sus parámetros*/

BCD4bitsWreg visualizacion (.num1(datA),
.num2(datB),
.clk(clk),
.sseg(SSeg),
.an(An),
.rst(rst)
); //Instanciamos un submódulo BCD4bitsWreg para hacer la visualización

endmodule
```

##### Simulación:

```verilog
module Lab4_TB;
  wire falta_esto;
endmodule
```

Esto también falta
![Resultado de la simulación para Lab4](/src/Sim_Lab4.jpg "Resultado de la simulación para Lab4")

---

## Borrar esto al final ↓↓
Si quieremos meter bloques grandes de código y que se vea nice lo ponemos con esta sintaxis:
```verilog
//Acá el código
module cajanegra(
  input hola[3:0];
  output buenas[3:0];
);
endmodule
```

Para meter imágenes locales (Guardamos la imagen en la carpeta src del repositorio antes de), las citamos así:

![Título que se muestra si la imagen no carga](/hdl/src/nombre_de_la_imagen.jpg "Título que se muestra al poner el cursor encima de la imagen")

***NOTA:*** *Es impotante dejar el enter antes y despues de cada imagen para que no se den problemas al subirlo a github.*

Si se trata de una imagen de internet, la citamos así:

![Titulo que se muestra si la imagen no carga](https://raw.githubusercontent.com/Fabeltranm/SPARTAN6-ATMEGA-MAX5864/master/lab/lab02-sumador4b/doc/sum4b.jpg "Título que se muestra al poner el cursor encima de la imagen")
Si queremos poner una nota al pie, ponemos así [^Nota2].
[^Nota2]: Luego así para que esto aparezca al final del documento como la nota en cuestión.

Si queremos colocar una tabla, hacemos lo siguiente:

| cosa 1 |   cosa 2  |   cosa 3  |   cosa 4  |   cosa 5  |
|:------:|:---------:|:---------:|:---------:|:---------:|
|   a    |     b     |     c     |     d     |     e     |

***NOTA:*** *Esto se construye más sencillo con la ayuda de <https://www.tablesgenerator.com/markdown_tables>.*
***NOTA:*** *Al igual que con las imágenes, es necesario dejar un enter antes y después para evitar errores.*

Para poner un punto aparte toca poner 2 espacios antes de dar enter para que markdown no pegue los renglones como si fuese un punto seguido. Ejemplo:  
Sin los 2 espacios.
Pasa esto.
<!-- Comentarios en Markdown :O -->
Con los 2 espacios.  
Pasa esto.

Para poner un nuevo párrafo (Salto de línea), damos 2 veces enter.

Para poner un video usamos una sintaxis similar a la de las imágenes. Aunque no se puede poner un reproductor dentro del documento, se puede poner una imagen que haga de hipervínculo hacia el video en cuestión, así:

[![Haga clic para ver el video](/hdl/src/Imagen_como_miniatura.jpg)](https://youtu.be/CN2idjPgXRs "Haga clic para ver el video")

### Implementación:
Pines 2 números BCD

![Asignación de pines para implementar el módulo BCD2num](/src/Pines_2numBCD.jpg "Asignación de pines para implementar el módulo BCD2num")

Video

[![Haga clic para ver el video](/src/Miniatura_2numBCD.jpg)](https://youtu.be/FuZlDRWVDdA "Haga clic para ver el video")

Pines Banco de Registros

![Asignación de pines para implementar el módulo BancoRegistro](/src/Pines_Test_BReg.jpg "Asignación de pines para implementar el módulo BancoRegistro")

Video

[![Haga clic para ver el video](/src/Miniatura_Test_BReg.jpg)](https://youtu.be/7mbj8uYGhwQ "Haga clic para ver el video")

Pines Lab4

![Asignación de pines para implementar el módulo Lab4](/src/Pines_Lab4.jpg "Asignación de pines para implementar el módulo Lab4")

Video

[![Haga clic para ver el video](/src/Miniatura_Lab4.jpg)](https://youtu.be/LxDmQTBfW5k "Haga clic para ver el video")

### Bibliografía:
Algunos ejemplos citados en formato IEEE

1. “Lenguaje de Descripción de Hardware”, *Wikipedia*, 2021. [En línea](https://es.wikipedia.org/wiki/Lenguaje_de_descripción_de_hardware)
2. “Verilog”, *Wikipedia*, 2021. [En línea](https://es.wikipedia.org/wiki/Verilog)
3. “Suma Binaria”, *Ladelec*. [En línea](https://www.ladelec.com/teoria/electronica-digital/401-suma-binaria)
4. D. Martinez, E. Navas, J. Gulín, "Herramienta de visualización dinámica de simulaciones del proceso de difusión en microfluidos con componentes biológicos", *Revista Cubana de Ciencias Informáticas*, vol. 10, pp. 88, 2016. [En línea](http://scielo.sld.cu/pdf/rcci/v10s1/rcci07517.pdf)
5. "Memorias", *Scuola Elettrica*, 2021. [En línea](https://scuolaelettrica.it/escuelaelectrica/elettronica/differe7.php#:~:text=Se%20dice%20memoria%20un%20circuito,los%20datos%20uno%20tras%20otro.)
