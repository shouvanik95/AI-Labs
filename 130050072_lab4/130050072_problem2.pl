/*Shouvanik Chakrabarti, 130050072 */

ktmove([X,Y], [X1,Y1]) :- c1(X,X1), c2(Y,Y1).
ktmove([X,Y], [X1,Y1]) :- c2(X,X1), c1(Y,Y1).
c1(X,X1) :- X > 1, X1 is X - 1.
c1(X,X1) :- X < 8, X1 is X + 1.
c2(X,X1) :- X > 2, X1 is X - 2.
c2(X,X1) :- X < 7, X1 is X + 2.

/* List of possible moves from Start */
nextAllowed(Start,Ans):-
    findall(Next,ktmove(Start,Next),Ans).

/* Obtaining an indexed element of a list */
getindex(0,[H|T],H).
getindex(N,[H|T],Ans):-
    N>=0,
    N1 is N-1,
    !,
    getindex(N1,T,Ans).

/* Get non repititive destinations*/
validmoves(Start,Walk,Ans):-
    nextAllowed(Start,Ans1),
    subtract(Ans1,Walk,Ans).

/* Blocking condition */
rWalker(Start,Walk,Walk):-
    validmoves(Start,Walk,L1),
    length(L1,X),
    X = 0.

/* Iterative predicate */
rWalker(Start,Walked,Ans):-
    validmoves(Start,Walked,Ans1),
    length(Ans1,X),
    X>0,
    random(0,X,X1),
    getindex(X1,Ans1,X2),
    rWalker(X2,[Start|Walked],Ans).

/* Front end function */
rWalk(Start,Ans):-
    rWalker(Start,[],Ans).

/* repeat function */
rpt(0,Start).
rpt(N,Start):- rWalk(Start,Walk),length(Walk,Ans),write(Ans),write(' steps before blocking.\n'),N1 is N-1,rpt(N1,Start).

/* Add element at head of list */
makehead(X,[],[X]).
makehead(X,L,[X|L]).

/* make new paths from visited vertices */
mnp([],L,[]).
mnp([H|T],L,[H1|T1]):-
    makehead(H,L,H1),
    mnp(T,L,T1).

/* Define bfs(End,Queue,Answer) where End is endpoint and Queue is the current queue of nodes to expand */
bfs(End,[[End|T]|T1],Ans):-
    reverse([End|T],Ans),
    !.
bfs(End,[[H|T]|T1],Ans):-
    nextAllowed(H,NA),
    mnp(NA,[H|T],NewPaths),
    append(T1,NewPaths,NewQueue),
    bfs(End,NewQueue,Ans).

/* Use breadth first search to find the shortest paths */
path(StartSq,EndSq,Path):-
    bfs(EndSq,[[StartSq]],Path).
