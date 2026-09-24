#!/bin/bash 

# Load and avail the required module
module load hisat2
module avail hisat2

# Assign input, output and reference genome directories
reference_genome=/home/amoh0254/mouse_reference/hisat2_ref/mouse_grcm39_index
input_dir=/home/amoh0254/amoh0254_BMS5309_AT1/trimmomatic
output_dir=/home/amoh0254/amoh0254_BMS5309_AT1/hisat2
mkdir -p "$output_dir"

# Find the pair files
for file1 in "$input_dir"/*_R1.trim_pe.fastq  
do   
file2="${file1/_R1.trim_pe.fastq/_R2.trim_pe.fastq}"   
if [[ ! -f "$file2" ]]; then   
echo "Paired file not found for: $file1"  
continue   
fi   
sample_name=$(basename "$file1"_R1.trim_pe.fastq)  
output_sam="${output_dir}/${sample_name}.hisat2.sam"   

# Run HISAT2 genome alignment
echo "Aligning sample: $sample_name"   
hisat2 -x "$reference_genome" -1 "$file1" -2 "$file2" -S "$output_sam"  
done  
