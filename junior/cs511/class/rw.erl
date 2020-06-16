%%supposed to simulate readers writers, not sure if works

-module(rw).
-compile(export_all).

start() ->
	RW = spawn(?MODULE, loop,[0,0]),
	register(rw,RW),
	[spawn(?MODULE,reader,[]) || _ <- lists:seq(1,R)],
	[spawn(?MODULE,writer,[]) || _ <- lists:seq(1,W)].

client() ->
	Ref = make_ref(),
	RW = whereis(rw),
	rw!{self(),Ref,start_read},
	receive
		{RW,Ref,ok_to_read} ->
			read
	end.

loop(R,W) ->
	receive
	{From,Ref,start_read}
		From!{self(),Ref,ok_to_read},
			loop(R+1,W);
  {From,Ref,end_read}
		loop(R-1,W);
  {From,Ref,start_write} when (W==0) and (R==0) ->
		From!{self(),Ref, ok_to_write},
		loop(R,W+1);
  {From,Ref,end_write} ->
		loop(R,W-1)
	end.
