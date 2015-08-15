/*Shouvanik Chakrabarti 130050072 */

/*Check if ugly number*/
is235(1).
is235(X):-
    Y is X//2,
    X is Y*2,
    is235(Y).
is235(X):-
    Y is X//3,
    X is Y*3,
    is235(Y).
is235(X):-
    Y is X//5,
    X is Y*5,
    is235(Y).

/*Brute force list construction. not used. Initialy include for testing purposes. */
get235(Num,Count,Limit,Last,Ans):-
    Count = Limit,
    !,
    Last = Ans.
get235(Num,Count,Limit,Last,Ans):-
    is235(Num),
    Count1 is Count + 1,
    Num1 is Num + 1,
    get235(Num1,Count1,Limit,Num,Ans).
get235(Num,Count,Limit,Last,Ans):-
    not(is235(Num)),
    Num1 is Num + 1,
    get235(Num1,Count,Limit,Last,Ans).  

/* Implementation of minimum for 3 numbers */
mymin(A,B,C,D):- A=<B,A=<C,D is A.
mymin(A,B,C,D):- C=<B,C=<A,D is C.
mymin(A,B,C,D):- B=<A,B=<C,D is B.

/*Minimum number in sorted list which when multiplied by a prime gives a number greater than the greatest number obtained so far */
minwith2(A,[H|T],Ans) :-
    H1 is H*2,
    H1 =< A,
    minwith2(A,T,Ans).
minwith2(A,[H|T],Ans) :-
    H1 is H*2,
    H1 > A,
    Ans is H1,
    !.

minwith3(A,[H|T],Ans) :-
    H1 is H*3,
    H1 =< A,
    minwith3(A,T,Ans).
minwith3(A,[H|T],Ans) :-
    H1 is H*3,
    H1 > A,
    Ans is H1,
    !.

minwith5(A,[H|T],Ans) :-
    H1 is H*5,
    H1 =< A,
    minwith5(A,T,Ans).
minwith5(A,[H|T],Ans) :-
    H1 is H*5,
    H1 > A,
    Ans is H1,
    !.

head([H|T],H).

/* Generate a list of ugly numbers. Find the minimum of minwith2, 3 and 5 and append the new value as the next ugly number*/ 
getlist235(1,[1]).
getlist235(X,[H|T]):-
    X>1,
    X1 is X-1,
    getlist235(X1,T),
    !,
    head(T,Limit),
    sort(T,T1),
    minwith2(Limit,T1,A2),
    minwith3(Limit,T1,A3),
    minwith5(Limit,T1,A5),
    mymin(A2,A3,A5,Ans),
    !,
    H is Ans.

/* Call the generated list and release its head as the answer */
p235(N,X) :-
    getlist235(N,L),
    !,
    head(L,X).

/*Construct a general predicate to replace minwith2, minwith3 etc. */
minwithprime(Prime,A,[H|T],Ans) :-
    H1 is H*Prime,
    H1 =< A,
    minwithprime(Prime,A,T,Ans).
minwithprime(Prime,A,[H|T],Ans) :-
    H1 is H*Prime,
    H1 > A,
    Ans is H1,
    !.

/* Apply minwith to list of primes */
minwithprimes([],A,L,[]).
minwithprimes([P|Ps],A,L,[H1|T1]):-
    minwithprime(P,A,L,H1),
    minwithprimes(Ps,A,L,T1).

/* Construct given number of elements of sequence */
getlistprimes(Primes,1,[1]).
getlistprimes(Primes,X,[H|T]):-
    X>1,
    X1 is X-1,
    getlistprimes(Primes,X1,T),
    !,
    head(T,Limit),
    sort(T,T1),
    minwithprimes(Primes,Limit,T1,Alist),
    min_list(Alist,Ans),
    !,
    H is Ans.

/* xReturn the head of the constructed list as answer */
findNth(Primes,N,Ans):-
    getlistprimes(Primes,N,Ans1),
    head(Ans1,Ans).
