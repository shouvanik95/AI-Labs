/* 130050072 Shouvanik Chakrabarti */

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

isPrime(2).
isPrime(X) :-
    X > 1,
    mysqrt(X,0,X1),
    findall(N, between(2,X1,N), L),
    nofactor(X,L),
    !.

allPrimes([]).
allPrimes([H|T]) :-
    isPrime(H),
    allPrimes(T).

sieve_primes(N,N,L,L).
sieve_primes(N,X,L,Ans) :-
    not(nofactor(X,L)),
    X1 is X+1,
    !,
    sieve_primes(N,X1,L,Ans).
sieve_primes(N,X,L,Ans) :-
    nofactor(X,L),
    X1 is X+1,
    !,
    sieve_primes(N,X1,[X|L],Ans).

primeList(2,[2]).
primeList(N,[N|T]) :-N>2,isPrime(N),N1 is N-1,!,primeList(N1,T).
primeList(N,List) :-N>2,not(isPrime(N)),!,N1 is N-1,primeList(N1,List).

/* Above code generates primes */
/* The problem specific code is below */

triplets([],_,[],Primes).
triplets([B|Bs],[],List,Primes) :-
    triplets(Bs,Primes,List,Primes).
triplets([B|Bs],[C|Cs],[[A,B,C]|T],Primes) :-
    C > B,
    A1 is B*B + 2*B -C,
    A2 is C+1,
    0 is A1 mod A2,
    A is A1 / A2,
    isPrime(A),
    triplets([B|Bs],Cs,T,Primes).
triplets([B|Bs],[C|Cs],T,Primes) :-
    C > B,
    A1 is B*B + 2*B -C,
    A2 is C+1,
    0 is A1 mod A2,
    A is A1 / A2,
    not(isPrime(A)),
    triplets([B|Bs],Cs,T,Primes).
triplets([B|Bs],[C|Cs],T,Primes) :-
    triplets([B|Bs],Cs,T,Primes).

addtriplets([],0).
addtriplets([[A,B,C]|T],Ans) :-
    addtriplets(T,Ans1),
    S1 is A + B + C,
    Ans is Ans1 + S1.

tripletSum(N,Ans) :-
    primeList(N,Primes),
    reverse(Primes,Pr),
    triplets(Pr,Pr,Ans1,Pr),
    addtriplets(Ans1,Ans).

