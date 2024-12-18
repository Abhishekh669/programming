#!/bin/bash

userList(){
    lastUserId=$(cat /etc/passwd | tail -n 1 | cut -d ":" -f3)

    list_array=()


    
    if [ $lastUserId -gt 1000 ]; then
        for (( i=1000; i<=lastUserId; i++ )); do
            data=$(grep "$i" /etc/passwd | cut -d ":" -f1)
            if [ -n "$data" ]; then
                list_array+=("$data")
            fi
        done
   
    fi

    printf "%s\n" "${list_array[@]}"
}


echo "Welcome To User Management System"

echo -e "\nChoose Your Options"
echo -e "1.Create New User\n2.List User\n3.Delete a  User\n4.Quit\n"
echo -n "Your Options : "
read userinput 

case $userinput in 
	1)
		echo -e  "\nYou choosed to create new user"
		echo -ne "Enter the name of the user "
		read newUser
		sudo useradd -m  $newUser
		
	;;
	2)
		echo -e "\nYou chosee to the list user"
		echo -e "\nList of the users : "
		userData=$(userList)
		if [  -n userData ]; then

		notoloop=$(echo "$userData"  | nl  )
		else  
		echo "$whoami"
		fi

		
		
		
		
	;;
	3)
		echo -e  "\nYou choosee to delete user"
		echo -ne "\nEnter the name of the user : "
		read delUser;
		sudo userdel -f "$delUser"
		if [[ $? -eq 0 ]];
		then 
			echo "successfully deleted"
			echo "$ntoloop"
		else
		ehco "failed to detel"
		fi
		
esac	
		


