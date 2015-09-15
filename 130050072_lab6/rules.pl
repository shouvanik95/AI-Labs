%
%   Representing Terms and rules in Prolog
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rule(+(0,X),X).
rule(+(s(X),Y),s(+(X,Y))).
rule(*(0,X),0).
rule(*(s(X),Y),+(Y,*(X,Y))).
rule(fac(0),s(0)).
rule(fac(s(X)),*(s(X),fac(X))).
