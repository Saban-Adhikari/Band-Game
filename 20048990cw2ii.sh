#!/bin/bash
#This function asks if the user wants to play the game again or not
playAgainOrExit() {
	PS3="Would you like to play again? Choose by typing 1 or 2: " #The PS3 shows a prompt with a question and option for the user to read and answer
	select answer in Yes No; do
		if [[ "$answer" == Yes ]]; then #The semi-colon is given below to execute one command after another in a sequence
			echo "Redirecting to the first part of the game"
			sleep .4
			echo -e ".\c"
			sleep .4
			echo -e ".\c"
			sleep .4
			echo -e ".\c"
			echo
			sleep 1
			bandGame
		else
			echo "Exiting you out of the system "
			sleep .3
			echo -e ".\c"
			sleep .2
			echo -e ".\c"
			sleep .2
			echo -e ".\c"
			echo
			echo "------------------------------------"
			echo "Bye, You have Successfully exited!!!"
			echo "------------------------------------"
			exit
		fi
	done
}
#This function first shows the three members chosen by the user and asks them to choose one from the three of the members chosen
#This function also shows the description about the band members for some members
chosenMember() {
	value=3
	echo "The member codes you chose are: "
	echo "----------------"
	echo "$memberA  | $memberB  | $memberC"
	echo "----------------"
	PS3="You need to choose one of the codes (1, 2 or 3) from the above three codes: "
	select code in $memberA $memberB $memberC; do #The variable code here refers to the code chosen by the user
		if [[ $code == JL ]]; then
			echo
			echo "Short description about John Lennon: " | lolcat
			echo "-----------------------------------  " | lolcat
			cat JL
			echo "-----------------------------------  " | lolcat
			sleep .30
			playAgainOrExit
		elif [[ $code == AY ]]; then
			echo
			echo "Short description about Angus Young: " | lolcat
			echo "-----------------------------------  " | lolcat
			cat AY
			echo "-----------------------------------  " | lolcat
			sleep .30
			playAgainOrExit
		elif [[ $code == KC ]]; then
			echo
			echo "Short description about Kurt Cobain:" | lolcat
			echo "----------------------------------- " | lolcat
			cat KC
			echo "----------------------------------- " | lolcat
			sleep .30
			playAgainOrExit
		else
			echo "--------------------------------------------------------"
			echo "The file with that name does not exist or isn't readable"
			echo "--------------------------------------------------------"
			echo "Redirecting you to the first part of the game" | lolcat
			sleep 3
			bandGame #Calls the bandGame function
		fi
	done
}
#This function asks the user to choose any three members from the list
bandMembers() {
	echo "------------------------------"
	echo "Band Member     | Member Code "
	echo "------------------------------"
	echo "John Lennon     |        JL   "
	echo "------------------------------"
	echo "Angus Young     |        AY   "
	echo "------------------------------"
	echo "Freddie Mercury |        FM   "
	echo "------------------------------"
	echo "Debbie Harry    |        DH   "
	echo "------------------------------"
	echo "Kurt Cobain     |        KC   "
	echo "------------------------------"
	membersChosen="false" #membersChosen variable is set as false as no members have been chosen and also to run the until loop which runs only when the condition returns false and terminates when the conditon is true
	until [[ "$membersChosen" == "true" ]]; do
		member1="JL" #membercodes to later use to check if member chosen is one of these codes or not
		member2="AY"
		member3="FM"
		member4="DH"
		member5="KC"
		echo "Choose any three members from the above list: "
		read memberA memberB memberC
		members=no
		while [[ "$members" == "no" ]]; do #The if condition below checks if whether the user input matches the membercode or not
			if [[ ("$memberA" == "$member1" || "$memberA" == "$member2" || "$memberA" == "$member3" || "$memberA" == "$member4" || "$memberA" == "$member5") && ("$memberB" == "$member1" ||
				"$memberB" == "$member2" || "$memberB" == "$member3" || "$memberB" == "$member4" || "$memberB" == "$member5") && ("$memberC" == "$member1" || "$memberC" == "$member2" || "$memberC" == "$member3" ||
				"$memberC" == "$member4" || "$memberC" == "$member5") ]]; then
				if [[ "$memberA" != "$memberB" && "$memberB" != "$memberC" && "$memberC" != "$memberA" ]]; then
					membersChosen="false"
					chosenMember
					break
				else
					members="yes"
					echo "-------------------------------------------"
					echo "You cannot repeat the same code, Try Again!"
					echo "-------------------------------------------"
					continue
				fi
			else
				members="yes"
				echo "-----------------------------------------------------------"
				echo "Only enter the codes shown above and ONLY three of them !!!"
				echo "-----------------------------------------------------------"
				continue
			fi
		done
	done
}
#This function asks the user to guess which is the best band
bandGame() {
	echo "-----------------------"
	echo "Band Names | Band Codes"
	echo "-----------------------"
	echo "Beatles    |  BEA      "
	echo "-----------------------"
	echo "AC/DC      |  AD       "
	echo "-----------------------"
	echo "Queen      |  QUE      "
	echo "-----------------------"
	echo "Blondie    |  BLO      "
	echo "-----------------------"
	echo "Nirvana    |  NIR      "
	echo "-----------------------"

	input=false #The input variable is set as false to run the loop when the user hasn't provided the input
	while [[ "$input" == "false" ]]; do
		read -p "Guess the best music band using the band codes: " answer
		if [ "$answer" == "NIR" ]; then
			input="true"
			echo "---------------" | lolcat
			echo "Correct answer!" | lolcat
			echo "---------------" | lolcat
			echo
			echo "A little info about the band: "
			echo "---------------------------------------------" | lolcat
			echo -e "Nirvana is an american rock band formed\nin Aberdeen, Washington, in 1987."
			echo "---------------------------------------------" | lolcat
			bandMembers #Calling the function called bandMembers
		else
			echo "-----------------------"
			echo "Not the correct answer!"
			echo "-----------------------"
			continue #The continue command is used to continue the loop from the main loop if the user input does not match the answwer which is NIR
		fi
	done
}
#This function asks the password to user to enter the game and if they're wrong it kicks them off the system
secKey() {
	Counter=3 #The counter is used to check how many times has the program has been running
	for i in {1..3}; do
		read -s -p "Enter the secret key to run the program: " hellothere #The hellothere is a variable that stores the value entered during the prompt answer
		pass="hello"                                                      #pass is variable contains the password to enter the system
		if [ "$hellothere" == $pass ]; then
			echo -e "\nHi, $2 $1 $(date)"
			bandGame
			break
		else
			((Counter--)) #It decreases the values of counter if it keeps on the loop and if it has ran over 3 times it throws the user out of the system
			echo -e "\nWRONG PASSWORD!!! Number of tries left: $Counter"
			if [[ $Counter -eq 0 ]]; then
				echo "------------------------------------"
				echo "Too many wrong attempts try again!!!"
				echo "------------------------------------"
				exit
			fi
			continue
		fi
	done
}
#This function checks if the user has or hasn't provided their username and userid and also is it in correct format or not
login() {
	if [[ -z $1 ]]; then
		echo "--------------------"
		echo "No username found!!!"
		echo "--------------------"
	elif [[ -z $2 ]]; then
		echo "-------------------------------"
		echo "Please enter the user id too!!!"
		echo "-------------------------------"
	elif [[ $2 =~ ^[a-z]?[A-Z]?[A-z] ]]; then
		echo "UserID must an integer/arithmetic value !!!"
	else
		figlet Welcome | lolcat
		secKey "$1" "$2" #Reference to the $1 and $2
	fi
}
login "$1" "$2" #The $1 and $2 are arguments that take different input from user
