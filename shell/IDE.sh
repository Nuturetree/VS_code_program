for d in 0DPA 5DPA 10DPA 20DPA
do
{
 for i in one two
 do
 {
  for j in poor rich
  do
  {
    for c in Gbar_A01 Gbar_A02 Gbar_A03 Gbar_A04 Gbar_A05 Gbar_A06 Gbar_A07 Gbar_A08 Gbar_A09 Gbar_A10 Gbar_A11 Gbar_A12 Gbar_A13 Gbar_D01 Gbar_D02 Gbar_D03 Gbar_D04 Gbar_D05 Gbar_D06 Gbar_D07 Gbar_D08 Gbar_D09 Gbar_D10 Gbar_D11 Gbar_D12 Gbar_D13 
    do
    {
     python ~/programs/interaction_decay_exponents.py 2 ./${d}/${c}_${j}_${i}.matrix 10000 ./IDE/${d}/${c}_${j}_${i}_IDE.txt
    }
    done
  }
  done
 }
 done
}
done