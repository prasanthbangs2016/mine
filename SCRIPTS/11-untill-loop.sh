# untill program is less than 10 it will get executed.

counter=20
	until [ $counter -lt 10 ] ; do
		echo The counter is  $counter
		counter=$(($counter-1))
	done