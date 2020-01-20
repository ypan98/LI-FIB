% Separa L en L1 L2 por el elemento X
split(X, [X|L], [], L):- !.
split(X, [Y|L], [Y|L1], L2):- split(X, L, L1, L2).


programa([begin|L]):- length(L, N), nth1(N, L, end, Laux), instrucciones(Laux).

instrucciones(L):- instruccion(L), !.
instrucciones(L):- split(;, L, L1, L2), instruccion(L1), instrucciones(L2).

instruccion([X, =, Y, +, Z]):- variable(X), variable(Y), variable(Z), !.
instruccion([if, X, =, Y, then |L]):- variable(X), variable(Y), length(L, N), nth1(N, L, endif, Laux),
                                      nth1(N2, Laux, else), split(else, Laux, L1, L2),
                                      %write(L1), nl, write(L2), nl,
                                      instrucciones(L1), instrucciones(L2), !.

variable(x).
variable(y).
variable(z).
