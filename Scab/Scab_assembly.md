# Scab_assembly
Documentation of analyses and commands used as part of the PhD project investigating next generation diagnostics
Note - all this work was performed in the directory:
/home/groups/harrisonlab/project_files/nano_diagnostics

##Test Assemblies
Test data generated as part of Tom Passey's PhD project was copied to test assembly methodologies:

###Copying data
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

####Data quality control
Data quality was visualised using fastqc:
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
