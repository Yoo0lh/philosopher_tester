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
		#test 1 / 1
		output=$("$1" 3 310 200 100 > log && sleep 4 ; pkill philo ; cat log | grep died -m 1 | awk '{print $NF}') 
		# ("$1" 3 310 200 200 > log) &&
		# sleep 5
		# pkill $1 > /dev/null 
		# output=$(cat log | grep died -m 1 | awk '{print $NF}')
		#echo $output
		if [ "$output" == "died" ]
				then
						echo -en "${SP}${Green}OK${White}"
		else
						echo -en "${SP}${Red}KO${White}"
		fi
		#test 2 / 1
		# output=$("$1" 3 800 400 400 > log2 ; sleep 0.9 ; pkill philo ; cat log2 | grep died -m 1 | awk '{print $NF}')
		# if [ "$output" == "died" ]
		# 		then
		# 				echo -en "${SP}${Green}OK${White}"
		# else
		# 				echo -en "${SP}${Red}KO${White}"
		# #test 3 / 1	
		# fi
		# output=$("$1" 10 800 400 200 > log3 ; sleep 0.9 ; pkill philo ; cat log3 | grep died -m 1 | awk '{print $NF}')
		# if [ "$output" == "died" ]
		# 		then
		# 				echo -en "${SP}${Green}OK${White}"
		# else
		# 				echo -en "${SP}${Red}KO${White}"
		# fi
		echo " "
		sleep 1
}

test_2 ()
{
		make re -C ../philo > /dev/null
		echo -en  "${Purple}test 2 :"
		#test 2 / 1
		output=$("$1" 3 800 200 200 > log &&  cat log | grep died -m 1 | awk '{print $NF}') &
		i=0
		check=0
		while [ $i -le 10 ] #|| [ "$output" == "died" ]
		do
				pgrep philo > /dev/null 
				if [ $? !=  0 ] || [ "$output" == "died" ]
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
		output=$("$1" 10 800 200 200 > log2 && cat log2 | grep died -m 1 | awk '{print $NF}') &
		i=0
		check=0
		while [ $i -le 10 ]
		do
				pgrep philo > /dev/null
				if [ $? !=  0 ] || [ "$output" == "died" ]
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
		output=$("$1" 100 800 200 200 > log3 &&  cat log3 | grep died -m 1 | awk '{print $NF}') &
		i=0
		check=0
		while [ $i -le 10 ] #|| [ "$ouput" == "died" ]
		do
				pgrep philo > /dev/null  
				if [ $? !=  0 ] || [ "$output" == "died" ]
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
# test 3 -----------------------------------------

test_3 ()
{
		echo -en "${Purple}test 3 :"
		#test 3 / 1
		output=$("$1" 4 410 200 200 > log && cat log | grep died -m 1 | awk '{print $NF}') &
		i=0
		check=0
		while [ $i -le 10 ]
		do
				pgrep philo > /dev/null
				if [ "$?" -ne 0 ] || [ "$output" == "died" ] 
				then
						#echo "$output"
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
		
		#pkill "$1" &2> /dev/null
		#test 3 / 2
		output=$("$1" 5 800 200 200 > log2 && cat log | grep died -m 1 | awk '{print $NF}') &
		#"$1" 5 800 200 200 > log  &
		i=0
		check=0
		while [ $i -le  10 ]
		do
				pgrep  philo > /dev/null
				if [ "$?" -ne 0 ] || [ "$output" == "died" ]
				then
						#echo  "$output"
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
		output=$("$1" 20 800 200 200 > log3 && cat log | grep died -m 1 | awk '{print $NF}') &
		#"$1" 5 800 200 200 > log  &
		i=0
		check=0
		while [ $i -le  10 ]
		do
				pgrep  philo > /dev/null
				if [ "$?" -ne 0 ] || [ "$output" == "died" ]
				then
						#echo  "$output"
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
		#rm -f $file_output
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
#sleep 1
test_3 "$file_name"
