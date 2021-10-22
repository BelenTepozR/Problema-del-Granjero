/*El estado final de cada personaje al que se quiere llegar siguiendo el orden (Granjero,Cabra,Lobo,col)*/
estadoFinal(estado(i,i,i,i)).
/*puede cruzar de izquierda a derecha y viceversa*/
cruza(i, d).
cruza(d, i).

/* 4 Movimientos válidos 
 * 1.-Granjero Cruza Solo
 * 2.-Granjero Cruza con lobo
 * 3.-Granjero Cruza con Cabra
 * 4.-Granjero Cruza con Col */
movimiento(estado(ACTUAL, CABRA, LOBO, COL), estado(DESTINO, CABRA, LOBO, COL)):- cruza(ACTUAL, DESTINO).
movimiento(estado(ACTUAL, CABRA, ACTUAL, COL), estado(DESTINO, CABRA, DESTINO, COL)):- cruza(ACTUAL, DESTINO).
movimiento(estado(ACTUAL, ACTUAL, LOBO, COL), estado(DESTINO, DESTINO, LOBO, COL)):- cruza(ACTUAL, DESTINO).
movimiento(estado(ACTUAL, CABRA, LOBO, ACTUAL), estado(DESTINO, CABRA, LOBO, DESTINO)):- cruza(ACTUAL, DESTINO).

/*  Restricciones
 * 1.- El lobo y la cabra no pueden estar sin la presencia del granjero
 * 2.- La cabra y la col no pueden estar sin la presencia del granjero*/
restriccion(estado(POSG, POSCL, POSCL, _)):- cruza(POSG, POSCL).
restriccion(estado(POSG, POSCC, _, POSCC)):- cruza(POSG, POSCC).

/*  Verifica si el estado ya está en el camino solución */
visitados(X, [X|_]).
visitados(X, [_|C]):- visitados(X, C).

/* Reglas para encontrar el camino solución, para ello se usa recursividad */ 
/*Caso base: Cuando llegue al estado final termina el algoritmo*/
caminoSolucion([EA | C], [EA | C]) :- estadoFinal(EA).
/*Para que un estado pueda ser insertado, el movimiento que se va a hacer tiene que ser:
 *  sea valido
 *  que no sea uno restringido
 * y no se haya insertado al camino solución*/
caminoSolucion([EA | C], CAMINOSOL):- movimiento(EA, EF), not(restriccion(EF)), not(visitados(EF, C)), caminoSolucion([EF, EA | C], CAMINOSOL).


/*Para hacer la consulta:
     * caminoSolucion([estado(d, d, d, d)], L).
     * en donde se le manda la lista con el estado inicial y la lista en donde retornará el camino solucion
     * como salida es el camino solucion final, imprime dos ya que hay dos posibles caminos, que corresponderias a los recorridos en anchura
     * y profundidad pero aqui no nos vamos a meter en esos asuntos :v 
 * */