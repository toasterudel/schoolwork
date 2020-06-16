%Christopher Rudel
%HW4
%watcher.erl
-module(watcher).
-export([start/0, createSensor/3, watch/1, restartSensor/2]).

start() ->
	{ok, [N]} = io:fread("enter number of sensors> ", "~d"),
	if N =< 1 ->
		io:fwrite("setup: range must be at least 2~n", []);
		true ->
			Num_watchers = 1 + (N div 10),
			createSensor(N,[], Num_watchers)
	end.

createSensor(Num_sensors, Sensor_list, Sensor_Id) ->
	if length(Sensor_list) == 10 ->
		io:format("Starting to watch: ~n"),
		[io:format("Id: ~p, Pid: ~p~n", [Id, Pid]) || {Id, Pid} <- Sensor_list],
	
		if Num_sensors /= 0 ->
			spawn(watcher, createSensor, [Num_sensors, [], Sensor_Id]),
			watch(Sensor_list);

		true ->
			watch(Sensor_list)

		end;

		Num_sensors == 0 ->
			io:format("Starting to watch: ~n"),
			[io:format("Id: ~p, Pid: ~p~n", [Id, Pid]) || {Id, Pid} <- Sensor_list],
			watch(Sensor_list);

		true ->
			{Sensor_Pid, _} = spawn_monitor(sensor, start, [self(), Sensor_Id]),
			createSensor(Num_sensors - 1, lists:merge(Sensor_list, [{Sensor_Id, Sensor_Pid}]), Sensor_Id + 1)

	end.

watch(Sensor_list) ->
	receive 
		{kill, {From, FromId}, error} ->
		io:format("Sensor ~p died, reason: anomalous_reading~n", [FromId]),
		restartSensor(lists:delete({FromId, From}, Sensor_list), FromId);
	
		{Measurement, {From, FromId}, Ref} ->
			io:format("Sensor ~4p reported measurement: ~2p~n", [FromId, Measurement]),
			From!{ok, Ref},
			watch(Sensor_list)

	end.


restartSensor(Sensor_list, Sensor_Id) ->
  {Sensor_Pid, _} = spawn_monitor(sensor, start, [self(), Sensor_Id]),
  NewList = lists:merge(Sensor_list, [{Sensor_Id, Sensor_Pid}]),
	io:format("Replacing sensor: ~p with sensor: ~p. New list: ~p~n", [Sensor_Id, Sensor_Pid, Sensor_list]),

  watch(NewList).
