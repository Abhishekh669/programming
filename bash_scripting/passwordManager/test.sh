key="0123456789abcdef0123456789abcdef" # 32 bits
iv="fedcba9876543210fedcba9876543210" # 32 bits
password="hello world"

encrypt_password() {
    local encrypted_password
    encrypted_password=$(echo "$password" | openssl enc -aes-256-cbc -K "$key" -iv "$iv" -a)
    echo "$encrypted_password"
}

# Call the function and capture its output into a variable
en_pass=$(encrypt_password)
echo "this is the new pass: $en_pass"
