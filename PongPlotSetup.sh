#ADMIXTURE PONG plotting



#create filemap file

ls -1  Qfiles | sort -V >tmp #gets sorted list of Q files
sed 's/^/Qfiles\//' tmp >col3
sed 's/dat3-indfiltered.maf01.tmp.hap.pruned./K/' tmp  | sed 's/.Q./-/' >col1
 sed -E 's/K([0-9].*)-.*/\1/' col1 > col2 


paste col1 col2 col3 >filemap 
rm col* tmp 

# create ind2pop 


cat dat3-indfiltered.maf01.tmp.hap.pruned.fam | while read line 
do 
pop=$(echo $line | cut -d" " -f1 )
ind=$(echo $line | cut -d" " -f2 )

if [[ $pop == "aDNA" ]]
then 
grep $ind ../dat3archvar/ind2pop
 else 
 echo $pop 
fi
done >ind2pop 


