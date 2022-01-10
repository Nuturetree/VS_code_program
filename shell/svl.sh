for d in 0DPA 5DPA 10DPA 20DPA
do
{
 for i in one two
 do
 {
  for j in poor rich
  do
  {
   cat ${d}_${j}_${i}_SVL.txt | awk -v D=${d} -v I=${i} -v J=${j} -v OFS="\t" '{print $1,$2,$3,$4,D,I,J}' >> all_day_poor_rich_SVL.txt
  }
  done
 }
 done
}
done