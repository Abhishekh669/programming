echo "Array simple demostration "

arr1=("hello" "world" "fine")

echo -e '\nUsing the simple technique\n'

echo "Length of the array : ${#arr1}"
echo "${arr1[0]}"
echo "${arr1[1]}"
echo "${arr1[2]}"
echo "All the content of the array  in one line : ${arr1[@]}