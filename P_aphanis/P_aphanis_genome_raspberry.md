# P.aphanis genome assembly and annotation pipeline

Documentation of analysis and commands used with P.aphanis sampled from raspberry as part of Nano Diagnistics PhD.

## Collecting data

All following commands were exectuted from the folder:
```bash
/projects/nano_diagnostics
```
Raw MiSeq sequence data for P.aphanis was linked from long term storage in /archives to the working folder /projects/nano_diagnostics/

```bash
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all

ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21043699-Z01-F001/X204SC21043699-Z01-F001/raw_data/A2004202101/A2004202101_FDMS210203466-1a_H3WJHDSX2_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/SCOTT2020_1_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21043699-Z01-F001/X204SC21043699-Z01-F001/raw_data/A2004202101/A2004202101_FDMS210203466-1a_H3WJHDSX2_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/SCOTT2020_1_r.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21043699-Z01-F001/X204SC21043699-Z01-F001/raw_data/A2004202101/A2004202101_FDMS210203466-1a_H3WJHDSX2_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all/SCOTT2020_1_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21043699-Z01-F001/X204SC21043699-Z01-F001/raw_data/A2004202101/A2004202101_FDMS210203466-1a_H3WJHDSX2_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all/SCOTT2020_1_r.fq.gz
```
Genome assemblies for black and red raspberry cultivars were downloaded.
```bash
mkdir -p assembly/genome/rubus/occidentalis/VanBuren
mkdir -p /data/scratch/heavet/assembly/genome/rubus/occidentalis
cd /data/scratch/heavet/assembly/genome/rubus/occidentalis
wget -P VanBuren https://www.rosaceae.org/rosaceae_downloads/Rubus_occidentalis/Rubus_occidentalis-genome.v3.0/assembly/Rubus_occ_V3_10-12-17.fasta.gz
cd VanBuren
gunzip Rubus_occ_V3_10-12-17.fasta.gz
cd /projects/nano_diagnostics
ln -s /data/scratch/heavet/assembly/genome/rubus/occidentalis/VanBuren/Rubus_occ_V3_10-12-17.fasta assembly/genome/rubus/occidentalis/VanBuren/Rubus_occ_V3_10-12-17.fasta

mkdir -p assembly/genome/rubus/idaeus/Wight
mkdir -p /data/scratch/heavet/assembly/genome/rubus/idaeus
cd /data/scratch/heavet/assembly/genome/rubus/idaeus
wget -P Wight https://www.biorxiv.org/content/biorxiv/early/2019/02/18/546135/DC5/embed/media-5.gz?download=true
cd Wight/
cp media-5.gz?download=true media-5.gz
rm media-5.gz?download=true
gunzip media-5.gz
cd /projects/nano_diagnostics
ln -s /data/scratch/heavet/assembly/genome/rubus/idaeus/Wight/media-5 assembly/genome/rubus/idaeus/Wight/rubusidaeus.fasta
```
There is no published P. aphanis genome assembly for comparison, published Podosphaera genomes for P. leucotricha and P. xanthii were downloaded.
```bash
cd /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales
wget -P P_leocotricha https://sra-download.ncbi.nlm.nih.gov/traces/wgs01/wgs_aux/JA/AT/OF/JAATOF01/JAATOF01.1.fsa_nt.gz
gunzip P_leocotricha/JAATOF01.1.fsa_nt.gz
cd /projects/nano_diagnostics
samtools faidx assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa 

mkdir -p assembly/genome/erysiphales/xanthii/Polonio
mkdir -p /data/scratch/heavet/assembly/genome/erysiphales/xanthii
cd /data/scratch/heavet/assembly/genome/erysiphales/xanthii
wget -P Polonio https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/014/884/795/GCA_014884795.1_ASM1488479v1/GCA_014884795.1_ASM1488479v1_genomic.fna.gz
cd Polonio/
gunzip GCA_014884795.1_ASM1488479v1_genomic.fna.gz
cd /projects/nano_diagnostics
ln -s /data/scratch/heavet/assembly/genome/erysiphales/xanthii/Polonio/GCA_014884795.1_ASM1488479v1_genomic.fna assembly/genome/erysiphales/xanthii/Polonio/GCA_014884795.1_ASM1488479v1_genomic.fna

mkdir -p assembly/genome/erysiphales/xanthii/Kim
cd /data/scratch/heavet/assembly/genome/erysiphales/xanthii
wget -P Kim https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/010/015/925/GCA_010015925.1_POXAN_niab_assembly/GCA_010015925.1_POXAN_niab_assembly_genomic.fna.gz
cd Kim/
gunzip GCA_010015925.1_POXAN_niab_assembly_genomic.fna.gz
cd /projects/nano_diagnostics
ln -s /data/scratch/heavet/assembly/genome/erysiphales/xanthii/Kim/GCA_010015925.1_POXAN_niab_assembly_genomic.fna assembly/genome/erysiphales/xanthii/Kim/GCA_010015925.1_POXAN_niab_assembly_genomic.fna
```
Additional genomes were downloaded for comparison.
```bash
#wheat powdery  mildew genome
wget -P assembly/genome/NCBI/erysiphales/B_graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/237/765/GCA_900237765.1_BghRACE1_v1/GCA_900237765.1_BghRACE1_v1_genomic.fna.gz 
gunzip assembly/genome/NCBI/erysiphales/B_graminis/GCA_900237765.1_BghRACE1_v1_genomic.fna.gz

#grape powdery mildew genome
wget -P assembly/genome/NCBI/erysiphales/E_necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/715/GCA_000798715.1_ASM79871v1/GCA_000798715.1_ASM79871v1_genomic.fna.gz 
gunzip assembly/genome/NCBI/erysiphales/E_necator/GCA_000798715.1_ASM79871v1_genomic.fna.gz


wget -P /data/scratch/heavet/assembly/genome/Erysiphe/pisi https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/208/805/GCA_000208805.1_ASM20880v1/GCA_000208805.1_ASM20880v1_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Erysiphe/pisi https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/214/055/GCA_000214055.1_ASM21405v1/GCA_000214055.1_ASM21405v1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Erysiphe/pisi/*.gz

wget -P /data/scratch/heavet/assembly/genome/Erysiphe/necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/715/GCA_000798715.1_ASM79871v1/GCA_000798715.1_ASM79871v1_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Erysiphe/necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/016/906/895/GCA_016906895.1_ASM1690689v1/GCA_016906895.1_ASM1690689v1_genomic.fna.gz  
wget -P /data/scratch/heavet/assembly/genome/Erysiphe/necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/795/GCA_000798795.1_ASM79879v1/GCA_000798795.1_ASM79879v1_genomic.fna.gz   
wget -P /data/scratch/heavet/assembly/genome/Erysiphe/necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/775/GCA_000798775.1_ASM79877v1/GCA_000798775.1_ASM79877v1_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Erysiphe/necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/755/GCA_000798755.1_ASM79875v1/GCA_000798755.1_ASM79875v1_genomic.fna.gz  
wget -P /data/scratch/heavet/assembly/genome/Erysiphe/necator https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/798/735/GCA_000798735.1_ASM79873v1/GCA_000798735.1_ASM79873v1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Erysiphe/necator/*.gz

wget -P /data/scratch/heavet/assembly/genome/Erysiphe/pulchra https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/918/395/GCA_002918395.1_ASM291839v1/GCA_002918395.1_ASM291839v1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Erysiphe/pulchra/*.gz

wget -P /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/611/235/GCA_003611235.1_ASM361123v1/GCA_003611235.1_ASM361123v1_genomic.fna.gz
wget -P /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/611/195/GCA_003611195.1_ASM361119v1/GCA_003611195.1_ASM361119v1_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/611/215/GCA_003611215.1_ASM361121v1/GCA_003611215.1_ASM361121v1_genomic.fna.gz
gunzip /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum/*.gz

wget -P /data/scratch/heavet/assembly/genome/Golovinomyces/magnicellulatus https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/006/912/115/GCA_006912115.1_ASM691211v1/GCA_006912115.1_ASM691211v1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Golovinomyces/magnicellulatus/*.gz

wget -P /data/scratch/heavet/assembly/genome/Oidium/neolycopersicim https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/610/855/GCA_003610855.1_ASM361085v1/GCA_003610855.1_ASM361085v1_genomic.fna.gz   
gunzip /data/scratch/heavet/assembly/genome/Oidium/neolycopersicim/*.gz

wget -P /data/scratch/heavet/assembly/genome/Oidium/heveae https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/957/845/GCA_003957845.1_ASM395784v1/GCA_003957845.1_ASM395784v1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Oidium/heveae/*.gz

wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/237/765/GCA_900237765.1_BghRACE1_v1/GCA_900237765.1_BghRACE1_v1_genomic.fna.gz
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/239/735/GCA_900239735.1_BGH_DH14_v4/GCA_900239735.1_BGH_DH14_v4_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/638/725/GCA_900638725.1_BGH_K1_v2/GCA_900638725.1_BGH_K1_v2_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/418/435/GCA_000418435.1_Bgt_454_newbler_assembly/GCA_000418435.1_Bgt_454_newbler_assembly_genomic.fna.gz  
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/401/675/GCA_000401675.1_A6_trimmed_clc_assembly_flt.fa/GCA_000401675.1_A6_trimmed_clc_assembly_flt.fa_genomic.fna.gz  
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/441/875/GCA_000441875.1_Bgt_70_1/GCA_000441875.1_Bgt_70_1_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/417/865/GCA_000417865.1_Bgt_94202_1/GCA_000417865.1_Bgt_94202_1_genomic.fna.gz 
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/417/025/GCA_000417025.1_ASM41702v1/GCA_000417025.1_ASM41702v1_genomic.fna.gz  
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/519/115/GCA_900519115.1_Bgt_genome_v3.16/GCA_900519115.1_Bgt_genome_v3.16_genomic.fna.gz  
wget -P /data/scratch/heavet/assembly/genome/Blumeria/graminis https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/905/067/625/GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2/GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Blumeria/graminis/*.gz

wget -P /data/scratch/heavet/assembly/genome/Podosphaera/cerasi https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/018/398/735/GCA_018398735.1_WSU_PS_Poc_1.0/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Podosphaera/cerasi/*.gz

wget -P /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha https://sra-download.ncbi.nlm.nih.gov/traces/wgs01/wgs_aux/JA/AT/OF/JAATOF01/JAATOF01.1.fsa_nt.gz
gunzip /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/*.gz

wget -P /data/scratch/heavet/assembly/genome/Sporidiobolus/pararoseus https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/010/758/995/GCA_010758995.1_ASM1075899v1/GCA_010758995.1_ASM1075899v1_genomic.fna.gz  
gunzip /data/scratch/heavet/assembly/genome/Sporidiobolus/pararoseus/GCA_010758995.1_ASM1075899v1_genomic.fna.gz

wget -P /data/scratch/heavet/assembly/genome/Sporidiobolus/salmonicolor https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/373/355/GCA_001373355.1_SPOSA68321A01/GCA_001373355.1_SPOSA68321A01_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Sporidiobolus/salmonicolor/GCA_001373355.1_SPOSA68321A01_genomic.fna.gz

wget -P /data/scratch/heavet/assembly/genome/Sporobolomyces/roseus https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/016/617/785/GCA_016617785.1_ASM1661778v1/GCA_016617785.1_ASM1661778v1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Sporobolomyces/roseus/GCA_016617785.1_ASM1661778v1_genomic.fna.gz 
```
## Data quality control
The raw sequence reads were subjected to a quality control check using FastQC.
```bash
for RawData in $(ls rawdata/P_aphanis/*/THeavenSCOTT2020_1/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename -a $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#758292
#758293

#The number of raw reads were counted:

cat rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/SCOTT2020_1_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#64,916,507
cat rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/SCOTT2020_1_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#64,916,507
```
Trimming was performed on data to trim adapters from sequences and remove poor quality data. This was done with trimmomatic. The data was visualised following trimming using FastQC.
```bash
for ReadDir in $(ls -d rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/*/*);
do
 Fread=$(ls $ReadDir/F/*.fq.gz)
 Rread=$(ls $ReadDir/R/*.fq.gz)
ls $Fread
ls $Rread
Adapters=~/git_repos/tools/seq_tools/ncbi_adapters.fa
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(echo $ReadDir|sed 's@rawdata@dna_qc@g')
Prefix=$(echo $ReadDir|cut -f2,3,4,5,6 -d '/' --output-delimiter '-')
echo $Prefix
sbatch $ProgDir/srun_trimmomatic.sh $Fread $Rread $Adapters $OutDir $Prefix
done
#758294

for RawData in $(ls dna_qc/P_aphanis/*/THeavenSCOTT2020_1/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename $RawData .fq.gz)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#758359
#758360
#758361
#758362

zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz | echo $((`wc -l`/4))
#63,062,135
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#1,329,728
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz | echo $((`wc -l`/4))
#63,062,135
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#413,908
```
## Alignment

### bowtie2
A bioconda installation of bowtie was performed

Alignments were made to the red raspberry genome and black raspberry genome, those reads not aligning to either were carried forward.
```bash
screen -S bowtie
srun -p himem  --mem 350G --pty bash
conda activate bowtie2

#red raspberry:
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus
bowtie2-build /projects/nano_diagnostics/assembly/genome/rubus/idaeus/Wight/rubusidaeus.fasta rubusidaeus_index
bowtie2 \
-x rubusidaeus_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedrubusidaeus.sam \
--un-gz THeavenSCOTT2020_1unalignedrubusidaeus_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedrubusidaeus_fr.fq.gz \
-S THeavenSCOTT2020_1alignedrubusidaeus.sam 2>&1 | tee -a report.txt
#16.14% overall alignment

#black raspberry
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusoccidentalis
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusoccidentalis
bowtie2-build /projects/nano_diagnostics/assembly/genome/rubus/occidentalis/VanBuren/Rubus_occ_V3_10-12-17.fasta rubuoccidentalis_index
bowtie2 \
-x rubuoccidentalis_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedrubusoccidentalis.sam \
--un-gz THeavenSCOTT2020_1unalignedrubusoccidentalis_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedrubusoccidentalis_fr.fq.gz \
-S THeavenSCOTT2020_1alignedrubusoccidentalis.sam 2>&1 | tee -a report.txt
#13.44% overall alignment

#red and black raspberry
mkdir /projects/nano_diagnostics/assembly/genome/rubus/DIY
cp /projects/nano_diagnostics/assembly/genome/rubus/idaeus/Wight/rubusidaeus.fasta /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis.fasta
cat /projects/nano_diagnostics/assembly/genome/rubus/occidentalis/VanBuren/Rubus_occ_V3_10-12-17.fasta >> /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis.fasta
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis
bowtie2-build /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis.fasta rubusidaeus+occidentalis_index
bowtie2 \
-x rubusidaeus+occidentalis_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis2.sam \
--un-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis_fr.fq.gz \
-S THeavenSCOTT2020_1alignedrubusidaeus+occidentalis.sam 2>&1 | tee -a report.txt
#15.5% overall alignment

echo finished
conda deactivate
exit
exit
```
Trimmed reads were also aligned to other mildew species and our draft P.aphanis genome assembly.
```bash
screen -S bowtiecomps
srun -p himem -c 6 --mem 50G --pty bash
conda activate bowtie2

#Cucurbit powdery mildew genome from Polonio et al.
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Polonio_P_xanthii
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Polonio_P_xanthii
bowtie2-build /projects/nano_diagnostics/assembly/genome/erysiphales/xanthii/Polonio/GCA_014884795.1_ASM1488479v1_genomic.fna Polonio_P_xanthii_index
bowtie2 \
-x Polonio_P_xanthii_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedHeaven_Polonio_P_xanthii.sam \
--un-gz THeavenSCOTT2020_1unalignedHeaven_Polonio_P_xanthii_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedHeaven_Polonio_P_xanthii_fr.fq.gz \
-S THeavenSCOTT2020_1alignedHeaven_Polonio_P_xanthii.sam 2>&1 | tee -a report.txt
#11.4% overall alignment

#Cucurbit powdery mildew genome from Kim et al.
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Kim_P_xanthii
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Kim_P_xanthii
bowtie2-build /projects/nano_diagnostics/assembly/genome/erysiphales/xanthii/Kim/GCA_010015925.1_POXAN_niab_assembly_genomic.fna Kim_P_xanthii_index
bowtie2 \
-x Kim_P_xanthii_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedHeaven_Kim_P_xanthii.sam \
--un-gz THeavenSCOTT2020_1unalignedHeaven_Kim_P_xanthii_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedHeaven_Kim_P_xanthii_fr.fq.gz \
-S THeavenSCOTT2020_1alignedHeaven_Kim_P_xanthii.sam 2>&1 | tee -a report.txt

#wheat powdery  mildew genome
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/P_graminis
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/P_graminis
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/B_graminis/GCA_900237765.1_BghRACE1_v1_genomic.fna P_graminis_index
bowtie2 \
-x P_graminis_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedHeaven_P_graminis.sam \
--un-gz THeavenSCOTT2020_1unalignedHeaven_P_graminis_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedHeaven_P_graminisr_fr.fq.gz \
-S THeavenSCOTT2020_1alignedHeaven_P_graminis.sam 2>&1 | tee -a report.txt
#1.41% overall alignment

#grape powdery mildew genome
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/E_necator
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/E_necator
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/E_necator/GCA_000798715.1_ASM79871v1_genomic.fna E_necator_index
bowtie2 \
-x E_necator_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedHeaven_E_necator.sam \
--un-gz THeavenSCOTT2020_1unalignedHeaven_E_necator_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedHeaven_E_necator_fr.fq.gz \
-S THeavenSCOTT2020_1alignedHeaven_E_necator.sam 2>&1 | tee -a report.txt
#3.34% overall alignment

#Publoshed apple powdery mildew from Ganan et al.
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/ganan_P_leucotricha
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/ganan_P_leucotricha
bowtie2-build /projects/nano_diagnostics/assembly/genome/NCBI/erysiphales/P_leocotricha/JAATOF01.1.fa  ganan_P_leucotricha_index
bowtie2 \
-x ganan_P_leucotricha_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedHeaven_ganan_P_leucotricha.sam \
--un-gz THeavenSCOTT2020_1unalignedHeaven_ganan_P_leucotricha_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedHeaven_ganan_P_leucotricha_fr.fq.gz \
-S THeavenSCOTT2020_1alignedHeaven_ganan_P_leucotricha.sam 2>&1 | tee -a report.txt
#13.24% overall alignment

#In house draft apple powdery mildew genome
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_leucotricha
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_leucotricha
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/filtered_contigs/contigs_min_500bp_filtered.fasta Heaven_P_leucotricha_index
bowtie2 \
-x Heaven_P_leucotricha_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedHeaven_P_leucotricha.sam \
--un-gz THeavenSCOTT2020_1unalignedHeaven_P_leucotricha_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedHeaven_P_leucotricha_fr.fq.gz \
-S THeavenSCOTT2020_1alignedHeaven_P_leucotricha.sam 2>&1 | tee -a report.txt
#15.91% ovarall alignment

#In house draft strawberry powdery mildew genome
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_aphanis
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_aphanis
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta Heaven_P_aphanis_index
bowtie2 \
-x Heaven_P_aphanis_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedHeaven_P_aphanis.sam \
--un-gz THeavenSCOTT2020_1unalignedHeaven_P_aphanis_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedHeaven_P_aphanis_fr.fq.gz \
-S THeavenSCOTT2020_1alignedHeaven_P_aphanis.sam 2>&1 | tee -a report.txt
#35.99% overall alignment

echo finished
conda deactivate
exit
exit
```

## Coverage
Coverage of data was estimated and the quality of sequencing data was assessed using KAT.
```bash
#Sequencing reads were compared with our in house p.aphanis genome, results were plotted with various settings
screen -S KAT
srun -p himem --mem 1000G --pty bash
conda activate kat
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis/reads_v_Heaven_P_aphanis '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta

kat plot spectra-cn -x 100 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis/reads_v_Heaven_P_aphanisplot100 alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis/reads_v_Heaven_P_aphanis-main.mx

kat plot spectra-cn -x 200 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis/reads_v_Heaven_P_aphanisplot200 alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis/reads_v_Heaven_P_aphanis-main.mx

kat plot spectra-cn -x 1100 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis/reads_v_Heaven_P_aphanisplot1100 alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis/reads_v_Heaven_P_aphanis-main.mx

kat plot spectra-cn -u -x 2000 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis/reads_v_Heaven_P_aphanisplot2000u alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis/reads_v_Heaven_P_aphanis-main.mx

#Sequencing reads were compared with the available red raspberry genome, results were plotted with various settings
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus
kat comp -m 21 -v -H 800000000 -I 800000000 -h -t 8 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus/reads_v_rubusidaeus '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/rubus/idaeus/Wight/rubusidaeus.fasta

kat plot spectra-cn -x 100 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus/reads_v_rubusidaeusplot100 alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus/reads_v_rubusidaeus-main.mx

kat plot spectra-cn -x 200 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus/reads_v_rubusidaeusplot200 alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus/reads_v_rubusidaeus-main.mx

kat plot spectra-cn -x 1100 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus/reads_v_rubusidaeusplot1100 alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus/reads_v_rubusidaeus-main.mx

kat plot spectra-cn -x 2000 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus/reads_v_rubusidaeusplot2000 alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus/reads_v_rubusidaeus-main.mx

#Coverage of the second round of sequencing data was estimated.
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_aphanis
samtools view --threads 8 -bS THeavenSCOTT2020_1alignedHeaven_P_aphanis.sam -o THeavenSCOTT2020_1alignedHeaven_P_aphanis.bam
samtools sort --threads 8 -o THeavenSCOTT2020_1alignedHeaven_P_aphanis_sorted.bam THeavenSCOTT2020_1alignedHeaven_P_aphanis.bam
samtools index -@ 8 THeavenSCOTT2020_1alignedHeaven_P_aphanis_sorted.bam THeavenSCOTT2020_1alignedHeaven_P_aphanis_sorted.bam.index
samtools coverage THeavenSCOTT2020_1alignedHeaven_P_aphanis_sorted.bam -o coverage.txt
#data from coverage.txt was copied into excel to estimate median and mean coverage

conda deactivate
exit
exit
echo finished
```

## Assembly
Trimmed reads that did not align to the camarosa genome were taken as raw data for assembly.
```bash
#files were renamed to correct extensions for spades
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis_fr.fq.1.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis_fr-f.fq.gz 
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis_fr.fq.2.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis_fr-r.fq.gz 
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis_s.fq.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis_s-s.fq.gz 

#files were unzipped
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis_fr-f.fq.gz
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis_fr-r.fq.gz 
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis_s-s.fq.gz
```
### SPAdes
A conda installation of SPAdes was performed

Trimmed MiSeq reads were assembled using the program SPAdes, contigs <500bp filtered out with abyss:
```bash
conda activate spades

  for ReadDir in $(ls -d alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/rubusidaeus+occidentalis@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
#758370 - SPAdes pipeline finished with warnings

  for ReadDir in $(ls -d alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/rubusidaeus+occidentalis@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 20
  done
#758406

  for ReadDir in $(ls -d alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/rubusidaeus+occidentalis@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 75
  done
#758404
conda deactivate
```
### Quast
Quast was used to assess the quality of genome assembly:
```bash
conda activate quast

    for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/758370/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#758397

    for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/758406/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#758616

    for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/758404/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
conda deactivate
#758592
```
### BUSCO
BUSCO was used to assess the quality of the genome assembly:
```bash
screen -S busco
srun -p himem -J busco --mem 350G --pty bash

#BUSCO analysis was performed of the SPAdes assembly using three databases.
conda activate BUSCO

for assembly in $(echo assembly/metagenome/P_aphanis/*/SPAdes/758370/filtered_contigs); do
	Data=$(ls $assembly/contigs_min_500bp.fasta) 
	Input=$(dirname $assembly)

	mkdir -p $Input/BUSCO/fungi/1
	cd $Input/BUSCO/fungi
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/ascomycota/1
	cd $Input/BUSCO/ascomycota
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/leotiomycetes/1
	cd $Input/BUSCO/leotiomycetes
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done

for assembly in $(echo assembly/metagenome/P_aphanis/*/SPAdes/758406/filtered_contigs); do
	Data=$(ls $assembly/contigs_min_500bp.fasta) 
	Input=$(dirname $assembly)

	mkdir -p $Input/BUSCO/fungi/1
	cd $Input/BUSCO/fungi
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/ascomycota/1
	cd $Input/BUSCO/ascomycota
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/leotiomycetes/1
	cd $Input/BUSCO/leotiomycetes
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done

for assembly in $(echo assembly/metagenome/P_aphanis/*/SPAdes/758404/filtered_contigs); do
	Data=$(ls $assembly/contigs_min_500bp.fasta) 
	Input=$(dirname $assembly)

	mkdir -p $Input/BUSCO/fungi/1
	cd $Input/BUSCO/fungi
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/ascomycota/1
	cd $Input/BUSCO/ascomycota
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/leotiomycetes/1
	cd $Input/BUSCO/leotiomycetes
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done
conda deactivate
exit 
exit
echo finished
```
### KAT
```bash
screen -S kat
srun -p himem  --mem 750G --pty bash
conda activate kat
cd /projects/nano_diagnostics

#Reads were compared to the spades draft mildew genome and results plotted:
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/THeavenSCOTT2020_1vdraft1 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz' assembly/metagenome/P_aphanis/*/SPAdes/758370/*/contigs_min_500bp.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/THeavenSCOTT2020_1vdraft1plot300 alignment/P_aphanis/THeavenSCOTT2020_1/kat/THeavenSCOTT2020_1vdraft1-main.mx

conda deactivate
exit
exit
```
### Kraken2
```bash
#Initial kraken with existing database
screen -S kraken12
srun -p himem  --mem 350G --pty bash
conda activate kraken2
mkdir -p analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/
mkdir -p analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi/
kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/nt2 \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/output.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/classified-out.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/report.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/758406/filtered_contigs/contigs_min_500bp.fasta
#  11602 sequences classified (84.88%)
#  2066 sequences unclassified (15.12%)

kraken2 \
--db analysis/P_leucotricha/THeavenp11_1/kraken2/fungi3 \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi/output.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi/unclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi/classified-out.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi/report.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/758406/filtered_contigs/contigs_min_500bp.fasta
#  10814 sequences classified (79.12%)
#  2854 sequences unclassified (20.88%)

conda deactivate
exit
exit
```
```bash
screen -S kraken
srun -p himem -J kraken --mem 350G --pty bash
conda activate kraken2

#Alternative download scripts were downloaded from a git repo:
#* from https://github.com/R-Wright-1/peptides
#* following the discussion at https://github.com/DerrickWood/kraken2/issues/272

#Genomes were downloaded:
mkdir /scratch/public_data/tch
cd /scratch/public_data/tch
wget https://github.com/R-Wright-1/peptides/archive/refs/heads/master.zip
unzip master.zip
conda create -n biopython
conda activate biopython
conda update -n base conda
conda install -c conda-forge biopython
conda install pandas
mkdir tmp123
cd tmp123
DBNAME=/projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt
kraken2-build --download-taxonomy --use-ftp --threads 20 --db $DBNAME 
#edit ../peptides-master/download_domain.py to http download
python ../peptides-master/download_domain.py --domain fungi --ext dna # 04052021
python ../peptides-master/download_domain.py --domain bacteria --complete True --ext dna 
python ../peptides-master/download_domain.py --domain plant --ext dna
python ../peptides-master/download_domain.py --domain vertebrate_mammalian --human True --complete True --ext dna
python ../peptides-master/download_domain.py --domain protozoa --ext dna 
python ../peptides-master/download_domain.py --domain archaea --ext dna 

python ../peptides-master/download_domain.py --domain plasmid --complete True --ext dna #unable to open assembly_summary.txt
python ../peptides-master/download_domain.py --domain viral --complete True --ext dna
python ../peptides-master/download_domain.py --domain human --complete True --ext dna #unable to open assembly_summary.txt
python ../peptides-master/download_domain.py --domain UniVec_Core --complete True --ext dna #unable to open assembly_summary.txt
echo complete
python ../peptides-master/download_domain.py --domain nt --ext dna #unable to open assembly_summary.txt

#Downloaded genomes added to database:
cd /projects/nano_diagnostics
mkdir -p analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt
kraken2-build --download-taxonomy --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt 2>&1 | tee 1.log
for file in $(ls /scratch/public_data/tch/tmp123/archaea/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt 2>&1 | tee -a 1.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/bacteria/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt 2>&1 | tee -a 1.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/fungi/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt 2>&1 | tee -a 1.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/plant/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt 2>&1 | tee -a 1.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/protozoa/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt 2>&1 | tee -a 1.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/viral/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt 2>&1 | tee -a 1.log 
done
for file in $(ls /scratch/public_data/tch/tmp123/vertebrate_mammalian/*.fna); do
	#echo $file
    kraken2-build --add-to-library $file --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt 2>&1 | tee -a 1.log 
done

#Presence of genomes of interest confirmed:
grep "|3750" /scratch/public_data/tch/tmp123/plant/* # confirms that apple is in the plant database
grep "|3747" /scratch/public_data/tch/tmp123/plant/* # confirms that strawberry is in the plant database -> NOT FOUND
grep "|57918" /scratch/public_data/tch/tmp123/plant/* # confirms that wild strawberry is in the plant database -> NOT FOUND
grep "|32247" /scratch/public_data/tch/tmp123/plant/* # confirms that red raspberry is in the plant database -> NOT FOUND
grep "|75079" /scratch/public_data/tch/tmp123/plant/* # confirms that black raspberry is in the plant database -> NOT FOUND
grep "|79249" /scratch/public_data/tch/tmp123/fungi/* # confirms that apple powdery mildew is in the fungal database -> NOT FOUND
grep "|135283" /scratch/public_data/tch/tmp123/fungi/* # confirms that cucurbit powdery mildew is in the fungal database -> NOT FOUND
grep "|454966" /scratch/public_data/tch/tmp123/fungi/* # confirms that Sporidiobolus metaroseus  is in the fungal database -> NOT FOUND
grep "|40563" /scratch/public_data/tch/tmp123/fungi/* # confirms that Sporobolomyces roseus is in the fungal database -> NOT FOUND

#Missing genomes added to database
cat /projects/nano_diagnostics/rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta | sed -e "s/>.*/&|kraken:taxid|3747/g" > /data/scratch/heavet/assembly/genome/fragaria/ananassa/F_ana_Camarosa_6-28-17.mod.fasta
sed 's/ Fragaria/|kraken:taxid|57918 Fragaria/g' /data/scratch/heavet/assembly/genome/fragaria/vesca/GCA_000184155.1_FraVesHawaii_1.0_genomic.fna > /data/scratch/heavet/assembly/genome/fragaria/vesca/GCA_000184155.1_FraVesHawaii_1.0_genomic.mod.fna
cat /data/scratch/heavet/assembly/genome/rubus/occidentalis/VanBuren/Rubus_occ_V3_10-12-17.fasta | sed -e "s/>..../&|kraken:taxid|75079/g" > /data/scratch/heavet/assembly/genome/rubus/occidentalis/VanBuren/Rubus_occ_V3_10-12-17.mod.fasta
cat /data/scratch/heavet/assembly/genome/rubus/idaeus/Wight/media-5 | sed -e "s/>.*/&|kraken:taxid|32247/g" > /data/scratch/heavet/assembly/genome/rubus/idaeus/Wight/media-5.mod.fasta
sed 's/ Podosphaera/|kraken:taxid|79249 Podosphaera/g' /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/JAATOF01.1.fsa_nt > /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/JAATOF01.mod.1.fa
sed 's/ Podosphaera/|kraken:taxid|135283 Podosphaera/g' /data/scratch/heavet/assembly/genome/erysiphales/xanthii/Polonio/GCA_014884795.1_ASM1488479v1_genomic.fna > /data/scratch/heavet/assembly/genome/erysiphales/xanthii/Polonio/GCA_014884795.1_ASM1488479v1_genomic.mod.fna
sed 's/ Podosphaera/|kraken:taxid|135283 Podosphaera/g' /data/scratch/heavet/assembly/genome/erysiphales/xanthii/Kim/GCA_010015925.1_POXAN_niab_assembly_genomic.fna > /data/scratch/heavet/assembly/genome/erysiphales/xanthii/Kim/GCA_010015925.1_POXAN_niab_assembly_genomic.mod.fna
#no sporidiobolus metaroseus genome is available therefore 2 other sporidiobolus scaffolds were added:
sed 's/ Sporidiobolus/|kraken:taxid|220536 Sporidiobolus/g' /data/scratch/heavet/assembly/genome/Sporidiobolus/pararoseus/GCA_010758995.1_ASM1075899v1_genomic.fna > /data/scratch/heavet/assembly/genome/Sporidiobolus/pararoseus/GCA_010758995.1_ASM1075899v1_genomic.mod.fna
sed 's/ Sporidiobolus/|kraken:taxid|379960 Sporidiobolus/g' /data/scratch/heavet/assembly/genome/Sporidiobolus/salmonicolor/GCA_001373355.1_SPOSA68321A01_genomic.fna > /data/scratch/heavet/assembly/genome/Sporidiobolus/salmonicolor/GCA_001373355.1_SPOSA68321A01_genomic.mod.fna
sed 's/ Sporobolomyces/|kraken:taxid|40563 Sporobolomyces/g' /data/scratch/heavet/assembly/genome/Sporobolomyces/roseus/GCA_016617785.1_ASM1661778v1_genomic.fna > /data/scratch/heavet/assembly/genome/Sporobolomyces/roseus/GCA_016617785.1_ASM1661778v1_genomic.mod.fna 
#Additional powdery mildew genomes were added to the database:
sed 's/ Podosphaera/|kraken:taxid|2086344 Podosphaera/g' /data/scratch/heavet/assembly/genome/Podosphaera/cerasi/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.fna > /data/scratch/heavet/assembly/genome/Podosphaera/cerasi/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.mod.fna
sed 's/ Blumeria/|kraken:taxid|62688 Blumeria/g' /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_900237765.1_BghRACE1_v1_genomic.fna > /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_900237765.1_BghRACE1_v1_genomic.mod.fna
sed 's/ Blumeria/|kraken:taxid|62688 Blumeria/g' /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_000401675.1_A6_trimmed_clc_assembly_flt.fa_genomic.fna > /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_000401675.1_A6_trimmed_clc_assembly_flt.fa_genomic.mod.fna
sed 's/ Blumeria/|kraken:taxid|62690 Blumeria/g' /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_000417025.1_ASM41702v1_genomic.fna > /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_000417025.1_ASM41702v1_genomic.mod.fna
sed 's/ Blumeria/|kraken:taxid|62690 Blumeria/g' /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_000417865.1_Bgt_94202_1_genomic.fna > /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_000417865.1_Bgt_94202_1_genomic.mod.fna
sed 's/ Blumeria/|kraken:taxid|62690 Blumeria/g' /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_000418435.1_Bgt_454_newbler_assembly_genomic.fna > /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_000418435.1_Bgt_454_newbler_assembly_genomic.mod.fna
sed 's/ Blumeria/|kraken:taxid|62690 Blumeria/g' /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_000441875.1_Bgt_70_1_genomic.fna > /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_000441875.1_Bgt_70_1_genomic.mod.fna
sed 's/ Blumeria/|kraken:taxid|62688 Blumeria/g' /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_900239735.1_BGH_DH14_v4_genomic.fna > /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_900239735.1_BGH_DH14_v4_genomic.mod.fna
sed 's/ Blumeria/|kraken:taxid|62690 Blumeria/g' /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_900519115.1_Bgt_genome_v3.16_genomic.fna > /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_900519115.1_Bgt_genome_v3.16_genomic.mod.fna
sed 's/ Blumeria/|kraken:taxid|62688 Blumeria/g' /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_900638725.1_BGH_K1_v2_genomic.fna > /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_900638725.1_BGH_K1_v2_genomic.mod.fna
sed 's/ Blumeria/|kraken:taxid|1689686 Blumeria/g' /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2_genomic.fna > /data/scratch/heavet/assembly/genome/Blumeria/graminis/GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2_genomic.mod.fna
sed 's/ Oidium/|kraken:taxid|299130 Oidium/g' /data/scratch/heavet/assembly/genome/Oidium/heveae/GCA_003957845.1_ASM395784v1_genomic.fna > /data/scratch/heavet/assembly/genome/Oidium/heveae/GCA_003957845.1_ASM395784v1_genomic.mod.fna
sed 's/ Oidium/|kraken:taxid|212602 Oidium/g' /data/scratch/heavet/assembly/genome/Oidium/neolycopersicim/GCA_003610855.1_ASM361085v1_genomic.fna > /data/scratch/heavet/assembly/genome/Oidium/neolycopersicim/GCA_003610855.1_ASM361085v1_genomic.mod.fna
sed 's/ Golovinomyces/|kraken:taxid|62714 Golovinomyces/g' /data/scratch/heavet/assembly/genome/Golovinomyces/magnicellulatus/GCA_006912115.1_ASM691211v1_genomic.fna > /data/scratch/heavet/assembly/genome/Golovinomyces/magnicellulatus/GCA_006912115.1_ASM691211v1_genomic.mod.fna
sed 's/ Golovinomyces/|kraken:taxid|62708 Golovinomyces/g' /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum/GCA_003611195.1_ASM361119v1_genomic.fna > /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum/GCA_003611195.1_ASM361119v1_genomic.mod.fna
sed 's/ Golovinomyces/|kraken:taxid|62708 Golovinomyces/g' /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum/GCA_003611215.1_ASM361121v1_genomic.fna > /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum/GCA_003611215.1_ASM361121v1_genomic.mod.fna
sed 's/ Golovinomyces/|kraken:taxid|62708 Golovinomyces/g' /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum/GCA_003611235.1_ASM361123v1_genomic.fna > /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum/GCA_003611235.1_ASM361123v1_genomic.mod.fna
sed 's/ Erysiphe/|kraken:taxid|225359 Erysiphe/g' /data/scratch/heavet/assembly/genome/Erysiphe/pulchra/GCA_002918395.1_ASM291839v1_genomic.fna > /data/scratch/heavet/assembly/genome/Erysiphe/pulchra/GCA_002918395.1_ASM291839v1_genomic.mod.fna
sed 's/ Erysiphe/|kraken:taxid|52586 Erysiphe/g' /data/scratch/heavet/assembly/genome/Erysiphe/necator/GCA_000798715.1_ASM79871v1_genomic.fna > /data/scratch/heavet/assembly/genome/Erysiphe/necator/GCA_000798715.1_ASM79871v1_genomic.mod.fna
sed 's/ Erysiphe/|kraken:taxid|52586 Erysiphe/g' /data/scratch/heavet/assembly/genome/Erysiphe/necator/GCA_000798735.1_ASM79873v1_genomic.fna > /data/scratch/heavet/assembly/genome/Erysiphe/necator/GCA_000798735.1_ASM79873v1_genomic.mod.fna 
sed 's/ Erysiphe/|kraken:taxid|52586 Erysiphe/g' /data/scratch/heavet/assembly/genome/Erysiphe/necator/GCA_000798755.1_ASM79875v1_genomic.fna > /data/scratch/heavet/assembly/genome/Erysiphe/necator/GCA_000798755.1_ASM79875v1_genomic.mod.fna
sed 's/ Erysiphe/|kraken:taxid|52586 Erysiphe/g' /data/scratch/heavet/assembly/genome/Erysiphe/necator/GCA_000798775.1_ASM79877v1_genomic.fna > /data/scratch/heavet/assembly/genome/Erysiphe/necator/GCA_000798775.1_ASM79877v1_genomic.mod.fna
sed 's/ Erysiphe/|kraken:taxid|52586 Erysiphe/g' /data/scratch/heavet/assembly/genome/Erysiphe/necator/GCA_000798795.1_ASM79879v1_genomic.fna > /data/scratch/heavet/assembly/genome/Erysiphe/necator/GCA_000798795.1_ASM79879v1_genomic.mod.fna
sed 's/ Erysiphe/|kraken:taxid|52586 Erysiphe/g' /data/scratch/heavet/assembly/genome/Erysiphe/necator/GCA_016906895.1_ASM1690689v1_genomic.fna > /data/scratch/heavet/assembly/genome/Erysiphe/necator/GCA_016906895.1_ASM1690689v1_genomic.mod.fna
sed 's/ Erysiphe/|kraken:taxid|36044 Erysiphe/g' /data/scratch/heavet/assembly/genome/Erysiphe/pisi/GCA_000214055.1_ASM21405v1_genomic.fna > /data/scratch/heavet/assembly/genome/Erysiphe/pisi/GCA_000214055.1_ASM21405v1_genomic.mod.fna
sed 's/ Erysiphe/|kraken:taxid|36044 Erysiphe/g' /data/scratch/heavet/assembly/genome/Erysiphe/pisi/GCA_000208805.1_ASM20880v1_genomic.fna > /data/scratch/heavet/assembly/genome/Erysiphe/pisi/GCA_000208805.1_ASM20880v1_genomic.mod.fna
cp /data/scratch/heavet/assembly/genome/fragaria/ananassa/F_ana_Camarosa_6-28-17.mod.fasta /data/scratch/heavet/assembly/genome/fragaria/ananassa/F_ana_Camarosa_6-28-17.mod.fna
cp /data/scratch/heavet/assembly/genome/rubus/occidentalis/VanBuren/Rubus_occ_V3_10-12-17.mod.fasta /data/scratch/heavet/assembly/genome/rubus/occidentalis/Rubus_occ_V3_10-12-17.mod.fna
cp /data/scratch/heavet/assembly/genome/rubus/idaeus/Wight/media-5.mod.fasta /data/scratch/heavet/assembly/genome/rubus/idaeus/media-5.mod.fna
cp /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/JAATOF01.mod.1.fa /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/JAATOF01.mod.fna
cp /data/scratch/heavet/assembly/genome/erysiphales/xanthii/Polonio/GCA_014884795.1_ASM1488479v1_genomic.mod.fna /data/scratch/heavet/assembly/genome/Podosphaera/xanthii/GCA_014884795.1_ASM1488479v1_genomic.mod.fna
cp /data/scratch/heavet/assembly/genome/erysiphales/xanthii/Kim/GCA_010015925.1_POXAN_niab_assembly_genomic.mod.fna /data/scratch/heavet/assembly/genome/Podosphaera/xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.mod.fna
for assembly in $(ls /data/scratch/heavet/assembly/genome/*/*/*.mod.fna); do
kraken2-build --add-to-library $assembly --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt 2>&1 | tee -a 2.log
done

#Databse was built:
kraken2-build --build --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt 2>&1 | tee -a 3.log
kraken2-build --clean --threads 20 --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt
exit
exit
echo finished

#Database tested with the ganan apple mildew genome
screen -S kraken
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/gananoutput.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/gananunclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/gananclassified-out.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/gananreport.txt \
--use-names \
/data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/JAATOF01.mod.1.fa
exit
exit
echo finished
#  8921 sequences classified (100.00%)
#  0 sequences unclassified (0.00%)
```
Kraken was used to identify the origin of contigs in the assembly:
```bash
#Kraken was run with the updated database
screen -S kraken
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutput.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-out.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntclassified-out.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreport.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/758406/filtered_contigs/contigs_min_500bp.fasta
#  12820 sequences classified (93.80%)
#  848 sequences unclassified (6.20%)

kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutput10.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-out10.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntclassified-out10.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreport10.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/758370/filtered_contigs/contigs_min_500bp.fasta
# 27956 sequences classified (66.01%)
# 14398 sequences unclassified (33.99%)
exit
exit
echo finished
```
Contaminant contigs were removed from the assembly
```bash
touch analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantlist.txt
nano analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantlist.txt

#Edited with the following: 

#An initial ITS sequencing of our DNA returned hits for Sporobolomyces, which is why these species were added to our kraken2 database, the results of kraken also indicate that our sample is contaminated with Sporobolomyces roseus with 12.26% of contigs identified as this species. Therefore all Sporobolomyces identified contigs were removed along with contigs identified as coming from non funngal soecies. All other fungal classified contigs and unclassified contigs were retained as presumed P.aphnis in origin.
Sporobolomyces
Sporidiobolaceae
Basidiomycota
#metazoa
Homo sapiens
#plants
Mesangiospermae
Pentapetalae
rosids
fabids
Rubus
Malus
Pyrus
Prunus
Cannabis
Lupinus
Glycine
Vigna
Medicago
Cicer arietinum
Arachis
Prosopis
Quercus
Juglans
Cucurbita
Cucumis
Benincasa
Momordica
Ricinus
Jatropha
malvids
Gossypium
Hibiscus
Herrania
Brassica
Raphanus
Camelina
Carica
Tarenaya
Pistacia
Citrus
Punica 
Vitis riparia
Cynara
Helianthus
lamiids
Solanales
Capsicum
Solanum
Nicotiana
Ipomoea
Olea europaea
Erythranthe
Coffea
Camellia
Chenopodium
Triticum
Aegilops
Oryza
Zea mays
Sorghum
Setaria
Arecaceae
Elaeis
Phoenix
Dendrobium
Phalaenopsis
Asparagus
Dioscorea
Nelumbo
Papaver
Nymphaea
Amborella
Selaginella
Chlorella
Eimeria
Ichthyophthirius
Leishmania
# bacteria
Bacteria
Buchnera
Pseudomonas
Legionella
Thermomonas
Idiomarina
Vibrio
Alphaproteobacteria
Paracoccus
Pseudorhodobacter
Sphingopyxis
Paremcibacter
Glycocaulis
Stigmatella
Terrabacteria
Ornithinimicrobium
Brachybacterium
Tetrasphaera
Microbacterium 
Streptomyces
Corynebacteriales
Lederbergia 
Brevibacillus
Mycoplasma 
Nostocales
Luteitalea 
Hymenobacter
#archaea
Halorubrum

grep -f analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantlist.txt analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutput.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontigs.txt

nawk -F"\\t" '{print $2}' analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontigs.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames.txt

conda activate seqtk
seqtk subseq /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/758406/filtered_contigs/contigs_min_500bp.fasta analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminants.fasta
conda deactivate

conda activate biopython
/home/heavet/git_repos/tools/DIY/filter.py /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/758406/filtered_contigs/contigs_min_500bp.fasta analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames.txt > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/filtered_contigs_min_500bp.fasta
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/filtered_contigs_min_500bp.fasta > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames.txt #2074
wc -l assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/contigs_min_500bp.fasta #27336
wc -l assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/contigs_min_500bp_filtered.fasta #23188
```
The Sporobolomyces roseus contigs were extracted and analysed for completeness of the Sporobolomyces roseus genome:
```bash
touch analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomyces.txt
nano analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomyces.txt
#Edited with:
Basidiomycota
Sporidiobolaceae
Sporobolomyces
Sporidiobolus
Rhodotorula
Melampsora
Agaricomycotina
Tremellomycetes
Cryptococcaceae
Kwoniella
Cryptococcus
Kockovaella
Trichosporonaceae
Apiotrichum
Trichosporon
Agaricomycetes
Phanerochaete
Sparassis
Fibroporia
Coniophora
Serpula
Mycena
Dacryopinax
Pseudozyma
Anthracocystis
Ceraceosorus

grep -f analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomyces.txt analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutput.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomycescontigs.txt
nawk -F"\\t" '{print $2}' analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomycescontigs.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomycescontigsnames.txt
conda activate seqtk
seqtk subseq /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/758406/filtered_contigs/contigs_min_500bp.fasta analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomycescontigsnames.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomycescontigs.fasta
conda deactivate
wc -l analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomycescontigs.fasta #3502

screen -S busco2
srun -p himem  --mem 350G --pty bash
conda activate BUSCO

for assembly in $(echo analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt); do
	Data=$(ls $assembly/Sporobolomycescontigs.fasta) 
	Input=$(dirname $assembly)

	mkdir -p $Input/Sporobolomyces/BUSCO/fungi/
	cd $Input/Sporobolomyces/BUSCO/fungi/
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o fungi -l fungi_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/Sporobolomyces/BUSCO/basidiomycota/
	cd $Input/Sporobolomyces/BUSCO/basidiomycota/
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o basidiomycota -l basidiomycota_odb10
	cd /projects/nano_diagnostics	

	mkdir -p $Input/Sporobolomyces/BUSCO/ascomycota/
	cd $Input/Sporobolomyces/BUSCO/ascomycota/
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o ascomycota -l ascomycota_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/Sporobolomyces/BUSCO/leotiomycetes/
	cd $Input/Sporobolomyces/BUSCO/leotiomycetes/
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o leotiomycetes -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done
exit
exit
echo finished

conda activate quast
    for Assembly in $(ls analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomycescontigs.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)/Sporobolomyces
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#764853
conda deactivate
```

Following the removal of contaminant contigs, kraken2, BUSCO and quast analysis were performed again for the filtered assembly
```bash
screen -S kraken2
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutputfiltered.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-outfiltered.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntclassified-outfiltered.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreportfiltered.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/contigs_min_500bp_filtered.fasta
exit
exit
echo finished
#  10746 sequences classified (92.69%)
#  848 sequences unclassified (7.31%)

screen -S busco
srun -p himem  --mem 350G --pty bash
conda activate BUSCO

for assembly in $(echo assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs); do
	Data=$(ls $assembly/contigs_min_500bp_filtered.fasta) 
	Input=$(dirname $assembly)

	mkdir -p $Input/BUSCO/fungi/1/filtered
	cd $Input/BUSCO/fungi/1
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l fungi_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/ascomycota/1/filtered
	cd $Input/BUSCO/ascomycota/1
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l ascomycota_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/leotiomycetes/1/filtered
	cd $Input/BUSCO/leotiomycetes/1
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done
exit
exit
echo finished

conda activate quast
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/contigs_min_500bp_filtered.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)/filtered
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#764339

#with unclassified removed
screen -S kraken2
srun -p himem  --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutputfiltered2.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-outfiltered2.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntclassified-outfiltered2.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreportfiltered2.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/contigs_min_500bp_filtered2.fasta
exit
exit
exit
echo finished
#10746  
#0

screen -S busco2
srun -p long  --mem 250G --pty bash
conda activate BUSCO

for assembly in $(echo assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs); do
	Data=$(ls $assembly/contigs_min_500bp_filtered2.fasta) 
	Input=$(dirname $assembly)

	mkdir -p $Input/BUSCO/fungi/1/filtered2
	cd $Input/BUSCO/fungi/1
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered2 -l fungi_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/ascomycota/1/filtered2
	cd $Input/BUSCO/ascomycota/1
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered2 -l ascomycota_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/leotiomycetes/1/filtered2
	cd $Input/BUSCO/leotiomycetes/1
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o filtered2 -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done
exit
exit
echo finished

conda activate quast
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/contigs_min_500bp_filtered2.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)/filtered2
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#764770
```
As our sample is apparently contaminated with Sporobolomyces roseus, as revealed by kraken2, another assembly was performed after removing Sporobolomyces roseus aligned reads. This assembly will be compared to the assembly resulting from removing Sporobolomyces roseus at the contig stage.
```bash
#Bowtie
#red and black raspberry + sporobolomyces
screen -S bowtie
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
cp /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis.fasta /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis+Sporobolomyces.fasta
cat /data/scratch/heavet/assembly/genome/Sporobolomyces/roseus/GCA_016617785.1_ASM1661778v1_genomic.fna >> /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis+Sporobolomyces.fasta
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces
bowtie2-build /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis+Sporobolomyces.fasta rubusidaeus+occidentalis+Sporobolomyces_index
bowtie2 \
-x rubusidaeus+occidentalis+Sporobolomyces_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces.sam \
--un-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr.fq.gz \
-S THeavenSCOTT2020_1alignedrubusidaeus+occidentalis+Sporobolomyces.sam 2>&1 | tee -a report.txt
#% overall alignment

echo finished
conda deactivate
exit
exit

#files were renamed to correct extensions for spades
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr.fq.1.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-f.fq.gz 
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr.fq.2.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-r.fq.gz 
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s.fq.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s-s.fq.gz 

#files were unzipped
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-f.fq.gz
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-r.fq.gz 
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s-s.fq.gz

#SPAdes assemblies were created
conda activate spades
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/rubusidaeus+occidentalis+Sporobolomyces@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 20
  done
  #773223

  for ReadDir in $(ls -d alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/rubusidaeus+occidentalis+Sporobolomyces@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 20
  done
  #773224
conda deactivate

#Quast was used to assess the quality of genome assemblys:
conda activate quast

    for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/773223/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#776801

    for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/773224/*/contigs_min_500bp.fasta); do
    	ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
    	OutDir=$(dirname $Assembly)
    	echo $Assembly
    	echo $OutDir
    	sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#776802
conda deactivate
#Quast results are very similar

#BUSCO analysis was performed of the SPAdes assembly using three databases.
screen -S busco
srun -p himem -J busco --mem 350G --pty bash
conda activate BUSCO

for assembly in $(echo assembly/metagenome/P_aphanis/*/SPAdes/773223/filtered_contigs); do
	Data=$(ls $assembly/contigs_min_500bp.fasta) 
	Input=$(dirname $assembly)

	mkdir -p $Input/BUSCO/fungi/1
	cd $Input/BUSCO/fungi
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/ascomycota/1
	cd $Input/BUSCO/ascomycota
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/leotiomycetes/1
	cd $Input/BUSCO/leotiomycetes
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done

for assembly in $(echo assembly/metagenome/P_aphanis/*/SPAdes/773224/filtered_contigs); do
	Data=$(ls $assembly/contigs_min_500bp.fasta) 
	Input=$(dirname $assembly)

	mkdir -p $Input/BUSCO/fungi/1
	cd $Input/BUSCO/fungi
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l fungi_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/ascomycota/1
	cd $Input/BUSCO/ascomycota
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l ascomycota_odb10
	cd /projects/nano_diagnostics

	mkdir -p $Input/BUSCO/leotiomycetes/1
	cd $Input/BUSCO/leotiomycetes
	busco -f -m genome -i /projects/nano_diagnostics/$Data -o 1 -l leotiomycetes_odb10
	cd /projects/nano_diagnostics
done
exit
exit
echo finished
#BUSCO results are exactly the same

#Kraken was used to identify the origin of contigs in the assemblies:
```bash
#Kraken was run with the updated database
screen -S kraken
srun -p himem -J kraken2 --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutput773223.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-out773223.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntclassified-out773223.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreport773223.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/773223/filtered_contigs/contigs_min_500bp.fasta
#  
#  

kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutput773224.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-out773224.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntclassified-out773224.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreport773224.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/773224/filtered_contigs/contigs_min_500bp.fasta
#
#
exit
exit
echo finished
```