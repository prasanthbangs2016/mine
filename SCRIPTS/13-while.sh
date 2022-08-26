
counter=0
	while test $counter -lt 10 
do
		echo The counter is  $counter
		counter=$(($counter+1))

#counter=0
#counter= `expr $counter + 1`
#let counter=$counter+1
#let counter+=1

done


#test ---- this keyword is for test condition like [] square brackets
# this test keyword we can invoke with if,while and untill blocks,
# but for loop we are not testing condition ,we're testing condition in multiple operations hence double braces[]