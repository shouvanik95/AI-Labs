%%%%%%%%%%%%%%%% Normalization of a term %%%%%%%%%%%%%%%
%
%   Naive version- Oct 10, 2001 - Siva
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
norm(T,Ans) :- nonvar(T), rwonce(T,T1),!,
               showstep(T,T1,2),norm(T1,Ans).
norm(T,T).

rwonce(T,R) :- nonvar(T), 
               functor(T,F,N), functor(L,F,N), 
               rule(L,R), match(L,T).
rwonce(T,R) :- nonvar(T), 
               T =.. [F | Args], 
               rwarg(Args, Args1), 
               R =.. [F | Args1].

rwarg([A1 | R], [A2 | R]) :- rwonce(A1, A2).
rwarg([A1 | R], [A1 | R1]) :- rwarg(R, R1).

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
