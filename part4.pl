:- style_check(-singleton).

element(E,S) :- member(E,S).

union([],[],[]).
union(L1,[],L1).
union(L1, [H|T], [H|Out]):- \+(member(H,L1)), union(L1,T,Out).
union(L1, [H|T], Out):- member(H,L1), union(L1,T,Out).  

intersectt([], B, []).

intersectt([E|RestA], B, [E|C]):-
	element(E, B),
	intersectt(RestA, B, C).

intersectt([Ignore|Rest], B, C):-
	intersectt(Rest, B, C).
		
intersect(S1, S2, S3):-
	intersectt(S1, S2, C),
	equivalent(S3, C).

equivalent(S1, S2) :- permutation(S1, S2).