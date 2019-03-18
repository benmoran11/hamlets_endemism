#!/usr/bin/env bash

WIN=$2;
STEP=$3;
OUT=$4;
VAL=$5;

echo -e "CHROM\tBIN_START\tBIN_END\tN_SNP\tAVG_POS\tBIN_RANK\tBIN_NR\tSNP_DENS\tAVG_${VAL}" > $OUT.txt

for j in {01..24}; do
	LG="LG"$j;
	IN=$( echo $1 | sed "s/XXtagXX/$LG/g" );
	cut -f 2,3,4 $IN | \
	awk -v lg=$LG -v "OFS=\t" '{print lg,$1,$2,$3}' | \
	awk -v OFS="\t" -v w=$WIN -v s=$STEP -v r=$j 'BEGIN{window=w;slide=s;g=0;OL=int(window/slide);}
{if(NR>1){g=int(($2-1)/slide)+1;{for (i=0;i<=OL-1;i++){if(g-i >0){A[g-i]+=$2; B[g-i]++;C[g-i]+=$4;G[g-i]=g-i;H[g-i]=$1;}}}};}
END{for(i in A){print H[i],(G[i]-1)*slide,(G[i]-1)*slide+window,B[i],A[i]/B[i],G[i],k+1,B[i]/window,C[i]/B[i];k++}}' >> $OUT.txt
done

gzip $OUT.txt