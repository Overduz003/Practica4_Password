module password_tb();
	
//Entradas 
	reg clk;
	reg rst;
	reg [3:0]fms_in;
	reg KEY;
//Salidas
	wire fms_out;
	wire [2:0] state_out;
	wire [15:0] display_val;
	
//Intancia del modulo

password DUT (
	.clk(clk),
	.rst(rst),
	.fms_in(fms_in),
	.KEY(KEY),
	.fms_out(fms_out),
	.state_out(state_out),
	.display_val(display_val));
	

//Generador de reloj

	always #5 clk=~clk;
	
//Guion de la simulacion

	initial
		begin
		
			clk= 0;
			rst = 1; 
			fms_in = 0;
			KEY= 1;
			#15;
			rst=0;
			#15;
			
// ------Empieza la magia --------------------			

			fms_in = 1; //Imgresamos 1
			#10;
			KEY= 0; //Presinamos boton 
			#10;
			KEY= 1; //Soltamos boton
			#20;
			
			fms_in = 2;
			#10;
			KEY= 0;
			#10;
			KEY= 1;
			#20;
			
			fms_in = 3;
			#10;
			KEY= 0;
			#10;
			KEY= 1;
			#20;
			
			fms_in = 4;
			#10;
			KEY= 0;
			#10;
			KEY = 1;
			#40;

//----------CASO ERRONEO----------------------

			rst= 1;
			#20;
			rst= 0;
			#20;
			
			fms_in = 1; //Imgresamos 1
			#10;
			KEY= 0; //Presinamos boton 
			#10;
			KEY= 1; //Soltamos boton
			#20;
			
			fms_in = 9; //Imgresamos 9
			#10;
			KEY= 0; //Presinamos boton 
			#10;
			KEY= 1; //Soltamos boton
			#20;
			
			fms_in = 3; //Imgresamos 3
			#10;
			KEY= 0; //Presinamos boton 
			#10;
			KEY= 1; //Soltamos boton
			#20;
			
			fms_in = 4; //Imgresamos 4
			#10;
			KEY= 0; //Presinamos boton 
			#10;
			KEY= 1; //Soltamos boton
			#20;
			
			
			
			$stop;
			
	end
endmodule
	
	
	
	
	