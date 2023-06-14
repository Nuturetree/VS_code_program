chromosomes=("Ghir_A01" "Ghir_A02" "Ghir_A03" "Ghir_A04" "Ghir_A05" "Ghir_A06" "Ghir_A07" "Ghir_A08" "Ghir_A09" "Ghir_A10" "Ghir_A11" "Ghir_A12" "Ghir_A13" "Ghir_D01" "Ghir_D02" "Ghir_D03" "Ghir_D04" "Ghir_D05" "Ghir_D06" "Ghir_D07" "Ghir_D08" "Ghir_D09" "Ghir_D10" "Ghir_D11" "Ghir_D12" "Ghir_D13")
python /public/home/xhhuang/program/pipeline/compartment/single_chr_interaction.py -b anthers_3000_abs.bed -m anthers_3000_iced.matrix -o ./ -YN N
for i in $(seq 0 25)
do
{
    h=`expr $i + 1`
    for j in $(seq $h 25)
    do
    {
        cat ${chromosome[$i]}.matrix ${chromosome[$j]}.matrix ${chromosome[$i]}_${chromosome[$j]}.matrix
        cat ${chromosome[$i]}_abs.bed ${chromosome[$j]}_abs.bed ${chromosome[$i]}_${chromosome[$j]}_abs.bed
        cat ../${chromosome[$i]}.biases ../${chromosome[$j]}.biases ${chromosome[$i]}_${chromosome[$j]}.biases
    }
    done
}
done
