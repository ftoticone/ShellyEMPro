#!/bin/bash
#Author		ftoticone
#Program Name	electric_billing_range.sh
#Use		this script is to get italian electric billing scheme


function electric_billing_range {
	RANGE1="F1"
	RANGE2="F2"
	RANGE3="F3"
	
	timestamp=$1

	#day of year
	yearday=$(date -d @$timestamp +'%Y%m%d')

	#day of week (1...7); 1 is Monday
	weekday=$(date -d @$timestamp +'%u')

	dayhourminute=$(date -d @$timestamp +'%H%M')
	
	#remove leading zeros
	dayhourminute=$(expr $dayhourminute + 0)


	if [[ $(calendar -A 0 -f ./calendar.italian -t $yearday) ]]; then
		echo "$RANGE3" #"[Bank Holiday]"	
	elif [[ $weekday -ge 1 && $weekday -le 5 ]]; then
		if [[ $dayhourminute -ge 800 && $dayhourminute -lt 1900 ]]; then
			echo "$RANGE1" #"[Mon - Fri]" "[08 - 19]"
		elif [[ $dayhourminute -ge 700 && $dayhourminute -lt 800 ]]; then
			echo "$RANGE2" #"[Mon - Fri]" "[07 - 08]"
		elif [[ $dayhourminute -ge 1900 && $dayhourminute -lt 2300 ]]; then
			echo "$RANGE2" #"[Mon - Fri]" "[19 - 23]"
		elif [[ $dayhourminute -ge 2300 || $dayhourminute -lt 700 ]]; then
			echo "$RANGE3" #"[Mon - Fri]" "[23 - 07]"
		fi
	elif [[ $weekday -eq 6 ]]; then
		if [[ $dayhourminute -ge 700 && $dayhourminute -lt 2300 ]]; then
			echo "$RANGE2" #"[Sat]" "[07 - 23]"
		elif [[ $dayhourminute -ge 2300 || $dayhourminute -lt 700 ]]; then
			echo "$RANGE3" #"[Sat]" "[23 - 07]"
		fi
	elif [[ $weekday -eq 7 ]]; then
		echo "$RANGE3" #"[Sun]" "[00 - 24]"
	else
		echo "FAIL"	
	fi

	exit 0
}
