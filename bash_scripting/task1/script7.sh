echo "System Information : "

hostname=$(hostname)
kernal_os=$(uname -s)
cpu_gen=$(cat /proc/cpuinfo | sort |  uniq | grep "model name")
cpu=$(echo $cpu_gen | cut -d ":" -f 4- | uniq)
echo $cpu
architecutre=$(lscpu | grep Architecture )
echo $architecutre
gpu=$(lspci | grep -i vga | cut -d ":" -f 4-)

echo "Host-Name: $hostname"
echo "OS: $kernal_os"
echo "$cpu_gen"
echo "$architecture"
echo "GPU_INFO: $gpu"
