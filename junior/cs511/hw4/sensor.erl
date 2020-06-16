%Christopher Rudel
%HW4
%sensor.erl
-module(sensor).
-export([start/2, work/3]).

start(Watcher_Pid, Sensor_Id) ->
	Ref = make_ref(),
	work(Watcher_Pid, Sensor_Id, Ref).

work(Watcher_Pid, Sensor_Id, Ref) ->
	Measurement = rand:uniform(11),
	if Measurement == 11 ->
		Watcher_Pid!{kill, {self(), Sensor_Id}, error},
		exit("anomalous_reading");
		true ->
			Watcher_Pid!{Measurement, {self(), Sensor_Id}, Ref}
	end,
	receive
		{ok, Ref} ->
			Sleep_time = rand:uniform(10000),
			timer:sleep(Sleep_time),
			work(Watcher_Pid, Sensor_Id, Ref)
	end.	
