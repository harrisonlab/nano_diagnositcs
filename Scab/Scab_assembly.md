This pipeline was performed on the old NPC GridEngine system. The files are still available (28/02/2020) within the projects/oldhome/ folder of the new SLURM system which contains a copy of the old home directory.



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
OutDir=gene_pred/busco/$Organism/$Strain/assembly/spades
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
  ProgDir=/home/heavet/git_repos/tools/DIY
  qsub $ProgDir/TCHPilon.sh $Assembly $TrimF1_Read $TrimR1_Read $OutDir
done
```
Quast was used to assess the quality of the polished assembly:
```bash
ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
for Assembly in $(ls /home/groups/harrisonlab/project_files/nano_diagnostics/assembly/spades/v.inaequalis/172/70m/polished_repeat/pilon_1.fasta); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev)  
    OutDir=assembly/spades/v.inaequalis/172/70m/polished_repeat
    qsub $ProgDir/sub_quast.sh $Assembly $OutDir 200
done
```

changing profile:
```bash
cp /home/armita/generic_profiles/2019-03-25/.generic_profile ~/.profile
```

KAT was used to assess the completeness of the SPAdes assembly:
```bash
for Assembly in $(ls assembly/spades/v.inaequalis/172/70m/polished_repeat/pilon_1.fasta); do
  Strain=$(echo $Assembly| rev | cut -d '/' -f4 | rev | sed 's/_v2//g')
  Organism=$(echo $Assembly | rev | cut -d '/' -f5 | rev)
  echo "$Organism - $Strain"
  IlluminaDir=$(ls -d qc_dna/paired/*/$Strain)
  ReadsF=$(ls $IlluminaDir/F/172_S4_L001_R1_001_trim.fq.gz)
  ReadsR=$(ls $IlluminaDir/R/172_S4_L001_R2_001_trim.fq.gz)
  echo "$ReadsF"
  echo "$ReadsR"
  OutDir=assembly/spades/$Organism/$Strain/70m/kat
  Prefix="172_repeat_masked"
  ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/assemblers/assembly_qc/kat
  qsub $ProgDir/sub_kat.sh $Assembly $ReadsF $ReadsR $OutDir $Prefix
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
As an additional test of assembly quality the program busco was used:
```bash
for Assembly in $(ls assembly/canu/v.inaequalis/172/70m/172_canu.contigs.fasta); do
Strain=$(echo $Assembly | rev | cut -f2 -d '/' | rev)
Organism=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
echo "$Organism - $Strain"
ProgDir=/home/heavet/git_repos/tools/gene_prediction/busco
BuscoDB=$(ls -d /home/groups/harrisonlab/dbBusco/ascomycota_odb9)
OutDir=gene_pred/busco/$Organism/$Strain/assembly/canu
qsub $ProgDir/sub_busco3.sh $Assembly $BuscoDB $OutDir
done
```

The assembly was polished using Pilon:
```bash
for Assembly in $(ls assembly/canu/v.inaequalis/172/70m/172_canu.contigs.fasta); do
  Organism=v.inaequalis
  Strain=172
  IlluminaDir=$(ls -d qc_dna/paired/$Organism/$Strain)
  TrimF1_Read=$IlluminaDir/F/172_S4_L001_R1_001_trim.fq.gz
  TrimR1_Read=$IlluminaDir/R/172_S4_L001_R2_001_trim.fq.gz
  OutDir=assembly/canu/$Organism/$Strain/polished_repeat
  ProgDir=/home/heavet/git_repos/tools/DIY
  qsub $ProgDir/TCHPilon.sh $Assembly $TrimF1_Read $TrimR1_Read $OutDir
done
```

Quast was used to assess the quality of the polished assembly:
```bash
ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
for Assembly in $(ls /home/groups/harrisonlab/project_files/nano_diagnostics/assembly/canu/v.inaequalis/172/70m/polished_repeat/pilon_1.fasta); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev)  
    OutDir=assembly/canu/v.inaequalis/172/70m/polished_repeat
    qsub $ProgDir/sub_quast.sh $Assembly $OutDir
done
```

KAT was used to assess the completeness of the canu assembly:
```bash
for Assembly in $(ls assembly/canu/v.inaequalis/172/70m/polished_repeat/pilon_1.fasta); do
  Strain=$(echo $Assembly| rev | cut -d '/' -f4 | rev | sed 's/_v2//g')
  Organism=$(echo $Assembly | rev | cut -d '/' -f5 | rev)
  echo "$Organism - $Strain"
  IlluminaDir=$(ls -d qc_dna/paired/*/$Strain)
  ReadsF=$(ls $IlluminaDir/F/172_S4_L001_R1_001_trim.fq.gz)
  ReadsR=$(ls $IlluminaDir/R/172_S4_L001_R2_001_trim.fq.gz)
  echo "$ReadsF"
  echo "$ReadsR"
  OutDir=assembly/canu/$Organism/$Strain/70m/kat
  Prefix="172_repeat_masked"
  ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/assemblers/assembly_qc/kat
  qsub $ProgDir/sub_kat.sh $Assembly $ReadsF $ReadsR $OutDir $Prefix
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
OutDir=gene_pred/busco/$Organism/$Strain/assembly/SMARTdenovo
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
  ProgDir=/home/heavet/git_repos/tools/DIY
  qsub $ProgDir/TCHPilon.sh $Assembly $TrimF1_Read $TrimR1_Read $OutDir
done
```
Quast was used to assess the quality of the polished assembly:
```bash
ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
for Assembly in $(ls /home/groups/harrisonlab/project_files/nano_diagnostics/assembly/SMARTdenovo/v.inaequalis/172/70m/polished_repeat/pilon_1.fasta); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev)  
    OutDir=assembly/SMARTdenovo/v.inaequalis/172/70m/polished_repeat
    qsub $ProgDir/sub_quast.sh $Assembly $OutDir
done
```

KAT was used to assess the completeness of the SMARTdenovo assembly:
```bash
for Assembly in $(ls assembly/SMARTdenovo/v.inaequalis/172/70m/polished_repeat/pilon_1.fasta); do
  Strain=$(echo $Assembly| rev | cut -d '/' -f4 | rev | sed 's/_v2//g')
  Organism=$(echo $Assembly | rev | cut -d '/' -f5 | rev)
  echo "$Organism - $Strain"
  IlluminaDir=$(ls -d qc_dna/paired/*/$Strain)
  ReadsF=$(ls $IlluminaDir/F/172_S4_L001_R1_001_trim.fq.gz)
  ReadsR=$(ls $IlluminaDir/R/172_S4_L001_R2_001_trim.fq.gz)
  echo "$ReadsF"
  echo "$ReadsR"
  OutDir=assembly/SMARTdenovo/$Organism/$Strain/70m/kat
  Prefix="172_repeat_masked"
  ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/assemblers/assembly_qc/kat
  qsub $ProgDir/sub_kat.sh $Assembly $ReadsF $ReadsR $OutDir $Prefix
done
```

## Merging

The two polished PacBio assemblies were merged:
```bash
  #better assembly goes first
  for PacBioAssembly in $(ls assembly/canu/v.inaequalis/172/70m/polished_repeat/pilon_1.fasta); do
    Organism=$(echo $PacBioAssembly | rev | cut -f4 -d '/' | rev)
    Strain=$(echo $PacBioAssembly | rev | cut -f3 -d '/' | rev)
    HybridAssembly=$(ls assembly/SMARTdenovo/v.inaequalis/172/70m/polished_repeat/pilon_1.fasta)
    AnchorLength=700000
    OutDir=assembly/merged_canu_SMARTdenovo/v.inaequalis/172/70m/
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/quickmerge
    qsub $ProgDir/sub_quickmerge.sh $PacBioAssembly $HybridAssembly $OutDir $AnchorLength
  done
```

Quast was used to assess the quality of the merged assembly:
```bash
ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
for Assembly in $(ls assembly/merged_canu_SMARTdenovo/v.inaequalis/172/70m/merged.fasta); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev)  
    OutDir=assembly/merged_canu_SMARTdenovo/v.inaequalis/172/70m/
    qsub $ProgDir/sub_quast.sh $Assembly $OutDir
done
```

The polished pacbio canu asembly and SPAdes miSeq assembly were merged:
```bash
  #better assembly goes first
  for PacBioAssembly in $(ls assembly/canu/v.inaequalis/172/70m/polished_repeat/pilon_1.fasta); do
    Organism=$(echo $PacBioAssembly | rev | cut -f4 -d '/' | rev)
    Strain=$(echo $PacBioAssembly | rev | cut -f3 -d '/' | rev)
    HybridAssembly=$(ls assembly/spades/v.inaequalis/172/70m/polished_repeat/pilon_1.fasta)
    AnchorLength=700000
    OutDir=assembly/merged_canu_spades/v.inaequalis/172/70m/
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/quickmerge
    qsub $ProgDir/sub_quickmerge.sh $PacBioAssembly $HybridAssembly $OutDir $AnchorLength
  done
```

Quast was used to assess the quality of the merged assembly:
```bash
ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
for Assembly in $(ls assembly/merged_canu_spades/v.inaequalis/172/70m/merged.fasta); do
    Strain=$(echo $Assembly | rev | cut -f3 -d '/' | rev)
    Organism=$(echo $Assembly | rev | cut -f4 -d '/' | rev)  
    OutDir=assembly/merged_canu_spades/v.inaequalis/172/70m/
    qsub $ProgDir/sub_quast.sh $Assembly $OutDir
done
```

Quality of the two merged assemblies are the same as the canu assembly alone?

KAT was used to assess the completeness of the merged assembly:
```bash
for Assembly in $(ls assembly/merged_canu_spades/v.inaequalis/172/70m/merged.fasta); do
  Strain=$(echo $Assembly| rev | cut -d '/' -f3 | rev | sed 's/_v2//g')
  Organism=$(echo $Assembly | rev | cut -d '/' -f4 | rev)
  echo "$Organism - $Strain"
  IlluminaDir=$(ls -d qc_dna/paired/*/$Strain)
  ReadsF=$(ls $IlluminaDir/F/172_S4_L001_R1_001_trim.fq.gz)
  ReadsR=$(ls $IlluminaDir/R/172_S4_L001_R2_001_trim.fq.gz)
  echo "$ReadsF"
  echo "$ReadsR"
  OutDir=assembly/merged_canu_spades/$Organism/$Strain/70m/kat
  Prefix="172_repeat_masked"
  ProgDir=/home/armita/git_repos/emr_repos/tools/seq_tools/assemblers/assembly_qc/kat
  qsub $ProgDir/sub_kat.sh $Assembly $ReadsF $ReadsR $OutDir $Prefix
done
```

try to make larger graph axis:
2.6.1
unsuccessful
```bash
for Assembly in $(ls assembly/merged_canu_spades/v.inaequalis/172/70m/merged.fasta); do
  Strain=$(echo $Assembly| rev | cut -d '/' -f3 | rev | sed 's/_v2//g')
  Organism=$(echo $Assembly | rev | cut -d '/' -f4 | rev)
  echo "$Organism - $Strain"
  IlluminaDir=$(ls -d qc_dna/paired/*/$Strain)
  ReadsF=$(ls $IlluminaDir/F/172_S4_L001_R1_001_trim.fq.gz)
  ReadsR=$(ls $IlluminaDir/R/172_S4_L001_R2_001_trim.fq.gz)
  echo "$ReadsF"
  echo "$ReadsR"
  OutDir=assembly/merged_canu_spades/$Organism/$Strain/70m/kat
  Prefix="172_repeat_masked"
  ProgDir=/home/heavet/git_repos/scripts/nano_diagnositcs/Temp/
  qsub $ProgDir/KAT_TCH.sh $Assembly $ReadsF $ReadsR $OutDir $Prefix
done
```

## Repeat Masking
As the canu assembly appears to be the best this was used from this point onwards.
Repeat masking was performed using the programs; transposonPSI and Repeatmodeler
```bash
  ProgDir=/home/heavet/git_repos/tools/seq_tools/repeat_masking
    for BestAss in $(ls assembly/canu/v.inaequalis/172/70m/polished_repeat/pilon_1.fasta); do
    qsub $ProgDir/rep_modeling.sh $BestAss
    qsub $ProgDir/transposonPSI.sh $BestAss
  done
```
The number of bases masked by transposonPSI and Repeatmasker were summarised using the following commands: 
```bash
  for RepDir in $(ls -d repeat_masked/172/70m/polished_repeat_repmask/*); do
    Strain=$(echo 172)
    Organism=$(echo v.inaequalis)  
    RepMaskGff=$(ls repeat_masked/172/70m/polished_repeat_repmask/70m_contigs_hardmasked.gff)
    TransPSIGff=$(ls repeat_masked/172/70m/polished_repeat_repmask/70m_contigs_unmasked.fa.TPSI.allHits)
    
    printf "$Organism\t$Strain\n"
    
    printf "The number of bases masked by RepeatMasker:\t"
    sortBed -i $RepMaskGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
    
    printf "The number of bases masked by TransposonPSI:\t"
    sortBed -i $TransPSIGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
    
    printf "The total number of masked bases are:\t"
    cat $RepMaskGff $TransPSIGff | 
    sortBed | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
  done
```
v.inaequalis    172
The number of bases masked by RepeatMasker:     34815752
The number of bases masked by TransposonPSI:    10254
The total number of masked bases are:   Differing number of GFF fields encountered at line: 35235.  Exiting...

## RNA-seq data download
Dowloaded from Thakur et al RNA-seq data from NCBI:
```bash
fastq-dump -O raw_rna/unpaired/v.inaequalis SRR2164202 

fastq-dump -O raw_rna/unpaired/v.inaequalis SRR2164317 

fastq-dump -O raw_rna/unpaired/v.inaequalis SRR2164320

fastq-dump -O raw_rna/paired/v.inaequalis SRR2164233 

fastq-dump -O raw_rna/paired/v.inaequalis SRR2164324 

fastq-dump -O raw_rna/paired/v.inaequalis SRR2164325

```

## Gene Prediction
Gene prediction followed three steps: 

Pre-gene prediction - Quality of genome assemblies were assessed using Cegma to see how many core eukaryotic genes can be identified. 

Gene model training - Gene models were trained using assembled RNAseq data as part of the Braker1 pipeline 

Gene prediction - Gene models were used to predict genes in genomes as part of the the Braker1 pipeline. This used RNAseq data as hints for gene models.

## Pre-gene prediction

Quality of genome assemblies was assessed by looking for the gene space in the assemblies.

```bash
  ProgDir=/home/heavet/git_repos/tools/gene_prediction/cegma
    cd /home/groups/harrisonlab/project_files/nano_diagnostics
    for Genome in $(ls repeat_masked/172/70m/polished_repeat_repmask/70m_contigs_unmasked.fa); do
    echo $Genome;
    qsub $ProgDir/sub_cegma.sh $Genome dna;
  done
```
Outputs were summarised using the commands:
```bash
  for File in $(ls gene_pred/cegma/172/70m/dna_cegma.completeness_report); do
    Strain=$(echo $File | rev | cut -f3 -d '/' | rev);
    Species=$(echo v.inaequalis);
    printf "$Species\t$Strain\n";
    cat $File | head -n18 | tail -n+4;printf "\n";
  done > gene_pred/cegma/cegma_results_dna_summary.txt

less gene_pred/cegma/cegma_results_dna_summary.txt
```

## Gene Prediction

Gene prediction was performed for V. inaequalis genomes using Braker1:

### Quality control of RNA seq data

qc was performed for RNAseq data:
```bash
  for File in $( ls raw_rna/*/*/*.fastq); do
  echo $File
    IlluminaAdapters=/home/armita/git_repos/emr_repos/tools/seq_tools/ncbi_adapters.fa
    ProgDir=/home/heavet/git_repos/tools/seq_tools/rna_qc
    qsub $ProgDir/rna_qc_fastq-mcf_unpaired.sh $File $IlluminaAdapters RNA
  done
  ```

cluster no. 7 running slowly therefore:
```bash
  for File in $( ls raw_rna/paired/*/*.fastq); do
  echo $File
    IlluminaAdapters=/home/armita/git_repos/emr_repos/tools/seq_tools/ncbi_adapters.fa
    ProgDir=/home/heavet/git_repos/tools/seq_tools/rna_qc
    qsub $ProgDir/rna_qc_fastq-mcf_unpaired.sh $File $IlluminaAdapters RNA
  done
  ```

Data quality was visualised using fastqc:

```bash
for RawData in $(ls qc_rna/*/*/*/*/*.fq.gz); do
ProgDir=/home/heavet/git_repos/tools/seq_tools/dna_qc
echo $RawData;
qsub $ProgDir/run_fastqc.sh $RawData
done
```

###Aligning
Insert sizes of the RNA seq library were unknown until a draft alignment could be made. To do this tophat and cufflinks were run, aligning the reads against a single genome. The fragment length and stdev were printed to stdout while cufflinks was running.
```bash
  for Assembly in $(ls repeat_masked/*/*/*/*_contigs_unmasked.fa | grep -w '172'); do
    Strain=$(echo 172)
    Organism=$(echo v.inaequalis)
    Paired=$(echo $Assembly | rev | cut -d '/' -f5 | rev)
    echo "$Organism - $Strain"
    for rna_file in $(ls qc_rna/*/*/*/*/*.fq.gz | grep -w 'paired'); do
      Timepoint=$(echo $rna_file | rev | cut -f1 -d '/' | cut -c12- | rev)
      echo "$Timepoint"
      OutDir=alignment/$Paired/$Organism/$Strain/$Timepoint
      ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
      qsub $ProgDir/tophat_alignment_unpaired.sh $Assembly $rna_file $OutDir
    done
  done
```
What is timepoint? - unique identifier
What is Paired?

Alignments were concatenated prior to running cufflinks: Cufflinks was run to produce the fragment length and stdev statistics:

```bash
  for Assembly in $(ls repeat_masked/*/*/*/*_contigs_softmasked.fa | grep -w '172'); do
    Strain=$(echo 172)
    Organism=$(echo v.inaequalis)
    echo "$Organism - $Strain"
    mkdir -p alignment/repeat_masked/$Organism/$Strain/concatenated_prelim
    AcceptedHits=alignment/repeat_masked/$Organism/$Strain/concatenated_prelim/concatenated.bam
    samtools merge -f $AcceptedHits \
    alignment/repeat_masked/$Organism/$Strain/SRR2164233/accepted_hits.bam \
    alignment/repeat_masked/$Organism/$Strain/SRR2164324/accepted_hits.bam \
    alignment/repeat_masked/$Organism/$Strain/SRR2164325/accepted_hits.bam
    OutDir=gene_pred/cufflinks/$Organism/$Strain/concatenated_prelim
    mkdir -p $OutDir
    cufflinks -o $OutDir/cufflinks -p 8 --max-intron-length 4000 $AcceptedHits 2>&1 | tee $OutDir/cufflinks/cufflinks.log
  done
```
Output from stdout included:


> Processed 47462 loci.                        [*************************] 100%
> Map Properties:
>       Normalized Map Mass: 10987405.31
>       Raw Map Mass: 10987405.31
>       Fragment Length Distribution: Truncated Gaussian (default)
>                     Default Mean: 200
>                  Default Std Dev: 80
[12:04:59] Assembling transcripts and estimating abundances.
> Processed 47495 loci.                        [*************************] 100%

How is the mean read length found?

A better alignment program is now available - Star - this was used:
```bash
for Assembly in $(ls repeat_masked/*/*/*/*_contigs_unmasked.fa | grep -w '172'); do
Strain=$(echo 172)
Organism=$(echo v.inaequalis)
echo "$Organism - $Strain"
for FileF in $(ls qc_rna/*/*/*/*/*.fq.gz); do
Jobs=$(qstat | grep 'sub_sta' | grep 'qw'| wc -l)
while [ $Jobs -gt 1 ]; do
sleep 1m
printf "."
Jobs=$(qstat | grep 'sub_sta' | grep 'qw'| wc -l)
done
printf "\n"
echo $FileF
Prefix=$(echo $FileF | rev | cut -f1 -d '/' | cut -c12- | rev)
Datatype=$(echo $FileF | rev | cut -f3 -d '/' | rev)
      echo "$Datatype"
OutDir=alignment/star/$Organism/$Strain/$Datatype/$Prefix
ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
qsub $ProgDir/sub_star_unpaired.sh $Assembly $FileF $OutDir
done
done
```
Accepted hits .bam file were concatenated and indexed for use for gene model training:
```bash
for OutDir in $(ls -d alignment/star/v.inaequalis/172); do
  Strain=$(echo 172)
  Organism=$(echo v.inaequalis)
  echo "$Organism - $Strain"
  # For all alignments
  BamFiles=$(ls alignment/star/v.inaequalis/172/*/SRR*/star/*sortedByCoord.out.bam | tr -d '\n' | sed 's/.bam/.bam /g')
  mkdir -p $OutDir/concatenated
  samtools merge -@ 4 -f $OutDir/concatenated/concatenated.bam $BamFiles
done
```

Braker prediction:

```bash
#Before braker predictiction is performed, double check that the genemark key is in user area and copy it over from the genemark install directory:
ls ~/.gm_key
cp /home/armita/prog/genemark/2019/gm_key_64 ~/.gm_key
#
#
#
rm -r /home/heavet/prog/augustus-3.1/config/species/"$Organism"_"$Strain"_braker
#
for Assembly in $(ls repeat_masked/*/*/*/*_contigs_unmasked.fa | grep -w '172'); do
Strain=$(echo 172)
Organism=$(echo v.inaequalis)
echo "$Organism - $Strain"
mkdir -p alignment/$Organism/$Strain/concatenated
OutDir=gene_pred/braker/$Organism/"$Strain"_braker
AcceptedHits=$(ls alignment/star/$Organism/$Strain/concatenated/concatenated.bam)
GeneModelName="$Organism"_"$Strain"_braker
ProgDir=/home/heavet/git_repos/tools/gene_prediction/braker1
qsub $ProgDir/sub_braker_fungi.sh $Assembly $OutDir $AcceptedHits $GeneModelName
done
```

Additional genes were added to Braker gene predictions, using CodingQuary in pathogen mode to predict additional regions.

Firstly, aligned RNAseq data was assembled into transcripts using Cufflinks.

Note - cufflinks doesn't always predict direction of a transcript and therefore features can not be restricted by strand when they are intersected.

```bash
for Assembly in $(ls repeat_masked/*/*/*/*_contigs_unmasked.fa | grep -w '172'); do
Strain=$(echo 172)
Organism=$(echo v.inaequalis)
echo "$Organism - $Strain"
OutDir=gene_pred/cufflinks/$Organism/$Strain/concatenated
mkdir -p $OutDir
AcceptedHits=$(ls alignment/star/$Organism/$Strain/concatenated/concatenated.bam)
ProgDir=/home/heavet/git_repos/tools/seq_tools/RNAseq
qsub $ProgDir/sub_cufflinks.sh $AcceptedHits $OutDir
done
```
Secondly, genes were predicted using CodingQuary:

```bash
  for Assembly in $(ls repeat_masked/*/*/*/*_contigs_unmasked.fa | grep -w '172'); do
    Strain=$(echo 172)
    Organism=$(echo v.inaequalis)
    echo "$Organism - $Strain"
    OutDir=gene_pred/codingquary/$Organism/$Strain
    CufflinksGTF=$(ls gene_pred/cufflinks/$Organism/$Strain/concatenated/transcripts.gtf)
    ProgDir=/home/heavet/git_repos/tools/gene_prediction/codingquary
    qsub $ProgDir/sub_CodingQuary.sh $Assembly $CufflinksGTF $OutDir
  done
  ```
Unmasked genome was wrapped:

```bash
for Assembly in $(ls repeat_masked/*/*/*/*_contigs_unmasked.fa | grep -w '172'); do
NewName=$(echo $Assembly | sed 's/_unmasked.fa/_unmasked_wrapped.fa/g')
cat $Assembly | fold > $NewName
done
```

Additional transcripts were added to Braker gene models, when CodingQuarry genes were predicted in regions of the genome, not containing Braker gene models:
```bash
for BrakerGff in $(ls gene_pred/braker/*/*_braker/*/augustus.gff3 | grep '172'); do
Strain=$(echo 172)
Organism=$(echo v.inaequalis)
echo "$Organism - $Strain"
Assembly=$(ls repeat_masked/172/70m/polished_repeat_repmask/70m_contigs_unmasked_wrapped.fa)
CodingQuaryGff=$(ls gene_pred/codingquary/$Organism/$Strain/out/PredictedPass.gff3)
PGNGff=$(ls gene_pred/codingquary/$Organism/$Strain/out/PGN_predictedPass.gff3)
AddDir=gene_pred/codingquary/$Organism/$Strain/additional
FinalDir=gene_pred/final/$Organism/$Strain/final
AddGenesList=$AddDir/additional_genes.txt
AddGenesGff=$AddDir/additional_genes.gff
FinalGff=$AddDir/combined_genes.gff
mkdir -p $AddDir
mkdir -p $FinalDir

for x in $CodingQuaryGff $PGNGff; do
  bedtools intersect -v -a $x -b $BrakerGff | grep 'gene'| cut -f2 -d'=' | cut -f1 -d';'
done > $AddGenesList

for y in $CodingQuaryGff $PGNGff; do
  ProgDir=/home/heavet/git_repos/tools/seq_tools/feature_annotation
  $ProgDir/gene_list_to_gff.pl $AddGenesList $y CodingQuarry_v2.0 ID CodingQuary
done > $AddGenesGff
ProgDir=/home/heavet/git_repos/tools/gene_prediction/codingquary
$ProgDir/add_CodingQuary_features.pl $AddGenesGff $Assembly > $AddDir/add_genes_CodingQuary_unspliced.gff3
$ProgDir/correct_CodingQuary_splicing.py --inp_gff $AddDir/add_genes_CodingQuary_unspliced.gff3 > $FinalDir/final_genes_CodingQuary.gff3
# -
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_CodingQuary.gff3 $FinalDir/final_genes_CodingQuary
cp $BrakerGff $FinalDir/final_genes_Braker.gff3
$ProgDir/gff2fasta.pl $Assembly $FinalDir/final_genes_Braker.gff3 $FinalDir/final_genes_Braker
cat $FinalDir/final_genes_Braker.pep.fasta $FinalDir/final_genes_CodingQuary.pep.fasta | sed -r 's/\*/X/g' > $FinalDir/final_genes_combined.pep.fasta
cat $FinalDir/final_genes_Braker.cdna.fasta $FinalDir/final_genes_CodingQuary.cdna.fasta > $FinalDir/final_genes_combined.cdna.fasta
cat $FinalDir/final_genes_Braker.gene.fasta $FinalDir/final_genes_CodingQuary.gene.fasta > $FinalDir/final_genes_combined.gene.fasta
cat $FinalDir/final_genes_Braker.upstream3000.fasta $FinalDir/final_genes_CodingQuary.upstream3000.fasta > $FinalDir/final_genes_combined.upstream3000.fasta

GffBraker=$FinalDir/final_genes_CodingQuary.gff3
GffQuary=$FinalDir/final_genes_Braker.gff3
GffAppended=$FinalDir/final_genes_appended.gff3
cat $GffBraker $GffQuary > $GffAppended
done
```

The final number of genes per isolate was observed using:
```bash
  for DirPath in $(ls -d gene_pred/final/*/*/final); do
    Strain=$(echo 172)
    Organism=$(echo v.inaequalis)
    echo "$Organism - $Strain"
    cat $DirPath/final_genes_Braker.pep.fasta | grep '>' | wc -l;
    cat $DirPath/final_genes_CodingQuary.pep.fasta | grep '>' | wc -l;
    cat $DirPath/final_genes_combined.pep.fasta | grep '>' | wc -l;
    echo "";
  done
  ```
  The number of genes predicted by Braker, supplimented by CodingQuary and in the final combined dataset was shown:
  ```bash
v.inaequalis - 172
11903
0
11903
```

