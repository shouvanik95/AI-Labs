/* Shouvanik Chakrabarti, 130050072 */

:- op(100, fx, '~').

/* Extract variables from a list */
getvars([],[]) :- !.
getvars([H|T],[H|T1]) :- atom(H), getvars(T,T1),!.
getvars([~(H)|T],[H|T1]) :- atom(H), getvars(T,T1),!.

/* Extract variables from list of lists */
get_variables([],[]) :- !.
get_variables([H|T],Ans) :-
    getvars(H,L),
    get_variables(T,A1),
    append(L,A1,A2),
    remdup(A2,Ans),
    !.

/* Remove duplicates from said list */
remdup([],[]) :- !.
remdup([A|B],[A|C]) :-
    delete(B,A,D),
    remdup(D,C), !.

/* Get an assignment */
assign([],[]).
assign([H|T],[H|T1]) :- assign(T,T1).
assign([H|T],A) :- assign(T,A).

/* Check it */
satatom(~(X),L) :- atom(X), not(member(X,L)).
satatom(X,L) :- atom(X), member(X,L).

satlist([H|T],L) :- satatom(H,L),!.
satlist([H|T],L) :- satlist(T,L),!.

satclause([],L) :- !.
satclause([H|T],L) :- satlist(H,L), satclause(T,L).

sat(Clauses, Ans) :-
    get_variables(Clauses,Vars),
    !,
    assign(Vars,Ans),
    satclause(Clauses,Ans).
