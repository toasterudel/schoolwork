%Christopher Rudel
%env.erl

-module(env).
-compile(export_all).
-include("types.hrl").

%these were straightforward; all methods were explained on the erlang dict pages
-spec new()-> envType().
new() ->
	dict:new().

-spec add(envType(),atom(),valType())-> envType().
add(Env,Key,Value) ->
	dict:store(Key, Value, Env).

-spec lookup(envType(),atom())-> valType().
lookup(Env,Key) -> 
	dict:fetch(Key, Env).
