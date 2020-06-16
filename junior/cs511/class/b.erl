%% implmentation of the barrier problem

-module(b). 
-compile(export_all).

startc(N) ->
	C = spawn(?MODULE, coordinator, [N,N,[]]),
	register(coordinator,C).

start() ->
	startc(3),
	spawn(?MODULE,client,["a~n","f~n"]),
	spawn(?MODULE,client,["c~n","d~n"]),
	spawn(?MODULE,client,["e~n","b~n"]).

coordinator(0,N,L) ->
	[ From!{self(), Ref, ok} || {From, Ref} <- L ],
	coordinator(N,N,[]);
coordinator(M,N,L) ->
	receive
		{From, Ref, arrived} ->
			coordinator(M-1, N, [{From,Ref} | L])
	end.

client(Str1,Str2) ->
	io:format(Str1),
	Ref = make_ref(),
	C = whereis(coordinator),
	coordinator!{self(),Ref,arrived},
	receive
		{C,Ref,ok} ->
			io:format(Str2)
	end.


