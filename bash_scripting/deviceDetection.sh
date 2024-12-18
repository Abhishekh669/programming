#!/bin/bash

echo "Scanning........."
nmap -A -T4 $1 > /dev/null -oG result.txt
cat result.txt | grep "nmap scan"
