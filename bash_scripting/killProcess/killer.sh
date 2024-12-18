#!/bin/bash
echo  -ne "\nEnter the process you want to kill : "
read app;

if [ ! -z $app ]; then
    res=$(top -b -n 1 | grep $app | nl)
    echo -e "\nResults : "
    echo " PID  USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND"
    echo "$res"
    if [ ! -z "$res" ]; then 
        echo -en '\nNow select your options  you want to kill : '
        read selectedNumber
        captureLine=$(echo "$res" | tail -n+$selectedNumber | head -1)
        extractId=$(echo $captureLine | cut -d " " -f 2 )
        echo "this is the selected id : $extractId"
        kill $extractId
        if [ $? -eq 0 ]; then 
            echo "Successfully killed!!!"
        else
            echo "Failed to kill"
        fi
    else
        echo "Nothing found "
    fi
    
    
else
    echo "not fine"
fi
