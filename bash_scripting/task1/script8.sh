#!/bin/bash

echo "Scanning........."

if [ $# -eq 1 ]; then

    nmap -A -T4 $1 > /dev/null -oG result.txt
    cat result.txt | grep "nmap scan"
elif [ $# -eq 0 ]; then
    echo "NO argument privided"
else 
    echo "To many argument"
fi