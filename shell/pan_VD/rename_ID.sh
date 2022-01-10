names=cat(VD_filename.txt)
for n in names
do
{
    fn=${n##*/}
    gzip -d test/${fn}.gvcf.gz
    sed -i 's/data_trim${fn}/'${fn}'/' test/${fn}.gvcf
    gzip test/${fn}.gvcf
}
done



names=cat(VD_filename.txt)
for n in names
do
{
    bsub -q q2680v2 -e %J.err -o %J.out -R span[hosts=1] -J renam "sh renam.sh ${n}"
}
done