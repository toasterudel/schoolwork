-module(basic).

-export([mult/2,double/1,distance/2,my_and/2,my_or/2,my_not/1,fib/1,sum/1,maximum/1]).

mult(A,B) -> A*B.
double(A) -> 1.0*A.
distance(X,Y) -> 
	{X1,Y1} = X,
	{X2,Y2} = Y,
	A = math:pow(X2-X1,2),
	B = math:pow(Y2-Y1,2),
	math:sqrt(A+B).

my_and(X,Y) -> X and Y.
my_or(X,Y) -> X or Y.
my_not(X) -> not X.

fib(X) when X<2 -> 1;
fib(X) -> fib(X-1) + fib(X-2).

sum(X) ->
	mysum(X,0).
mysum([H|T], Num) ->
	mysum(T, H+Num);
mysum([], Num) ->
	Num.

maximum([H|T]) -> maximum(T,H).
maximum(X, Num) ->
	case X of
		[H|T] = X ->
			if
				H > Num ->
					maximum(T,H);
				true -> maximum(T,Num)
			end;
		[] = X -> Num
	end.
