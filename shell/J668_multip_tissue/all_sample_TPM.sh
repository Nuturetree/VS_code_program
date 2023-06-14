#!/bin/bash
for n in anthers cotyledon fiber_10DPA fiber_20DPA fiber_5DPA hypocotyl leaf ovules petals radicle root stem stigma
do
{
    for i in rep1 rep2
    do
    {
        cat ${n}_${i}_FPKM_TPM.txt | sort -k1 | awk -F "\t" '{print $NF}' > test.txt 
        paste -d "\t" J668_all_tissue_TPM.txt test.txt > test_tmp.txt
        mv test_tmp.txt J668_all_tissue_TPM.txt
    }
    done
}
done
rm test.txt 