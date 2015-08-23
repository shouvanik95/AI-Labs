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

%utility functions.
nmoves(N, Pos,Visited,Ans) :-
    findall(Next,ktmove(N,Pos,Next), Cands),
    newMoves(Visited,Cands,Poss),
    length(Poss,Ans).

minmoves(N,[Min],Visited,Min):-!.
minmoves(N,[H,K|T],Visited,Min) :-
    nmoves(N,H,Visited,H1),
    nmoves(N,K,Visited,K1),
    H1 < K1,
    minmoves(N,[H|T],Visited,Min).
minmoves(N,[H,K|T],Visited,Min) :-
    nmoves(N,H,Visited,H1),
    nmoves(N,K,Visited,K1),
    H1 >= K1,
    minmoves(N,[K|T],Visited,Min).

% traverse options in order of heuristic.
checkWalk(N,List,Path,Len,Ans):-
    minmoves(N,List,Path,Min),
    delete(List,Min,L1),
    (wWalk1(N,[Min|Path],Len,Ans);
     checkWalk(N,L1,Path,Len,Ans)).

wWalk1(N,Path,1,Path) :- !.
wWalk1(N,[Current|Rest],Len,Ans):-
    L1 is Len - 1,
    findall(Next,ktmove(N,Current,Next), Cands),
    newMoves([Current|Rest],Cands,Poss),
    checkWalk(N,Poss,[Current|Rest],L1,Ans),
    !. %remove cut to get more walks

wWalk(N,Start,Len,Ans):- wWalk1(N,[Start],Len,Ans).
