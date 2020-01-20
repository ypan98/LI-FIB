camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
  unPaso( EstadoActual, EstSiguiente ),
  \+member(EstSiguiente,CaminoHastaAhora),
  camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

solucionOptima:-
  nat(N), 						% Buscamos solución de "coste" 0; si no, de 1, etc.
  camino([3, 3, 0, 0, 0], [0, 0, 3, 3, 1], [[3, 3, 0, 0, 0]], C),
  length(C,N), 					% -el coste es la longitud de C.
  write(C), !.

nat(0).
nat(N):- nat(N0), N is N0+1.

correct([0, C1, M2, C2]):- between(0, 3, C1), between(0, 3, M2), between(0, 3, C2), !.
correct([M1, C1, 0, C2]):- between(0, 3, M1), between(0, 3, C1), between(0, 3, C2), !.
correct([M1, C1, M2, C2]):- M1 >= C1, M2 >= C2, between(0, 3, M1), between(0, 3, C1), between(0, 3, M2), between(0, 3, C2).

% 5 casos: enviar 1 m, enviar 2 m, enviar 1 c, enviar 2 c, enviar 1 m 1 c.

% 1m
unPaso([M1, C1, M2, C2, 0], [M1F, C1F, M2F, C2F, 1]):- M1F is M1-1, M2F is M2+1, C1F is C1, C2F is C2, correct([M1F, C1F, M2F, C2F]).
% 2m
unPaso([M1, C1, M2, C2, 0], [M1F, C1F, M2F, C2F, 1]):- M1F is M1-2, M2F is M2+2, C1F is C1, C2F is C2, correct([M1F, C1F, M2F, C2F]).
% 1c
unPaso([M1, C1, M2, C2, 0], [M1F, C1F, M2F, C2F, 1]):- C1F is C1-1, C2F is C2+1, M1F is M1, M2F is M2, correct([M1F, C1F, M2F, C2F]).
% 2c
unPaso([M1, C1, M2, C2, 0], [M1F, C1F, M2F, C2F, 1]):- C1F is C1-2, C2F is C2+2, M1F is M1, M2F is M2, correct([M1F, C1F, M2F, C2F]).
% 1m1c
unPaso([M1, C1, M2, C2, 0], [M1F, C1F, M2F, C2F, 1]):- M1F is M1-1, M2F is M2+1, C1F is C1-1, C2F is C2+1, correct([M1F, C1F, M2F, C2F]).


% lo mismo con la vuelta
% 1m
unPaso([M1, C1, M2, C2, 1], [M1F, C1F, M2F, C2F, 0]):- M1F is M1+1, M2F is M2-1, C1F is C1, C2F is C2, correct([M1F, C1F, M2F, C2F]).
% 2m
unPaso([M1, C1, M2, C2, 1], [M1F, C1F, M2F, C2F, 0]):- M1F is M1+2, M2F is M2-2, C1F is C1, C2F is C2, correct([M1F, C1F, M2F, C2F]).
% 1c
unPaso([M1, C1, M2, C2, 1], [M1F, C1F, M2F, C2F, 0]):- C1F is C1+1, C2F is C2-1, M1F is M1, M2F is M2, correct([M1F, C1F, M2F, C2F]).
% 2c
unPaso([M1, C1, M2, C2, 1], [M1F, C1F, M2F, C2F, 0]):- C1F is C1+2, C2F is C2-2, M1F is M1, M2F is M2, correct([M1F, C1F, M2F, C2F]).
% 1m1c
unPaso([M1, C1, M2, C2, 1], [M1F, C1F, M2F, C2F, 0]):- M1F is M1+1, M2F is M2-1, C1F is C1+1, C2F is C2-1, correct([M1F, C1F, M2F, C2F]).
