config_f=$1
# Determine if a folder needs to be created
if [! -d "data_trim"]; then
mkdir data_trim
fi
if [! -d "bowtie2"]; then
mkdir bowtie2
fi
if [! -d "peaks"]; then
mkdir peaks
fi
if [! -d "script"]; then
mkdir script
fi
while read line
do
    sample=`echo ${line}| cut -d " " -f 1`
    histone=`echo ${line}| cut -d " " -f 2`
    repeat=`echo ${line}| cut -d " " -f 3`
    if [! -d "peaks/${sample}"]; then
    mkdir "peaks/${sample}"
    fi
    # setting parameters
    name="${sample}_${histone}_${repeat}"
    fastq1="../rawdata/${sample}/${name}_R1.fq.gz"
    fastq2="../rawdata/${sample}/${name}_R2.fq.gz"
    filter_fq1="../data_trim/${name}_R1_val_1.fq.gz"
    filter_fq2="../data_trim/${name}_R2_val_1.fq.gz"
    output_f="script/${name}.sh"
    node='q2680v2'
    n_cpu="20"
    peaks_path="../peaks/${sample}"
    index_path="/public/home/xhhuang/biodate/Ghir/bowtie/Ghir"
    genome_path=


    echo "module load SAMtools" > ${output_f}
    echo "module load MACS2" >> ${output_f}
    echo "#BSUB -q ${node}" >> ${output_f}
    echo "#BSUB -n ${n_cpu}" >> ${output_f}
    echo "#BSUB -e %J.err" >> ${output_f}
    echo "#BSUB -o %J.out" >> ${output_f}
    echo "#BSUB -J macs2" >> ${output_f}

    echo "trim_galore -q 20 --phred33 --stringency 3 --length 20 --paired --gzip --trim-n ${fastq1} ${fastq2} -o ../data_trim" >> ${output_f}
    echo "bowtie2 -p 20 -x ${index_path} -1 ../data_trim/${name}_val_1.fq.gz -2 ../data_trim/${name}_val_1.fq.gz | samtools sort -@20 -o ../bowtie2/${name}.sorted.bam > ../bowtie2/${name}.log 2> ../bowtie2/${name}.err" >> ${output_f}
    echo "samtools rmdup ../bowtie2/${name}.sorted.bam ../bowtie2/${name}.sorted.rmdup.bam" >> ${output_f}
    echo "samtools view -bh -q 30 ../bowtie2/${name}.sorted.rmdup.bam -o ../bowtie2/${name}.sorted.rmdup.q30.bam" >> ${output_f}
    echo "rm ../bowtie2/${name}.sorted.rmdup.bam" "../bowtie2/${name}.sorted.bam" >> ${output_f}
    echo "macs2 callpeak -t ../bowtie2/${name}.sorted.rmdup.bam -c ../bowtie2/${sample}_input_input.sorted.rmdup.bam -f BAM -g 2300000000 -n ${peaks_path}/${name} -m FE" >> ${output_f}
    echo "macs2 bdgcmp -t ${peaks_path}/${name}_treat_pileup.bdg -c ${peaks_path}/${name}_control_lambda.bdg -o ${peaks_path}/${name}_bdgcmp.bed -m FE " >> ${output_f}
    echo "grep -v 'Scaff' ${peaks_path}/${name}_bdgcmp.bed > ${peaks_path}/${name}_bdgcmp_noscaff.bed" >> ${output_f}
    echo "sort -k1,1 -k2,2n ${peaks_path}/${name}_bdgcmp_noscaff.bed > ${peaks_path}/${name}_bdgcmp_noscaff_sort.bed" >> ${output_f}
    echo "macs2 bdgopt -i ${peaks_path}/${name}_bdgcmp_noscaff_sort.bed -p 0.254 -o ${peaks_path}/${name}_bdgcmp_noscaff_sort_bdgopt.bed" >> ${output_f}
    echo "sed -i '1d' ${peaks_path}/${name}_bdgcmp_noscaff_sort_bdgopt.bed" >> ${output_f}
    echo "sort -k1,1 -k2,2n ${peaks_path}/${name}_bdgcmp_noscaff_sort_bdgopt.bed > ${peaks_path}/${name}_bdgcmp_noscaff_sort2_bdgopt.bed" >> ${output_f}
    echo "bedGraphToBigWig ${peaks_path}/${name}_bdgcmp_noscaff_sort2_bdgopt.bed ${genome_path} ${peaks_path}/${name}_bdgcmp_noscaff_bdgopt.bw" >> ${output_f}
    echo "rm ${peaks_path}/${name}_bdgcmp_noscaff.bed ${peaks_path}/${name}_bdgcmp_noscaff_sort.bed ${peaks_path}/${name}_bdgcmp_noscaff_sort_bdgopt.bed" >> ${output_f}
done < ${config_f}




