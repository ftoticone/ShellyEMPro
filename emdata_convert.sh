#!/bin/bash
#Author		ftoticone
#Program Name	emdata_convert.sh
#Use		this script is to extracting and aggregating data exported from Shelly PRO EM

source progress_bar.sh
source electric_billing_range.sh

function convert_data {
	file_to_convert=$1
	
	#Associative array with aggregate data
	declare -A energy_usage=()
	file_result="emdata_converted_""$(date +'%Y%m%d%H%M%S')"".csv" 

	#Reading of lines in the exported data
	echo "Reading and converting data"
	total_records=$(tail -n+2 $file_to_convert | sed -n '$=')
	current_record=1
	
	[ ! -f $file_to_convert ] && { echo "$file_to_convert file not found"; exit 99; }
	while IFS="," read -r rec1 rec2
	do
		timestamp=$rec1
		el_bill_range=$(electric_billing_range "$timestamp")
		year_month=$(date -d @$timestamp +'%Y%m')
		year_month_range=$year_month$el_bill_range
		energy=$(echo $rec2 | sed 's/\././')
		
		if [[ ${energy_usage[$year_month_range]} ]]
		then
			energy_usage[$year_month_range]=$(echo "scale=8 ;${energy_usage[$year_month_range]} + $energy" | bc)
		else
			energy_usage[$year_month_range]=$energy
		fi
		
		show_progress $current_record $total_records
		(( current_record += 1 ))

	done < <(cut -d "," -f1,2 $file_to_convert | tail -n +2)
	echo ""

	#read -p "Press enter to continue"

	#set default excel separator and columns headers
	echo "sep=;" > $file_result
	echo "Year;Month;Range;Consumption (kWh)" >> $file_result

	echo "Storing data"
	total_records=${#energy_usage[@]}
	current_record=1
	for i in "${!energy_usage[@]}"
	do
		#divide valute by 1000 in order to show energy consumption in kWh
		scaled_value=$(echo "scale=8 ;${energy_usage[$i]}"/1000 | bc)
		echo "$(cut -c 1-4 <<< ${i});$(cut -c 5-6 <<< ${i});$(cut -c 7-8 <<< ${i});$(echo $scaled_value | sed 's/\./,/')" >> $file_result
		
		show_progress $current_record $total_records
		(( current_record += 1 ))
	done
	echo ""
	
	echo "Shelly Pro EM data converted and saved in "$file_result
	echo ""
}
