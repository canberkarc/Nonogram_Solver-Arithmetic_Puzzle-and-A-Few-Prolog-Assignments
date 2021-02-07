% a rectangular array of variables with NRows rows and NCs columns 

arrVarFunc(NRows,NCs,Rows,Cs) :-
   NRows > 0, NCs > 0,
   length(Rows,NRows),
   Pred1 =.. [len2, NCs],
   checklist(Pred1,Rows),
   length(Cs,NCs),
   Pred2 =.. [len2, NRows],
   checklist(Pred2,Cs),
   func_unify(Rows,Cs).

len2(Len,List) :- length(List,Len).

func_unify(_,[]).
func_unify([],_).
func_unify([[X|Row1]|Rows],[[X|C1]|Cs]) :-
   rUnify(Row1,Cs,CsR), 
   func_unify(Rows,[C1|CsR]).   

rUnify([],[],[]).
rUnify([X|Row],[[X|C1]|Cs],[C1|CsR]) :- rUnify(Row,Cs,CsR).


% It is a list of char-lists 

correspondLst([],[]) :- !.
correspondLst([Len1|Lens],[Run1-T|Runs]) :- 
   put_x(Len1,Run1,T),
   correspondLst2(Lens,Runs).

% difference from correspondLst is a space character at the beginning.
correspondLst2([],[]).
correspondLst2([Len1|Lens],[[' '|Run1]-T|Runs]) :- 
   put_x(Len1,Run1,T),
   correspondLst2(Lens,Runs).

put_x(0,T,T) :- !.
put_x(N,['x'|Xs],T) :- N > 0, N1 is N-1, put_x(N1,Xs,T).

% Generating all possibilities.

generatePoss([],[]).
generatePoss([Line-Rest|Runs],Line) :- generatePoss(Runs,Rest).
generatePoss(Runs,[' '|Rest]) :- generatePoss(Runs,Rest).
 
% the puzzle is solved here and it is representation of a bitmap

puzzle(Num_of_cs,Num_of_rows, Answer) :-
   length(Num_of_rows,NRows),
   length(Num_of_cs,NCs),
   arrVarFunc(NRows,NCs,Rows,Cs),
   append(Rows,Cs,Lines),
   append(Num_of_rows,Num_of_cs,LineNums),
   maplist(correspondLst,LineNums,RLines),
   assemb(Lines,RLines,OpsLine),
   getAnswers(OpsLine),
   Answer = Rows.

assemb([],[],[]).
assemb([Lst1|Ls],[NN|Ns],[op(Lst1,NN)|Ts]) :- assemb(Ls,Ns,Ts).

getAnswers([]).
getAnswers([op(Line,RLines)|Ops]) :- 
   generatePoss(RLines,Line),
   getAnswers(Ops).


% Printing result to file and on terminal

print_puzzle([],ColN,[], File) :- printColN(ColN, File).
print_puzzle([RowNums1|RowNums],ColN,[Row1|Rows], File) :-
   print_row(Row1, File),
   print_rownums(RowNums1, File),
   print_puzzle(RowNums,ColN,Rows, File).

print_row([], File) :- write('  '), write(File, '  ').
print_row([X|Xs], File) :- print_replace(X,Y), write(''), write(File, ''), write(Y),  write(File, Y), print_row(Xs, File).
   
print_replace(' ','_|') :- !.
print_replace(x,'X|').

print_rownums([], File) :- nl, nl(File).
print_rownums([N|Ns], File) :- write(N),write(File, N),  write(' '),write(File, ' '), print_rownums(Ns, File). %sayilarin bastirildigi kisim

printColN(ColN, File) :-
   lMax(ColN,M,0),
	printColN(ColN,ColN,1,M, File).

lMax([],M,M).
lMax([L|Ls],M,A) :- length(L,N), B is max(A,N), lMax(Ls,M,B). 

printColN(_,[],M,M, File) :- !, nl, nl(File).
printColN(ColN,[],K,M, File) :- K < M, !, nl, nl(File), 
   K1 is K+1, printColN(ColN,ColN,K1,M, File).
printColN(ColN,[C1|Cs],K,M, File) :- K =< M, 
write_kth(K,C1, File), printColN(ColN,Cs,K,M, File).

write_kth(K,List, File) :- nth1(K,List,X), !, writef('%2r',[X]), swritef(S, '%2r',[X]), write(File, S).
write_kth(_,_, File) :- write('  '), write(File, '  ').

% Please run related test with input to test code

test1 :- 
   input1(Rs,Cs),
   puzzle(Cs, Rs, Answer), nl,
   open('output.txt',write,File),      
   print_puzzle(Rs,Cs,Answer, File),
   close(File).

test2 :- 
   input2(Rs,Cs),
   puzzle(Cs, Rs, Answer), nl,
	open('output.txt',write,File),      
   print_puzzle(Rs,Cs,Answer, File),
   close(File).
test3 :- 
   input3(Rs,Cs),
   puzzle(Cs, Rs, Answer), nl, 
   open('output.txt',write,File),      
   print_puzzle(Rs,Cs,Answer, File),
   close(File).

input1(
	[[3], [2,1], [3,2], [2,2], [6], [1,5], [6], [1], [2]],
	[[1,2], [3,1], [1,5], [7,1], [5], [3], [4], [3]]
	).

input2([[3,1], [2,4,1], [1,3,3], [2,4], [3,3,1,3], [3,2,2,1,3],
	 [2,2,2,2,2], [2,1,1,2,1,1], [1,2,1,4], [1,1,2,2], [2,2,8],
	 [2,2,2,4], [1,2,2,1,1,1], [3,3,5,1], [1,1,3,1,1,2],
	 [2,3,1,3,3], [1,3,2,8], [4,3,8], [1,4,2,5], [1,4,2,2],
	 [4,2,5], [5,3,5], [4,1,1], [4,2], [3,3]],
	[[2,3], [3,1,3], [3,2,1,2], [2,4,4], [3,4,2,4,5], [2,5,2,4,6],
	 [1,4,3,4,6,1], [4,3,3,6,2], [4,2,3,6,3], [1,2,4,2,1], [2,2,6],
	 [1,1,6], [2,1,4,2], [4,2,6], [1,1,1,1,4], [2,4,7], [3,5,6],
	 [3,2,4,2], [2,2,2], [6,3]]
	).

input3(
	[[5], [2,3,2], [2,5,1], [2,8], [2,5,11], [1,1,2,1,6], [1,2,1,3],
	 [2,1,1], [2,6,2], [15,4], [10,8], [2,1,4,3,6], [17], [17],
	 [18], [1,14], [1,1,14], [5,9], [8], [7]],
	[[5], [3,2], [2,1,2], [1,1,1], [1,1,1], [1,3], [2,2], [1,3,3],
	 [1,3,3,1], [1,7,2], [1,9,1], [1,10], [1,10], [1,3,5], [1,8],
	 [2,1,6], [3,1,7], [4,1,7], [6,1,8], [6,10], [7,10], [1,4,11],
	 [1,2,11], [2,12], [3,13]]
	).