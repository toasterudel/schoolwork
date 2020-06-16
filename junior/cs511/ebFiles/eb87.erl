-module(eb87).
-compile(export_all).

start()->
	L = [spawn(?MODULE,client,[]) || _ <- list:seq(1,10)],
	spawn(?MODULE, timer, [100, L]).

timer(Frequency, L) ->
	error(implement).

client() ->
	error(implement).
