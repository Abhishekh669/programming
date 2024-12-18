
display_arr(){
    echo "$1"
    local arr="$@"
    for (( i=0; i<${#arr[@]}; i++)); do
        echo ${arr[i]};
    done
}

userDetail=("jack" 15 "pokhara")

display_arr ${userDetail[@]}

