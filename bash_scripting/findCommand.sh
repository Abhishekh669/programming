#!/bin/bash
performFind(){
    target=$1;
    targetType=$2;
    echo -en "enter the pathname : "
    read location
    result=$(find $location -type $targetType -name $target 2> /dev/null)
    if [ "$?" != 0 ]; then
        echo "failed to find the porgram"
    else    
        echo "Result : "
        echo "$result"
    fi
    
}

echo -n "give the name  to search : ";
read targetName;
echo -n  "enter the type 'f' for file and 'd' for folder : "
read type;
if [ "$type" = "f" -o "$type" = "d" ]; then
    echo "you cna od"
    performFind "$targetName" "$type"
else
    echo "you cannot do"
fi
