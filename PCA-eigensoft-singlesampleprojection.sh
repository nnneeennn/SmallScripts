SAM=SampleID
DATA=dat4_global_my



mkdir $SAM 
cd $SAM 



grep $SAM ../${DATA}.fam >list.samples
grep -v aDNA ../${DATA}.fam >>list.samples
grep $SAM ../${DATA}.fam >list.$SAM

plink --bfile ../${DATA} --keep list.$SAM --make-bed --out $SAM
plink --bfile $SAM --geno 0 --make-bed --out $SAM.nomiss 

 rm $SAM.{bed,bim,fam}
 rm $SAM.nomiss.{bed,fam}


 plink --bfile ../${DATA} --keep list.samples --extract $SAM.nomiss.bim --make-bed --out $SAM.filtered

echo "genotypename: $SAM.filtered.bed #inputfile.ped,bed
snpname:      $SAM.filtered.bim #inputfile.map,bim
indivname:    $SAM.filtered.fam #inputfile.ped ,fam
evecoutname:  $SAM.filtered.evec #output.evec 
evaloutname:  $SAM.filtered.eval #output.eval
killr2: NO
numoutlieriter: 0" >parfile.$SAM

awk '$6="0" {print $0}' $SAM.filtered.fam  > tmp &&mv tmp $SAM.filtered.fam 

sbatch -A snic2020-15-287 -p core -n 1 -t 2-0:00:00 -J PCA_$SAM ../job_PCA.sh $SAM 
cd .. 
