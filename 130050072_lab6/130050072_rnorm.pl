%%%%%%%%%%%%%%%% Normalization of a term %%%%%%%%%%%%%%%
%
%   130050072- Shouvanik Chakrabarti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rnorm(T,Ans) :- nonvar(T), rule(A,B), rwonce(T,T1,A,B),!,
               showstep(T,T1,2),rnorm(T1,Ans).
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

% rules in the file rules.pl must be loaded first
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% try goals such as the following
%    norm(*(s(s(0)),+(s(0),s(0))), Ans).
%    norm(fac(s(s(s(0)))), Ans).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
