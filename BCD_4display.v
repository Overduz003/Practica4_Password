module BCD_4display #(parameter N_in=7, N_out=7)( //parametros 

	input [N_in-1:0] bcd_in,  // 10 pines de entradas 
	output[N_out-1:0] D_un, D_de, D_ce, D_mi); // 7 pines de salidas
	
	wire[3:0] unidades, decenas, centenas, millares;
	
	assign unidades = bcd_in %10; // obtener unidades
	assign decenas = (bcd_in / 10) % 10; // obtener unidades
	assign centenas = (bcd_in / 100) %10; //obtner centenas
	assign millares = (bcd_in / 1000) %10; //obtener millares
	
	//Instanciar 
	
	BCD_module uni (
	.bcd_in(unidades),
	.bcd_out(D_un));
	
	BCD_module dec (
	.bcd_in(decenas),
	.bcd_out(D_de));

	BCD_module cen(
	.bcd_in(centenas),
	.bcd_out(D_ce));
	
	BCD_module mill(
	.bcd_in(millares),
	.bcd_out(D_mi));
	
endmodule  
	