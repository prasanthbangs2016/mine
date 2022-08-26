#loop starts from 0
# this is to print less than 10 numbers

counter=0
	while [ $counter -le 10 ] ; do
		echo The counter is  $counter
		counter=$(($counter+1))

#counter=0
#counter= `expr $counter + 1`
#let counter=$counter+1
#let counter+=1

done
 echo '***'
 
echo this is for loop
for (( i =0; i<=10 ; i++)) ; do
echo the value of i is $i
	done