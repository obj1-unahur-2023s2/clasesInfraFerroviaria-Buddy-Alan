/** First Wollok example */


/*### Vagones de pasajeros
Para definir un vagón de pasajeros, debemos indicar el largo y el ancho medidos en metros, si tiene o no _baños_, y si está o no _ordenado_. 

A partir de estos valores, la _cantidad de pasajeros_ que puede transportar un vagón se calcula de esta forma:
- si el ancho es hasta 3 metros, entran 8 pasajeros por cada metro de largo.
- si el ancho es de más de 3 metros, entran 10 pasajeros por cada metro de largo.

Si el vagón no está ordenado, restar 15 pasajeros.

P.ej.:
- un vagón de pasajeros de 10 metros de largo y 2 de ancho puede llevar hasta 80 pasajeros si está ordenado, 65 pasajeros si no.
- otro vagón, también de 10 metros de largo, pero de 4 metros de ancho, puede llevar hasta 100 pasajeros si está ordenado, 85 pasajeros si no. 

La cantidad máxima de _carga_ que puede llevar un vagón de pasajeros depende de si tiene o no baños:
- si tiene baños, entonces puede llevar hasta 300 kilos.
- si no, hasta 800 kilos.

El _peso máximo_ de un vagón de pasajeros se calcula así: 2000 kilos, más 80 kilos por cada pasajero, más el máximo de carga que puede llevar.
 
 */
class VagonesDePasajeros 
	{
		const property largo
		const property ancho
		const property tieneBanio
		var property estaOrdenado = true
			
		method cantidadDePasajerosOrdenado () 
			{
				return if(self.ancho() <= 3){ 8*self.largo()} else { 10*self.largo()}
			}
		method cantidaMaximaDePasajeros ()
		{	
			if (estaOrdenado) 
			{
				return self.cantidadDePasajerosOrdenado()
			} 
			else {
				return ( 0.max(self.cantidadDePasajerosOrdenado() - 15))
			}
		}
		method cargaMaxima () 
		{
			return if (tieneBanio){ 300} else  { 800 }
		}
		method pesoMaximo () 
			{
				return 2000+ self.cargaMaxima() + (self.cantidaMaximaDePasajeros()*80)
			}
	method esPopular ()
		{
			return self.cantidaMaximaDePasajeros() > 50
		}
	method hacerMantenimieno () 
	{
		self.estaOrdenado(true) 
	}
		
	}
	
	/*
	 * 
	 * Para cada vagón dormitorio se indica: cuántos compartimientos tiene, y cuántas camas se ponen en cada compartimiento.

La _cantidad máxima de pasajeros_ es el resultado de multiplicar cantidad de compartimientos por cantidad de camas por compartimiento.
P.ej. un vagón dormitorio con 12 compartimientos de 4 camas cada uno, puede llevar hasta 48 pasajeros.

Todos los vagones dormitorio _tienen baños_, y pueden llevar hasta 1200 kilos de carga cada uno.

Su _peso máximo_ se calcula así: 4000 kilos, más 80 kilos por cada pasajero, más el máximo de carga que puede llevar.
	 
	 * 
	 */
	
class VagonDeDormitorio
	{
		const property tieneBanio = true
		const property cantidadDeCompartimientos
		var property cantidadDeDormitoriosPorCormpartimentos
		
		method cantidaMaximaDePasajeros() =  cantidadDeCompartimientos * cantidadDeDormitoriosPorCormpartimentos
		
		method cargaMaxima () =  1200
		method pesoMaximo () 
			{
				return 4000 + self.cargaMaxima() + (self.cantidaMaximaDePasajeros()*80)
			}
		method esPopular ()  
			{
				return self.cantidaMaximaDePasajeros() > 50
			}
		method hacerMantenimieno () 
				{
					
				}
		
	}	
	/*
	### Vagones de carga
Para cada vagón de carga se indica su carga máxima ideal, y cuántas maderas tiene sueltas.  
Un vagón de carga puede llevar hasta su carga máxima ideal, menos 400 kilos por cada madera suelta.

P.ej. un vagón de carga con carga máxima ideal 8000 kilos con 5 maderas sueltas puede llevar hasta 6000 kilos; si cambiamos la cantidad de maderas sueltas a 2, entonces puede llevar hasta 7200 kilos.

No puede llevar pasajeros, y no tiene baños.

Su _peso máximo_ es de 1500 kilos más el máximo de carga que puede llevar.
*/
	
	
class VagonDeCarga 
	{
		const property cargaMaximaIdeal = 0
		var property cantidaDeMaderas = 0
		const  property tieneBanio = false
		
		method cantidaDePasajerosMaxima() =  0
		
		method cargaMaxima ()  {
			return 0.max(cargaMaximaIdeal - cantidaDeMaderas*400 )
			
		}
		
		method pesoMaximo () = 1500 + self.cargaMaxima() 
		method esPopular () 
		{
			return false
		}
	method hacerMantenimieno () 
		{
			self.cantidaDeMaderas(0.max(cantidaDeMaderas - 2)) 
		}
		
		
	}