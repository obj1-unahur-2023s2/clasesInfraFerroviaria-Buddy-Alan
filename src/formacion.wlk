import vagones.*
import locomotoras.*
/*Requerimientos - información sobre una formación

A partir del modelo que se construya se tiene que poder saber fácilmente, para una formación:

    hasta cuántos pasajeros puede llevar.
    cuántos vagones populares tiene. Un vagón es popular si puede llevar más de 50 pasajeros.
    si es una formación carguera, o sea, si todos los vagones pueden transportar al menos 1000 kilos de carga.
    cuál es la dispersión de pesos, que es el resultado de esta cuenta: peso máximo del vagón más pesado - peso máximo del vagón más liviano. P.ej. si una formación tiene 4 vagones, cuyos pesos máximos son 9000, 12000, 3500 y 8000, entonces su dispersión de pesos es 12000 - 3500 = 8500.
    cuántos baños tiene una formación, que se obtiene como la cantidad de vagones que tienen baños (se supone que cada vagón que tiene baños, tiene uno solo).

Además, se tiene que poder hacer mantenimiento de una formación, que implica hacer mantenimiento de cada vagón, de acuerdo a estas definiciones

    hacer mantenimiento de un vagón de pasajeros quiere decir ordenarlo; si no estaba ordenado pasa a estar ordenado, si ya estaba ordenado no cambia nada.
    hacer mantenimiento de un vagón de carga es arreglar dos de las maderas que tiene sueltas: si tenía 5 pasa a 3, si tenía 1 pasa a 0, si tenía 0 queda en 0.
    hacer mantenimiento de un vagón dormitorio no tiene ningún efecto que interese para este modelo.
    * Un poco más salados

Poder pedirle a una formación lo siguiente:

    si está equilbrada en pasajeros, o sea: si considerando sólo los vagones que llevan pasajeros, la diferencia entre el que más lleva y el que menos no supera los 20 pasajeros.
    si está organizada, o sea: adelante los vagones que llevan pasajeros, y atrás los que no. Para esto, los vagones se tienen que almacenar en una lista. Si agregamos dos vagones que llevan pasajeros, uno que no, y después uno que sí, entonces la formación no está organizada.
    ¡Ojo! si todos los vagones de la formación llevan pasajeros, o si ninguno lleva, entonces la formación sí se considera organizada.
    
*/


	/*## Etapa 2 - locomotoras

Agregar al modelo las **locomotoras**. 
*De cada locomotora debe indicarse: su peso, hasta cuánto peso puede arrastar, y su velocidad máxima. 
*Decimos que una locomotora es _eficiente_ si puede arrastrar, al menos, cinco veces su peso. 
*P.ej. una locomotora que pesa 1000 kilos y puede arrastar hasta 7000 es eficiente; si puede arrastrar hasta 3000 entonces no es eficiente.

Ahora una formación incluye locomotoras (pueden ser varias), además de vagones. 

Con el modelo ampliado, tiene que poder obtenerse fácilmente, para una formación:
- su _velocidad máxima_ , que es el mínimo entre las velocidades máximas de las locomotoras.
- Si es _eficiente_; o sea, si todas sus locomotoras lo son.
- Si _puede moverse_. 
  Una formación puede moverse si la suma del arrastre de cada una de sus locomotoras, es mayor o igual al _peso máximo_ de la formación, que es: peso de las locomotoras + peso máximo de los vagones.
- Cuántos _kilos de empuje le faltan_ para poder moverse, que es: 0 si ya se puede mover, y si no, el resultado de: peso máximo - suma de arrastre de cada locomotora.

P.ej. si una formación tiene una locomotora que pesa 1000 kilos y arrastra hasta 30000, y cuatro vagones, de 6000 kilos de peso máximo cada uno, entonces sí puede moverse, porque su peso máximo es 25000.  
Si agregamos dos vagones más de 6000 kilos, llevamos el peso máximo a 37000. Ahora la formación no puede moverse y le faltan 7000 kilos de empuje.
	 * 
	 * 
	 * 
	 */
	

class Formacion 
	{
		const vagonesDeLaFormacion = []
		const locomotoras =  []
			method agregarVagonALaFormacion(nuevoVagon) 
				 { 
				 	vagonesDeLaFormacion.add(nuevoVagon)
				 }
				 
		method maximoDePasajerosDeLaFormacion()  {
			return vagonesDeLaFormacion.sum({vagon => vagon.cantidaMaximaDePasajeros()})
			
			}
		
		
		method cantidadDeVagonesPopulares() { 
			 
			return vagonesDeLaFormacion.count({vagon =>vagon.esPopular()})
		}
		
		/*Arreglar pasando a otro  methodo */
		method esFormacionCarguera () =  vagonesDeLaFormacion.all({vagon => vagon.cargaMaxima() >= 1000})
		method dispersionDePeso ()  {  
			
			const maximo = vagonesDeLaFormacion.max({vagon => vagon.pesoMaximo()})
			const minimo =  vagonesDeLaFormacion.min({vagon => vagon.pesoMaximo()})
			return maximo.pesoMaximo() - minimo.pesoMaximo()
		}
		
		method cantidadDeBanio() = 	vagonesDeLaFormacion.count({vagon => vagon.tieneBanio()})
		
		method estaEquilibtado () {
			  const maximo  = vagonesDeLaFormacion.max({vagon => vagon.cantidaMaximaDePasajeros()})
			  const minimo  vagonesDeLaFormacion.min({vagon => vagon.cantidaMaximaDePasajeros()})
			  return  (maximo.cantidaMaximaDePasajeros() - minimo.cantidaMaximaDePasajeros()) < 20
			  }
			  
		method realizarMantenimiento () {
			 const diferenciaEntreVagones  = vagonesDeLaFormacion.max({vagon => vagon.cantidaMaximaDePasajeros()}).cantidaMaximaDePasajeros() - vagonesDeLaFormacion.min({vagon => vagon.cantidaMaximaDePasajeros()}).cantidaMaximaDePasajeros()
			return diferenciaEntreVagones < 20
			  }

  method estaOrdenado ()
   { 
   	return not (1..vagonesDeLaFormacion.size()-1).any({
   		i => vagonesDeLaFormacion.get(i).cantidaMaximaDePasajeros() > 0 and 
   		not (vagonesDeLaFormacion.get(i-1).cantidaMaximaDePasajeros() == 0)
   	}) 
   	
   }
    method velocidadMaxima()
    	{
    		const laLocomotoraConLaMenorVelocidad =  locomotoras.min({l => l.velocidadMaxima()})
    		return laLocomotoraConLaMenorVelocidad.velocidadMaxima()
    	}
    method esEficiente () = locomotoras.all({l => l.esEficiente()})
    
    method pesoDeLocomotoras () = locomotoras.sum({l=>l.peso()})
    
     method pesoDeVagones () = vagonesDeLaFormacion.sum({v=>v.pesoMaximo()})
     method sumaDePesos () =  self.pesoDeVagones() + self.pesoDeLocomotoras()
     
        method sumaDelArrastre () = locomotoras.sum({l => l.peso()})
     method  puedeMoverse() = self.sumaDelArrastre () >= self.sumaDePesos()
     
     
	}
	
	
	

	
	
	
