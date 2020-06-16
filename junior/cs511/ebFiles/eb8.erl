-module(eb8).
-compile(export_all).

start() ->
	spawn(fun server/0).

server() ->
	A = "",
	receive
	{From,start} ->
		receive
			{add, S} -> 
				A ++ S;
			{done} -> 
				!From(self(), A)
		end
	end.

client(S,M) ->
	S!{self(),start},
	S!{add, M},
	receive
		{F, M2} ->
			io:fwrite(M2)
	end.
