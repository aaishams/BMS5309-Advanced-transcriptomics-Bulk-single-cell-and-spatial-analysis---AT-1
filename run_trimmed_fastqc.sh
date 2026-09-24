#!/bin/bash  

# Load and avail required modules
module load fastqc
module avail fastqc
module load multiqc
module avail multiqc

# Assign input and output directories
input_dir=~/amoh0254_BMS5309_AT1/trimmomatic
output_dir=~/amoh0254_BMS5309_AT1/trimmed_fastqc_original

# Create output directory if it doesn't already exist (-p allows creation of nested directories)
mkdir -p "$output_dir"
for file in "$input_dir"/*.trim_pe.fastq  
do  
echo "$file"
fastqc "$file" --outdir="$output_dir"
done  
multiqc "$output_dir" -o "$output_dir"
