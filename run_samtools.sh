#!/bin/bash  

# Load and avail the required module
module load samtools
module avail samtools

# Assign input and output directories
input_dir=~/analysis/trimmomatic
output_dir=~/analysis/aligned_sorted_bam  
mkdir -p $output_dir  

for file in $input_dir/*.sam  
do   
# Get the basename of the file minus the ".sam" ending   
name=$(basename $file .sam)   
echo $name   

# Convert SAM to BAM format   
samtools view -b $file > $output_dir/$name.unsorted.bam   

# Sort BAM files   
samtools sort $output_dir/$name.unsorted.bam > $output_dir/$name.sorted.bam  

# Index BAM files   
samtools index $output_dir/$name.sorted.bam   

# Generate summary stats   
samtools flagstat $output_dir/$name.sorted.bam > $output_dir/$name.flagstat   

# Delete the unsorted BAM   
rm $output_dir/$name.unsorted.bam  
done 
