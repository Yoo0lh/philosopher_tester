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
		output=$("$1" 3 310 200 100 > log && sleep 2 ; pkill "$1" ; cat log | grep died -m 1 | awk '{print $NF}')
		#echo $output
		if [ "$output" == "died" ]
				then
						echo -e "${Green}OK${White}"
		fi
}
# test_2 ()
# {

# }
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
