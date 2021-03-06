#!/bin/bash

#EXTRACTS SINGLE POSITIONS (DEFINED IN PLINK .BIM FILE) FROM REFERENCE FASTA SEQUENCE (OR ANY FASTA SEQUENCE)
#should be run as command bimfile reference

cat $1.bim | while read line  
do 
chr=$(echo $line | cut -d" "  -f1 ); pos=$(echo $line | cut -d" "  -f4 )
allele=$(samtools faidx $2 ${chr}:${pos}-${pos} | tail -n1)
if [ ! -z $allele ]; then 
echo "$allele" >>refallele
else echo "empty" >>refallele
fi
done
