# P.aphanis genome assembly and annotation pipeline

Documentation of analysis and commands used with P.aphanis sampled from raspberry as part of Nano Diagnistics PhD.

All following commands were execited on the NIAB HPC from the folder /projects/nano_diagnostics up to gene prediction steps, at this point files were moved to the Crop Diversity HPC and commands were executed from the /home/theaven/scratch directory.

All bowtie2 folders have been subsequently deleted to save space.

All genomes that were stored in /data/scratch/heavet/assembly/genome have been moved to the crop diversity hpc to save space

## Collecting data

Raw MiSeq sequence data for P.aphanis was linked from long term storage in /archives to the working folder /projects/nano_diagnostics/

```bash
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all

ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21043699-Z01-F001/X204SC21043699-Z01-F001/raw_data/A2004202101/A2004202101_FDMS210203466-1a_H3WJHDSX2_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/SCOTT2020_1_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21043699-Z01-F001/X204SC21043699-Z01-F001/raw_data/A2004202101/A2004202101_FDMS210203466-1a_H3WJHDSX2_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/SCOTT2020_1_r.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21043699-Z01-F001/X204SC21043699-Z01-F001/raw_data/A2004202101/A2004202101_FDMS210203466-1a_H3WJHDSX2_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all/SCOTT2020_1_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21043699-Z01-F001/X204SC21043699-Z01-F001/raw_data/A2004202101/A2004202101_FDMS210203466-1a_H3WJHDSX2_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all/SCOTT2020_1_r.fq.gz

ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLRA01/THMLRA01_FDSW210224379-1r_HTN5VDSXY_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/SCOTT2020_2_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLRA01/THMLRA01_FDSW210224379-1r_HTN5VDSXY_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/SCOTT2020_2_r.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLRA01/THMLRA01_FDSW210224379-1r_HTN5VDSXY_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all/SCOTT2020_2_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLRA01/THMLRA01_FDSW210224379-1r_HTN5VDSXY_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all/SCOTT2020_2_r.fq.gz
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

#In house red raspberry genome was uploaded pre-publication.
/data/scratch/heavet/assembly/genome/rubus/idaeus/AnitraCuratedED_HiC.fasta
```
There is no published P. aphanis genome assembly for comparison, other mildew genomes were downloaded for comparison.
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

wget -P /data/scratch/heavet/assembly/genome/Podosphaera/xanthii https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/010/015/925/GCA_010015925.1_POXAN_niab_assembly/GCA_010015925.1_POXAN_niab_assembly_genomic.fna.gz
wget -P /data/scratch/heavet/assembly/genome/Podosphaera/xanthii https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/014/884/795/GCA_014884795.1_ASM1488479v1/GCA_014884795.1_ASM1488479v1_genomic.fna.gz
gunzip /data/scratch/heavet/assembly/genome/Erysiphe/xanthii/*.gz

wget -P /data/scratch/heavet/assembly/genome/Podosphaera/cerasi https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/018/398/735/GCA_018398735.1_WSU_PS_Poc_1.0/GCA_018398735.1_WSU_PS_Poc_1.0_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Podosphaera/cerasi/*.gz

wget -P /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha https://sra-download.ncbi.nlm.nih.gov/traces/wgs01/wgs_aux/JA/AT/OF/JAATOF01/JAATOF01.1.fsa_nt.gz
gunzip /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/*.gz
```
The genomes of contaminant species were downloaded:
```bash
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
#788771
#788772

#The number of raw reads were counted:

cat rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/SCOTT2020_1_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#64,916,507
cat rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/SCOTT2020_1_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#64,916,507
cat rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/SCOTT2020_2_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,278,181
cat rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/SCOTT2020_2_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,278,181
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
#788775

for RawData in $(ls dna_qc/P_aphanis/*/THeavenSCOTT2020_1/*/002/*/*.fq.gz); do
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
#788776
#788777
#788778
#788779

zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz | echo $((`wc -l`/4))
#63,062,135
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#1,329,728
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz | echo $((`wc -l`/4))
#63,062,135
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#413,908
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim.fq.gz | echo $((`wc -l`/4))
#4,176,889
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#59,182
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim.fq.gz | echo $((`wc -l`/4))
#4,176,889
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#35,155
```
## Alignment

### bowtie2
A bioconda installation of bowtie was performed

Alignments were made to the red raspberry genome and black raspberry genome, those reads not aligning to either were carried forward for genome assembly.
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
Trimmed reads were also aligned to other mildew species and our draft P.aphanis genome assembly for comparison.
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
Coverage of data was estimated and the quality of sequencing data assessed using KAT.
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

#Coverage of the sequencing data was estimated.
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
Trimmed reads that did not align to either raspberry genome were taken as raw data for assembly. Reads were renamed for input into SPAdes.
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

Trimmed MiSeq reads were assembled using the program SPAdes, contigs <500bp filtered out with abyss. Several cuttoff values were trialled.
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
Quast was used to assess the quality of genome assemblies.
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
BUSCO was used to assess the completeness of the genome assemblies.
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
Based upon the results of quast and BUSCO the assembly using cuttoff of 20 was carried forward for further analysis.

### KAT
KAT was used to reassess coverage using assembled contigs.
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
## Filtering
As our samples were taken from wild outbreaks of powdery mildew we anticipate that they will contain contaminants. The program kraken2 was used to assign taxonomic identity to each assembled contig and thereby identify any contaminants in the sample.
### Kraken2
Kraken2 was used to screen the assembly for contaminant contigs.
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
The kraken2 databases built previously did not contain any raspberry genomes. As mildew samples were collected from raspberry plants this is a likely contaminant of our assembly. A new database was built containing raspberry as well as all other mildew genomes available for download from the NCBI database and a contaminant identified durng initail ITS sequencing of the sample.
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
The new database was used to identify the origin of contigs in the assembly.
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

#An assemlby with cuttoff of 10 was also investigated
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
#Kraken2 results further confirm that the 20 cuttoff assembly is our best assembly
```
Kraken results indicate that our sample is contaminated with Sporobolomyces roseus with 12.26% of contigs identified as this species.

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
As we know that there is a contaminant fungus in the sample it needs to be decided whether or not to include any contigs unclassified by kraken2 in our final assembly.

Following the removal of contaminant contigs, kraken2, BUSCO and quast analysis were performed again for the filtered assembly. 
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
As our sample is contaminated with Sporobolomyces roseus, as revealed by kraken2, another assembly was performed after removing Sporobolomyces roseus aligned reads. This assembly was compared to the assembly resulting from removing Sporobolomyces roseus at the contig stage.
```bash
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
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces.sam \
--un-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr.fq.gz \
-S THeavenSCOTT2020_1alignedrubusidaeus+occidentalis+Sporobolomyces.sam 2>&1 | tee -a report.txt
#16.92% overall alignment #EXTRA

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
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
  #780910
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

    for Assembly in $(ls assembly/metagenome/P_aphanis/*/SPAdes/780910/*/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#748817
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

for assembly in $(echo assembly/metagenome/P_aphanis/*/SPAdes/780910/filtered_contigs); do
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
#

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
#  12660 sequences classified (93.61%)
#  864 sequences unclassified (6.39%)

kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutput780910.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-out780910.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntclassified-out780910.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreport780910.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/780910/filtered_contigs/contigs_min_500bp.fasta
#  27776 sequences classified (65.91%)
#  14366 sequences unclassified (34.09%) 
exit
exit
echo finished

wc -l analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreport773223.txt #761
wc -l analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreport780910. #3623

#Many more species identified that are not powdery mildews in the assembly with a 10 coverage cuttoff, therefore the 20 cuttoff assembly continued with and not the 10.

touch analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contlist.txt
nano analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contlist.txt

#Edited with the following: 
Basidiomycota
Sporobolomyces
Sporidiobolaceae
Basidiomycota
Sporidiobolus
Rhodotorula
Melampsora
Agaricomycotina
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
Mycena
Serpula
Dacryopinax
Pseudozyma
Anthracocystis 
Acaromyces
Ceraceosorus
#metazoa
Homo sapiens
#plants
Mesangiospermae
Pentapetalae
rosids
fabids
Rubus
Fragaria
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
brasiliensis
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
Syzygium
Eucalyptus
Vitis riparia
Cynara
Lactuca
Helianthus
Daucus
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
Spinacia
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
Physcomitrium
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
Glycocaulis
Paracoccus
Pseudorhodobacter
Bradyrhizobium 
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
Clostridium
Anaerostipes
Lederbergia 
Brevibacillus
Mycoplasma 
Nostocales
Luteitalea 
Hymenobacter
#archaea
Halorubrum
Methanobacterium
#Viruses
Escherichia

grep -f analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contlist.txt analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutput773223.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontigs773223.txt
nawk -F"\\t" '{print $2}' analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontigs773223.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames773223.txt
conda activate seqtk
seqtk subseq /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/773223/filtered_contigs/contigs_min_500bp.fasta analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames773223.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminants773223.fasta
conda deactivate
conda activate Biopython
/home/heavet/git_repos/tools/DIY/filter.py /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/773223/filtered_contigs/contigs_min_500bp.fasta analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames773223.txt > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/filtered_contigs_min_500bp.fasta
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/filtered_contigs_min_500bp.fasta > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames773223.txt #2011
wc -l assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp.fasta #27048
wc -l assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta #23026

screen -S kraken2
srun -p himem -J kraken2 --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutputfiltered773223.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-outfiltered773223.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntclassified-outfiltered773223.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreportfiltered773223.txt \
--use-names \
/projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta
#  10649 sequences classified (92.50%)                                                                                                                                                     |
#  864 sequences unclassified (7.50%) 

screen -S busco
srun -p himem -J busco  --mem 350G --pty bash
conda activate BUSCO

for assembly in $(echo assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs); do
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
#BUSCO results are nearly identical for this assembly removing sporobolomyces at the read stage as for the assemby removing only at the contig stage following kraken2.

conda activate quast
    for Assembly in $(ls assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)/filtered
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#780138
#QUAST results are very similar for this assembly removing sporobolomyces at the read stage compared to the assemby removing only at the contig stage following kraken2. 81 less contigs, 164,389 bp less total genome length.
```
The assemblies are very similar however removing Sporobolomyces at the read stage is a more robust approach and to this assembly is carried forward.

As we know that there is a contaminant fungus in the sample it needs to be decided whether or not to include any contigs unclassified by kraken2 in our final assembly.

The unclassified contigs were extracted.
```bash
grep unclassified analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutputfiltered773223.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigs.txt
nawk -F"\\t" '{print $2}' analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigs.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigsnames.txt
conda activate seqtk
seqtk subseq /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/773223/filtered_contigs/contigs_min_500bp.fasta analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigsnames.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigs.fasta
conda deactivate
wc -l analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigs.fasta #1728
```
KAT was used to investigate the coverage of the unclassified contigs within our sequencing reads.
```bash
screen -S kat
srun -p himem  --mem 750G --pty bash
conda activate kat
cd /projects/nano_diagnostics

kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/THeavenSCOTT2020_1vdunclass773223 '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz' analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigs.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/THeavenSCOTT2020_1vdunclass773223plot300 alignment/P_aphanis/THeavenSCOTT2020_1/kat/THeavenSCOTT2020_1vdunclass773223-main.mx


kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/THeavenSCOTT2020_1vsporobolomyces '/projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz' analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomycescontigs.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/THeavenSCOTT2020_1vsporobolomycesplot300 alignment/P_aphanis/THeavenSCOTT2020_1/kat/THeavenSCOTT2020_1vsporobolomyces-main.mx

conda deactivate
exit
exit
echo finished
```
Reads were aligned to the genome. - - calculate median coverage over each contig in R - plot contigs in scatterplot (coverage x length?) and highlight unclassified contigs in plot (Do they fall within the distribution of classified contigs
```bash


screen -S bowtie
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_sporobolomyces
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_sporobolomyces
bowtie2-build /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomycescontigs.fasta Heaven_sporobolomyces
bowtie2 \
-x Heaven_sporobolomyces \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedHeaven_P_aphanis_sporo.sam \
--un-gz THeavenSCOTT2020_1unalignedHeaven_P_aphanis_sporo_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedHeaven_P_aphanis_sporo_fr.fq.gz \
-S THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp.sam 2>&1 | tee -a report.txt
#6.69% overall alignment
conda deactivate
exit
exit
echo finished
samtools view -S -b THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp.sam > THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp.bam
samtools sort THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp.bam -o THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp.sorted.bam
samtools faidx /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomycescontigs.fasta
awk -v OFS='\t' {'print $1,$2'} /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomycescontigs.fasta.fai > /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomycescontigs.txt
genomeCoverageBed -ibam THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp.sorted.bam -g /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/Sporobolomycescontigs.txt -d > coverageperbase.txt
sed -n '0~100p' coverageperbase.txt > coverageperbase100th.txt
nano coverageperbase100th.txt #editied with column headers
#Files were then downloaded for processing with R

screen -S bowtie
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_aphanis_rasp
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_aphanis_rasp
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta Heaven_P_aphanis_rasp_index
bowtie2 \
-x Heaven_P_aphanis_rasp_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedHeaven_P_aphanis_rasp.sam \
--un-gz THeavenSCOTT2020_1unalignedHeaven_P_aphanis_rasp_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedHeaven_P_aphanis_rasp_fr.fq.gz \
-S THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp.sam 2>&1 | tee -a report.txt
#51.83% overall alignment

conda deactivate
exit
exit
echo finished

samtools view -S -b THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp.sam > THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp.bam
samtools sort THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp.bam -o THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp.sorted.bam
samtools faidx /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta
awk -v OFS='\t' {'print $1,$2'} /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta.fai > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.txt
genomeCoverageBed -ibam THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp.sorted.bam -g /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.txt -d > coverageperbase.txt
sed -n '0~1000p' coverageperbase.txt > coverageperbase1000th.txt
nano coverageperbase1000th.txt #editied with column headers
grep -f /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigsnames.txt coverageperbase1000th.txt > unclasscoverageperbase1000th.txt
nano unclasscoverageperbase1000th.txt #editied with column headers
#Files were then downloaded for processing with R

screen -S bowtie
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_aphanis_rasp2
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_aphanis_rasp2
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/contigs_min_500bp_filtered2.fasta Heaven_P_aphanis_rasp2_index
bowtie2 \
-x Heaven_P_aphanis_rasp2_index \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedHeaven_P_aphanis_rasp2.sam \
--un-gz THeavenSCOTT2020_1unalignedHeaven_P_aphanis_rasp2_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedHeaven_P_aphanis_rasp2_fr.fq.gz \
-S THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp2.sam 2>&1 | tee -a report.txt
#51.77% overall alignment rate

conda deactivate
exit
exit
echo finished

samtools view -S -b THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp2.sam > THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp2.bam
samtools sort THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp2.bam -o THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp2.sorted.bam
samtools faidx /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/contigs_min_500bp_filtered2.fasta
awk -v OFS='\t' {'print $1,$2'} /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/contigs_min_500bp_filtered2.fasta.fai > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/contigs_min_500bp_filtered2.txt
genomeCoverageBed -ibam THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp2.sorted.bam -g /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/758406/filtered_contigs/contigs_min_500bp_filtered2.txt -d > coverageperbase2.txt
sed -n '0~100p' coverageperbase2.txt > coverageperbase2100th.txt
nano coverageperbase2100th.txt #editied with column headers
#Files were then downloaded for processing with R

screen -S bowtie
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
cd /projects/nano_diagnostics
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_aphanis_rasp_un
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_aphanis_rasp_un
bowtie2-build /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigs.fasta Heaven_P_aphanis_rasp_index_un
bowtie2 \
-x Heaven_P_aphanis_rasp_index_un \
-1 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz \
-2 /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz \
-U /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /projects/nano_diagnostics/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedHeaven_P_aphanis_rasp_un.sam \
--un-gz THeavenSCOTT2020_1unalignedHeaven_P_aphanis_rasp_un_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedHeaven_P_aphanis_rasp_un_fr.fq.gz \
-S THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp_un.sam 2>&1 | tee -a report.txt
#0.74% overall alignment rate

samtools view -S -b THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp_un.sam > THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp_un.bam
samtools sort THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp_un.bam -o THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp_un.sorted.bam
samtools faidx /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigs.fasta
awk -v OFS='\t' {'print $1,$2'} /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigs.fasta.fai > /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigs.fasta.txt
genomeCoverageBed -ibam THeavenSCOTT2020_1alignedHeaven_P_aphanis_rasp_un.sorted.bam -g /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigs.fasta.txt -d > coverageperbase.txt

conda deactivate
exit
exit
echo finished
```
A kraken database was created for fungi with our draft podosphaera leucotricha and podosphaera aphanis assemblies were included. Unclassified reads were run against this to investigate whether any unclassified reads were captured in the strawberry sample.
```bash
#Build a fungi only kraken database:
cp assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta /data/scratch/heavet/assembly/genome/Podosphaera/aphanis/THeavenDRCT72020_1.fasta
cat /data/scratch/heavet/assembly/genome/Podosphaera/aphanis/THeavenDRCT72020_1.fasta | sed -e "s/>.*/&|kraken:taxid|79252/g" > /data/scratch/heavet/assembly/genome/Podosphaera/aphanis/THeavenDRCT72020_1.mod.fna
cp assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed.fasta /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/THeavenp11_1.fasta
cat /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/THeavenp11_1.fasta | sed -e "s/>.*/&|kraken:taxid|79249/g" > /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/THeavenp11_1.mod.fna
screen -S kraken2
srun -p long --mem 250G --pty bash
mkdir analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi4
conda activate kraken2
kraken2-build --download-taxonomy --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi4
for file in $(ls /scratch/public_data/tch/tmp123/fungi/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi4  2>&1 | tee -a 4.log
done
for assembly in $(ls /data/scratch/heavet/assembly/genome/*/*/*.mod.fna); do
kraken2-build --add-to-library $assembly --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi4 2>&1 | tee -a 4.log
done
kraken2-build --build --threads 1 --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi4
#kraken2-build --clean --threads 1 --db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi4 
exit
exit
echo finished 

screen -S kraken2
srun -p himem -J kraken2 --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi4 \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclass773223fungi.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-unclass773223fungi.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/classified-unclass773223fungi.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/reportunclass773223fungi.txt \
--use-names \
/projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclasscontigs.fasta
exit
exit
echo finished
```
Based upon these results it was decided to proceed with the assembly with Sporobolomyces reads exluded and to exclude the unclassified reads from our assembly.
```bash
echo unclassified >> analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contlist.txt
grep -f analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contlist.txt analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutput773223.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontigs773223.txt
nawk -F"\\t" '{print $2}' analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontigs773223.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames773223.txt
conda activate seqtk
seqtk subseq /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/773223/filtered_contigs/contigs_min_500bp.fasta analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames773223.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminants773223.fasta
conda deactivate
conda activate Biopython
/home/heavet/git_repos/tools/DIY/filter.py /projects/nano_diagnostics/assembly/metagenome/P_aphanis/*/SPAdes/773223/filtered_contigs/contigs_min_500bp.fasta analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames773223.txt > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/filtered_contigs_min_500bp.fasta
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/filtered_contigs_min_500bp.fasta > /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames773223.txt #2875
wc -l assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp.fasta #27048
wc -l assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta #21298
cat analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/classified-unclass773223fungi.txt | sed -e "s/kraken:taxid|79252/ /g" | sed -e "s/kraken:taxid|79249/ /g"> analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/classified-unclass773223fungimod.txt
cat analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/classified-unclass773223fungimod.txt >> assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta #21360

conda activate quast
    for Assembly in $(ls /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=/scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#12037
conda deactivate
```


### NCBI submission

Following filtering our assembly was submitted to NCBI with a request that they run it through their own contamination detection pipelines. The returned report was used to correct the assembly to NCBI standards. Contigs were renamed in accordance with ncbi recomendations. This was also done for our sporobolomyces contigs.
# After this point pipeline is work in progress
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#

# /projects has been read only for months and I can't put of work any longer, I will run the pipeline with additional data in the /scratch area

All following commands were exectuted from the folder:
```bash
/scratch/projects/heavet
```
## Collecting data

Raw MiSeq sequence data for P.aphanis was linked from long term storage in /archives and /main to the working folder /scratch/projects/heavet

```bash
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R
mkdir -p rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all

ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21043699-Z01-F001/X204SC21043699-Z01-F001/raw_data/A2004202101/A2004202101_FDMS210203466-1a_H3WJHDSX2_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/SCOTT2020_1_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21043699-Z01-F001/X204SC21043699-Z01-F001/raw_data/A2004202101/A2004202101_FDMS210203466-1a_H3WJHDSX2_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/SCOTT2020_1_r.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21043699-Z01-F001/X204SC21043699-Z01-F001/raw_data/A2004202101/A2004202101_FDMS210203466-1a_H3WJHDSX2_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all/SCOTT2020_1_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21043699-Z01-F001/X204SC21043699-Z01-F001/raw_data/A2004202101/A2004202101_FDMS210203466-1a_H3WJHDSX2_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all/SCOTT2020_1_r.fq.gz

ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLRA01/THMLRA01_FDSW210224379-1r_HTN5VDSXY_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/SCOTT2020_2_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLRA01/THMLRA01_FDSW210224379-1r_HTN5VDSXY_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/SCOTT2020_2_r.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLRA01/THMLRA01_FDSW210224379-1r_HTN5VDSXY_L4_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all/SCOTT2020_2_f.fq.gz
ln -s /archives/2021_eastmall_general/thomas_heaven_X204SC21063461-Z01-F001/X204SC21063461-Z01-F001/raw_data/THMLRA01/THMLRA01_FDSW210224379-1r_HTN5VDSXY_L4_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all/SCOTT2020_2_r.fq.gz

ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLRA01/THMLRA01_FDSW210224379-1r_HGHJ7DSX2_L1_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/SCOTT2020_3_f.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLRA01/THMLRA01_FDSW210224379-1r_HGHJ7DSX2_L1_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/SCOTT2020_3_r.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLRA01/THMLRA01_FDSW210224379-1r_HGHJ7DSX2_L1_1.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all/SCOTT2020_3_f.fq.gz
ln -s /main/temp-archives/2021_eastmall_general/UKI-NIAB-50-fungus-reseq-WOBI_X204SC21063461-Z01-F003/X204SC21063461-Z01-F003/raw_data/THMLRA01/THMLRA01_FDSW210224379-1r_HGHJ7DSX2_L1_2.fq.gz rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/1/all/SCOTT2020_3_r.fq.gz
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
#118832
#118833
#118834
#118835
#118836
#118837

#The number of raw reads were counted:

cat rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/SCOTT2020_1_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#64,916,507
cat rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/SCOTT2020_1_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#64,916,507
cat rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/SCOTT2020_2_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,278,181
cat rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/SCOTT2020_2_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#4,278,181
cat rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/SCOTT2020_3_f.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#36,376,676
cat rawdata/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/SCOTT2020_3_r.fq.gz | gunzip -cf | echo $((`wc -l`/4))
#36,376,676
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
#11840
#11841
#11842

for RawData in $(ls dna_qc/P_aphanis/*/THeavenSCOTT2020_1/*/*/*/*.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename $RawData .fq.gz)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#11869
#11870
#11871
#11872
#11873
#11874
#11875
#11876
#11877
#11878
#11879
#11880

zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz | echo $((`wc -l`/4))
#63,062,135
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#1,329,728
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz | echo $((`wc -l`/4))
#63,062,135
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#413,908
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim.fq.gz | echo $((`wc -l`/4))
#4,176,889
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#59,182
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim.fq.gz | echo $((`wc -l`/4))
#4,176,889
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#35,155
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim.fq.gz | echo $((`wc -l`/4))
#35,443,812
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#638,893
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim.fq.gz | echo $((`wc -l`/4))
#35,443,812
zcat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim_unpaired.fq.gz | echo $((`wc -l`/4))
#235,815
```

```bash
mkdir -p dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/F
touch dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_F_trim.fq.gz

cat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_F_trim.fq.gz
touch dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_F_trim_unpaired.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_F_trim.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_F_trim_unpaired.fq.gz

mkdir -p dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/R
touch dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_R_trim.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim.fq.gz dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_R_trim.fq.gz
touch dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_R_trim_unpaired.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_R_trim.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_R_trim_unpaired.fq.gz

touch dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_trim_unpaired.fq.gz
cat dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_F_trim_unpaired.fq.gz dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_R_trim_unpaired.fq.gz > dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_trim_unpaired.fq.gz

for RawData in $(ls dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/all/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-all_trim_unpaired.fq.gz); do
echo $RawData
ProgDir=~/git_repos/tools/seq_tools/dna_qc
OutDir=$(dirname $RawData)
Outfile=$(basename $RawData)_fastqc
sbatch $ProgDir/srun_fastqc.sh $RawData $OutDir $Outfile
done
#18878
```
## Alignment

### bowtie2
A bioconda installation of bowtie was performed

Alignments were made to the red raspberry genome and black raspberry genome as well as the known contaminant sporobolomyces genome, those reads not aligning to either were carried forward for genome assembly. Aligment was made to our strawberry P aphanis genome for comparison.

```bash
#In house red raspberry + black raspberry + sporobolomyces
cp /data/scratch/heavet/assembly/genome/rubus/idaeus/AnitraCuratedED_HiC.fasta /scratch/projects/heavet/alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/rubusidaeus+occidentalis+Sporobolomyces.fasta
cat /projects/nano_diagnostics/assembly/genome/rubus/occidentalis/VanBuren/Rubus_occ_V3_10-12-17.fasta >> /scratch/projects/heavet/alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/rubusidaeus+occidentalis+Sporobolomyces.fasta
cat /data/scratch/heavet/assembly/genome/Sporobolomyces/roseus/GCA_016617785.1_ASM1661778v1_genomic.fna >> /scratch/projects/heavet/alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/rubusidaeus+occidentalis+Sporobolomyces.fasta
screen -S bowtie
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
cd /scratch/projects/heavet
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/rubusidaeus+occidentalis+Sporobolomyces.fasta alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2/rubusidaeus+occidentalis+Sporobolomyces.fasta 
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2
bowtie2-build /scratch/projects/heavet/alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/rubusidaeus+occidentalis+Sporobolomyces.fasta rubusidaeus2+occidentalis+Sporobolomyces_index
bowtie2 \
-x rubusidaeus2+occidentalis+Sporobolomyces_index \
-1 /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces.sam \
--un-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr.fq.gz \
-S THeavenSCOTT2020_1alignedrubusidaeus+occidentalis+Sporobolomyces.sam 2>&1 | tee -a report.txt
#18.78% overall alignment rate
conda deactivate
exit
echo finished

#Both rubus idaeus + rubus occidentalis + sporobolomyces
screen -S bowtie
srun -p long  --mem 350G --pty bash
conda activate bowtie2
cd /scratch/projects/heavet
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/3
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/3
cp /scratch/projects/heavet/alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/rubusidaeus+occidentalis+Sporobolomyces.fasta /scratch/projects/heavet/alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/rubusidaeusx2+occidentalis+Sporobolomyces.fasta 
cat /projects/nano_diagnostics/assembly/genome/rubus/idaeus/Wight/rubusidaeus.fasta >> /scratch/projects/heavet/alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/rubusidaeusx2+occidentalis+Sporobolomyces.fasta
bowtie2-build /scratch/projects/heavet/alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/rubusidaeusx2+occidentalis+Sporobolomyces.fasta rubusidaeusx2+occidentalis+Sporobolomyces_index
bowtie2 \
-x rubusidaeusx2+occidentalis+Sporobolomyces_index \
-1 /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces.sam \
--un-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr.fq.gz \
-S THeavenSCOTT2020_1alignedrubusidaeus+occidentalis+Sporobolomyces.sam 2>&1 | tee -a report.txt
#19.45% overall alignment rate
conda deactivate
exit
echo finished

#red and black raspberry and sporobolomyces
screen -S bowtie7
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
cp /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis.fasta /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis+Sporobolomyces.fasta
cat /data/scratch/heavet/assembly/genome/Sporobolomyces/roseus/GCA_016617785.1_ASM1661778v1_genomic.fna >> /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis+Sporobolomyces.fasta
cd /scratch/projects/heavet
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces
bowtie2-build /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis+Sporobolomyces.fasta rubusidaeus+occidentalis+Sporobolomyces_index
bowtie2 \
-x rubusidaeus+occidentalis+Sporobolomyces_index \
-1 /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces.sam \
--un-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr.fq.gz \
-S THeavenSCOTT2020_1alignedrubusidaeus+occidentalis+Sporobolomyces.sam 2>&1 | tee -a report.txt
#19.13% overall alignment rate
conda deactivate
exit
exit
echo finished

#red and black raspberry
screen -S bowtie
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
mkdir /projects/nano_diagnostics/assembly/genome/rubus/DIY
cp /projects/nano_diagnostics/assembly/genome/rubus/idaeus/Wight/rubusidaeus.fasta /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis.fasta
cat /projects/nano_diagnostics/assembly/genome/rubus/occidentalis/VanBuren/Rubus_occ_V3_10-12-17.fasta >> /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis.fasta
cd /scratch/projects/heavet
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis
bowtie2-build /projects/nano_diagnostics/assembly/genome/rubus/DIY/rubusidaeus+occidentalis.fasta rubusidaeus+occidentalis_index
bowtie2 \
-x rubusidaeus+occidentalis_index \
-1 /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis2.sam \
--un-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis_fr.fq.gz \
-S THeavenSCOTT2020_1alignedrubusidaeus+occidentalis.sam 2>&1 | tee -a report.txt
#18.78% overall alignment rate
conda deactivate
exit
exit
echo finished

#In house draft strawberry powdery mildew genome
screen -S bowtie6
srun -p himem  --mem 350G --pty bash
conda activate bowtie2
cd /scratch/projects/heavet
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_aphanis
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_aphanis
bowtie2-build /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta Heaven_P_aphanis_index
bowtie2 \
-x Heaven_P_aphanis_index \
-1 /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim.fq.gz \
-2 /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim.fq.gz \
-U /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim_unpaired.fq.gz, /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim_unpaired.fq.gz \
--un THeavenSCOTT2020_1unalignedHeaven_P_aphanis.sam \
--un-gz THeavenSCOTT2020_1unalignedHeaven_P_aphanis_s.fq.gz \
--un-conc-gz THeavenSCOTT2020_1unalignedHeaven_P_aphanis_fr.fq.gz \
-S THeavenSCOTT2020_1alignedHeaven_P_aphanis.sam 2>&1 | tee -a report.txt
#36.90% overall alignment rate
conda deactivate
exit
exit
echo finished
```

## Coverage
Coverage of data was estimated and the quality of sequencing data assessed using KAT.
```bash
#Sequencing reads were compared with our in house p.aphanis genome
screen -S KAT
srun -p himem --mem 1000G --pty bash
conda activate kat
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis
kat comp -m 21 -v -h -t 8 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis/reads_v_Heaven_P_aphanis '/scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/filtered_contigs/contigs_min_500bp_filtered.fasta

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis/reads_v_Heaven_P_aphanisplot300 alignment/P_aphanis/THeavenSCOTT2020_1/kat/Heaven_P_aphanis/reads_v_Heaven_P_aphanis-main.mx

conda deactivate
exit
exit
echo finished

#Sequencing reads were compared with the available red raspberry genome
screen -S KAT2
srun -p himem --mem 1000G --pty bash
conda activate kat
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus
kat comp -m 21 -v -H 800000000 -I 800000000 -h -t 8 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus/reads_v_rubusidaeus '/scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim_unpaired.fq.gz' /projects/nano_diagnostics/assembly/genome/rubus/idaeus/Wight/rubusidaeus.fasta

kat plot spectra-cn -x 1100 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus/reads_v_rubusidaeusplot1100 alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeus/reads_v_rubusidaeus-main.mx

conda deactivate
exit
exit
echo finished

#Sequencing reads were compared with the anitra red raspberry genome
screen -S KAT
srun -p himem --mem 1000G --pty bash
conda activate kat
cd /scratch/projects/heavet/
mkdir -p alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeusanitra
kat comp -m 21 -v -H 800000000 -I 800000000 -h -t 8 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeusanitra/reads_v_rubusidaeus '/scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/001/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-001_R_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/002/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-002_R_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/F/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_F_trim_unpaired.fq.gz /scratch/projects/heavet/dna_qc/P_aphanis/MiSeq/THeavenSCOTT2020_1/paired/003/R/P_aphanis-MiSeq-THeavenSCOTT2020_1-paired-003_R_trim_unpaired.fq.gz' /data/scratch/heavet/assembly/genome/rubus/idaeus/AnitraCuratedED_HiC.fasta

kat plot spectra-cn -x 1100 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeusanitra/reads_v_rubusidaeusplot1100 alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeusanitra/reads_v_rubusidaeus-main.mx

kat plot spectra-cn -x 300 -o alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeusanitra/reads_v_rubusidaeusplot300 alignment/P_aphanis/THeavenSCOTT2020_1/kat/rubusidaeusanitra/reads_v_rubusidaeus-main.mx

conda deactivate
exit
echo finished

#Coverage of the sequencing data was estimated.
cd alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/Heaven_P_aphanis/coverage
samtools view --threads 8 -bS THeavenSCOTT2020_1alignedHeaven_P_aphanis.sam -o coverage/THeavenSCOTT2020_1alignedHeaven_P_aphanis.bam
cd coverage
samtools sort --threads 8 -o THeavenSCOTT2020_1alignedHeaven_P_aphanis_sorted.bam THeavenSCOTT2020_1alignedHeaven_P_aphanis.bam
samtools index -@ 8 THeavenSCOTT2020_1alignedHeaven_P_aphanis_sorted.bam THeavenSCOTT2020_1alignedHeaven_P_aphanis_sorted.bam.index
samtools coverage THeavenSCOTT2020_1alignedHeaven_P_aphanis_sorted.bam -o coverage.txt
#data from coverage.txt was copied into excel to estimate median and mean coverage
#median depth 363, mean depth x84.5 12528/12705 contigs
```

## Assembly
Trimmed reads that did not align to either raspberry genome were taken as raw data for assembly. Reads were renamed for input into SPAdes.
```bash
#files were renamed to correct extensions for spades
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr.fq.1.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-f.fq.gz 
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr.fq.2.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-r.fq.gz 
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s.fq.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s-s.fq.gz 
#files were unzipped
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-f.fq.gz
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-r.fq.gz 
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s-s.fq.gz

#Anitra raspberry:
#files were renamed to correct extensions for spades
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr.fq.1.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-f.fq.gz 
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr.fq.2.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-r.fq.gz 
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s.fq.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s-s.fq.gz 
#files were unzipped
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-f.fq.gz
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-r.fq.gz 
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s-s.fq.gz

#Both red raspberry:
#files were renamed to correct extensions for spades
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/3/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr.fq.1.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/3/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-f.fq.gz 
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/3/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr.fq.2.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/3/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-r.fq.gz 
mv alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/3/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s.fq.gz alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/3/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s-s.fq.gz 
#files were unzipped
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/3/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-f.fq.gz
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/3/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_fr-r.fq.gz 
gunzip alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/3/THeavenSCOTT2020_1unalignedrubusidaeus+occidentalis+Sporobolomyces_s-s.fq.gz
```
### SPAdes
A conda installation of SPAdes was performed

Trimmed MiSeq reads were assembled using the program SPAdes, contigs <500bp filtered out with abyss.
```bash
#Both red raspberry using 20 cuttoff established as best by N50 number from previous assemblies
conda activate spades
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/3); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/rubusidaeus+occidentalis+Sporobolomyces/3@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 20
  done
#15530
conda deactivate

#Anitra assembly using 20 cuttoff established as best by N50 number from previous assemblies
conda activate spades
  for ReadDir in $(ls -d alignment/P_aphanis/THeavenSCOTT2020_1/bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2); do
    ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/spades
    F_Read=$(ls $ReadDir/*f.fq)
    R_Read=$(ls $ReadDir/*r.fq)
    S_Read=$(ls $ReadDir/*s.fq)
    OutDir=$(echo $ReadDir|sed 's@alignment@assembly/metagenome@g'|sed 's@bowtie2/rubusidaeus+occidentalis+Sporobolomyces/2@SPAdes@g')
    echo $F_Read
    echo $R_Read
    echo $S_Read
    echo $OutDir
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 20
  done
#13760
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/scaffolds.fasta 500 > /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs/contigs_min_500bp.fasta
    for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#17832
conda deactivate

#Redundant assemblies:
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
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 10
  done
#12038
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/12038/scaffolds.fasta 500 > /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/12038/filtered_contigs/contigs_min_500bp.fasta
    for Assembly in $(ls /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/12038/filtered_contigs/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#13759
conda deactivate

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
#11942
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11942/scaffolds.fasta 500 > /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11942/filtered_contigs/contigs_min_500bp.fasta
    for Assembly in $(ls /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11942/filtered_contigs/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#11991
conda deactivate

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
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 30
  done
#11987
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11987/scaffolds.fasta 500 > /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11987/filtered_contigs/contigs_min_500bp.fasta
    for Assembly in $(ls /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11987/filtered_contigs/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#13756
conda deactivate

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
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 40
  done
#11988
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11988/scaffolds.fasta 500 > /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11988/filtered_contigs/contigs_min_500bp.fasta
    for Assembly in $(ls /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11988/filtered_contigs/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#13757
conda deactivate

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
    sbatch $ProgDir/submit_SPAdes.sh $F_Read $R_Read $S_Read $OutDir correct 50
  done
#11989
conda deactivate
conda activate quast
python /projects/oldhome/armita/git_repos/emr_repos/tools/seq_tools/assemblers/abyss/filter_abyss_contigs.py /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11989/scaffolds.fasta 500 > /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11989/filtered_contigs/contigs_min_500bp.fasta
    for Assembly in $(ls /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11989/filtered_contigs/contigs_min_500bp.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#13758
conda deactivate
```
## Filtering
As our samples were taken from wild outbreaks of powdery mildew we anticipate that they will contain contaminants. The program kraken2 was used to assign taxonomic identity to each assembled contig and thereby identify any contaminants in the sample.
### Kraken2
Kraken2 was used to screen the assembly for contaminant contigs.
```bash
#kraken was run with a general database containing all erysiphales genomes published on NCBI and the red and black raspberry genomes.
screen -S kraken2
srun -p himem -J kraken2 --mem 350G --pty bash
conda activate kraken2
cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutput13760.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-out13760.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntclassified-out13760.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreport13760.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs/contigs_min_500bp.fasta
# 15673 sequences classified (85.08%)
# 2748 sequences unclassified (14.92%)
conda deactivate
exit
exit
echo finished

#Contaminants were removed
touch analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contlistanitra.txt
nano analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contlistanitra.txt #edited to include all entries in analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreport13760.txt that were not ascomycota fungi, including unclassified. These were removed from the assembly as contaminants.
grep -f analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contlistanitra.txt analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutput13760.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontigs13760.txt
nawk -F"\\t" '{print $2}' analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontigs13760.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames13760.txt
conda activate seqtk
seqtk subseq /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/*/SPAdes/13760/filtered_contigs/contigs_min_500bp.fasta analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames13760.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminants13760.fasta
conda deactivate
conda activate Biopython
/home/heavet/git_repos/tools/DIY/filter.py /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/*/SPAdes/13760/filtered_contigs/contigs_min_500bp.fasta /scratch/projects/heavet/gene_pred_vAG/_sigP/split/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames13760.txt > /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs/filtered_contigs_min_500bp.fasta
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs/filtered_contigs_min_500bp.fasta > /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contlistanitra.txt #1158
wc -l analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontigs13760.txt #7703
wc -l analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames13760.txt #7703
wc -l analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminants13760.fasta #15406
wc -l /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs/filtered_contigs_min_500bp.fasta #902794
wc -l assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs/contigs_min_500bp.fasta #36842
wc -l assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs/contigs_min_500bp_filtered.fasta #21436

#A kraken database was created for fungi with our draft podosphaera leucotricha and podosphaera aphanis assemblies included. Unclassified reads were run against this to investigate whether any unclassified reads were captured in the strawberry sample.
screen -S kraken2
srun -p himem -J kraken2 --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi4 \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclass13760fungi.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-unclass13760fungi.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/classified-unclass13760fungi.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/reportunclass13760fungi.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-out13760.txt
#  44 sequences classified (1.60%)
#  2704 sequences unclassified (98.40%)
exit
exit
echo finished

#Those newly classified reads were added back into the genome

cat analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/classified-unclass13760fungi.txt >> assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs/contigs_min_500bp_filtered.fasta #21524

conda activate quast
    for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs/contigs_min_500bp_filtered.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#17842
conda deactivate

screen -S BUSCO4
srun -p long -J busco  --mem 250G --pty bash
conda activate BUSCO

for assembly in $(echo assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs); do
    Data=$(ls $assembly/contigs_min_500bp_filtered.fasta) 
    Input=$(dirname $assembly)

    mkdir -p $Input/BUSCO/fungi/1/filtered
    cd $Input/BUSCO/fungi/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l fungi_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

    mkdir -p $Input/BUSCO/ascomycota/1/filtered
    cd $Input/BUSCO/ascomycota/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l ascomycota_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split

    mkdir -p $Input/BUSCO/leotiomycetes/1/filtered
    cd $Input/BUSCO/leotiomycetes/1
    busco -f -m genome -i /scratch/projects/heavet/gene_pred_vAG/_sigP/split/$Data -o filtered -l leotiomycetes_odb10
    cd /scratch/projects/heavet/gene_pred_vAG/_sigP/split
done

conda deactivate
exit
exit
echo finished
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Redundant assemblies:

#kraken was run with a general database containing all erysiphales genomes published on NCBI and the red and black raspberry genomes.
screen -S kraken2
srun -p himem -J kraken2 --mem 350G --pty bash
conda activate kraken2
cd /scratch/projects/heavet
kraken2 \
--db /projects/nano_diagnostics/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutput11942_1.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-out11942_1.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntclassified-out11942_1.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreport11942_1.txt \
--use-names \
/scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11942/filtered_contigs/contigs_min_500bp.fasta
# 15608 sequences classified (84.72%) 
#  2814 sequences unclassified (15.28%)
conda deactivate
exit
exit
echo finished

#A new database was created containing the R.idaeus genome generated by NIAB.
screen -S kraken
srun -p himem -J kraken --mem 350G --pty bash
conda activate kraken2
mkdir /scratch/public_data/tch
cd /scratch/public_data/tch/tmp123
conda create -n biopython
conda activate biopython
conda update -n base conda
conda install -c conda-forge biopython
conda install pandas
mkdir -p /scratch/projects/heavet/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/plants
DBNAME=/scratch/projects/heavet/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/plants
kraken2-build --download-taxonomy --use-ftp --threads 20 --db $DBNAME 
python ../peptides-master/download_domain.py --domain plant --ext dna
kraken2-build --download-taxonomy --db /scratch/projects/heavet/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/plants 2>&1 | tee 1.log  #<-----ERROR HERE CANNOT UNZIP
for file in $(ls /scratch/public_data/tch/tmp123/plant/*.fna); do
    #echo $file
    kraken2-build --add-to-library $file --db /scratch/projects/heavet/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/plants 2>&1 | tee -a 1.log 
done
cat /data/scratch/heavet/assembly/genome/rubus/idaeus/AnitraCuratedED_HiC.fasta | sed -e "s/>.*/&|kraken:taxid|32247/g" > /data/scratch/heavet/assembly/genome/rubus/idaeus/AnitraCuratedED_HiC.mod.fna
for assembly in $(ls /data/scratch/heavet/assembly/genome/*/*/*.mod.fna); do
kraken2-build --add-to-library $assembly --db /scratch/projects/heavet/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/plants 2>&1 | tee -a 2.log
done
kraken2-build --build --db /scratch/projects/heavet/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/plants 2>&1 | tee -a 3.log
kraken2-build --clean --threads 20 --db /scratch/projects/heavet/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/plants
exit
exit
echo finished

touch analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contlist2.txt
nano analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contlist2.txt
#edited to include all entries in analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntreport11942.txt that were not Basidiomycota fungi, including unclassified. These were removed from the assembly as contaminants.


grep -f analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contlist2.txt analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntoutput11942.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontigs11942.txt
nawk -F"\\t" '{print $2}' analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontigs11942.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames11942.txt
conda activate seqtk
seqtk subseq /scratch/projects/heavet/assembly/metagenome/P_aphanis/*/SPAdes/11942/filtered_contigs/contigs_min_500bp.fasta analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames11942.txt > analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminants11942.fasta
conda deactivate
conda activate Biopython
/home/heavet/git_repos/tools/DIY/filter.py /scratch/projects/heavet/assembly/metagenome/P_aphanis/*/SPAdes/11942/filtered_contigs/contigs_min_500bp.fasta /scratch/projects/heavet/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames11942.txt > /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11942/filtered_contigs/filtered_contigs_min_500bp.fasta
conda deactivate
awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11942/filtered_contigs/filtered_contigs_min_500bp.fasta > /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11942/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/contaminantcontignames11942.txt #7715
wc -l assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11942/filtered_contigs/contigs_min_500bp.fasta #36844
wc -l assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11942/filtered_contigs/contigs_min_500bp_filtered.fasta #21414

#A kraken database was created for fungi with our draft podosphaera leucotricha and podosphaera aphanis assemblies included. Unclassified reads were run against this to investigate whether any unclassified reads were captured in the strawberry sample.

screen -S kraken2
srun -p himem -J kraken2 --mem 350G --pty bash
conda activate kraken2
kraken2 \
--db analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/fungi4 \
--output analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/unclass11942fungi.txt \
--unclassified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-unclass11942fungi.txt \
--classified-out analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/classified-unclass11942fungi.txt \
--report analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/reportunclass11942fungi.txt \
--use-names \
/scratch/projects/heavet/analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/ntunclassified-out11942.txt
#  45 sequences classified (1.60%)
#  2769 sequences unclassified (98.40%)
exit
exit
echo finished

#Those newly classified reads were added back into the genome

cat analysis/P_aphanis/THeavenSCOTT2020_1/kraken2/nt/classified-unclass11942fungi.txt >> assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11942/filtered_contigs/contigs_min_500bp_filtered.fasta
wc -l assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11942/filtered_contigs/contigs_min_500bp_filtered.fasta #21504

conda activate quast
    for Assembly in $(ls /scratch/projects/heavet/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11942/filtered_contigs/contigs_min_500bp_filtered.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#12032
conda deactivate

screen -S busco
srun -p long -J busco  --mem 250G --pty bash
conda activate BUSCO

for assembly in $(echo assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/11942/filtered_contigs); do
    Data=$(ls $assembly/contigs_min_500bp_filtered.fasta) 
    Input=$(dirname $assembly)

    mkdir -p $Input/BUSCO/fungi/1/filtered
    cd $Input/BUSCO/fungi/1
    busco -f -m genome -i /scratch/projects/heavet/$Data -o filtered -l fungi_odb10
    cd /scratch/projects/heavet

    mkdir -p $Input/BUSCO/ascomycota/1/filtered
    cd $Input/BUSCO/ascomycota/1
    busco -f -m genome -i /scratch/projects/heavet/$Data -o filtered -l ascomycota_odb10
    cd /scratch/projects/heavet

    mkdir -p $Input/BUSCO/leotiomycetes/1/filtered
    cd $Input/BUSCO/leotiomycetes/1
    busco -f -m genome -i /scratch/projects/heavet/$Data -o filtered -l leotiomycetes_odb10
    cd /scratch/projects/heavet
done

conda deactivate
exit
exit
echo finished
```
## NCBI submission
Following filtering our assembly was submitted to NCBI with a request that they run it through their own contamination detection pipelines. The returned report was used to correct the assembly to NCBI standards. Contigs were renamed in accordance with ncbi recomendations.

NCBI reports (FCSreport.txt) were manually downloaded to the following locations:
```bash
mkdir -p /scratch/projects/heavet/gene_pred_vAG/_sigP/split/genome_submission/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/NCBI_report_dir
mv /scratch/projects/heavet/gene_pred_vAG/_sigP/split/genome_submission/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/NCBI_report_dir/Contamination.txt /scratch/projects/heavet/gene_pred_vAG/_sigP/split/genome_submission/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/NCBI_report_dir/FCSreport.txt
```
These downloaded files were used to correct assemblies:
```bash
conda activate biopython
for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/filtered_contigs/contigs_min_500bp_filtered.fasta); do
NCBI_report=$(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/genome_submission/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/NCBI_report_dir/FCSreport.txt)
OutDir=$(dirname $Assembly|sed 's@filtered_contigs@ncbi_edits@g')
mkdir -p $OutDir
ProgDir=~/git_repos/tools/seq_tools/assemblers/assembly_qc/remove_contaminants
python $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/contigs_min_500bp_renamed.fasta --coord_file $NCBI_report > $OutDir/log.txt
done
conda deactivate

conda activate quast
    for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/ncbi_edits/contigs_min_500bp_renamed.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#17985
conda deactivate
```
Round 2
```bash
conda activate biopython
for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/ncbi_edits/contigs_min_500bp_renamed.fasta); do
NCBI_report=$(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/genome_submission/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/NCBI_report_dir/FCSreport2.txt)
OutDir=$(dirname $Assembly|sed 's@ncbi_edits@ncbi_edits2@g')
mkdir -p $OutDir
ProgDir=~/git_repos/tools/seq_tools/assemblers/assembly_qc/remove_contaminants
python2.7 $ProgDir/remove_contaminants.py --inp $Assembly --out $OutDir/contigs_min_500bp_renamed.fasta --coord_file $NCBI_report > $OutDir/log.txt
done
conda deactivate

conda activate quast
    for Assembly in $(ls /scratch/projects/heavet/gene_pred_vAG/_sigP/split/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/13760/ncbi_edits2/contigs_min_500bp_renamed.fasta); do
        ProgDir=/home/heavet/git_repos/tools/seq_tools/assemblers/assembly_qc/quast
        OutDir=$(dirname $Assembly)
        echo $Assembly
        echo $OutDir
        sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#18019
conda deactivate
```