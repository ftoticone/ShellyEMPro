#!/bin/bash
#Author		ftoticone
#Program Name	emdata_merge.sh
#Use		this script is to merging several esported csv files from Shelly PRO EM



function merge_data {
	DATA_PATH=$1
	MERGED_FILE="emdata_merged_""$(date +'%Y%m%d%H%M%S')"".csv"
	declare -a files
	
	for file in $DATA_PATH/*.csv
	do
	    files=("${files[@]}" "$file")	    
	    
	    TMP_FILE="$file"".tmp"

	    #remove special chars
	    awk '{ gsub(/\xef\xbb\xbf/,""); print }' $file > $TMP_FILE && mv $TMP_FILE $file
	done
	
	touch "./$MERGED_FILE"
	
	if [ ${#files[@]} -gt 0 ]
	then
		#get the column names
		column_names=$(head -n 1 ${files[0]})	
		
		sort -u $(echo "${files[@]}") >> "./$MERGED_FILE"

		#remove the last line of file because is made of column names
		sed -i '$ d' "./$MERGED_FILE"

		#adding the column names as first line of merged file
		sed -i 1i$column_names "./$MERGED_FILE"
	fi
	
	echo "./$MERGED_FILE"
}
