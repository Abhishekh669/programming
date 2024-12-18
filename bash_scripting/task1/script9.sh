random_number=$((RANDOM %100 + 1));
count=5
while true
do
    if [ $count  != 0 ]; then
        echo  -n "guess the number between0 to 100 : "
        read user_guess
        if [ $user_guess -eq $random_number ]; then
            echo "you  guessed it right"
            echo "terminating...."
            break;
        else
            echo "you were wrong"
        fi
        
        echo "your left trail : $count"
    else
        echo "Your trailed finished"
        echo "the number was $random_number"
        break;
    fi
    count=$((count - 1));
done

