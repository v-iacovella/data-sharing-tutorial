#!/bin/bash

# This script:
# could be ran from everywhere
# takes as input an absolute path with the original DICOM files
#
# Convert the DICOM files into properly named nifti files



in_dir=$1
study_name=$2
im_type=$3
part_ID=$4
task_name=$5
run_counter=$6
	

echo $in_dir $out_dir

if [ "$im_type" == "func" ]; then

	./software/deface/mri_deface-v1.22-Linux64 ./"$in_dir"/"$study_name"/"$part_ID"/"$im_type"/"$part_ID"_task-"$task_name"_run-"$run_counter"_bold.nii.gz ./software/deface/talairach_mixed_with_skull.gca ./software/deface/face.gca ./"$in_dir"/"$study_name"/"$part_ID"/"$im_type"/"$part_ID"_task-"$task_name"_run-"$run_counter"_bold.deface.nii.gz
fi


if [ "$im_type" == "anat" ]; then

	./software/deface/mri_deface-v1.22-Linux64 ./"$in_dir"/"$study_name"/"$part_ID"/"$im_type"/"$part_ID""_T1w.nii.gz" ./software/deface/talairach_mixed_with_skull.gca ./software/deface/face.gca ./"$in_dir"/"$study_name"/"$part_ID"/"$im_type"/"$part_ID""_T1w.deface.nii.gz"
fi
