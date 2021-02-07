% construct gets left and right term from the given list then find appropriate equivalent terms
construct(Lst,L,R) :-
   split(Lst,LP,RP),
   term(LP,L),
   term(RP,R),
   L =:= R.

% L is the list of the leaves in the arithmetic term T
% A number is also a term
term([X],X).                    
term(L,T) :-
   split(L,LP,RP),
   term(LP,LeT),
   term(RP,RiT),
   termBinary(LeT,RiT,T).

% termBinary finds combined binary term which is constructed from left term and right term
termBinary(LeT,RiT,LeT+RiT).
termBinary(LeT,RiT,LeT-RiT).
termBinary(LeT,RiT,LeT*RiT).
termBinary(LeT,RiT,LeT/RiT) :- RiT =\= 0.   % RiT =\= 0 is to prevent division by zero


% split the list into two parts that are non-empty
split(L,L1,L2) :- L1 = [_|_], L2 = [_|_], append(L1,L2,L).

% Finally find possible answers and write them to the output.txt
find_answer_and_write([L]) :- 
	construct(L,LeT,RiT),
	write_output(LeT, RiT),
	fail.
find_answer_and_write(_).

% helper loop to write answer in lines
helper_loop(File, LeT, RiT) :-
    write(File, LeT  ),
    write(File,  " = "  ),
    write(File, RiT  ),
    write(File,"\n" ),
    fail.

% write operation happens in it
write_output(LeT, RiT) :-
    open('output.txt', append, File),
    \+ helper_loop(File, LeT, RiT),
    close(File).

% main predicate
% THIS PREDICATE MUST BE RUN ON TERMINAL TO GET ANSWERS
main :-
    open('input.txt', read, Str),
    read_file(Str,Lines),
    close(Str),
    open('output.txt',write, File), close(File),
    find_answer_and_write(Lines).

% predicate to read contents from file.
read_file(File,[]) :-
    at_end_of_stream(File).

read_file(File,[X|L]) :-
    \+ at_end_of_stream(File),
    read(File,X),
    read_file(File,L).