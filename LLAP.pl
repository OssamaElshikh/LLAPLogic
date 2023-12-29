
:-include('KB.pl').

%fluents

find(Food,Material,Energy,0,0,s0):-
	food(Food),materials(Material),energy(Energy).

find(NewF,NewM,NewE,Build1,Build2,result(Action,Situation)):- 
	find(OldF,OldM,OldE,Oldbuild1,Oldbuild2,Situation),
	(
	  (Action=b2,build2(A,B,C),OldF>=A,OldM>=B,OldE>=C,Build2 = 1,Build1=Oldbuild1 ,NewF is OldF - A,NewM is OldM - B, NewE is OldE - C);
	  (Action=b1,build1(X,Y,Z),OldF>=X,OldM>=Y,OldE>=Z,Build1 = 1,Build2=Oldbuild2 ,NewF is OldF - X,NewM is OldM - Y, NewE is OldE - Z);
	  (Action=reqf,NewF is OldF + 1, NewM =OldM , NewE=OldE,  Build1=Oldbuild1, Build2=Oldbuild2);
	  (Action=reqm ,NewM is OldM + 1, NewF =OldF , NewE=OldE,  Build1=Oldbuild1, Build2=Oldbuild2);
	  (Action=reqe,NewE is OldE + 1, NewM =OldM , NewF=OldF,  Build1=Oldbuild1, Build2=Oldbuild2)
	 ).

goal(Situation):-
	ids(Situation,4).	


ids(Situation,L):-
	(call_with_depth_limit(find(_,_,_,1,1,Situation),L,R), number(R));
	(call_with_depth_limit(find(_,_,_,1,1,Situation),L,R), R=depth_limit_exceeded,L1 is L+1, ids(Situation,L1)).
	 

