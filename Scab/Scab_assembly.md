# Scab_assembly
Documentation of analyses and commands used as part of the PhD project investigating next generation diagnostics
Note - all this work was performed in the directory:
/home/groups/harrisonlab/project_files/nano_diagnostics

## Test Assemblies
Test data generated as part of Tom Passey's PhD project was copied to test assembly methodologies:

## Copying data
Directories for miseq reads were made:
```bash
mkdir -p raw_dna/paired/v.inaequalis/172/F
mkdir -p raw_dna/paired/v.inaequalis/172/R
mkdir -p raw_dna/paired/v.inaequalis/007/F
mkdir -p raw_dna/paired/v.inaequalis/007/R
```
Files were copied from the following directories  into the respective directories made above:
```bash
cp /home/groups/harrisonlab/project_files/venturia/raw_dna/paired/v.inaequalis/007/F/007_S1_L001_R1_001.fastq.gz raw_dna/paired/v.inaequalis/007/F/.

cp /home/groups/harrisonlab/project_files/venturia/raw_dna/paired/v.inaequalis/007/R/007_S1_L001_R2_001.fastq.gz raw_dna/paired/v.inaequalis/007/R/.

cp /home/groups/harrisonlab/project_files/venturia/raw_dna/paired/v.inaequalis/172/F/172_S4_L001_R1_001.fastq.gz raw_dna/paired/v.inaequalis/172/F/.

cp /home/groups/harrisonlab/project_files/venturia/raw_dna/paired/v.inaequalis/172/R/172_S4_L001_R2_001.fastq.gz raw_dna/paired/v.inaequalis/172/R/.
```
Reads from pac-bio were also linked into this file system:
```bash
RawDatDir=/home/groups/harrisonlab/project_files/venturia/raw_dna/pacbio/v.inaequalis/172_pacbio/extracted
OutDir=raw_dna/pacbio/v.inaequalis/172/extracted

mkdir -p $OutDir

cp -s $RawDatDir/concatenated_pacbio.fastq $OutDir/.

```
## Data quality control
MiSeq data quality was visualised using fastqc:
```bash
for RawData in $(ls raw_dna/paired/v.inaequalis/*/*/*.fastq.gz); do
echo $RawData
ProgDir=/home/heavet/git_repos/tools/seq_tools/dna_qc
qsub $ProgDir/run_fastqc.sh $RawData
done
```

Trimming was performed on data to trim adapters from sequences and remove poor quality data. This was done with fastq-mcf. Trimming was performed on all isolates:
```bash
for EachRead in $(ls -d raw_dna/paired/*/*);
do
ProgDir=/home/heavet/git_repos/tools/seq_tools/rna_qc
IlluminaAdapters=/home/heavet/git_repos/tools/seq_tools/ncbi_adapters.fa
ReadsF=$(ls $EachRead/F/*.fastq*)
ReadsR=$(ls $EachRead/R/*.fastq*)
echo $ReadsF
echo $ReadsR
qsub $ProgDir/rna_qc_fastq-mcf.sh $ReadsF $ReadsR $IlluminaAdapters DNA
done
```

Data was visualised following trimming:
```bash
for TrimData in $(ls qc_dna/paired/*/*/*/*.fq.gz); do
ProgDir=/home/heavet/git_repos/tools/seq_tools/dna_qc
echo $TrimData;
qsub $ProgDir/run_fastqc.sh $TrimData
done
```

Sequencing coverage was estimated:
```bash
for TrimData in $(ls qc_dna/paired/*/*/*/*.fq.gz); do
ProgDir=/home/heavet/git_repos/tools/seq_tools/dna_qc;
echo $TrimData;
GenomeSz=72
OutDir=$(dirname $TrimData)
qsub $ProgDir/sub_count_nuc.sh $GenomeSz $TrimData $OutDir
done

tail -n1 -q qc_dna/paired/v.inaequalis/*/*/*_cov.txt | cat 
```

Find predicted coverage for these isolates:
```bash
for StrainDir in $(ls -d qc_dna/paired/*/*); do
Strain=$(basename $StrainDir)
printf "$Strain\t"
for File in $(ls qc_dna/paired/*/"$Strain"/*/*.txt); do
echo $(basename $File);
cat $File | tail -n1 | rev | cut -f2 -d ' ' | rev;
done | grep -v '.txt' | awk '{ SUM += $1} END { print SUM }'
done
```
Output of predicted coverage was:

For isolate 007 :    38.28

For isolate 172  :   36.2

## SPAdes assembly
Trimmed MiSeq reads were assembled using the program SPAdes:
```bash
  for StrainPath in $(ls -d qc_dna/paired/*/*); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    Strain=$(echo $StrainPath | rev | cut -f1 -d '/' | rev)
    Organism=$(echo $StrainPath | rev | cut -f2 -d '/' | rev)
    F_Read=$(ls $StrainPath/F/*.fq.gz)
    R_Read=$(ls $StrainPath/R/*.fq.gz)
    OutDir=assembly/spades/$Organism/$Strain
    echo $F_Read
    echo $R_Read
    qsub $ProgDir/submit_SPAdes.sh $F_Read $R_Read $OutDir correct 10
  done
```
Quast was used to assess the quality of genome assembly:
```bash
  ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    for Assembly in $(ls assembly/spades/*/*/filtered_contigs/contigs_min_500bp.fasta); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev)  
    OutDir=assembly/spades/$Organism/$Strain/filtered_contigs
    qsub $ProgDir/sub_quast.sh $Assembly $OutDir
  done
```
The results of quast were desplayed:
```bash
  for Assembly in $(ls assembly/spades/*/*/filtered_contigs/report.txt); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev);
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev);
    echo;
    echo $Organism;
    echo $Strain;
    cat $Assembly;
  done > assembly/quast_results.txt
```
Contigs were renamed in accordance with ncbi recommendations:
```bash
  ProgDir=~/git_repos/tools/seq_tools/assemblers/assembly_qc/remove_contaminants
  touch tmp.csv
  for Assembly in $(ls assembly/spades/*/*/filtered_contigs/contigs_min_500bp.fasta); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev)  
    OutDir=assembly/spades/$Organism/$Strain/filtered_contigs
    $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/contigs_min_500bp_renamed.fasta --coord_file tmp.csv
  done
  rm tmp.csv
```
As an addition test of assembly quality the program busco was used:
```bash
for Assembly in $(ls assembly/spades/*/*/filtered_contigs/contigs_min_500bp.fasta); do
Strain=$(echo $Assembly | rev | cut -f2 -d '/' | rev)
Organism=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
echo "$Organism - $Strain"
ProgDir=/home/heavet/git_repos/tools/gene_prediction/busco
BuscoDB=$(ls -d /home/groups/harrisonlab/dbBusco/ascomycota_odb9)
OutDir=gene_pred/busco/$Organism/$Strain/assembly
qsub $ProgDir/sub_busco3.sh $Assembly $BuscoDB $OutDir
done
```

The assembly was polished usinng Pilon:
```bash
for Assembly in $(ls assembly/spades/*/*/filtered_contigs/contigs_min_500bp.fasta); do
  Organism=v.inaequalis
  Strain=172
  IlluminaDir=$(ls -d qc_dna/paired/$Organism/$Strain)
  TrimF1_Read=$IlluminaDir/F/172_S4_L001_R1_001_trim.fq.gz
  TrimR1_Read=$IlluminaDir/R/172_S4_L001_R2_001_trim.fq.gz
  OutDir=assembly/spades/$Organism/$Strain/polished_repeat
  ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/pilon
  qsub $ProgDir/sub_pilon.sh $Assembly $TrimF1_Read $TrimR1_Read $OutDir
done
```

## Canu Assembly
PacBio reads were assembled using the program Canu, genome size estimate from MiSeq reads was used:
```bash
Reads=$(ls raw_dna/pacbio/*/*/extracted/concatenated_pacbio.fastq)
GenomeSz="70m"
Strain=$(echo $Reads | rev | cut -f3 -d '/' | rev)
Organism=$(echo $Reads | rev | cut -f4 -d '/' | rev)
Prefix="$Strain"_canu
OutDir="assembly/canu/$Organism/$Strain/70m"
ProgDir=~/git_repos/tools/seq_tools/assemblers/canu
qsub $ProgDir/submit_canu.sh $Reads $GenomeSz $Prefix $OutDir
```
Quast was used to assess the quality of genome assembly:
```bash
ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
for Assembly in $(ls assembly/canu/v.inaequalis/172/70m/172_canu.contigs.fasta); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev)  
    OutDir=assembly/canu/$Organism/$Strain/70m
    qsub $ProgDir/sub_quast.sh $Assembly $OutDir
done
```
As an addition test of assembly quality the program busco was used:
```bash
for Assembly in $(ls assembly/canu/v.inaequalis/172/70m/172_canu.contigs.fasta); do
Strain=$(echo $Assembly | rev | cut -f2 -d '/' | rev)
Organism=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
echo "$Organism - $Strain"
ProgDir=/home/heavet/git_repos/tools/gene_prediction/busco
BuscoDB=$(ls -d /home/groups/harrisonlab/dbBusco/ascomycota_odb9)
OutDir=gene_pred/busco/$Organism/$Strain/assembly
qsub $ProgDir/sub_busco3.sh $Assembly $BuscoDB $OutDir
done
```

The assembly was polished usinng Pilon:
```bash
for Assembly in $(ls assembly/canu/v.inaequalis/172/70m/172_canu.contigs.fasta); do
  Organism=v.inaequalis
  Strain=172
  IlluminaDir=$(ls -d qc_dna/paired/$Organism/$Strain)
  TrimF1_Read=$IlluminaDir/F/172_S4_L001_R1_001_trim.fq.gz
  TrimR1_Read=$IlluminaDir/R/172_S4_L001_R2_001_trim.fq.gz
  OutDir=assembly/Canu/$Organism/$Strain/polished_repeat
  ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/pilon
  qsub $ProgDir/sub_pilon.sh $Assembly $TrimF1_Read $TrimR1_Read $OutDir
done
```

## SMART denovo
An assembly was also performed using the program SMARTdenovo, with the objective of comparing the assembly results from the two programs; Canu and SMARTdenovo.

```bash
for CorrectedReads in $(ls assembly/canu/v.inaequalis/172/70m/172_canu.trimmedReads.fasta.gz); do
Organism=$(echo $CorrectedReads | rev | cut -f3 -d '/' | rev)
Strain=$(echo $CorrectedReads | rev | cut -f2 -d '/' | rev)
Prefix="$Strain"_smartdenovo
OutDir=assembly/SMARTdenovo/$Organism/"$Strain"
ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/SMARTdenovo
qsub $ProgDir/sub_SMARTdenovo.sh $CorrectedReads $Prefix $OutDir
done
```
quast was used to assess the quality of the SMARTdenovo assembly. 
```bash
ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
for Assembly in $(ls assembly/SMARTdenovo/172/70m/70m_smartdenovo.dmo.lay.utg); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev)  
    OutDir=$(dirname $Assembly)
    qsub $ProgDir/sub_quast.sh $Assembly $OutDir
done
```
The results of Canu and SMARTdenovo quality assessment indicate that the Canu assembly is of higher quality.

As an addition test of assembly quality the program busco was used:
```bash
for Assembly in $(ls assembly/SMARTdenovo/172/70m/70m_smartdenovo.dmo.lay.utg); do
Strain=$(echo $Assembly | rev | cut -f2 -d '/' | rev)
Organism=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
echo "$Organism - $Strain"
ProgDir=/home/heavet/git_repos/tools/gene_prediction/busco
BuscoDB=$(ls -d /home/groups/harrisonlab/dbBusco/ascomycota_odb9)
OutDir=gene_pred/busco/$Organism/$Strain/assembly
qsub $ProgDir/sub_busco3.sh $Assembly $BuscoDB $OutDir
done
```

The assembly was polished usinng Pilon:
```bash
for Assembly in $(ls assembly/SMARTdenovo/172/70m/70m_smartdenovo.dmo.lay.utg); do
  Organism=v.inaequalis
  Strain=172
  IlluminaDir=$(ls -d qc_dna/paired/$Organism/$Strain)
  TrimF1_Read=$IlluminaDir/F/172_S4_L001_R1_001_trim.fq.gz
  TrimR1_Read=$IlluminaDir/R/172_S4_L001_R2_001_trim.fq.gz
  OutDir=assembly/SMARTdenovo/$Organism/$Strain/polished_repeat
  ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/pilon
  qsub $ProgDir/sub_pilon.sh $Assembly $TrimF1_Read $TrimR1_Read $OutDir
done
```