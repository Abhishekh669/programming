

display_result() {

    echo "Displaying the result of the $2 service"
    nmap -sT -T4 "$1" > /dev/null -oG /home/lucid/file
    cat /home/lucid/file | grep "$2" > /home/lucid/file1
    cat /home/lucid/file1
}

echo "Ip Address : $1"
echo "Scanning Started..........."

display_result "$1" "$2"
echo "Finally completed scanning"
