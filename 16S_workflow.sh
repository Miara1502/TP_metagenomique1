#!/bin/bash

cd soft
./JarMaker.sh AlienTrimmer.java 
java -jar AlienTrimmer.jar
cd ..

mkdir Cleaning-Trimming-outputs

gunzip *.gz


