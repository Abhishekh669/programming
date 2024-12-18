#!/bin/bash
cd /home/lucid/testing
echo "executing  "
for i in *.*;
do 
	if [ "$i" != "." -a "$i" != ".." ];
	then
		echo "Handling $i"
		owner="$(stat --format "%U" ./$i)"
		if [ "${owner}" = "lucid" ]; then 
			timeout -s 9 60 ./$i

		fi
		rm -f ./$i
	fi
done

