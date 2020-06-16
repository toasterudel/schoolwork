#!/bin/bash

path=$(echo $PATH|tr ":" " ")
for i in $path
	do	
	if [[ -x ${i}/$1 ]]
	then
		echo ${i}/$1
	fi
done

