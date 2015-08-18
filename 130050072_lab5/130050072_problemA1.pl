/* 130050072 Shouvanik Chakrabarti */

rotate([H|T],Ans):-
    append(T,[H],Ans).

rotator(List,[],0).
rotator(List,[H|T],N) :-
    N > 0,
    rotate(List,H),
    N1 is N-1,
    rotator(H,T,N1).

getRotations(List,Ans) :-
    length(List,L),
    rotator(List,Ans,L).

makeNumbers([],[]).
makeNumbers([H|T],[H1|T1]) :-
    number_codes(H1,H),
    makeNumbers(T,T1).

numRotation(N,Ans) :-
    number_codes(N,X),
    getRotations(X,A),
    makeNumbers(A,Ans).

nofactor(X,[]).
nofactor(X,[H|T]) :-
    not(X mod H =:= 0),
    !,
    nofactor(X,T).

mysqrt(X,Y,Y) :-
    Y1 is Y*Y,
    Y1 >= X, !.
mysqrt(X,Y,Ans) :-
    Y1 is Y*Y,
    Y<X,
    Y2 is Y+1,
    mysqrt(X,Y2,Ans).

isPrime(X) :-
    mysqrt(X,0,X1),
    findall(N, between(2,X1,N), L),
    nofactor(X,L),
    !.

allPrimes([]).
allPrimes([H|T]) :-
    isPrime(H),
    allPrimes(T).

cp(X) :-
    numRotation(X,L),
    allPrimes(L).

checkDigits(N) :-
    number_codes(N,X),
    not(member(48,X)),
    not(member(50,X)),
    not(member(52,X)),
    not(member(53,X)),
    not(member(54,X)),
    not(member(56,X)).

circular_prime(0,[]) :- ! .
circular_prime(1,[]) :- ! .
circular_prime(2,[]) :- ! .
circular_prime(3,[2]) :- !.
circular_prime(N,L) :-
    N1 is N-1,
    not(checkDigits(N1)),
    !,
    circular_prime(N1,L).
circular_prime(N,[H|T]) :-
    H is N-1,
    checkDigits(H),
    cp(H),
    !,
    circular_prime(H,T).
circular_prime(N,L) :-
    N1 is N-1,
    not(cp(N1)),
    !,
    circular_prime(N1,L).
    
    
