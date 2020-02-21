#建立 bwa/samtools 索引
bwa index -a bwtsw Bacillus_subtilis.scaffolds.fasta
samtools faidx Bacillus_subtilis.scaffolds.fasta
#bwa 比对 > bam
bwa mem -t 4 -M Bacillus_subtilis.scaffolds.fasta Bacillus_subtilis.filt_R1.fastq.gz Bacillus_subtilis.filt_R2.fastq.gz | samtools view -@ 4 -bS > Bacillus_subtilis.bam
#bam 排序
samtools sort -@ 4 Bacillus_subtilis.bam > Bacillus_subtilis.sort.bam
rm Bacillus_subtilis.bam
#测序深度、基因组碱基含量统计
samtools depth Bacillus_subtilis.sort.bam > Bacillus_subtilis.depth
python3 depth_base_stat.py -g Bacillus_subtilis.scaffolds.fasta -d Bacillus_subtilis.depth -s depth_base.stat.txt -l 2000
#depth_GC 散点图
Rscript depth_GC_plot.r -i depth_base.stat.txt -o depth_GC