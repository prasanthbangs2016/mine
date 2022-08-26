echo $0
read a
enter a value for a:
read b
enter a value for b:
echo $0
if [ $a -gt $b ]
then
echo "$a number is greater"
else
echo "$b number is greater"
fi
echo "Total no of inputs to the program is $#"


#$0 --- program  name
#$# --- no of inputs passed to program
# read --- it will wait for user input