#!/bin/bash

# Constants
PASSWORD_FILE="passwords.txt"
ENCRYPTION_KEY="your_encryption_key_here"

# Function to encrypt a password
encrypt_password() {
    local plaintext="$1"
    echo "$plaintext" | openssl enc -aes-256-cbc -a -k "$ENCRYPTION_KEY"
}

# Function to decrypt a password
decrypt_password() {
    local encrypted="$1"
    echo "$encrypted" | openssl enc -d -aes-256-cbc -a -k "$ENCRYPTION_KEY"
}

# Function to add a password entry
add_password() {
    read -p "Enter website/service name: " website
    read -p "Enter username: " username
    read -s -p "Enter password: " password
    encrypted_password=$(encrypt_password "$password")
    echo "$website | $username | $encrypted_password" >> "$PASSWORD_FILE"
    echo "Password added successfully."
}

# Function to retrieve a password entry
retrieve_password() {
    read -p "Enter website/service name to retrieve password: " website
    password_entry=$(grep "^$website" "$PASSWORD_FILE" | tail -n 1)
    if [ -n "$password_entry" ]; then
        encrypted_password=$(echo "$password_entry" | cut -d '|' -f 3 | sed 's/ //g')
        decrypted_password=$(decrypt_password "$encrypted_password")
        echo "Password for $website: $decrypted_password"
    else
        echo "Password not found for $website."
    fi
}

# Function to display menu and handle user input
main_menu() {
    while true; do
        echo "Password Manager"
        echo "1. Add Password"
        echo "2. Retrieve Password"
        echo "3. Exit"
        read -p "Enter your choice: " choice
        case $choice in
            1) add_password ;;
            2) retrieve_password ;;
            3) echo "Exiting Password Manager."; break ;;
            *) echo "Invalid choice. Please enter 1, 2, or 3." ;;
        esac
    done
}

# Check if password file exists, create if not
if [ ! -f "$PASSWORD_FILE" ]; then
    touch "$PASSWORD_FILE"
fi

# Start the password manager
main_menu

