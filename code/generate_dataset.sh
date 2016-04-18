#!/bin/bash

key_file=$1
in_dir=$2
out_dir=$3
study_name=$4

n_participants=$(cat $1 | wc -l)
#echo $n_participants Participants in this study
mkdir $out_dir

for p in $(seq -w $n_participants)
do
	run=1
#	cat $key_file
	curr_dir=$(cat $key_file | awk NR=="$p" | awk '{print $1}')
	curr_ID=$(cat $key_file | awk NR=="$p" | awk '{print $2}')
	
#	echo $curr_dir
#	echo $curr_ID

	for s in $(ls ./"$in_dir"/"$curr_dir")
	do
		
		echo $s
		curr_dir_length=$(ls ./"$in_dir"/"$curr_dir"/$s |wc -l)
		if [ "$curr_dir_length" == "176" ]; then

			echo anat
			./code/BIDS_file_converter.sh "$in_dir"/"$curr_dir"/$s $out_dir $study_name anat $curr_ID
				
		else
	
			echo func $run
			./code/BIDS_file_converter.sh "$in_dir"/"$curr_dir"/$s $out_dir $study_name func $curr_ID FER $run
			run=$(echo $run+1|bc)

		fi

		

	done
	

done
