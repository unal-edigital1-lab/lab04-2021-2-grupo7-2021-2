transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Datos/UNAL/Materias/2021-2/Electronica_Digital_I/lab04-2021-2-grupo7-2021-2/src {C:/Datos/UNAL/Materias/2021-2/Electronica_Digital_I/lab04-2021-2-grupo7-2021-2/src/Lab4.v}
vlog -vlog01compat -work work +incdir+C:/Datos/UNAL/Materias/2021-2/Electronica_Digital_I/lab04-2021-2-grupo7-2021-2/src {C:/Datos/UNAL/Materias/2021-2/Electronica_Digital_I/lab04-2021-2-grupo7-2021-2/src/BCDtoSSeg.v}
vlog -vlog01compat -work work +incdir+C:/Datos/UNAL/Materias/2021-2/Electronica_Digital_I/lab04-2021-2-grupo7-2021-2/src {C:/Datos/UNAL/Materias/2021-2/Electronica_Digital_I/lab04-2021-2-grupo7-2021-2/src/BCD4bitsWreg.v}
vlog -vlog01compat -work work +incdir+C:/Datos/UNAL/Materias/2021-2/Electronica_Digital_I/lab04-2021-2-grupo7-2021-2/src {C:/Datos/UNAL/Materias/2021-2/Electronica_Digital_I/lab04-2021-2-grupo7-2021-2/src/BancoRegistro.v}

vlog -vlog01compat -work work +incdir+C:/Datos/UNAL/Materias/2021-2/Electronica_Digital_I/lab04-2021-2-grupo7-2021-2/quartus/../src {C:/Datos/UNAL/Materias/2021-2/Electronica_Digital_I/lab04-2021-2-grupo7-2021-2/quartus/../src/Lab4_TB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  Lab4_TB

add wave *
view structure
view signals
run -all
