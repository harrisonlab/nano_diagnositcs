# Copying results from scratch/projects to long term storage/backup areas and removing working files

# Crop Diversity
## Crop Diversity policy from the 01/04/2023 is to delete all files over 6 months old from the scratch area on an ongoing basis. Therefore everything in this directory will need to be moved or deleted.

### apps 31/03/2023
As apps will be kept indefinitely and are larger than 10G they have been moved to the projects directory. This will screw up all the path names in previous scripts and within many tools, which have not been changed at this time. COPY BACK TO SCRATCH AS NEEDED?
```bash
mv apps ~/projects/niab/theaven/.
```
### Genomes
In house genome assemblies were saved, downloaded genomes were not saved as they can be re-downloaded from source.
```bash
mv assembly ~/projects/niab/theaven/.
```
###  Alignments 07/09/2022
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
### reports
```bash
mkdir ~/projects/niab/theaven/reports
cp -Lr reports/* ~/projects/niab/theaven/reports/.
```
### analysis
This contains finles from phylogeny analysis, full BUSCO tables were not kept as they are large
This also contains orthogroup analysis files
```bash
mv analysis ~/projects/niab/theaven/.
mv gene_pred/busco_summaries ~/projects/niab/theaven/analysis/.
```
### gene_pred
In house genomes proteome, SecretomeP and blast results were saved
```bash
for result in $(ls -d gene_pred/P*/T*/codingquarry/rep_modeling/final); do
Dir=$(echo $result|cut -f2,3,4,5 -d '/')
echo $result
echo $Dir
mkdir -p ~/projects/niab/theaven/gene_pred/${Dir}
mv $result ~/projects/niab/theaven/gene_pred/${Dir}/.
done 
```
In house genomes predector results were saved
```bash
for result in $(ls -d gene_pred/*/*/predector_singularity3/results); do
Dir=$(echo $result|cut -f1,2,3,4 -d '/')
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp -Lr $result ~/projects/niab/theaven/$Dir/.
done 

#This is the minus-raspberry data:
for result in $(ls -d gene_pred/*/*/predector_singularity2/results); do
Dir=$(echo $result|cut -f1,2,3,4 -d '/')
echo $Dir
mkdir -p ~/projects/niab/theaven/$Dir
cp -Lr $result ~/projects/niab/theaven/$Dir/.
done 
```


Wider mildew clade proteome results were saved
```bash
for result in $(ls */*/gene_pred/braker/final/*final_genes_renamed.pep.fasta); do
Dir=$(echo $result|cut -f2,4 -d '/')
echo $result
echo $Dir
mkdir -p ~/projects/niab/theaven/gene_pred/mildewreannotation/${Dir}
mv $result ~/projects/niab/theaven/gene_pred/mildewreannotation/${Dir}/.
done 
```
Wider mildew clade secretomeP results were saved
```bash
for result in $(ls */*/gene_pred/braker/final/*secretome*); do
Dir=$(echo $result|cut -f2 -d '/')
echo $result
echo $Dir
mkdir ~/projects/niab/theaven/gene_pred/mildewreannotation/${Dir}/Secretomep
mv $result ~/projects/niab/theaven/gene_pred/mildewreannotation/${Dir}/Secretomep/.
done
```
Wider mildew clade blast results were saved
```bash
for result in $(ls */*/gene_pred/braker/final/*inblast*); do
Dir=$(echo $result|cut -f2 -d '/')
echo $result
echo $Dir
mkdir ~/projects/niab/theaven/gene_pred/mildewreannotation/${Dir}/braker
mv $result ~/projects/niab/theaven/gene_pred/mildewreannotation/${Dir}/braker/.
done
for result in $(ls */*/gene_pred/braker/final/*outblast*); do
Dir=$(echo $result|cut -f2 -d '/')
echo $result
echo $Dir
mkdir ~/projects/niab/theaven/gene_pred/mildewreannotation/${Dir}/braker
mv $result ~/projects/niab/theaven/gene_pred/mildewreannotation/${Dir}/braker/.
done
```
Wider mildew clade predector results were saved
```bash
#This also contained BUSCO results, and final annotation report files
for result in $(ls -d */*/gene_pred/predector/Prothint); do
Dir=$(echo $result|cut -f2,4 -d '/')
echo $result
echo $Dir
mkdir -p ~/projects/niab/theaven/gene_pred/mildewreannotation/${Dir}
mv $result ~/projects/niab/theaven/gene_pred/mildewreannotation/${Dir}/.
done 

for result in $(ls -d */*/gene_pred/predector/abinitio); do
Dir=$(echo $result|cut -f2,4 -d '/')
echo $result
echo $Dir
mkdir -p ~/projects/niab/theaven/gene_pred/mildewreannotation/${Dir}
mv $result ~/projects/niab/theaven/gene_pred/mildewreannotation/${Dir}/.
done 
```

# NIAB HPC