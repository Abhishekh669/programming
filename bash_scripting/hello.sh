# #!/bin/bash
# nline=`wc -l ./file.txt`
# echo "$nline"
# echo $100


# grep "r.*t" /etc/passwd

# echo "There is no * in my path: $PATH"

# echo I don\'t like contractions inside shell scripts.

# echo "I don't like contractions inside shell scripts."

if [ -e $1 ]; then 
    cat $1;
    file $1;
else 
    echo "not a regular file $1";
fi