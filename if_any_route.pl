% knowledge base.
% flights between cities

:-style_check(-singleton).

flight(edirne,edremit).
flight(edremit,edirne).
flight(edremit,erzincan).
flight(erzincan,edremit).
flight(burdur,ısparta).
flight(ısparta,burdur).
flight(ısparta,izmir).
flight(izmir,ısparta).
flight(izmir,istanbul).
flight(istanbul,izmir).
flight(istanbul,antalya).
flight(istanbul,gaziantep).
flight(istanbul,ankara).
flight(istanbul,van).
flight(istanbul,rize).
flight(antalya,istanbul).
flight(antalya,konya).
flight(antalya,gaziantep).
flight(gaziantep,istanbul).
flight(gaziantep,antalya).
flight(konya,antalya).
flight(konya,ankara).
flight(ankara,konya).
flight(ankara,istanbul).
flight(ankara,van).
flight(van,ankara).
flight(van,istanbul).
flight(van,rize).
flight(rize,van).
flight(rize,istanbul).

% rules

path(From, To) :-
    flight(From, To).

route(From, To, VisitedOnes) :- 
	path(From, X), not(member(X, VisitedOnes)), (To = X ; route(X, To, [From | VisitedOnes])).
route(From, To) :-
    route(From, To, []) .