echo "The script name": echo $0
echo $0
if [ $1 -gt $2 ]
then
echo "$1 number is greater"
else
echo "$2 number is greater"
fi
echo "Total no of inputs to the program is $#"


#$0 --- program  name
#$# --- no of inputs passed to program