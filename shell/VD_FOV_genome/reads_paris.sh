for t in 1min 5min 10min 30min 90min 180min 12h
do
{
    for n in mock Fov7
    do
    {
        for i in 1 2
        do
        {
            samp_n='Read/J668'_${n}_${t}${i}_read.bed
            out_f='Read/J668_'${t}_read_pair.bed
            if [ ! -f ${out_f} ]; then
                awk '{print $4, $NF}' ${samp_n} | sort -k1> ${out_f}
            else
                cat ${samp_n} | sort -k4 | awk '{print $NF}' > test.txt
                paste -d "\t" ${out_f} test.txt > test_tmp.txt
                mv test_tmp.txt ${out_f}
                rm test.txt
            fi
        }
        done
    }
    done
}
done