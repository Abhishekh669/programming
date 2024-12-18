newarray=("hi", "how", "are", "you");
for (( i=0; i<${#newarray[@]}; i++ )); do
    echo ${newarray[i]}
done

