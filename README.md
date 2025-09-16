### Bash code to simulate the cutadapt tool

Modern biology and medicine rely heavily on DNA and RNA sequencing technologies. Sequencing allows researchers to determine the exact order of nucleotides in genomes, transcriptomes, and other biological samples. It is crucial for:
*	Identifying genetic variants that cause disease.
*	Understanding cancer mutations.
*	Profiling microbial diversity.
*	Measuring gene expression through RNA sequencing.
*	Advancing precision medicine and drug discovery.

High-throughput sequencing technologies (e.g., Illumina) generate millions of short reads cost-effectively. To prepare DNA or RNA fragments for sequencing, molecular biologists add adapter sequences. These short synthetic DNA sequences enable fragments to:
*	Bind to the flow cell during sequencing.
*	Be amplified by PCR so enough copies are available for detection.
*	Serve as priming sites for sequencing reactions.

Although essential for sequencing, adapters often appear at the ends of reads in output data. If not trimmed away, they interfere with alignment, variant calling, and expression quantification, making adapter trimming a necessary preprocessing step.
The data are typically stored in FASTQ files, which include both sequence and quality information. Each read consists of four lines:
1.	A read identifier line (starts with @).
2.	The nucleotide sequence of the read.
3.	A separator line (+, sometimes repeating the identifier).
4.	The quality scores, with one ASCII symbol per base in the sequence.

Adapters can appear on line 2 (the sequence line) and their removal improves data quality. Tools like Cutadapt effectively remove adapters, accounting for sequencing errors and partial overlaps.
In this repository, we implement a simplified trimmer in Bash that initially remove just the adapter sequence, then the adapter and all nucleotides that follow in the red sequence, then we correspondingly trim the quality scores line to only contain the scores for the nucleotides that are still present in the sequence line. Then, we attempt a partial match. 

We use a test `read.fastq` file as well as the result of runnig cutadapt on that file `reads_cutadapt.fastq` to build our simulator and see how our bash simulator results compare with the results of cutadapt on the test file and document the differences in a `comparison.txt` file.

We also simulate a mistake where we ovewrite the script and then delete the script and document how we recover the script in the file `recovery.txt`.


