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
echo $nameR1;
Read2=$(echo $i | sed s/R1/R2/g);
echo $Read2;

# fastqc
java -jar ./soft/AlienTrimmer.jar -if $Read1 -ir $Read2 -c ./databases/contaminants.fasta -q 20 -of ./result1/$(basename $Read1) -or ./result1/$(basename $Read2)
done

#Merging 


