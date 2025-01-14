#!/bin/bash
#Author		ftoticone
#Program Name	emdata_batch.sh
#Use		this script is to batching several esported csv files from Shelly PRO EM

source emdata_merge.sh
source emdata_convert.sh

if [[ -z $1 ]]; then
        echo "Please specify the data path...."
        exit 1
fi

DATA_PATH=$1

echo "Merging phase"
MERGED_FILE=$(merge_data "$DATA_PATH")
echo "DONE"
echo ""

echo "Converting phase"
convert_data $MERGED_FILE

rm $MERGED_FILE
