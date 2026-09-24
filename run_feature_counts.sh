#!/bin/bash  

# Load and avail the required module
module load subread
module avail subread

# Assign all the required directory locations
reference_gtf="/home/amoh0254/mouse_reference/Mus_musculus.GRCm39.110.gtf"
bam_dir="/home/amoh0254/amoh0254_BMS5309_AT1/aligned_sorted_bam"  
output_dir="/home/amoh0254/amoh0254_BMS5309_AT1/feature_counts"
output_file="combined_counts.txt"  
mkdir -p "$output_dir"  

# Run featureCounts
featureCounts -p -t exon -g gene_id -s 0 \
  -a "$reference_gtf" \
  -o "$output_dir/$output_file" \
  "$bam_dir"/*_R1.trim_pe.fastq_R1.trim_pe.fastq.hisat2.sorted.bam
