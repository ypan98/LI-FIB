camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
  unPaso( EstadoActual, EstSiguiente ),
  \+member(EstSiguiente,CaminoHastaAhora),
  camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

solucionOptima:-
  nat(N), 						% Buscamos solución de "coste" 0; si no, de 1, etc.
  camino([0,0],[0,4],[[0,0]],C),  % En "hacer aguas": -un estado es [cubo5,cubo8], y.
  length(C,N), 					% -el coste es la longitud de C.
  write(C).

%unPaso([ActX,ActY], [SigX, SigY]):-

nat(0).
nat(N):- nat(N0), N is N0+1.


% Rellnar o vaciar un cubo
unPaso([_, C2], [5, C2]).
unPaso([C1, _], [C1, 8]).
unPaso([_, C2], [0, C2]).
unPaso([C1, _], [C1, 0]).
% Pasar de un cubo a otro
unPaso([C1, C2], [C1F, C2F]):- C1F is max(0, C1-(8-C2)), C2F is min(8, C1+C2).  %C1 a C2
unPaso([C1, C2], [C1F, C2F]):- C2F is max(0, C2-(5-C1)), C1F is min(5, C1+C2).  %C2 a C1
