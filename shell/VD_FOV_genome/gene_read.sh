module load BEDTools
#BSUB -q smp
#BSUB -e %J.err
#BSUB -o %J.out
#BSUB -R span[hosts=1]
#BSUB -J gene_read

for n in J668 glr19 other
do
{
    if [ ${n} == 'J669' ]
    then
        for tag in mock Fov7 v991
            do
            {
                for t in 1min 5min 10min 30min 90min 180min 12h
                do
                {
                    for s in 1 2
                    do
                    {
                        samp_n='RNA_Seq/'${n}_${tag}_${t}${s}_sorted.bam
                        bed_out_n='RNA_Seq/'${n}_${tag}_${t}${s}_sorted.bed
                        out_n='Read/'${n}_${tag}_${t}${s}_read.bed
                        bedtools bamtobed -i ${samp_n} > ${bed_out_n}
                        bedtools coverage -a all_gene_sort.bed2 -b ${bed_out_n} | awk -v OFS="\t" '{print $1,$2,$3,$4,$5,$6,$7}' > ${out_n}                         
                    }
                    done
                } 
                done
            }
            done
    elif [ ${n}=='glr19' ]
    then
            for tag in mock Fov7
            do
            {
                for t in 1min 5min 10min 30min 90min 180min 12h
                do
                {
                    for s in 1 2
                    do
                    {
                        samp_n='RNA_Seq/'${n}_${tag}_${t}${s}_sorted.bam
                        bed_out_n='RNA_Seq/'${n}_${tag}_${t}${s}_sorted.bed
                        out_n='Read/'${n}_${tag}_${t}${s}_read.bed
                        bedtools bamtobed -i ${samp_n} > ${bed_out_n}
                        bedtools coverage -a all_gene_sort.bed2 -b ${bed_out_n} | awk -v OFS="\t" '{print $1,$2,$3,$4,$5,$6,$7}' > ${out_n}                        
                    }
                    done
                } 
                done
            }
            done
    else
            for k in J668 glr19
            do
            {
                for j in 1 2
                do
                {
                    samp_n='RNA_Seq/'${k}_0h${j}_sorted.bam
                    bed_out_n='RNA_Seq/'${k}_0h${j}_sorted.bed
                    out_n='Read/'${k}_0h${j}_read.bed
                    bedtools bamtobed -i ${samp_n} > ${bed_out_n}
                    bedtools coverage -a all_gene_sort.bed2 -b ${bed_out_n} | awk -v OFS="\t" '{print $1,$2,$3,$4,$5,$6,$7}' > ${out_n}
                }
                done
            }
            done

    fi
}
done
