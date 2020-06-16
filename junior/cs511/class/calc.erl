-module(calc).
-compile(export_all).

-type num() :: {const, number()}.

-type expr() :: {const, number()}
		| {var,string()}
		| {add, expr(), expr()}
		| {sub, expr(), expr()}
		| {mul, expr(), expr()}
		| {divi, expr(), expr()}.

-type result() :: {const, number()}.

anExpr() ->
	{add,
		{sub,{const,3},{const,2}},
		{var,"x"}}.

initEnv() ->
	dict:append("x",{const,2},dict:append("y",{const,7},dict:new())).

-spec eval(dict:dict(string(),result()),expr()) ->result().

eval(_Env, {const,N}) ->
	{const, N};
eval(Env,{var,Id}) ->
	hd(dict:fetch(Env,Id));
eval(Env,{add,E1,E2})->
	{const,V1} = eval(Env,E1),
	{const,V2} = eval(Env,E2),
	{const, V1+V2};
eval(Env,{sub,E1,E2})->
	{const,V1} = eval(Env,E1),
	{const,V2} = eval(Env,E2),
	{const, V1-V2};
eval(Env,{mul,E1,E2})->
	{const,V1} = eval(Env,E1),
	{const,V2} = eval(Env,E2),
	{const, V1*V2};
eval(Env,{divi,E1,E2})->
	{const,V1} = eval(Env,E1),
	{const,V2} = eval(Env,E2),
	{const, V1/V2}.

