module load SAMtools
module load hisat2
module load StringTie
rawdata_dir='/public/home/xhhuang/Rawdata/VD_FOV/RNA_seq'
for treatment in mock Fov7 v991
do
{
    for times in 1min 5min 10min 12min 30min 90min 180min 
    do
    {
        for rep in 1 2
        do
        {
            samples=glr19_${treatment}_${times}${rep}
            hisat2 -x /public/home/xhhuang/biodate/Ghir/Ghir_hisat2_index/Ghirsutum_genome --trim5 2 --trim3 5 --max-intronlen 100000 -1 ${rawdata_dir}/${samples}_R1.fastq.gz -2 ${rawdata_dir}/${samples}_R2.fastq.gz -p 20 | samtools view -bS -q 25 -@ 20 -o ./bam/${samples}.bam > ./bam/${samples}.log 2> ./    bam/${samples}.err
            samtools sort ./bam/${samples}.bam -o ./bam/${samples}_sorted.bam -@ 20
            stringtie ./bam/${samples}_sorted.bam -p 20 --rf -e -G /public/home/xhhuang/biodate/Ghir/Ghir_hisat2_index/Ghirsutum_gene_model.gff3 -o stringtie/${samples}_stringtie.txt -A stringtie/${samples}_abund.tab -b stringtie/${samples}_Ballgown_InputData
            awk -v OFS="\t" '{print $1,$3,$5,$6,$8,$9}' stringtie/${samples}_abund.tab > FPKM/${samples}_FPKM_TPM.txt

        }
        done
    }
    done
}
done