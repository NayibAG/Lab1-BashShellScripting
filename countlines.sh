#!/bin/bash 

option="$1"
aux="$2"

showLinesPerFile(){
	local files=("$@") #Takes the whole list an asigned to files
	for it in $files;do 
		local linesAmount=$(wc -l $it)
		echo "File: $it,	Lines: $linesAmount"
	done
}

caseOwner(){
	local user=${aux:1}
	local lowerCase=${user,,}
	echo "Looking for files where the owner is: $user"
	local files=$(ls -l | awk '$3=="'$lowerCase'" {print $9}') #Take only the files of that owner/user  
	showLinesPerFile "${files[@]}" #Pass the whole list as argument
}

caseMonth(){
	local mon=${aux:1}
	local lowerCase=${mon,,}
	echo "Looking for files where the month is: $mon"
	local files=$(ls -l | awk '$6=="'$lowerCase'" {print $9}') #Take only the files of that creation date month  
	showLinesPerFile "${files[@]}" #Pass the whole list as argument
}

if [ $option = "-o" ] && [ ! -z $aux ] || [ $option = "-m" ] && [ ! -z $aux ] ;then
	if [ $option = "-o" ] && [ ! -z $aux ];then
		caseOwner
	else
		caseMonth
	fi
else
	echo "Please use -o <owner> To select files where the owner is <owner>"
	echo "OR"
	echo "Please use -m <month> To select files where the creation month is <month>"
fi