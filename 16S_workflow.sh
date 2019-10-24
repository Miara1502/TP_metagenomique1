#!/bin/bash

cd soft
./JarMaker.sh AlienTrimmer.java 
java -jar AlienTrimmer.jar
cd ..

mkdir Cleaning-Trimming-outputs

gunzip *.gz

# Récuperer le nom des reads
for i in $(ls fastq/*_R1.fastq);do
echo $i;
Read1="$i";
echo $nameR1;
Read2=$(echo $i | sed s/R1/R2/g);
echo $Read2;


