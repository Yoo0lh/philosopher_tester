
#!bin/bash

Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

test_1 ()
{
		echo -en "${Purple}test 1 : "
		output=$("$1" 3 310 200 100 > log && sleep 2 ; pkill "$1" ; cat log | grep died -m 1 | awk '{print $NF}')
		#echo $output
		if [ "$output" == "died" ]
				then
						echo -e "${Green}OK${White}"
		else
						echo -e "${Red}KO${White}"
		output=$("$1" 3 800 400 400 > log && sleep 0.9 ; pkill "$1" ; cat log | grep died -m 1 | awk '{print $NF}')

		rm -f log
		fi
}

test_2 ()
{
		"$1" 3 800 200 200 > log &
		i=1
		check=0
		while [ $i -lt 5 ]
		do
				pgrep philo > /dev/null
				if [ $? != 0 ]
				then
						check=1
						echo -e "${Red}KO${White}"
						pkill "$1" $2>/dev/null  
						break ;
				fi
				sleep 1
				i=$((i + 1)) 
		done 
		if [ $check == 0 ]
				then
						echo -e "${Green}OK${Withe}"
						pkill "$1" &2>/dev/null 
		fi
		#rm -f log
}
# test_3 ()
# {

# }
# test_4 ()
# {

# }
# test_5 ()
# {

# }
# test_6 ()
# {

# }

if [ "$1" == "m" ]
		then
				make -C ../philo/ > /dev/null 
				file_name="../philo/philo"
elif [ "$1" == "b" ]
		then 
				make -C ../philo_bonus/ > /dev/null 
				file_name="../philo_bonus/philo_bonus"
else
		echo "ERROR  arguments"
		exit 1
fi
#echo $file_name
test_1 "$file_name"
#test_2 "$file_name"
