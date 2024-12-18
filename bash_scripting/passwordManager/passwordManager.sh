#!/bin/bash
# features to add  : 1. if the username and password is duplicate check for it 2. show all the detail of hte passowrd  i.e admin detail 3.decryput passowrd 4. delete all the data 5. dlete it using the username and decrypted password
key="0123456789abcdef0123456789abcdef" #32 bits
iv="fedcba9876543210fedcba9876543210" # 32 bits


encrypt_password(){
    local password=$1
    local  enc_password=$(echo "$password" | openssl enc -aes-256-cbc -K "$key" -iv "$iv" -a)
    echo "$enc_password"
}

decrypt_password(){
    decrypted_password=$(echo "$encrypted_password" | openssl enc -d -aes-256-cbc -K "$key" -iv "$iv" -a)
    echo "thsi si the decryped password $decrypted_password"
}

check_length(){
    if [ ! ${#password} -eq 0  -a ! ${#username} -eq 0 ]; then
        echo "you can go"
    else    
        echo "Invalid username or password"
        exit
    fi
}


check_duplication(){
    check=$(grep "username=$username password=$encrypted_password" impFile.txt);
    if [  $? -eq 0 ]; then
        echo "Warning : Same data found"
        exit;
    else 
        # echo "you are not found"
        echo "you are unique you can append "
    fi
    



}

display_delay(){
    local wel_msg=$1;
    
    for (( i=0; i<${#wel_msg}; i++ ));
    do
        echo -n "${wel_msg:i:1}";
        sleep 0.08
    done
    echo -e "\n"
}

append_pass(){
    check_length $password
    encrypted_pass=$(encrypt_password)
    echo "This is the append pass $enc_pass"
	local data=$(echo "username=$username password=$encrypted_password");
	if [ ! -f "impFile.txt" ]; then
		echo "$data" > impFile.txt
		if [ $? == 0 ]; then
			echo "Appended Successfully"
		else
			echo "Failed to add the data"
		fi
	else
        check_duplication 
		echo "$data" | cat >> impFile.txt
		if [ $? == 0 ]; then
			echo "Appended Successfully"
		else
			echo "Failed to add the data"
		fi
	fi 
	

}

display_info(){
	search_msg="Searching........."
	display_delay "$search_msg"
	if [ ! -f "impFile.txt" ]; then
		echo "File is not created yet"
	else
		echo "i will search for you"
		if grep -q "username=$username password=$encrypted_password" impFile.txt; then
			# grep -i "username=$username password=$decrypted_password" impFile.txt
            echo "username=$username password=$decrypted_password"
            exit
		else
			echo "no user found"
		fi
		
	fi

}
delete_user(){
    if [ ! -f "impFile.txt" ]; then
        echo "File is not created yet"
    else 
        echo "Searching for user: $username"
        
        # Search for the user entry in impFile.txt
        userData=$(grep -i "$username" impFile.txt)
        
        if [ -z "$userData" ]; then
            echo "User not found in impFile.txt"
        else
            echo "User details:"
            echo "$userData"
            
            # Extract line number from numbered data
            numberedData=$(echo "$userData" | nl )
			echo $numberedData


			numberedline=$(echo $numberedData | cut -c 1)

            
            # Delete the line number from impFile.txt
            sed -i "${numberedline}d" impFile.txt
            
            # Check deletion status
            if [ $? -eq 0 ]; then
                echo "User deleted successfully."
            else
                echo "Failed to delete user."
            fi
        fi
    fi
}


userInfo(){
    echo -ne "\nEnter your name : "
    read username
    echo -ne "Enter your password : "
    read password
	echo -e "\n"
    
    
    
    
}

userOption(){
    echo -e "\nPlease choose an options "
    echo -e "1.Append Password\n2.Display Info\n3.Delete Password\n4.Quit"
    echo -ne "\nYou Option :  "
    read userChoice
    
    case $userChoice in
        1)
            userInfo
            encrypt_password
			append_pass
            
        ;;
        2)
            userInfo
			display_info

        ;;
		3)
			userInfo
			delete_user
		;;

        4)
            echo -e "\nExiting...."
            exit
        ;;

        *)
            echo -e "\nInvalid Input !!"
        ;;
        
        
        
        
    esac
}

clear
wel_msg="Welcome To Password Manager"
display_delay "$wel_msg"

echo  -e  "\nTry the most secured password saving\n"

while true
do
    userOption
done
