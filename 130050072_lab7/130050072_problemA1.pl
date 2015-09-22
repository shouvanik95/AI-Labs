/* Shouvanik Chakrabarti, 130050072 */

/* define operators */
:- op(100, fx, '~').
:- op(200, yfx, '^').
:- op(300, yfx, 'v').
:- op(400, xfx, '=>').

/* defines rules for propositional logic */
rule(~(~X),X).
rule(~(v(A,B)),^(~(A),~(B))).
rule(~(^(A,B)),v(~(A),~(B))).
rule(=>(A,B),v(~(A),B)).
rule(v(^(A,B),C),^(v(A,C),v(B,C))).
rule(v(C,^(A,B)),^(v(A,C),v(B,C))).

/* Rule by rule conversion to cnf */
cnFer(^(A,B),Clauses) :-
    cnFer(A,Clause1),
    cnFer(B,Clause2),
    append(Clause1,Clause2,Clauses), !.
cnFer(A,[B]) :- makeList(A,B), !.

makeList(v(A,B),[A|T]) :- makeList(B,T), !.
makeList(A,[A]) :- !.

cnF(A,Clause) :- rnorm(A,B), cnFer(B,Clause).

/* Previous lab code for rule by rule application */
rnorm(T,Ans) :- nonvar(T), rule(A,B), rwonce(T,T1,A,B),!,
               rnorm(T1,Ans).
rnorm(T,T).

rwonce(T,R,A,B) :-
    nonvar(T),
    functor(T,F,N),
    functor(L,F,N),
    match(L,A),
    match(L,T),
    match(R,B).
rwonce(T,R,A,B) :- nonvar(T), 
               T =.. [F | Args], 
               rwarg(Args, Args1, A, B), 
               R =.. [F | Args1].

rwarg([A1 | R], [A2 | R], A, B) :- rwonce(A1, A2, A, B).
rwarg([A1 | R], [A1 | R1], A, B) :- rwarg(R, R1, A, B).

match(L, T) :- var(L), !, L = T.
match(L, T) :- L =.. [F | Lr], 
               T =.. [F | Tr], allmatch(Lr, Tr).

allmatch([],[]).
allmatch([A | R], [B | S]) :- match(A,B), 
                              allmatch(R,S).


showstep(T,R,N) :- blnks(N), write('  -->  '), write(R),nl.
blnks(0).
blnks(N) :- N > 0, N1 is N - 1, write('  '), blnks(N1).
