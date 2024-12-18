folderPath=$1

for i  in $folderPath; 
do
    if [ -d $i ]; then
        ls -la $i 
    else 
     echo "file doesnot exist:"
    fi
done