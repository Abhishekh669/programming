echo  -e "Check either the file exists\n"

delay_msg(){
    local msg=$1
    for(( i=0; i<${#msg}; i++ )); do
        echo -n ${msg:i:1}
        sleep 0.08
    done
}
if [ $#  -le  0 ]; then
    echo "No argumetns provided"

elif [ $# -eq 2 ]; then   
    title_msg="Searching $1 in  $2"
    delay_msg $title_msg
    echo -e "\nResults : "
    find $2 -type f -name $1 2> /dev/null | nl
    
    

else    
    echo "only 2  arguments is necessary"
fi

