#!/bin/bash

# Extract the highest UID from /etc/passwd
totalLast=$(awk -F: '{print $3}' /etc/passwd | sort -n | tail -n 1)

# Print a header
echo "List of users with UIDs from 1000 to $totalLast:"

# Loop through UIDs from 1000 to the highest UID
for (( i=1000; i<=$totalLast; i++ )); do 
    # Extract user names for the current UID
    user=$(grep ":$i:" /etc/passwd | cut -d ":" -f1)
    
    # Print UID and user name if a user is found
    if [[ -n $user ]]; then
        echo "UID $i: $user"
    fi
done
