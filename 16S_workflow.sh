#!/bin/bash

cd soft
./JarMaker.sh AlienTrimmer.java 
java -jar AlienTrimmer.jar
cd ..

mkdir result1

gunzip *.gz

# Récuperer le nom des reads
for i in $(ls fastq/*_R1.fastq);do
echo $i;
Read1="$i";
echo $Read1;
Read2=$(echo $i | sed s/R1/R2/g);
echo $Read2;

# fastqc
java -jar ./soft/AlienTrimmer.jar -if $Read1 -ir $Read2 -c ./databases/contaminants.fasta -q 20 -of ./result1/$(basename $Read1) -or ./result1/$(basename $Read2)
done

#Merging des Read1 et Read2
mkdir result_merge

for i in $(ls result1/*_R1.fastq);do
vsearch --fastq_mergepairs $i --reverse ${i:0:-9}"_R2.fastq" --fastqout ./result_merge/$(basename ${i:0:-9})".fasta" --label_suffix $(basename ${i:0:-9})
done

for i in $(ls result_merge/*.fasta);do
cat $i | sed -e 's/ //g' > result_merge/amplicon.fasta
done


#CLUSTERISATION : 
# 1° table d'abondance : alignement des amplicons contre les OTU
# rentrer un amplicon.fasta et sort une deduplication
vsearch --derep_fulllength ./result_merge/amplicon.fasta --sizeout --minuniquesize 10 --output ./result_merge/deduplication.fasta

# Assemblage DE NOVO
vsearch --uchime_denovo ./result_merge/amplicon.fasta --nonchimeras  ./result_merge/amplicon_nonchimeras.fasta








