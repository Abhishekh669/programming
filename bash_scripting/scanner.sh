echo "Ip Address : $1"
echo "Scanning..........."
nmap -sT -T4 $1 > /dev/null -oG /home/lucid/newFile
cat /home/lucid/newFile | grep "open" > /home/lucid/newFile2

cat /home/lucid/newFile2
echo "Finally competed scanning"