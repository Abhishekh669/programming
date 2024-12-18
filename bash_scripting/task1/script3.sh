noOfArgument=3
echo "No. of arguments needed : $noOfArgument"
echo "No of arguments passed : $#"

if [ $# -lt $noOfArgument ]; then
    echo "Condtion dissatisfied"
    
else 
    echo "Condition satisfied"
    echo -e "Name : $1\nAge : $2\nAddress : $3"
fi