#!bin/bash

Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
SP="  "
file_output="output"

test_1 ()
{
		echo -en "${Purple}test 1 :"
		output=$("$1" 3 310 200 100 > log && sleep 0.4 ; pkill "$1" ; cat log | grep died -m 1 | awk '{print $NF}')
		#echo $output
		if [ "$output" == "died" ]
				then
						echo -en "${SP}${Green}OK${White}"
		else
						echo -en "${SP}${Red}KO${White}"
		fi
		output=$("$1" 3 800 400 400 > log && sleep 0.9 ; pkill "$1" ; cat log | grep died -m 1 | awk '{print $NF}')	
		if [ "$output" == "died" ]
				then
						echo -en "${SP}${Green}OK${White}"
		else
						echo -en "${SP}${Red}KO${White}"
		output=$("$1" 10 800 400 400 > log && sleep 0.9 ; pkill "$1" ; cat log | grep died -m 1 | awk '{print $NF}')	
		fi
		if [ "$output" == "died" ]
				then
						echo -en "${SP}${Green}OK${White}"
		else
						echo -en "${SP}${Red}KO${White}"

		#echo -e "\n" 
		fi
		pkill "$1" &2>/dev/null
		rm -f log
		echo " "
		sleep 1
}

test_2 ()
{
		echo -en  "${Purple}test 2 :"
		#test 2 / 1
		"$1" 3 800 200 200 > log &
		i=0
		check=0
		while [ $i -le 5 ]
		do
				if [ $? !=  0 ]
				then
						check=1
						echo -ne "${SP}${Red}KO${White}"
						break ;
				fi
				sleep 1
				i=$((i + 1)) 
		done
		if [ $check == 0 ]
				then
						echo -ne "${SP}${Green}OK${Withe}"
		fi
		#test 2 / 2
		"$1" 10 800 200 200 > log &
		i=0
		check=0
		while [ $i -le 5 ]
		do
				if [ $? !=  0 ]
				then
						check=1
						echo -ne "${SP}${Red}KO${White}"
						break ;
				fi
				sleep 1
				i=$((i + 1)) 
		done 
		if [ $check == 0 ]
				then
						echo -ne "${SP}${Green}OK${Withe}"
		fi
		#test 2 / 3
		"$1" 100 800 200 200 > log &
		i=0
		check=0
		while [ $i -le 5 ]
		do
				if [ $? !=  0 ]
				then
						check=1
						echo -ne "${SP}${Red}KO${White}"
						break ;
				fi
				sleep 1
				i=$((i + 1)) 
		done 
		if [ $check == 0 ]
				then
						echo -ne "${SP}${Green}OK${Withe}"
		fi
		pkill philo &2>/dev/null
		echo " "
		rm -f $file_output
}
test_3 ()
{
		echo -en "${Purple}test 3 :"
		#test 3 / 1
		"$1" 4 410 200 200 > log  &
		i=0
		check=0
		while [ $i -le  5 ]
		do
				pgrep $1 
				if [ $? != 0 ]
				then
						check=1
						echo  -en "${SP}${Red}KO${White}"
						break ;
				fi
				sleep 1
				i=$((i + 1))
		done 
		if [ $check == 0 ]
				then
						echo -en "${SP}${Green}OK${White}"
		fi
		#test 3 / 2
		"$1" 5 800 200 200 > log  &
		i=0
		check=0
		while [ $i -le  5 ]
		do
				pgrep $1
				if [ "$?" -ne 0 ]
				then
						check=1
						echo  -en "${SP}${Red}KO${White}"
						break ;
				fi
				sleep 1
				i=$((i + 1))
		done 
		if [ $check -eq 0 ]
				then
						echo -en "${SP}${Green}OK${White}"
		fi

		pkill philo &2> /dev/null
		echo " "
		rm -f $file_output
}
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
#test_1 "$file_name"
#test_2 "$file_name"
test_3 "$file_name"
