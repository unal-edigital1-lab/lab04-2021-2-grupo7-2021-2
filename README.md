# Laboratorio 04: Diseño de banco de Registro

### Autores
- Deimy Xiomara Murcia Chavarría
- Delwin José Padilla Padilla
- Diego Alejandro Sánchez Mendoza

### Palabras Clave:
Banco de registros, Flip-Flop, Lógica secuencial, Memoria, Visualización dinámica

### Objetivo:
Crear un banco de registros en el cual se puedan leer y escribir registros de 4 bits; el ingreso de la información se realizará por medio de interruptores y este debe ser capaz de permitir la lectura de 2 registros simultaneamente. Adicionalmente debe permitir la escritura de registros acorde a la señal de control.

### Marco Teórico:
- Banco de registros: Está formado por un numero **n** de registros que pueden ser seleccionados mediante una señal de control para ser escritos o leídos. Por lo general, el banco de registros tiene un puerto de salida de datos y uno de entrada.\[1\]

- Flip-Flop: Son dispositivos biestables **(2 estados)**, que sirven como memoria básica para las operaciones de logica secuencial. Estos son ampliamente usados para el almacenamiento y transferencia de datos digitales. Se usan normalmente en unidades llamadas “registros” , para el almacenamiento de datos numéricos binarios, estos son los tipos de Flip-Flop más utilizados: \[2\]
    * Flip-Flop tipo S/R: Es el más básico y a diferencia de los otros, es asíncrono. Este opera de acuerdo a la siguiente tabla de verdad:

      |   Acción  | S | R | Q | ~Q |
      |:---------:|:-:|:-:|:-:|:--:|
      |  Mantiene | 0 | 0 | 0 |  1 |
      | Fija un 0 | 0 | 1 | 0 |  1 |
      | Fija un 1 | 1 | 0 | 1 |  0 |
      | Prohibido | 1 | 1 | 1 | 1  |

    Los valores de **Q** y **~Q** se asumen con un **S=0** y **R=1** previos. La condición **11** está prohibida en este Flip-Flop ya que esta rompe la lógica de tener dos salidas distintas (Una siendo el negado de la otra). Gráficamente, se representa como:

    ![Flip-Flop tipo S/R](/img/flip_flop_S_R.png  "Flip-Flop tipo S/R")

    * Flip-Flop tipo J/K: A diferencia del flip flop S/R, en el caso de activarse ambas entradas a la vez, la salida adquiere el estado contrario al que tenía, se representa de la siguiente manera:

    ![Flip-Flop tipo J/K](/img/flip_flop_J_K.png  "Flip-Flop tipo J/K")

    * Flip-Flop tipo D: Su función es dejar pasar la señal que ingresa por D, a la salida Q, después de un pulso del reloj.

    ![Flip-Flop tipo D](/img/flip_flop_D.png  "Flip-Flop tipo D")

- Circuito Secuencial Síncrono: Un circuito secuencial síncrono utiliza señales que modifican su estado solo en instantes discretos de tiempo. La sincronización se logra a través de un dispositivo de sincronización llamado generador de señales de reloj que produce una sucesión periódica de pulsos de reloj. Estos se distribuyen en todo el sistema de tal manera que los elementos de almacenamiento sólo sean afectados a la llegada de cada pulso.\[3\]

- Circuito de memoria: Se dice memoria un circuito en condiciones de mantener una información y hacerla disponible cuando se necesite. Se distinguen dos tipos de memorias:\[4\]
    * La memoria secuencial: Permite leer o escribir mediante la organización de los datos uno tras otro. Para leer un dato es necesario leer todos los almacenados previamente en el mismo orden de almacenamiento; para escribir un dato es necesario escribir después del último previamente escrito.
    * La memoria aleatoria o random: Es un tipo de memoria en la que los datos se leen o se escriben en la posición deseada. Esto se logra con una codificación previa de todas las direcciones de memoria, por lo que los datos se pueden almacenar a como se desee, sin llevar un orden secuencial; de forma análoga, los datos pueden ser leídos directamente al indicar la dirección donde se almacenan.

- Display 7-Segmentos: Son dispositivos electrónicos de visualización, los cuales se componen de varios segmentos que se encienden y apagan según los niveles de voltaje que reciban en cada uno de sus pines para dar la apariencia del glifo deseado. Los segmentos generalmente son LED individuales o cristales líquidos. \[5\]

![Display 7 Segmentos](http://www.micropic.es/mpblog/wp-content/uploads/2007/07/7seg_pinouts.png "Display 7 Segmentos")

### Desarrollo:

#### Parte 1 - Visualización:
<!-- Revisar luego si vale la pena volver a poner los módulos de labs anteriores o solo decir como "esto lo explicamos en tal lab" -->
Para diseñar todo el sistema de Banco de registros con visualización en displays 7-Segmentos era necesario probar cada submódulo por separado. Para lograr la visualización se modificó el módulo `BCD4bits` trabajado en el *laboratorio anterior*, de la siguiente manera:
```verilog
`timescale 1ns / 1ps
module BCD4bitsWreg(
    input [3:0] num1, //Ahora se tienen 2 entradas que serán
    input [3:0] num2, //las salidas del Banco de Registros
    input clk,
    output [0:6] sseg,
    output reg [3:0] an,
	  input rst
    );

reg [3:0]bcd=0;
//wire [15:0] num1=16'h4321;

BCDtoSSeg bcdtosseg(.BCD(bcd), .SSeg(sseg)); //Sub-módulo del lab anterior

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
    case (num1) //Codifica la entrada 1 a BCD
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
    case (num2) //Codifica la entrada 2 a BCD
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
Este módulo no se explica en detalle pues sería redundante explicar nuevamente el mismo funcionamiento del código.

##### Simulación:
Para realizar la prueba del módulo `BCD2num` se utilizó el siguiente testbench:
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
Este se encarga de inicializar los displays con dos números, un `5` para observar como se visualizará un número menor a 9 y un `15` para ver si la codificación se visualiza correctamente. `rst = 1`, debido a que la tarjeta *Cyclone IV* mantiene sus pulsadores en 1 y solo abre el circuito al oprimirlos, razón por la que el código del módulo `BCD2num` hace la división de frecuencia y el respectivo multiplexado de los ánodos de los displays si `rst = 1` y se detiene en otro caso.  
Al hacer la simulación se obtuvo lo siguiente:

![Resultado de la simulación para BCD2num](/img/Sim_2numBCD.jpg "Resultado de la simulación para BCD2num")

Así como se observó en el *laboratorio anterior*, este módulo recorre desde el LSB hasta el MSB del número que reciba por entrada. Como en este caso son 2 números, primero se visualizan las unidades del número 2 *(El 15, entonces, se visualiza un 5=0100100)* y luego sus decenas *(1=1001111)*; acto seguido, cuando los ánodos pasan a `1011` y `0111` se visualizan las unidades para el número 1 *(5=0100100)* y luego las decenas *(0=0000001)*, respectivamente.  
Una vez comprobado que la modificación funciona correctamente se procede a implementarla para determinar en cuales de los 8 displays 7-Segmentos de la tarjeta se van a visualizar las lecturas del sistema completo.

#### Parte 2 - Banco de Registros:
Para su diseño se empleó el código dado, el cual describe el módulo `BancoRegistro`y permite crear un arreglo de 2ⁿ registros del tamaño que se le indique al redefinir los parámetros `BIT_ADDR`y `BIT_DATO`, respectivamente.
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
reg [BIT_DATO-1:0] breg [NREG-1:0]; /*Crea un arreglo de NREG registros, cada
                                      uno de BIT_DATO bits*/

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
Como una memoria o arreglo de registros de este estilo debe permitir la escritura y lectura simultáneas, se dispone de 3 direcciones: 2 de ellas (`addrRa` y `addrRb`) para leer la información almacenada en esas posiciones del banco (Lectura de dos posiciones en paralelo) y `addrW` para indicarle al sistema en qué posición se desea guardar un dato. Como la idea es mantener la información en las posiciones correspondientes,a menos que se le indique la orden de carga, se dispone del selector `RegWrite`, el cual habilita o deshabilita la carga de la información. Cabe aclarar que la lectura se realiza en todo momento; por ejemplo, al tener `addrRa = 101` y colocar `addrW = 101`, apenas se dé la orden de carga, el sistema permitirá ver el número cargado y reflejará cualquier cambio que se dé a la entrada hasta que `RegWrite = 0` nuevamente.  
El módulo también incluye una funcionalidad de reset, la cual hace que todos los registros que conforman el banco se "borren". Esto se coloca entre comillas, porque no se utiliza el reset de los flip flop como tal, sino que se da la orden global para que todas las posiciones almacenen de forma asíncrona un 0 en todos sus bits.  
El funcionamiento detallado del módulo se explica en los respectivos comentarios del código.

Adicionalmente, se agregó la posibilidad de inicializar el banco con un archivo de memoria `Reg8.mem` que contiene datos HEX separados por algún delimitador (Salto de línea en este caso) y con la instrucción `$readmemh` se lee dicho archivo y se almacena, en orden desdendente, desde la posición `0` a la `NREG-1`, cada dato en una posición diferente. En caso de no haber suficientes datos, solo se inicializan las posiciones hasta donde alcance con las entradas del archivo y las demás se mantienen en 0 por defecto; o en caso contrario, si hay un número de datos mayor al tamaño del banco de registros, el sistema almacena hasta donde alcance y los demás datos son ignorados.  
Para inicializar la memoria, además de colocar el comando de verilog `$readmemh` o `readmemb` si el archivo contiene datos BIN y no HEX, es muy importante colocar el archivo `Reg8.mem` en la carpeta donde se encuentren los archivos verilog *(Con extensión .v)* y también en la carpeta *simulation/modelsim/* que genera el proyecto de *Quartus* una vez se le ordena que haga la *simulación RTL* por primera vez. De lo contrario se producirán 2 errores:

![Error en simulación por no colocar el archivo de memoria en la carpeta simulation/modelsim/](/img/Error_Reg8.jpg "Error en simulación por no colocar el archivo de memoria en la carpeta simulation/modelsim/")

Este error se produce cuando no se guarda `Reg8.mem` en la carpeta *simulation/modelsim/*. Si bien no impide que se haga la sintetización y el resto de la simulación, no permitirá que se inicialice la memoria. Luego, si no se guarda `Reg8.mem` en la carpeta que contiene los archivos **.v*, al intentar sintetizar el código se producirá el siguiente error, el cual, a diferencia del anterior, si impide que se complete el proceso exitosamente:

![Error en sintetización por no colocar el archivo de memoria en la carpeta que contiene los archivos verilog](/img/Error_Reg8_Comp.jpg "Error en sintetización por no colocar el archivo de memoria en la carpeta que contiene los archivos verilog")

##### Simulación:
Para probar el módulo `BancoRegistro` se utilizó el siguiente testbench:
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
```
Este se divide en 3 etapas: En la primera se verifica que la inicialización de memoria sea correcta, para lo cual se recorren todas las posiciones aprovechando la lectura en paralelo para hacerlo más eficientemente. Nótese que es necesario inicializar `RegWrite = 0`, porque de lo contrario se cargaría un 0 en todas las posiciones por el valor dado a `datW` durante la inicialización de las variables. Luego llega la segunda etapa, la cual consiste en cargar datos diferentes en cada posición y acto seguido verificar que todo se haya guardado correctamente. Para eso se coloca `RegWrite = 1` mientras se carga y luego se vuelve a dejar en cero para que no se sobreescriban todas las posiciones con el último valor que haya quedado en `datW`\.  
Y finalmente la etapa 3, en la cual se verifica la funcionalidad del reset al cambiar su estado a `rst = 0` y leer por última vez todas las posiciones del banco.

Para hacer la simulación fue necesario redefinir temporalmente la condición `cont < NREG` dentro del `for` que rellena de **0** el banco al hacer reset en el código para el módulo `BancoRegistro`, cambiándola por `cont < 8` (O en lugar de 8 se coloca el número de registros que se vayan a crear dentro del banco, es decir, el valor que tenga NREG). Esto se hace porque *Quartus* no sabe que valores se le darán externamente a los parámetros `BIT_ADDR` y `BIT_DATO` y por ende no logra calcular un valor para el parámetro local `NREG`, generándose el siguiente error para *Análisis y síntesis*:

![Error por tamaño indefinido de NREG](/img/Error_NREG.jpg "Error por tamaño indefinido de NREG")

Luego de hacer la modificación y sintetizar, se obtuvo el siguiente resultado de simulación:

![Resultado de la simulación para BancoRegistro](/img/Sim_Test_BReg.jpg "Resultado de la simulación para BancoRegistro")

Nótese como `addrRa` y `addrRb` se mantienen en `011` y `111`, respectivamente, y luego de almacenar nuevos valores en estas posiciones, cuando el reloj produce un flanco de subida al cabo de **17** y **25 ns**, en las salidas `datOutRa` y `datOutRb` se ven reflejados dichos valores almacenados, así `RegWrite = 1`, tal y como se explicó en el funcionamiento del módulo.  
Esta simulación se lee más fácilmente con la ayuda de los comandos `$display`, los cuales imprimen en consola la dirección que se lee en cada etapa de la simulación con su respectivo valor almacenado, así:

![Lecturas de los registros para explorar las funciones del banco](/img/Consola_Test_BReg.jpg "Lecturas de los registros para explorar las funciones del banco")

Algo que faltó mencionar previamente es el contenido del archivo `Reg8.mem`. Este contiene los números **HEX impares** desde **15** a **1**, en orden **descendente**. Con esto en mente, se observa en la simulación que la inicialización de memoria se hizo correctamente. Por último, se observa como una vez se le da el pulso de reset, el registro se fija en **0** para todas las posiciones, tal como se esperaba. Por lo anterior, se puede seguir con la implementación de este módulo y así tener todo listo para diseñar el sistema completo.

Si se da el error en simulación por no guardar el archivo `Reg8.mem` en la carpeta `simulation/modelsim/`, la simulación se ve así:

![Resultado de la simulación para BancoRegistro](/img/Sim_Test_BReg_con_Error.jpg "Resultado de la simulación para BancoRegistro")

Nótese como en la primera etapa de lecturas no hay señal alguna para `datOutRa` y `datOutRb`, debido a que *ModelSim* no puede encontrar el archivo `Reg8.mem` para leerlo. Estas adquieren un valor apenas se cargan datos en las posiciones respectivas que se están leyendo en ese momento (`011` y `111`).

#### Parte 3 - Banco de registros 8x4 con visualización BCD:
Finalmente, se diseñó el módulo maestro o *top entity*, el cual instancia un submódulo `BancoRegistro` y un submódulo `BCD2num`, interconectando estos dos a su vez con la ayuda de dos buses de 4 bits cada uno: `datA` y `datB`\.  
En el caso del submódulo `BancoRegistro`, fue necesario redefinir sus parámetros por defecto para el tamaño de memoria y la profundidad de la misma (El número de bits de cada registro). En este caso se determinó un tamaño de registro **3**, pero esto no significa que se cree un banco con 3 registros; recordemos que `NREG` fue definido como `2 ** BIT_ADDR`, es decir, `NREG` es una **potencia de 2**, entonces, al redefinir `BIT_ADDR` como 3 se crearán **2³ = 8** registros, de **4 bits** cada uno (Porque redefinimos `BIT_DATO = 4`).
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

BancoRegistro #(3,4) registro ( //BIT_ADDR = 3, BIT_DATO = 4
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
Este es un módulo muy simple, ya que solo se encarga de unir los submódulos y estos internamente se encargan de todas las operaciones lógcas necesarias para que el sistema funcione.

##### Simulación:
Para comprobar su funcionamiento se utilizó el siguiente testbench:

```verilog
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
//Contador para la escritura (Tamaño del dato)
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
	
	/*Lee dos direcciones para verificar la inicialización previa de la memoria
	  con el archivo Reg8.mem*/
		addrA = 1;
		addrB = 6;
		#1000000;

	RegWrite = 1; //Habilita la carga de datos
	#100000;
	
	//Carga datos en las mismas posiciones previamente leídas
	addrW = 6;
	datW = 5;
	#500000;
	addrW = 1;
	datW = 11;
	#500000;

	RegWrite = 0; //Habilita la lectura

	//Lee las posiciones recién cargadas
		addrA = 1;
		addrB = 6;
		#1050000;

	rst = 0; //Borra el banco y lee los datos luego de su efecto
	#50000;
	rst = 1;
end

	//Emulación de los pulsos de reloj
	always #1 clk = ~clk;
	initial begin: TEST_CASE
		$dumpfile("TestBench.vcd");
		#(4300000) $stop; /*tiempo necesario para lograr la visualización dinámica correcta 
				  debido al divisor de frecuencia de visualización del display*/
 	end
endmodule

```
El resultado de la simulación fue el siguiente:

![Resultado de la simulación para Lab4](https://user-images.githubusercontent.com/92879278/149717640-086e730a-bb44-4fab-9619-29589638e9f5.png "Resultado de la simulación para Lab4")

Se observa en una primera etapa la lectura de los datos guardos den el registro de memoria, en el momento que el `RegWrite` pasa a 1,  se comienza a cargar datos a las posiciones 1 y 6, como se indicó en el código, los datos cargados serán 5 y 11 respectivamente y en simulación se observa la carga correcta de los datos, enonces, el `RegWrite` pasa a 0 y los datos recien cargados vuelven a ser leídos, es por esto que vemos 2 veces los datos 5 y 11 en la simulación. Por último, el `rst` pasa 0, es decir, todo el banco es borrado o lo que es equivalente a decir que se escribió 0000 en cada posición. Se realiza la lectura de los datos de las posiciones indicadas (1 y 6) y se obtienen salidas de 00 en cada posición.

### Implementación:
#### Parte 1 - Visualización:
Se implementaron casi los mismos pines que los utilizados en el *laboratorio anterior* para el módulo BCD4bits:

![Asignación de pines para implementar el módulo BCD2num](/img/Pines_2numBCD.jpg "Asignación de pines para implementar el módulo BCD2num")

La diferencia es que ahora se incluyen asignaciones para el número 1, las cuales corresponden a la otra mitad del dipswitch de la tarjeta (Las asignaciones para el número 2 son las mismas que se usaron en el *laboratorio anterior*) y también se modificaron las asignaciones de `An` para que no se vean los dos números pegados en el mismo arreglo de displays, sino que tengan una separación de 2 displays apagados de por medio. Es decir, se asignó `An` de tal manera que los números se visualicen así:

![Displays a utilizar para lograr la visualización BCD de dos entradas simultáneas](/img/Visualizacion.jpg "Displays a utilizar para lograr la visualización BCD de dos entradas simultáneas")

El funcionamiento de este módulo se presenta en el video a continuación:

[![Haga clic para ver el video](/img/Miniatura_2numBCD.jpg)](https://youtu.be/FuZlDRWVDdA "Haga clic para ver el video")

Tal y como se vió en simulación, los números **menores a 9** se visualizan como **0X**, donde **X** es el número en cuestión, y los que son **mayores a 9** se codifican correctamente a BCD.

#### Parte 2 - Banco de Registros:
Los pines de la tarjeta *Cyclone IV* que fueron asignados, son:

![Asignación de pines para implementar el módulo BancoRegistro](/img/Pines_Test_BReg.jpg "Asignación de pines para implementar el módulo BancoRegistro")

Esta asignación se asemeja a la vista en el *laboratorio anterior* para el caso de la visualización dinámica con 4 displays 7-Segmentos, en tanto, como hay más de 8 bits de entrada (3 para `addrRa`, 3 para `addrRb`, 1 para `RegWrite`, 3 para `addrW` y 4 para `datW`. En total 16), se necesita una forma de ingresar los demás bits para. Entonces, se hizo uso de los pines para jumpers y una protoboard.  
Las entradas para las direcciones de lectura se asignaron a estos jumpers y el bits de carga/lectura, dirección de escritura y entrada de dato para cargar se asignaron a los 8 bits del dipswitch. Respecto a los 8 bits de salida, estos fueron asignados a los leds de la tarjeta, siguiendo un orden específico:

![Leds a utilizar para lograr la visualización de dos registros a la vez](/img/Visualizacion_BReg.jpg "Leds a utilizar para lograr la visualización de dos registros a la vez")

Lo anterior se entiende mejor al ver el funcionamiento del banco de registros en el video a continuación:

[![Haga clic para ver el video](/img/Miniatura_Test_BReg.jpg)](https://youtu.be/7mbj8uYGhwQ "Haga clic para ver el video")

Como se pudo observar, el banco de registros funciona correctamente y cumple a la perfección lo explicado en secciones anteriores.

#### Parte 3 - Banco de registros 8x4 con visualización BCD:
La asignación de pines para este módulo es un compendio de las anteriores, como se observa a continuación:

![Asignación de pines para implementar el módulo Lab4](/img/Pines_Lab4.jpg "Asignación de pines para implementar el módulo Lab4")

Lo único que cambia es el nombre de algunas señales, pero esto es meramente estético y no afecta en lo absoluto a los pines correspondientes. El funcionamiento del sistema completo se muestra en el siguiente video:

[![Haga clic para ver el video](/img/Miniatura_Lab4.jpg)](https://youtu.be/LxDmQTBfW5k "Haga clic para ver el video")

Algo que faltó presentar en el video de funcionamiento del módulo `BancoRegistro` fue la inicialización de memoria, ya que creíamos que solo servía en simulación y no era sintetizable como tal, por lo cual se comentó esa línea antes de grabar el video de su implementación, no obstante, para el sistema completo lo pasamos por alto y nos dimos cuenta que también se inicializaba el banco con los datos del archivo `Reg8.mem`\.  
El funcionamiento es practicamente una réplica de la simulación del módulo `BancoRegistro`, es decir, se observa como la inicialización funciona correctamente, luego se hace reset y se verifica con algunas direcciones que todo está en **0**; se cargan datos y se leen correctamente y como valor agregado, se muestra lo explicado previamente que sucedía al dejar `RegWrite = 1`, es decir, cualquier cambio a la entrada se refleja a la salida, mientras que al dejar `RegWrite = 0`, el banco mantiene la información cargada anteriormente y es indiferente a cualquier cambio en `datW`. Finalmente, como no se cargaron datos de forma manual que fuesen **mayores a 9**, se presentan algunos ejemplos de que, en efecto, se pueden cargar números de 4 bits **mayores a 9** y al momento de leer esas posiciones, la información se visualiza en BCD.

### Bibliografía:
1. "Banco de Registros", *Dpto. Automática. ATC*, 2021. [PDF](http://atc2.aut.uah.es/~avicente/asignaturas/lac/pdf/Practica-3.pdf). 
2. "Flip Flops", *Ingenieria Mecafenix*, 2021. [En línea](https://www.ingmecafenix.com/electronica/flipflop/).
3. "LÓGICA SECUENCIAL Y COMBINATORIA", *Instituto Tecnológico de Querétaro*, pp. 2. [En línea](http://www.itq.edu.mx/carreras/IngElectronica/archivos_contenido/Apuntes%20de%20materias/Apuntes_Log_Sec_Comb/Sesion_12_LSC.pdf)
4. "Memorias", *Scuola Elettrica*, 2021. [En línea](https://scuolaelettrica.it/escuelaelectrica/elettronica/differe7.php#:~:text=Se%20dice%20memoria%20un%20circuito,los%20datos%20uno%20tras%20otro.)
5. "Display de 7 segmentos", *Newark*, 2021. [En línea](https://mexico.newark.com/display-seven-segment-display-technology)