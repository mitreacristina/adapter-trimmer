#!/bin/bash

# set up variables so if we make a change in these parameters we only make it here
# $1 and $2 are the first two arguments that are listed after the script name when runing the script
# the separator is whitespace

input_fastq=$1
adapter=$2
output_fastq="reads_trimmed.fastq"

if [ $# -ne 2 ]; then
	echo Please provide a fastq file and an adapter sequence as input.
fi

# using awk to only affect lines withthe sequence - second line and every 4th line thereafter
# the modulo operator (% - computes the remainder of the division) allows us to do that when applied to the line number
# in awk the line number is given by NR
# gsub allows us to substitute a substrig with another in our lines that meet the condition

echo Removing $adapter from $input_fastq and saving the results in $output_fastq.
echo I replace $adapter with "__" just to see where the replacement happens.

awk -v adapter="$adapter" 'NR%4==2 {gsub(adapter, "__")} 1' $input_fastq > $output_fastq  

echo Done removing $adapter from $input_fastq. Please check $output_fastq.
echo Here are the differences between $input_fastq and $output_fastq.
diff -d <(cat -n $input_fastq) <(cat -n $output_fastq)
