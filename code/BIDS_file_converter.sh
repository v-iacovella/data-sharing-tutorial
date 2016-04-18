#!/bin/bash

# This script:
# could be ran from everywhere
# takes as input an absolute path with the original DICOM files
#
# Convert the DICOM files into properly named nifti files



in_dir=$1
out_dir=$2
study_name=$3
im_type=$4
part_ID=$5


mkdir "$out_dir"/"$study_name"/"$part_ID"/"$im_type" -p

echo $in_dir $out_dir




if [ "$im_type" == "func" ]; then

	task_name=$6
	run_counter=$7
	

	./software/dcm2niix/dcm2niix -o "./$out_dir/"$study_name""/"$part_ID"/"$im_type" -f "$part_ID""_task-"$task_name"_run-""$run_counter""_bold" -z y "$in_dir"/*

	first_dcm=$(ls $in_dir |  head -n 1)
	TR=$(echo "scale=4 ; $(./software/misc/dicom_hdr $in_dir/$first_dcm | grep Repetition | awk -F "//" '{print $3}')/1000" | bc)
	out_file="./$out_dir/"$study_name""/"$part_ID"/"$im_type"/"$part_ID""_task-"$task_name"_run-""$run_counter""_bold.json"

	echo \{ > $out_file
	echo \"RepetitionTime\"\: $TR"," >> $out_file
	echo \"TaskName\"\: \"$task_name\" >> $out_file
	echo \} >> $out_file

	echo func

fi


if [ "$im_type" == "anat" ]; then

	./software/dcm2niix/dcm2niix -o "./$out_dir/"$study_name""/"$part_ID"/"$im_type" -f "$part_ID""_T1w" -z y "$in_dir"/*
	first_dcm=$(ls $in_dir |  head -n 1)
	echo $in_dir/$first_dcm
	TR=$(echo "scale=4 ; $(./software/misc/dicom_hdr $in_dir/$first_dcm | grep Repetition | awk -F "//" '{print $3}')/1000" | bc)

	out_file="./$out_dir/"$study_name""/"$part_ID"/"$im_type"/"$part_ID""_T1w.json"

	echo \{ > $out_file
	echo \"RepetitionTime\"\: $TR"," >> $out_file
	echo \"TaskName\"\: \"anat\" >> $out_file
	echo \} >> $out_file

	echo anat

fi
