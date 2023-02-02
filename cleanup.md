# Copying results from scratch/projects to long term storage/backup areas and removing working files

# Crop Diversity

Alignments 07/09/2022
```bash
#Text logs of Bowtie alignments saved. These alignments were performed to find stats of P.aphanis and P.leucotricha vs host plants and other public mildew genomes, there are no .sam or .bam files here to be used in further analysis, eg. unaligned to host therefore nothing else was saved.
for result in $(ls alignment/*/*/bowtie2/*.txt); do
Dir=$(dirname $result)
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp $result ~/projects/niab/theaven/$Dir/.
done 
rm -r alignment/*/*/bowtie2

#Text logs of Bowtie alignments and coverage were saved. These are alignments of raw reads vs complete assemblies, output used in coverage calculations therefore .bam files were also saved.
for result in $(ls alignment/*/bowtie2/*.txt); do
Dir=$(dirname $result)
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp $result ~/projects/niab/theaven/$Dir/.
done 
for result in $(ls alignment/*/bowtie2/*bam.index); do
Dir=$(dirname $result)
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp $result ~/projects/niab/theaven/$Dir/.
done 
rm -r alignment/*/bowtie2

#KAT plots can be regenerated from -main.max files, these were saved along with plots themselves.
for result in $(ls alignment/*/*/kat/*/*-main.mx); do
Dir=$(dirname $result)
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp $result ~/projects/niab/theaven/$Dir/.
done 
for result in $(ls alignment/*/*/kat/*/*.png); do
Dir=$(dirname $result)
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp $result ~/projects/niab/theaven/$Dir/.
done 
rm -r alignment/*/*/kat

#.bam files produced from star alignments of rna versus genome assemblies are used in gene prediction, these were saved
for result in $(ls alignment/*/*/star/*/*/*.bam); do
Dir=$(dirname $result)
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp $result ~/projects/niab/theaven/$Dir/.
done 
rm -r alignment/*/*/star

#.sam files from alignments are the starting point for SNP prediciton, .bam version take up less space, these were saved.
for result in $(ls alignment/venturia/inaequalis/LLimon/bowtie/THSC*/passey/*aligned.bam); do
Dir=$(dirname $result)
Isolate=$(echo $result | cut -d '/' -f6)
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
echo ~/projects/niab/theaven/$Dir/$(echo $Isolate)_$(basename $result)
cp $result ~/projects/niab/theaven/$Dir/$(echo $Isolate)_$(basename $result)
done 
rm -r alignment/venturia/inaequalis/LLimon/bowtie/THSC*

#those unaligned reads are from alignments to the host are carried forward for assembly, these were saved along with bowtie run logs
for result in $(ls alignment/blumeria/graminis/secalis/*/bowtie2/rye/*fq.gz); do
Dir=$(dirname $result)
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp $result ~/projects/niab/theaven/$Dir/.
done 
for result in $(ls alignment/blumeria/graminis/secalis/*/bowtie2/rye/*.txt); do
Dir=$(dirname $result)
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp $result ~/projects/niab/theaven/$Dir/.
done 
rm -r alignment/blumeria/graminis/secalis/*/bowtie2

#KAT plots can be regenerated from -main.max files, these were saved along with plots themselves.
for result in $(ls alignment/*/*/*/*/kat/*-main.mx); do
Dir=$(dirname $result)
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp $result ~/projects/niab/theaven/$Dir/.
done 
for result in $(ls alignment/*/*/*/*/kat/*.png); do
Dir=$(dirname $result)
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp $result ~/projects/niab/theaven/$Dir/.
done 
rm -r alignment/*/*/*/*/kat

#Text logs of Bowtie alignments saved. 
for result in $(ls alignment/Podosphaera/*/*/*/*/*/*.txt); do
Dir=$(dirname $result)
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp $result ~/projects/niab/theaven/$Dir/.
done 
rm -r alignment/Podosphaera/*/*/*/bowtie2
```
gene_pred
```bash
#In house genomes predector results were saved
for result in $(ls -d gene_pred/*/*/predector_singularity3/results); do
Dir=$(echo $result|cut -f1,2,3,4 -d '/')
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp -Lr $result ~/projects/niab/theaven/$Dir/.
done 


```

# NIAB HPC