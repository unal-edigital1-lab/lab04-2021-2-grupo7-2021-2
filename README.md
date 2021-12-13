# Laboratorio 04: Diseño de banco de Registro

### Autores
- Deimy Xiomara Murcia Chavarría
- Delwin José Padilla Padilla
- Diego Alejandro Sánchez Mendoza

### Palabras Clave:
Banco de registro, Memoria, Flip flops

### Objetivo:
El presente laboratorio buscar crear un banco de registro en el cual se puedan leer y escribir registro de 4 bits; el ingreso de la informacion se realizara por medio de interruptores y este debe ser capaz de permitir la lectura de 2 registros simultaneamente y tambien permitir la escritura de registros acorde a la señal de control.

### Marco Teórico:
Mucho texto

### Desarrollo:
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

Con los 2 espacios.  
Pasa esto.

Para poner un nuevo párrafo (Salto de línea), damos 2 veces enter.

### Implementación:
Momento Delwin :v

### Bibliografía:
Algunos ejemplos citados en formato IEEE

1. “Lenguaje de Descripción de Hardware”, *Wikipedia*, 2021. [En línea](https://es.wikipedia.org/wiki/Lenguaje_de_descripción_de_hardware)
2. “Verilog”, *Wikipedia*, 2021. [En línea](https://es.wikipedia.org/wiki/Verilog)
3. “Suma Binaria”, *Ladelec*. [En línea](https://www.ladelec.com/teoria/electronica-digital/401-suma-binaria)
4. D. Martinez, E. Navas, J. Gulín, "Herramienta de visualización dinámica de simulaciones del proceso de difusión en microfluidos con componentes biológicos", *Revista Cubana de Ciencias Informáticas*, vol. 10, pp. 88, 2016. [En línea](http://scielo.sld.cu/pdf/rcci/v10s1/rcci07517.pdf)
