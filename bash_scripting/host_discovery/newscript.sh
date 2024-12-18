
echo "Welcome Man"
echo -ne "\nEnter the base IP address : "
read baseIp

echo -ne "\nEnter the starting range : "
read startingOctet

echo -ne "\nEnter the ending range : "
read endingOctet

checkMacAddress(){
    local ip=$1
    arpResult=$(arp -a)
    echo "$arpResult"
    local hell=$(echo $arpResult | grep $ip)
    echo "$hell"
}


echo "You have selected  : $baseIp.($startingOctet-$endingOctet)"
if [ $endingOctet -gt $startingOctet ]; then
    if [ $endingOctet -lt 255 -a $startingOctet -lt 255 ]; then
        for (( i="$startingOctet"; i<="$endingOctet"; i++ )); do
                echo -ne "\nCurrent  Hosts : $baseIp.$i"
                echo -ne "\nScanning ($baseIp.$i) ....\n"
                checking=$(ping -c 1 $baseIp.$i)
               checkingRes=$(echo  $checking | grep "Destination Host Unreachable")
               if [ -z $checkingRes ];then

                    echo -e "\n $baseIp.$i is active"

                    echo $i >> "/home/lucid/testok/data.txt"
                    ip=$baseIp.$i
                    checkMacAddress "$ip"
                    

               else
                    echo  -ne "\n$baseIp.$i is not active"
                fi    
        done
    else
        echo "i am greated than 255"
    fi
else
    echo "EndingOctet should be always greater than starting Octet"
fi
