#!/bin/bash

fileName=$1;
newFileName=${fileName%%.*}

gcc $fileName -o $newFileName
echo "Result : "
./${newFileName}
