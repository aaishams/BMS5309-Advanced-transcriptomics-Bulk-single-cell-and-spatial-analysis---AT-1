#!/bin/bash  

# Load and avail required modules
module load fastqc
module avail fastqc
module load multiqc
module avail multiqc

# Assign input and output sources
input_dir=~/AT1_data
output_dir=~/amoh0254_BMS5309_AT1

# Create output directory if it doesn't already exist (-p allows creation of nested directories)
mkdir -p "$output_dir"
for file in "$input_dir"/*.fastq  
do  
echo "$file"
fastqc "$file" --outdir="$output_dir"
done  
multiqc "$output_dir" -o "$output_dir"
