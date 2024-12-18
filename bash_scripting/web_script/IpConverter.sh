#!/bin/bash

echo -ne "Welcome To IpConverter\n"
echo -ne "\nEnter the Ip Address :: "
read Ipaddress

echo -ne "Chose option :\n1.Ip to Domain Name\n2.Domain Ip "
echo -en "\nYour Option :: "
read userChoice

case  $userChoice in 
    1)
        

    ;;

    2)

    ;;

    *) 
                echo  -e "\nInvalid Input\n"
    ;;
esac