#!/bin/bash  

# Load and avail the required module
module load trimmomatic
module avail trimmomatic

# Assign the input and output sources
input_dir=~/AT1_data
output_dir=~/amoh0254_BMS5309_AT1/trimmomatic
mkdir -p "$output_dir"

# Find the pair files
for file1 in "${input_dir}"/*_R1.fastq  
do   
file2="${file1/_R1.fastq/_R2.fastq}"  
if [[ ! -f "$file2" ]]; then   
echo "Warning: Pair file not found for $file1" continue   
fi  

# Extract sample base name (e.g., SRR975551)  
name=$(basename "$file1" "_R1.fastq")  

# Define output file names  
out1="${output_dir}/${name}_R1.trim_pe.fastq"  
out2="${output_dir}/${name}_R2.trim_pe.fastq"  
out1se="${output_dir}/${name}_R1.trim_se.fastq"  
out2se="${output_dir}/${name}_R2.trim_se.fastq"  

# Run trimmomatic
echo "Running Trimmomatic for $name..."  
java -jar "$TRIMMOMATIC_PATH"/trimmomatic-0.38.jar PE -threads 4 "$file1" "$file2" "$out1" "$out1se" "$out2" "$out2se" LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:50
done 
