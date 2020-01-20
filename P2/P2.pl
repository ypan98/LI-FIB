padre(juan,pedro).
padre(maria,pedro).
hermano(pedro,vicente).
hermano(pedro,alberto).
tio(X,Y):- padre(X,Z), hermano(Z,Y).

pert(X,[X|_]).
pert(X,[_|L]):- pert(X,L).

concat([],L,L).
concat([X|L1],L2,[X|L3]):- concat(L1,L2,L3).


fact(0,1):-!.
fact(X,F):-  X1 is X - 1, fact(X1,F1), F is X * F1.

nat(0).
nat(N):- nat(N1), N is N1 + 1.

%mul(X,Y,M):- nat(M), 0 is M mod X, 0 is M mod Y.
mul(X,Y,M):- nat(N), M is N * X,   0 is M mod Y.

pert_con_resto(X,L,Resto):- concat(L1,[X|L2],L), concat(L1,L2,Resto).

% Alternativa una mica m�s eficient.
%pert_r(X,[X|L],L).
%pert_r(X,[Y|L],[Y|R]):- pert_r(X,L,R).

long([],0).
long([_|L],M):- long(L,N),M is N+1.



%factores_primos(1,[]) :- !.
%factores_primos(N,[F|L]):- nat(F), F>1, 0 is N mod F, N1 is N // F,
%                factores_primos(N1,L),!.

f(1,[]).
f(N,[F|L]):- N > 1, nat(F), write(F), nl, F>1, 0 is N mod F, N1 is N // F,
                f(N1,L), !.

permutacion([],[]).
permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).




subcjto([],[]).  %subcjto(L,S) significa "S es un subconjunto de L".
subcjto([X|C],[X|S]):-subcjto(C,S).
subcjto([_|C],S):-subcjto(C,S).

cifras(L,N):- subcjto(L,S), permutacion(S,P), expresion(P,E),
              N is E, write(E),nl,fail.

expresion([X],X).
expresion(L,E1+E2):- concat(L1,L2,L),  L1\=[],L2\=[],
                     expresion(L1,E1), expresion(L2,E2).
expresion(L,E1-E2):- concat(L1,L2,L),  L1\=[],L2\=[],
                     expresion(L1,E1), expresion(L2,E2).
expresion(L,E1*E2):- concat(L1,L2,L),  L1\=[],L2\=[],
                     expresion(L1,E1), expresion(L2,E2).

% expresion(L,E1//E2):- concat(L1,L2,L),  L1\=[],L2\=[],
%                      expresion(L1,E1), expresion(L2,E2),
% 		     X is E2, X \= 0, 0 is E1 mod E2.


der(X, X, 1):-!.
der(C, _, 0) :- number(C).
der(A+B, X, A1+B1) :- der(A, X, A1), der(B, X, B1).
der(A-B, X, A1-B1) :- der(A, X, A1), der(B, X, B1).
der(A*B, X, A*B1+B*A1) :- der(A, X, A1), der(B, X, B1).
der(sin(A), X, cos(A)*B) :- der(A, X, B).
der(cos(A), X, -sin(A)*B) :- der(A, X, B).
der(e^A, X, B*e^A) :- der(A, X, B).
der(ln(A), X, B*1/A) :- der(A, X, B).


simplifica(E,E1):- unpaso(E,E2),!, simplifica(E2,E1).
simplifica(E,E).

unpaso(A+B,A+C):- unpaso(B,C),!.
unpaso(B+A,C+A):- unpaso(B,C),!.
unpaso(A*B,A*C):- unpaso(B,C),!.
unpaso(B*A,C*A):- unpaso(B,C),!.
unpaso(0*_,0):-!.
unpaso(_*0,0):-!.
unpaso(1*X,X):-!.
unpaso(X*1,X):-!.
unpaso(0+X,X):-!.
unpaso(X+0,X):-!.
unpaso(N1+N2,N3):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(N1*N2,N3):- number(N1), number(N2), N3 is N1*N2,!.
unpaso(N1*X+N2*X,N3*X):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(N1*X+X*N2,N3*X):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(X*N1+N2*X,N3*X):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(X*N1+X*N2,N3*X):- number(N1), number(N2), N3 is N1+N2,!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%2 producto de lista
prod([], 1):- !.
prod([X|L], P):- prod(L, P1), P is X*P1.
prod([], 0).


%3 producto escalar de listas
pescalar([], [], 0):- !.
pescalar([X|LX], [Y|LY], P):- pescalar(LX, LY, P1), P is P1+X*Y.


%4 union, interseccion de cjt (lista), sin repeticiones
union([], L2, L2).
union([X|L1], L2, L3):- member(X,L2), !, union(L1, L2, L3).
union([X|L1], L2, [X|L3]):- union(L1, L2, L3).

interseccion([], _, []).
interseccion([X|L1], L2, [X|L3]):- member(X, L2), !, interseccion(L1, L2, L3).
interseccion([_|L1], L2, L3):- interseccion(L1, L2, L3).


%5 último de lista y inverso de lista
last(L, Last):- concat(_, [Last], L), !.

inverso([X], [X]):-!.
inverso(L, [Last|Linv]):- concat(L2, [Last], L), inverso(L2, Linv).

%6 fibonaci n-esimo
fib(1, 1):-!.
fib(2, 1):-!.
fib(N, F):- N > 2, N1 is N-1, N2 is N-2, fib(N1, F1), fib(N2, F2), F is F1+F2.

%7 dado: L expresa una manera de sumar P puntos lanzando N dados
dados(0, 0, []).
dados(P, N, [X|L]):- N > 0, between(1, 6, X), N1 is N-1, P1 is P-X, dados(P1, N1, L).

%8 suma_demas: L contiene un elemento que es igual a la suma de los otros
suma_demas(L):- pert_con_resto(X, L, L1), suma(X, L1), !.

suma(0, []).
suma(S, [X|L]):- suma(S1, L), S is X+S1.

%9 suma_ant: L contiene un elemento que es igual a la suma de los anteriores
suma_ant(L):- concat(L1, [X|_], L), suma(X, L1), !.


%10 card:dada una lista de enteros L,
%escriba la lista que, para cada elemento de L, dice cuantas veces aparece este
%elemento en L.
card(L):- card(L, R), write(R).

card([],[]).
card([X|L], [[X,C]|R]):-card(L, R2), pert_con_resto([X, C2], R2, R), C is C2+1, !.
card([X|L], [[X, 1]|R]):-card(L,R).

%11
esta_ordenada(L):- length(L, N), N > 0, nth0(0, L, X), concat([X], L1, L), esta_ordenada(L1, X).

esta_ordenada([], _):- !.
esta_ordenada([X|L], Y):- Y =< X, !, esta_ordenada(L, X).
esta_ordenada(_, _):- fail.

esta_ordenada2([]).
esta_ordenada2([_]).
esta_ordenada2([X,Y|L]):- X =< Y, esta_ordenada2([Y|L]), !.


%12 ordenar de menor a mayor
ordenacion(L1, L2):- permutacion(L1, L2), esta_ordenada(L2), !.


%13 Sea n el tamaño de la lista. En caso peor, la ordenacion anterior puede llegar a generar n! permutaciones diferentes
%   Para cada permutacion puede llegar a hacer n comparaciones, por lo tanto n*n!.

%14 ordenacion2 : usando insercion (insertar un elemento al sitio que debe estar)
insercion(X, [], [X]).
insercion(X, [Y|L], [X,Y|L]):- X =< Y, !.
insercion(X, [Y|L], [Y|R]):- insercion(X, L, R).

ordenacion2([], []).
ordenacion2([X|L1], L2):- ordenacion2(L1, Laux), insercion(X, Laux, L2).

%15 Sea n el tamaño de la lista, El número de máximo comparaciones es: n(n-1)/2. ~= O(n^2)
%   Las llamadas a inserción es con una lista de tamaño: 1, 2, 3... sucesivamente.


%16 ordenacion por merge
merge([], L, L).
merge(L, [], L).
merge([X|L1], [Y|L2], [X|L3]):- X =< Y, merge(L1, [Y|L2], L3), !.
merge([X|L1], [Y|L2], [Y|L3]):- merge([X|L1], L2, L3).

split([], [], []).
split([X], [X], []).
split([X,Y|L], [X|L2], [Y|L3]):- split(L, L2, L3).

ordenacion3([], []):-!.
ordenacion3([X], [X]):-!.
ordenacion3(L1, L2):- split(L1, L11, L12), ordenacion3(L11, L11Ord), ordenacion3(L12, L12Ord), merge(L11Ord, L12Ord, L2).

%17 diccionario
nmember(_, 0, []):-!.
nmember(A, N, [X|L]):- pert(X, A), N1 is N-1, nmember(A, N1, L).

escribir([]):- write(' '),!.
escribir([X|L]):- write(X), escribir(L).

diccionario(A, N):- nmember(A, N, W), escribir(W), fail.

%18 palindromos
palindromos(L):- setof(R, (permutacion(L, R), esPalindromo(R)), W), escribir2(W).

esPalindromo(L):- reverse(L, R), esPalindromo2(L,R).

esPalindromo2([], []):-!.
esPalindromo2([_], [_]):-!.
esPalindromo2([X|L], [X|L2]):- esPalindromo2(L, L2).

escribir2([]).
escribir2([X|L]):-write(X), nl, escribir2(L).

%19
