#!/bin/bash
file='events.txt'
while getopts 'lc:a:tm' option; do
	case $option in
		a)
		if [[ ${OPTARG} =~ ^[A-Za-z]{1,}_[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]
		then
		echo "${OPTARG}" >> $file
		echo "Esemény sikeresen hozzáadva"
		else
		echo "Helytelen argumentum formátum"
		fi;;
		l)
		 echo "Az összes esemény:"
		while IFS= read -r line
		do
		echo "$line"
		done <$file;;
		c)
		if [[ ${OPTARG} =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]
		then
		if  grep -q "${OPTARG}" "$file" 
		then
		grep -n "${OPTARG}" "$file"
		else 
		echo "Nincs esemeny"
		fi
		else
		echo "Helytelen argumentum formátum"
		fi;;
		t)
		actualtime=$(date +"%Y-%m-%d")
		echo "Az aktu�lis d�tum: $actualtime";;
		m)
		actualtime=$(date +"%Y-%m-%d")
		vane=nincs
		echo "Eseménye a mai napon: "
		while IFS= read -r line
		do
		len=$((${#line}-10))
		ido="${line:$len}"
		if [ "$ido" == "$actualtime" ]
		then
		echo "$line"
		vane=van
		fi
		done<$file
		if [ "$vane" == "nincs" ]
		then
		echo "Nincs a mai napon esemény"
		fi;;

	esac
	done

