#!/bin/bash
# Code generated with the use of the Gemini family of AI models and then slightly modified

# Define the adapter sequence to search for
ADAPTER=$2 # "AGATCGGAAGAGC" 

# Input FASTQ file
INPUT_FASTQ=$1 # "reads.fastq"

# Output trimmed FASTQ file
OUTPUT_FASTQ="reads_trimmed_extra.fastq"

# Check if we have two parameters
if [ $# -ne 2 ]; then
        echo Please provide a fastq file and an adapter sequence as input.
fi

# Check if input file exists
if [ ! -f "$INPUT_FASTQ" ]; then
    echo "Error: Input file '$INPUT_FASTQ' not found."
    exit 1
fi

# AWK script to process the FASTQ file
awk -v adapter="$ADAPTER" '
BEGIN {
    FS="\n"; RS="@"; # Set record separator to '@' to process each read as a block
}
NF > 1 { # Ensure we are processing a valid read block
    # Split the read into its four lines
    header = $1;
    sequence = $2;
    plus = $3;
    quality = $4;

    # Search for the adapter in the sequence
    adapter_pos = index(sequence, adapter);

    if (adapter_pos > 0) {
        # If adapter found, trim sequence and quality from the start of the adapter
        trimmed_sequence = substr(sequence, 1, adapter_pos - 1);
        trimmed_quality = substr(quality, 1, adapter_pos - 1);
    } else {
        # If no adapter found, keep the original sequence and quality
        trimmed_sequence = sequence;
        trimmed_quality = quality;
    }

    # Print the trimmed read
    print "@" header;
    print trimmed_sequence;
    print plus;
    print trimmed_quality;
}
' "$INPUT_FASTQ" > "$OUTPUT_FASTQ"

echo "Adapter trimming complete. Trimmed reads saved to '$OUTPUT_FASTQ'."



#=======================================

# To run the code use:
# bash trim_adaptor_extra.sh reads.fastq AGATCGGAAGAGC   

# The output will be:    
#-----------------
# Adapter trimming complete. Trimmed reads saved to 'reads_trimmed_extra.fastq'.
#-----------------

# To check the difference to the cutadapt resut use:
# diff reads_cutadapt.fastq reads_trimmed_extra.fastq 

# The result will be:
#-----------------
# 26c26
# < CCCGCGTAAACTTTAGTGATTCACCCTTCAGTGGGGCTAGGTTTTCCAACCACAACTATGG
# ---
# > CCCGCGTAAACTTTAGTGATTCACCCTTCAGTGGGGCTAGGTTTTCCAACCACAACTATGGAGAT
# 28c28
# < AAFFFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJJJJJJJJJJJJJJJJJ
# ---
# > AAFFFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJJJJJJJJJJJJJJJJJJJJJJJ
#-----------------

# Only the lines (read sequence and quality score) with the partial match trim is now different between the cutadapt and the bash script simulator. 

#=======================================

