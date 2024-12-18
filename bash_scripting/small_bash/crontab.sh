#! /bin/bash

searchScript(){
    local scriptName=$1
    echo "$scriptName"
    echo "Searching....."
    local searching=$(find / -type f -name "$scriptName.*" 2> /dev/null | nl)
    echo "List of the Result : "
    echo "$searching"
    if [ ! -z "$searching" ]; then 
          echo  -n "Choose you options : "
    read option
    local selectedPath=$(echo "$searching" | tail -n+$option | head -1)
    echo "Selected Path : $selectedPath"
    local extractPath=$(echo $selectedPath | cut -d " " -f 2 )
    echo "this is the extracted path : $extractPath"
    local min=$(echo "$time" | cut -d " " -f 1)
    local hour=$(echo "$time" | cut -d " " -f 2)
    local day_of_month=$(echo "$time"  | cut -d " " -f 3)
    local month=$(echo "$time" | cut -d " " -f 4)
    local day_of_week=$(echo "$time" | cut -d " " -f 5)
    echo "min : $min"
    echo "hour : $hour"
    echo "day_of_month : $day_of_month"
    echo "month : $month"
    echo "day_of_week : $day_of_week"

    local cron_job="$min $hour $day_of_month $month $day_of_week $extractPath"
    ( crontab -l; echo "$cron_job") | crontab -
    else 
        echo ' nothing found'
    fi
    

  
}

echo -e " Hints : \nM H DOM MON DOW COMMAND "
echo -e "0 5   *   *  *  echo 'hello world'"
echo -e "Help: \n1. *-> Runs every  minutes\n2. M-> runs every given  minute(range -> 0-59)\n3. H -> runs every given hours(range -> (0-23)\n4. DOM-> run every day of month(range -> (1-31))\n5. DOW -> Run every given day of week (range -> (0-6, where 0=sunday)\n7. MON -> Run given every month (range ->(1-12)\n8. command -> givie the normal linux command ." 
echo  -ne "Give the time( format : 5 * * * * ) : "
read time

if [ ${#time} -lt 9  -o  ${#time} -gt 15 ];then 
    echo "Not correct Format of time "
else
    echo "lets procced"
    echo  -ne "name of the script which you want to run : "
    read scriptName
    searchScript "$scriptName"

fi
# echo -ne "name of the script which you want to run  : ";
# read scriptName

