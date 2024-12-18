#!/bin/bash

display_delay(){
    local msg=$1
    echo ""
    for (( i=0;  i<${#msg}; i++)); do
        echo -n "${msg:i:1}"
        sleep 0.08
    done
    echo ""
}



echo "System Tracker"
start_msg="Starting......."
display_delay "$start_msg"

echo -e "\nSystem Information : "

