import vagones.*
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

class formacion 
	{
		const vagonesDeLaFormacion = []
		method agregarVagonALaFormacion(nuevoVagon)  { vagonesDeLaFormacion.add(nuevoVagon)}
		method maximoDePasajerosDeLaFormacion() = vagonesDeLaFormacion.sum({vagon => vagon.cantidaMaximaDePasajeros()})
		method cantidadDeVagonesPopulares() =  vagonesDeLaFormacion.count({ vagon =>vagon.esPopular()})
		/*Arreglar pasando a otro  methodo */
		method esFormacionCarguera () =    {vagonesDeLaFormacion.all({vagon => vagon.cargaMaxima() >= 1000})}
		method dispersionDePeso ()  {  
			
			const maximo = vagonesDeLaFormacion.max({vagon => vagon.pesoMaximo()})
			const minimo =  vagonesDeLaFormacion.min({vagon => vagon.pesoMaximo()})
			return maximo.pesoMaximo() - minimo.PesoMaximo()
		}
		
		method cantidadDeBanio() = 	vagonesDeLaFormacion.count({vagon => vagon.tieneBanio()})
		
		method estaEquilibtado () {
			  const maximo  = vagonesDeLaFormacion.max({vagon => vagon.cantidaMaximaDePasajeros()})
			  const minimo  vagonesDeLaFormacion.min({vagon => vagon.cantidaMaximaDePasajeros()})
			  return  (maximo - minimo) < 20
			  }
			  
		method realizarMantenimiento () {
			 const diferenciaEntreVagones  = vagonesDeLaFormacion.max({vagon => vagon.cantidaMaximaDePasajeros()})- vagonesDeLaFormacion.min({vagon => vagon.cantidaMaximaDePasajeros()})
			return diferenciaEntreVagones < 20
			  }

  method estaOrdenado ()
   { 
   	return not (1..vagonesDeLaFormacion.size()-1).any({i => vagonesDeLaFormacion.get(i).cantidadDeasajerosMaxima() > 0 and not vagonesDeLaFormacion.get(i-1).cantidadDeasajerosMaxima() == 0}) 
   	
   }
	}