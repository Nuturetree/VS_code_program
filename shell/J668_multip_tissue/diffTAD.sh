#!bin/bash
samples=("anthers" "cotyledon" "ovules" "fiber_5DPA" "fiber_10DPA" "fiber_20DPA" "hypocotyl" "leaf" "petals" "radicle" "root" "stem" "stigma")
chrN=("Ghir_A01" "Ghir_A02" "Ghir_A03" "Ghir_A04" "Ghir_A05" "Ghir_A06" "Ghir_A07" "Ghir_A08" "Ghir_A09" "Ghir_A10" "Ghir_A11" "Ghir_A12" "Ghir_A13" "Ghir_D01" "Ghir_D02" "Ghir_D03" "Ghir_D04" "Ghir_D05" "Ghir_D06" "Ghir_D07" "Ghir_D08" "Ghir_D09" "Ghir_D10" "Ghir_D11" "Ghir_D12" "Ghir_D13")
number=${#sample[*]}

for s1 in $(seq 0 ${number})
do
{
    h=$(expr $s1 + 1)
    for s2 in $(seq ${h} ${number});
    do
    {
        outdir="${samples[$s1]}_${samples[$s2]}"
        outfile="${samples[$s1]}_${samples[$s2]}_diffTAD.txt"
        mtx_f1="rawdata/"${samples[$s1]}"_20000.matrix"
        mtx_f2="rawdata/"${samples[$s2]}"_20000.matrix"
        abs_f="rawdata_20Kb_abs.bed"
        
        if [ ! -d ${outdir} ]; then
            mkdir ${outdir}
        fi
        for c in ${chrN[*]};
        do
        {
            sed -i "s/chrname/${c}/g" run_TADreg.sh
            bsub -q high -e %J.err -o %J.out -J TADreg -n 4 "Rscript run_TADreg.sh ${mtx_f1} ${mtx_f2} ${abs_f} ${outdir}/${outfile}"
            sed -i "s/${c}/chrname/g" run_TADreg.sh
        }
        done
    }
    done
}
done