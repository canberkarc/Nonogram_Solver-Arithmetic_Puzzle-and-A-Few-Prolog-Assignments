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

% Distances between cities

distance(gaziantep,istanbul,847.42).
distance(gaziantep,antalya,592.33).
distance(antalya,gaziantep,592.33).
distance(konya,antalya,192.28).
distance(konya,ankara,227.34).
distance(ankara,konya,227.34).
distance(burdur,ısparta,24.60).
distance(ankara,istanbul,351.50).
distance(ankara,van,920.31).
distance(van,ankara,920.31).
distance(van,istanbul,1262.37).
distance(van,rize,373.01).
distance(rize,van,373.01).
distance(rize,istanbul,967.79).
distance(ısparta,burdur,24.60).
distance(ısparta,izmir,308.55).
distance(izmir,ısparta,308.55).
distance(izmir,istanbul,328.80).
distance(istanbul,izmir,328.80).
distance(istanbul,antalya,482.75).
distance(antalya,konya,192.28).
distance(edirne,edremit,914.67).
distance(edremit,edirne,914.67).
distance(edremit,erzincan,736.34).
distance(erzincan,edremit,736.34).
distance(istanbul,gaziantep,847.42).
distance(istanbul,ankara,351.50).
distance(istanbul,van,1262.37).
distance(istanbul,rize,967.79).
distance(antalya,istanbul,482.75).

%rules

sroute(A,B,Dist):-distance(A,B,Dist).
sroute(A,B,Dist):- distance(A,Z,Dist1),
                distance(Z,B,Dist2),
                Dist is Dist1+Dist2.