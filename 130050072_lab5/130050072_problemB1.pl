rWalk(N,Start,Ans) :- rWalk1(rand, N, [Start],Ans).

rWalk1(HowNext,N,[Current|Rest],Ans):-
    findall(Next,ktmove(N,Current,Next), Cands),
    newMoves([Current|Rest],Cands,Poss),
    pickMove(HowNext,N,Poss,Step) ->
	rWalk1(HowNext,N,[Step|[Current|Rest]],Ans); % continue walking
    Ans = [Current|Rest]. % No more moves possible. Stop

pickMove(rand, N, [F|Poss], Step):-
    length(Poss,M),
    (M =:= 0 -> Step = F; %Exactly one move posssible. Take it.
     M1 is M+1, random(1,M1,M2), nth1(M2,Poss,Step)).

newMoves(Visited, [], []).
newMoves(Visited,[A|R], Ans) :-
    member(A,Visited) ->
	newMoves(Visited,R,Ans);
    newMoves(Visited, R, A1),
    Ans=[A|A1].

ktmove(N, [X,Y], [X1,Y1]) :- c1(N,X,X1), c2(N,Y,Y1).
ktmove(N,[X,Y], [X1,Y1]) :- c2(N,X,X1), c1(N,Y,Y1).
c1(N,X,X1) :- X > 1, X1 is X - 1.
c1(N,X,X1) :- X < N, X1 is X + 1.
c2(N,X,X1) :- X > 2, X1 is X - 2.
c2(N,X,X1) :- N1 is N - 1, X < N1, X1 is X + 2.

% Recursion with cuts to find only one walk. Removing the cut in the second rule for dfsWalk1 will give more. 
dfsWalk(N, Start, Len, Ans) :- dfsWalk1(N, [Start], Len, Ans).

dfsWalk1(N,Path,1,Path) :- !.
dfsWalk1(N, [Current|Rest], Len, Ans) :-
    L1 is Len - 1,
    ktmove(N,Current,Next),
    not(member(Next,[Current|Rest])),
    dfsWalk1(N, [Next|[Current|Rest]], L1, Ans), %remove to get more walks.
    !.
    
