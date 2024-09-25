# Powdery mildew comparative genomics pipeline

Documentation of analysis and commands used for comparative genomics work as part of Nano Diagnostics PhD. - This file documents effector prediciton and comparisons across the powdery mildew clade.

Genomes assembled and annotated in nano_diagnostics/P_aphanis, nano_diagnostics/P_leucotricha and nano_diagnostics/B_graminis were used alongside genomes downloaded from NCBI for the following analysis.

All the following commands were executed on the Crop Diversity HPC from the folder /home/theaven/scratch unless stated otherwise.

## Collecting data

Genomes were initially downloaded to the NIAB HPC, these were subsequently moved to the Crop Diversity HPC and all data in the /data/scratch/heavet directory of the NIAB HPC has since been deleted to save space.

Our powdery mildew genomes:
```bash
mkdir -p /data/scratch/heavet/assembly/genome/Podosphaera/aphanis
cp /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenDRCT72020_1/SPAdes/725715/ncbi_edits/contigs_min_500bp_renamed2.fasta /data/scratch/heavet/assembly/genome/Podosphaera/aphanis/THeavenDRCT72020_1.fna
cp /projects/nano_diagnostics/assembly/metagenome/P_aphanis/THeavenSCOTT2020_1/SPAdes/773223/filtered_contigs/contigs_min_500bp_filtered.fasta /data/scratch/heavet/assembly/genome/Podosphaera/aphanis/THeavenSCOTT2020_1.fna
cp /projects/nano_diagnostics/assembly/metagenome/P_leucotricha/THeavenp11_1/SPAdes/580029/ncbi_edits/contigs_min_500bp_renamed.fasta /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/THeavenp11_1.fna
cp /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/JAATOF01.1.fsa_nt /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/JAATOF01.fna
```

Downloaded powdery mildew genomes:
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
Secalis genomes
```bash
for Assembly in $(ls /home/theaven/scratch/assembly/metagenome/blumeria/graminis/secalis/*/SPAdes/256935*/filtered_contigs/S*contigs_min_500bp.fasta); do
Outname=$(echo $Assembly|rev|cut -f1 -d '/'|rev|sed 's@.fasta@.c.fna@g')
cp $Assembly data/assembly/genome/Blumeria/graminis/$Outname
done
```
```bash
conda activate quast
    for Assembly in $(ls data/assembly/genome/Podosphaera/xanthii/GCA_010015925.1_POXAN_niab_assembly_genomic.mod.fna); do
      ProgDir=apps/quast
      OutDir=$(dirname $Assembly)/quast
      echo $Assembly
      echo $OutDir
      sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#2538596
    for Assembly in $(ls data/assembly/genome/Podosphaera/leucotricha/JAATOF01.mod.fna); do
      ProgDir=apps/quast
      OutDir=$(dirname $Assembly)/quast
      echo $Assembly
      echo $OutDir
      sbatch $ProgDir/sub_quast.sh $Assembly $OutDir
    done
#2538597
conda deactivate
```
Download host genomes:
```bash
#Apple
cp /projects/oldhome/groups/harrisonlab/project_files/root_architecture/Apple_genome/GDDH13_1-1_formatted.fasta /data/scratch/heavet/assembly/genome/malus/domestica/GDDH13_1-1_formatted.fna

#Strawberry
cp /projects/nano_diagnostics/rawdata/F_ananassa/camarosa/genome/F_ana_Camarosa_6-28-17.fasta /data/scratch/heavet/assembly/genome/fragaria/ananassa/F_ana_Camarosa_6-28-17.fna

#Raspberry
cp /data/scratch/heavet/assembly/genome/rubus/idaeus/AnitraCuratedED_HiC.fasta /data/scratch/heavet/assembly/genome/rubus/idaeus/AnitraCuratedED_HiC.fna

wget -P /data/scratch/heavet/assembly/genome/rubus/idaeus/media-5.fna.gz https://www.biorxiv.org/content/biorxiv/early/2019/02/18/546135/DC5/embed/media-5.gz?download=true
gunzip /data/scratch/heavet/assembly/genome/rubus/idaeus/*.gz

wget -P /data/scratch/heavet/assembly/genome/rubus/occidentalis/Rubus_occ_V3_10-12-17.fna.gz https://www.rosaceae.org/rosaceae_downloads/Rubus_occidentalis/Rubus_occidentalis-genome.v3.0/assembly/Rubus_occ_V3_10-12-17.fasta.gz
gunzip /data/scratch/heavet/assembly/genome/rubus/occidentalis/*.gz

#Barley GCA_904849725.1
wget -P /data/scratch/heavet/assembly/genome/hordeum/vulgare/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/904/849/725/GCA_904849725.1_MorexV3_pseudomolecules_assembly/GCA_904849725.1_MorexV3_pseudomolecules_assembly_genomic.fna.gz  
gunzip /data/scratch/heavet/assembly/genome/hordeum/vulgare/*.gz

#Rye GCA_016097815.1 - powdery mildew raw data available but not assembly :( https://www.ncbi.nlm.nih.gov/sra/?term=SRP062198+secalis - menardo
wget -P /data/scratch/heavet/assembly/genome/secale/cereale/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/016/097/815/GCA_016097815.1_HAU_Weining_v1.0/GCA_016097815.1_HAU_Weining_v1.0_genomic.fna.gz
gunzip /data/scratch/heavet/assembly/genome/secale/cereale/*.gz

#Triticale - no genome available

#Wheat GCA_018294505.1
wget -P /data/scratch/heavet/assembly/genome/triticum/aestivum/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/018/294/505/GCA_018294505.1_IWGSC_CS_RefSeq_v2.1/GCA_018294505.1_IWGSC_CS_RefSeq_v2.1_genomic.fna.gz  
gunzip /data/scratch/heavet/assembly/genome/triticum/aestivum/*.gz

#Grapevine  GCA_000003745.2
wget -P /data/scratch/heavet/assembly/genome/vitus/vinifera/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/003/745/GCA_000003745.2_12X/GCA_000003745.2_12X_genomic.fna.gz   
gunzip /data/scratch/heavet/assembly/genome/vitus/vinifera/*.gz

#Pea    GCA_900700895.2
wget -P /data/scratch/heavet/assembly/genome/pisum/sativum/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/700/895/GCA_900700895.2_Pisum_sativum_v1a/GCA_900700895.2_Pisum_sativum_v1a_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/pisum/sativum/*.gz

#Flowering Dogwood - no genome available

#Sow thistle - no genome available

#Tobacco    GCA_000715135.1
wget -P /data/scratch/heavet/assembly/genome/nicotiana/tabacum/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/715/135/GCA_000715135.1_Ntab-TN90/GCA_000715135.1_Ntab-TN90_genomic.fna.gz
gunzip /data/scratch/heavet/assembly/genome/nicotiana/tabacum/*.gz

#Arabidopsis    GCA_000001735.2
wget -P /data/scratch/heavet/assembly/genome/Arabidopsis/thaliana/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/735/GCA_000001735.2_TAIR10.1/GCA_000001735.2_TAIR10.1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/Arabidopsis/thaliana/*.gz

#Phlox paniculata - no genome available

#Rubber tree    GCA_001654055.1
wget -P /data/scratch/heavet/assembly/genome/hevea/brasiliensis/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/654/055/GCA_001654055.1_ASM165405v1/GCA_001654055.1_ASM165405v1_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/hevea/brasiliensis/*.gz

#Tomato     GCA_000188115.3
wget -P /data/scratch/heavet/assembly/genome/solanum/lycopersicum/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/188/115/GCA_000188115.3_SL3.0/GCA_000188115.3_SL3.0_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/solanum/lycopersicum/*.gz

#Sweet cherry   GCA_002207925.1
wget -P /data/scratch/heavet/assembly/genome/prunus/avium/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/207/925/GCA_002207925.1_PAV_r1.0/GCA_002207925.1_PAV_r1.0_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/prunus/avium/*.gz

#Cucumber   GCA_000004075.3
wget -P /data/scratch/heavet/assembly/genome/cucumis/sativus/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/004/075/GCA_000004075.3_Cucumber_9930_V3/GCA_000004075.3_Cucumber_9930_V3_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/cucumis/sativus/*.gz

#Courgette  GCA_002806865.2
wget -P /data/scratch/heavet/assembly/genome/cucurbita/pepo/. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/806/865/GCA_002806865.2_ASM280686v2/GCA_002806865.2_ASM280686v2_genomic.fna.gz 
gunzip /data/scratch/heavet/assembly/genome/cucurbita/pepo/*.gz
```
Outgroup genomes downloaded:
```bash
mkdir -p assembly/genome/NCBI/S.cerevisiae
cd assembly/genome/NCBI/S.cerevisiae
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/146/045/GCF_000146045.2_R64/GCF_000146045.2_R64_genomic.fna.gz
gunzip GCF_000146045.2_R64_genomic.fna.gz
mkdir -p /data/scratch/heavet/assembly/genome/Saccharomyces/cerevisiae
cp /projects/nano_diagnostics/assembly/genome/NCBI/S.cerevisiae/GCF_000146045.2_R64_genomic.fna /data/scratch/heavet/assembly/genome/Saccharomyces/cerevisiae/GCF_000146045.2_R64_genomic.d.fna
```

Transfering data from NIAB hpc to Crop diversity hpc:

Genomes:
```bash
Arabidopsis/    erysiphales/    hevea/          Oidium/         rubus/          Sporidiobolus/
Blumeria/       Erysiphe/       hordeum/        pisum/          Saccharomyces/  Sporobolomyces/
cucumis/        fragaria/       malus/          Podosphaera/    secale/         triticum/
cucurbita/      Golovinomyces/  nicotiana/      prunus/         solanum/        vitus/

mkdir Arabidopsis/
  mkdir thaliana
mkdir hevea/
  mkdir brasiliensis
mkdir Oidium/
  mkdir heveae/
  mkdir neolycopersicim/
mkdir rubus/
  mkdir idaeus
  mkdir occidentalis
mkdir Sporidiobolus/
  mkdir pararoseus/  
  mkdir salmonicolor/
mkdir Blumeria/
  mkdir graminis
mkdir Erysiphe/ 
  mkdir necator
  mkdir pisi
  mkdir pulchra
mkdir hordeum/ 
  mkdir vulgare
mkdir pisum/ 
  mkdir sativum       
mkdir Saccharomyces/ 
  mkdir cerevisiae
mkdir Sporobolomyces/
  mkdir roseus
mkdir cucumis/
  mkdir sativus
mkdir fragaria/  
 mkdir vesca
 mkdir ananassa
mkdir malus/
  mkdir domestica
mkdir Podosphaera/  
  mkdir cerasi
  mkdir leucotricha
  mkdir xanthii
  mkdir aphanis
mkdir secale/
  mkdir cereale
mkdir triticum/
  mkdir aestivum
mkdir cucurbita/
  mkdir pepo
mkdir Golovinomyces/ 
  mkdir cichoracearum 
  mkdir magnicellulatus
mkdir nicotiana/
  mkdir tabacum     
mkdir prunus/ 
  mkdir avium     
mkdir solanum/
  mkdir lycopersicum      
mkdir vitus/
  mkdir vinifera

mkdir /home/theaven/scratch/data/assembly/genome/Erysiphe/alphitoides
mkdir /home/theaven/scratch/data/assembly/genome/Golovinomyces/magnicellulatus

scp -r /data/scratch/heavet/assembly/genome/vitus/vinifera/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/vitus/vinifera 
scp -r /data/scratch/heavet/assembly/genome/solanum/lycopersicum/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/solanum/lycopersicum
scp -r /data/scratch/heavet/assembly/genome/prunus/avium/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/prunus/avium
scp -r /data/scratch/heavet/assembly/genome/nicotiana/tabacum/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/nicotiana/tabacum
scp -r /data/scratch/heavet/assembly/genome/triticum/aestivum/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/triticum/aestivum 
scp -r /data/scratch/heavet/assembly/genome/Saccharomyces/cerevisiae/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Saccharomyces/cerevisiae
scp -r /data/scratch/heavet/assembly/genome/pisum/sativum/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/pisum/sativum 
scp -r /data/scratch/heavet/assembly/genome/hordeum/vulgare/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/hordeum/vulgare
scp -r /data/scratch/heavet/assembly/genome/hevea/brasiliensis/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/hevea/brasiliensis
scp -r /data/scratch/heavet/assembly/genome/Arabidopsis/thaliana/*.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Arabidopsis/thaliana 
scp -r /data/scratch/heavet/assembly/genome/fragaria/ananassa/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/fragaria/ananassa 
scp -r /data/scratch/heavet/assembly/genome/fragaria/vesca/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/fragaria/vesca
scp -r /data/scratch/heavet/assembly/genome/Sporobolomyces/roseus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Sporobolomyces/roseus
scp -r /data/scratch/heavet/assembly/genome/Sporidiobolus/pararoseus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Sporidiobolus/pararoseus
scp -r /data/scratch/heavet/assembly/genome/Sporidiobolus/salmonicolor/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Sporidiobolus/salmonicolor
scp -r /data/scratch/heavet/assembly/genome/rubus/occidentalis/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/rubus/occidentalis
scp -r /data/scratch/heavet/assembly/genome/rubus/idaeus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/rubus/idaeus 
scp -r /data/scratch/heavet/assembly/genome/Oidium/heveae/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Oidium/heveae 
scp -r /data/scratch/heavet/assembly/genome/Oidium/neolycopersicim/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Oidium/neolycopersicim
scp -r /data/scratch/heavet/assembly/genome/Blumeria/graminis/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Blumeria/graminis
scp -r /data/scratch/heavet/assembly/genome/Erysiphe/pisi/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Erysiphe/pisi 
scp -r /data/scratch/heavet/assembly/genome/Erysiphe/necator/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Erysiphe/necator 
scp -r /data/scratch/heavet/assembly/genome/Erysiphe/pulchra/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Erysiphe/pulchra
scp -r /data/scratch/heavet/assembly/genome/Golovinomyces/cichoracearum/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Golovinomyces/cichoracearum
scp -r /data/scratch/heavet/assembly/genome/Golovinomyces/magnicellulatus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Golovinomyces/magnicellulatus
scp -r /data/scratch/heavet/assembly/genome/secale/cereale/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/secale/cereale
scp -r /data/scratch/heavet/assembly/genome/cucurbita/pepo/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/cucurbita/pepo
scp -r /data/scratch/heavet/assembly/genome/malus/domestica/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/malus/domestica
scp -r /data/scratch/heavet/assembly/genome/cucumis/sativus/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/cucumis/sativus
scp -r /data/scratch/heavet/assembly/genome/Podosphaera/cerasi/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/cerasi
scp -r /data/scratch/heavet/assembly/genome/Podosphaera/xanthii/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/xanthii
scp -r /data/scratch/heavet/assembly/genome/Podosphaera/aphanis/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/aphanis
scp -r /data/scratch/heavet/assembly/genome/Podosphaera/leucotricha/*.mod.fna theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/data/assembly/genome/Podosphaera/leucotricha

#non-mildew genomes:
mkdir -p /home/theaven/scratch/data/assembly/genome/amorphotheca/resinae
cd /home/theaven/scratch/data/assembly/genome/amorphotheca/resinae
#Amorphotheca resinae:
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/019/875/GCA_003019875.1_Amore1/GCA_003019875.1_Amore1_genomic.fna.gz 
#Amorphotheca resinae:
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/018/167/515/GCA_018167515.1_ASM1816751v1/GCA_018167515.1_ASM1816751v1_genomic.fna.gz 
mkdir -p /home/theaven/scratch/data/assembly/genome/amorphotheca/araneosa
cd /home/theaven/scratch/data/assembly/genome/amorphotheca/araneosa
#Amorphotheca araneosa:
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/988/855/GCA_003988855.1_ASM398885v1/GCA_003988855.1_ASM398885v1_genomic.fna.gz  
mkdir -p /home/theaven/scratch/data/assembly/genome/ascocoryne/sarcoides
cd /home/theaven/scratch/data/assembly/genome/ascocoryne/sarcoides
#Ascocoryne sarcoides
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/328/965/GCA_000328965.1_ASM32896v1/GCA_000328965.1_ASM32896v1_genomic.fna.gz 
mkdir -p /home/theaven/scratch/data/assembly/genome/chlorociboria/aeruginascens
cd /home/theaven/scratch/data/assembly/genome/chlorociboria/aeruginascens
#Chlorociboria aeruginascens
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/276/475/GCA_002276475.2_Chloro_aeru_v2/GCA_002276475.2_Chloro_aeru_v2_genomic.fna.gz 
mkdir -p /home/theaven/scratch/data/assembly/genome/Glarea/lozoyensis
cd /home/theaven/scratch/data/assembly/genome/Glarea/lozoyensis
#Glarea lozoyensis
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/409/485/GCA_000409485.1_GLAREA/GCA_000409485.1_GLAREA_genomic.fna.gz
mkdir -p /home/theaven/scratch/data/assembly/genome/marssonina/brunnea
cd /home/theaven/scratch/data/assembly/genome/marssonina/brunnea
#Marssonina brunnea f. sp. multigermtubi
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/298/775/GCA_000298775.1_ASM29877v1/GCA_000298775.1_ASM29877v1_genomic.fna.gz
mkdir -p /home/theaven/scratch/data/assembly/genome/neobulgaria/alba
cd /home/theaven/scratch/data/assembly/genome/neobulgaria/alba
#Neobulgaria alba
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/988/965/GCA_003988965.1_ASM398896v1/GCA_003988965.1_ASM398896v1_genomic.fna.gz 
mkdir -p /home/theaven/scratch/data/assembly/genome/oidiodendron/maius
cd /home/theaven/scratch/data/assembly/genome/oidiodendron/maius
#Oidiodendron maius
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/827/325/GCA_000827325.1_Oidiodendron_maius_Zn_v1.0/GCA_000827325.1_Oidiodendron_maius_Zn_v1.0_genomic.fna.gz 
mkdir -p /home/theaven/scratch/data/assembly/genome/phialocephala/scopiformis
cd /home/theaven/scratch/data/assembly/genome/phialocephala/scopiformis
#Phialocephala scopiformis
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/500/285/GCA_001500285.1_Phisc1/GCA_001500285.1_Phisc1_genomic.fna.gz 
mkdir -p /home/theaven/scratch/data/assembly/genome/phialocephala/1
cd /home/theaven/scratch/data/assembly/genome/phialocephala/1
#Phialocephala
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/073/065/GCA_900073065.1_PAC_version_1/GCA_900073065.1_PAC_version_1_genomic.fna.gz 
gunzip /home/theaven/scratch/data/assembly/genome/*/*/*.gz

cd ~/scratch
mkdir -p data/assembly/genome/Quercus/robur
cd data/assembly/genome/Quercus/robur
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/932/294/415/GCA_932294415.1_dhQueRobu3.1/GCA_932294415.1_dhQueRobu3.1_genomic.fna.gz 
gunzip *.gz 
cd ~/scratch
mkdir -p data/assembly/genome/Capsicum/annuum
cd data/assembly/genome/Capsicum/annuum
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/878/395/GCA_002878395.3_UCD10Xv1.1/GCA_002878395.3_UCD10Xv1.1_genomic.fna.gz
gunzip *.gz 
cd ~/scratch
mkdir -p data/assembly/genome/Morus/alba
cd data/assembly/genome/Morus/alba
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/012/066/045/GCA_012066045.3_ASM1206604v3/GCA_012066045.3_ASM1206604v3_genomic.fna.gz 
gunzip *.gz 
cd ~/scratch
```

ls data/assembly/genome/Erysiphe/alphitoides/*.f*
ls data/assembly/genome/leveillula/taurica/*.f*
ls data/assembly/genome/parauncinula/polyspora/*.f* #genome not available from ENA as paper claims
ls data/assembly/genome/phyllactinia/moricola/*.f*
ls data/assembly/genome/pleochaeta/shiraiana/*.f*
ls data/assembly/genome/Golovinomyces/orontii/*.f*

ls data/assembly/genome/mollisia/scopiformis/*.f*
ls data/assembly/genome/drepanopeziza/brunnea/*.f*

ls data/assembly/genome/amorphotheca/resinae/*.f*
ls data/assembly/genome/arachnopeziza/araneosa/*.f*
ls data/assembly/genome/ascocoryne/sarcoides/*.f*
ls data/assembly/genome/chlorociboria/aeruginascens/*.f*
ls data/assembly/genome/Glarea/lozoyensis/*.f* 
ls data/assembly/genome/marssonina/brunnea/*.f*
ls data/assembly/genome/neobulgaria/alba/*.f*
ls data/assembly/genome/oidiodendron/maius/*.f*
ls data/assembly/genome/phialocephala/scopiformis/*.f*
ls data/assembly/genome/phialocephala/1/*.f* 

ls data/assembly/genome/Quercus/robur/*.f* 
ls data/assembly/genome/Capsicum/annuum/*.f* 
ls data/assembly/genome/Morus/alba/*.f* 

## Phylogeny

### Maximum likelihood phylogenetic tree - BUSCOs

A phylogenetic tree from powdery mildew species and their host species was generated using just the draft genomes (genomes that still don’t have the annotations yet).

### BUSCO

BUSCO was run to predict conserved genes:
```bash
#BUSCO has errors when using .mod.fna files due to the | symbol
while read file; do
  echo "$file"
  Out=$(echo $file|sed 's@.mod.fna@.c.fna@g')
  echo $Out
  sed 's/|kraken:taxid|/ /g' $file > $Out
done < piped.txt

conda activate BUSCO
for assembly in $(cat new.txt); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=fungi_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2734247,51,53,56,58,60,62, 3057144-164
conda deactivate
exit
echo finished

conda activate BUSCO
for assembly in $(cat new.txt); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=viridiplantae_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2462675-2462728, 2487763-8, 2488333-2488367, 2569867-71, 3057102-122
conda deactivate
exit
echo finished

conda activate BUSCO
for assembly in $(cat new.txt); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=ascomycota_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2463015-2463068,2488280-2488332, 2569873-77, 3057081-101
conda deactivate
exit
echo finished

conda activate BUSCO
for assembly in $(cat new.txt); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=leotiomycetes_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2463069-2463122, 2487770-2487809, 2569879-83, 3057123-143
conda deactivate
exit
echo finished





for assembly in $(ls data/assembly/genome/ascocoryne/sarcoides/*.f*); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=ascomycota_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
for assembly in $(ls data/assembly/genome/pleochaeta/shiraiana/*.f*); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=viridiplantae_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#HEAVEN_strawb2021.fna
#HEAVEN_apple2019.fna
#HEAVEN_apple2021.fna
for assembly in $(ls data/assembly/genome/Podosphaera/*/HEAVEN_strawb2021.fna); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=leotiomycetes_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done 
for assembly in $(ls data/assembly/genome/marssonina/brunnea/*.f*); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=fungi_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#3057167-


conda activate BUSCO
for assembly in $(ls data/assembly/genome/cucumis/melo/GCA_025177605.1_USDA_Cmelo_AY_1.0_genomic.fna); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=viridiplantae_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done


ls -d gene_pred/*/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/busco_sequences/single_copy_busco_sequences

ls gene_pred/*/*/*/BUSCO/*/*/*/full_table.tsv
```

Short summary files from BUSCo run directories were copied to another directory in order to generate BUSCO plots:

```bash
mkdir -p gene_pred/busco_summaries/plant
mkdir -p gene_pred/busco_summaries/ascomycota
mkdir -p gene_pred/busco_summaries/leotiomycetes
for file in $(ls gene_pred/*/*/*/BUSCO/viridiplantae_odb10/*/short_summary*); do
cp $file gene_pred/busco_summaries/plant/.;
done
for file in $(ls gene_pred/*/*/*/BUSCO/ascomycota_odb10/*/short_summary*); do
cp $file gene_pred/busco_summaries/ascomycota/.;
done
for file in $(ls gene_pred/*/*/*/BUSCO/leotiomycetes_odb10/*/short_summary*); do
cp $file gene_pred/busco_summaries/leotiomycetes/.;
done
```
Complete BUSCO genes were extracted from the output of BUsco runs:
```bash
#Mildew BUSCOs:
for file in $(ls gene_pred/Podosphaera/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Erysiphe/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Blumeria/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Golovinomyces/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Oidium/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Saccharomyces/*/*4/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/leveillula/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/phyllactinia/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/pleochaeta/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/mollisia/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/drepanopeziza/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/amorphotheca/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/arachnopeziza/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/ascocoryne/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/chlorociboria/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Glarea/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/marssonina/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/neobulgaria/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/oidiodendron/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/phialocephala/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done

#Host BUSCOs:
for file in $(ls gene_pred/Arabidopsis/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/malus/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/secale/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/vitus/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/fragaria/*/*c/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/nicotiana/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/solanum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/prunus/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/cucumis/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/hevea/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/rubus/*/*c/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/cucurbita/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/hordeum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/pisum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/triticum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Quercus/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Capsicum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Morus/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
for file in $(ls gene_pred/cucumis/melo/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt;
done
```
BUSCOs that were only present in less than 3 genomes were filtered out:

```bash
#Mildew BUSCOs:
sort analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt |uniq -c > analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids_with_counts.txt
grep -v " 2 " analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids_with_counts.txt | grep -v " 1 " > analysis/phylogeny/busco/mildew_leotiomycetes_final_busco_ids.txt
awk '{print $2}' analysis/phylogeny/busco/mildew_leotiomycetes_final_busco_ids.txt > analysis/phylogeny/busco/mildew_leotiomycetes_final_buscos_ids.txt

#Host BUSCOs:
sort analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt |uniq -c > analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids_with_counts.txt
grep -v " 2 " analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids_with_counts.txt | grep -v " 1 " > analysis/phylogeny/busco/host_viridiplantae_final_busco_ids.txt
awk '{print $2}' analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids_with_counts.txt > analysis/phylogeny/busco/host_viridiplantae_final_buscos_ids.txt
```
Genes (both nucleotides and amino acids) were copied to a different directory. - Note that the gene names for each BUSCO output are only indetified by BUSCO id with either faa or fna extenstions. If you try to copy them directly to a single directory, you will likely overwrite all the files and end up with only the last set of files. Therefore each BUSCO gene for each genome was assigned a unique name and then all were merged together, writing them to a single busco id file. Ssequence nameS (fasta header) were edited so to include organism identifiers.

NOTE:.fna files containing nucleotide information will not be created by busco unless --augustus parameter is used (has not been here).
```bash
#For pathogen; Blumeria Erysiphe Podosphaera Golovinomyces Oidium and Saccharomyces outgroup 

for file in $(ls gene_pred/*/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
ID=$(echo $file|cut -f4,5 -d '/'|sed 's@.c/BUSCO@@g')
echo $ID
rm -r gene_pred/*/*/${ID}/BUSCO/*/*/run_*/busco_sequences/single_copy_busco_sequences
done

mkdir -p analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa
mkdir -p analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt

for dir in $(ls -d gene_pred/*/*/*/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/busco_sequences/single_copy_busco_sequences); do
  sppname=$(echo $dir |cut -f 2-4 -d "/" | sed 's@/@_@g');
  abbrv=$(echo $sppname | sed 's@_@@g')
  echo $sppname
  echo $abbrv
  for file in $(ls $dir/*.faa); do
    out=$(echo $file |rev |cut -f 1 -d "/"|rev)
    cp $file analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}
    sed -i 's/^>/>'${abbrv}'|/g' analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}
  cut -f 1 -d ":" analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}.1
  mv analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}.1 analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/${sppname}_${out}
  done

#  for file in ${dir}/*.fna; do
#    cp $file analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}
#    sed -i 's/^>/>'${abbrv}'|/g' analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}
#  cut -f 1 -d ":" analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}.1
#  mv analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}.1 analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt/${sppname}_${out}  
#  done
done


#For hosts; Arabidopsis malus secale vitus fragaria nicotiana solanum prunus cucumis hevea rubus cucurbita hordeum pisum triticum

mkdir -p analysis/phylogeny/busco/host_viridiplantae_busco_aa
mkdir -p analysis/phylogeny/busco/host_viridiplantae_busco_nt

for dir in $(ls -d gene_pred/*/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/busco_sequences/single_copy_busco_sequences); do
  sppname=$(echo $dir |cut -f 2-4 -d "/" | sed 's@/@_@g');
  abbrv=$(echo $sppname | sed 's@_@@g')
  echo $sppname
  echo $abbrv
  for file in $(ls $dir/*.faa); do
    out=$(echo $file |rev |cut -f 1 -d "/"|rev)
    cp $file analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}
    sed -i 's/^>/>'${abbrv}'|/g' analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}
  cut -f 1 -d ":" analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}.1
  mv analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}.1 analysis/phylogeny/busco/host_viridiplantae_busco_aa/${sppname}_${out}
  done

#  for file in ${dir}/*.fna; do
#    cp $file analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}
#    sed -i 's/^>/>'${abbrv}'|/g' analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}
#  cut -f 1 -d ":" analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}.1
#  mv analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}.1 analysis/phylogeny/busco/host_viridiplantae_busco_nt/${sppname}_${out}  
#  done
done
exit 
exit
exit
```
Now that BUSCO genes have been named uniquely for each genome analysed they were copied into a single .fasta file one for each gene.
```bash
screen -S comps
srun -p long  -c 1 --mem 50G --pty bash
cd /home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa
buscos=/home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_final_buscos_ids.txt
lines=$(cat $buscos)
for line in $lines; do
  for faa in $(ls *_$line.faa); do
  echo $faa
  output=$(echo $line)_aa.fasta
  echo $output
  cat $faa >> $output
  done
done
rm *.faa

cd /home/theaven/scratch/uncompressed/analysis/phylogeny/busco/host_viridiplantae_busco_aa
buscos=/home/theaven/scratch/uncompressed/analysis/phylogeny/busco/host_viridiplantae_final_buscos_ids.txt
lines=$(cat $buscos)
for line in $lines; do
  for faa in $(ls *_$line.faa); do
  echo $faa
  output=$(echo $line)_aa.fasta
  echo $output
  cat $faa >> $output
  done
done
rm *.faa
exit
exit
```
Submit alignment for single copy busco genes with a hit in each organism
```bash 
conda activate mafft

  AlignDir=/home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa
  cd $AlignDir
  ProgDir=/home/theaven/scratch/apps/phylogeny
  sbatch $ProgDir/sub_mafft_alignment.sh $AlignDir
#2569979, 2859967, 3113181

  AlignDir=/home/theaven/scratch/uncompressed/analysis/phylogeny/busco/host_viridiplantae_busco_aa
  cd $AlignDir
  ProgDir=/home/theaven/scratch/apps/phylogeny
  sbatch $ProgDir/sub_mafft_alignment.sh $AlignDir
#2569980, 2859968, 3113182, 22958584
conda deactivate

cd ~/scratch  
```
create a folder for each gene
```bash
for gene in $(ls /home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/*_aligned.fasta); do
  ID=$(basename $gene |sed 's@_aa_aligned.fasta@@g')
  echo $ID
  mkdir /home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/$ID
  cp $gene /home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/$ID
done

for gene in $(ls /home/theaven/scratch/uncompressed/analysis/phylogeny/busco/host_viridiplantae_busco_aa/*_aligned.fasta); do
  ID=$(basename $gene |sed 's@_aa_aligned.fasta@@g')
  echo $ID
  mkdir /home/theaven/scratch/uncompressed/analysis/phylogeny/busco/host_viridiplantae_busco_aa/$ID
  cp $gene /home/theaven/scratch/uncompressed/analysis/phylogeny/busco/host_viridiplantae_busco_aa/$ID
done
```
Collect pathogen and hosts only:
```bash
#Pathogen:
for Alignment in $(ls /home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/*/*_aa_aligned.fasta); do
  Output=$(echo $Alignment | sed 's@aligned.fasta@aligned_path.fasta@g')
grep -A1 '>AMORPHOTHECARESINAE\|>ARACHNOPEZIZAARANEO\|>ASCOCORYNESARCOIDES\|>BLUMERIAGRAMINIS\|>CHLOROCIBORIAAERUGINASCENS\|>DREPANOPEZIZABRUNNEADREPANO\|>ERYSIPHE\|>GLAREALOZOYENSIS\|>GOLOVINOMYCES\|>LEVEILLULATAURICA\|>MARSSONINABRUNNEA\|>MOLLISIASCOPIFORMIS\|>NEOBULGARIAALBA\|>OIDIODENDRONMAIUS\|>OIDIUM\|>PHIALOCEPHALA\|>PHYLLACTINIAMORICOLA\|>PLEOCHAETASHIRAIANA\|>PODOSPHAERA\|>SACCHAROMYCESCEREVISIAE' $Alignment > $Output
done

#Host:
for Alignment in $(ls /home/theaven/scratch/uncompressed/analysis/phylogeny/busco/host_viridiplantae_busco_aa/*/*_aligned.fasta); do
  Output=$(echo $Alignment | sed 's@aligned.fasta@aligned_host.fasta@g')
grep -A1 '>ARABIDOPSISTHALIANA\|>CAPSICUMANNUUM\|>CUCUMISSATIVUS\|>CUCURBITAPEPO\|>FRAGARIA\|>HEVEABRASILIENS\|>HORDEUMVULGARE\|>MALUSDOMESTICA\|>MORUSALBA\|>NICOTIANATABACUM\|>PISUMSATIVUM\|>PRUNUSAVIUM\|>QUERCUSROBUR\|>RUBUS\|>SACCHAROMYCESCEREVISIAE\|>SECALECEREALE\|>SOLANUMLYCOPERSICUM\|>VITUSVINIFERA\|>TRITICUMAESTIVUM\|>CUCUMISMELO' $Alignment > $Output
done
```

Trimming sequence alignments using Trim-Al, this is a tool for removing spurious sequences and poorly aligned regions from multiple sequence alignments.
```bash
Note - automated1 mode is optimised for ML tree reconstruction
conda activate trimal
  for Alignment in $(ls /home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/*/*_aligned.fasta); do
    OutDir=$(dirname $Alignment)
    TrimmedName=$(basename $Alignment .fasta)"_trimmed.fasta"
    echo $Alignment
    echo $OutDir
    echo $TrimmedName
    trimal -in $Alignment -out $OutDir/$TrimmedName -keepheader -automated1
  done

  for Alignment in $(ls /home/theaven/scratch/uncompressed/analysis/phylogeny/busco/host_viridiplantae_busco_aa/*/*aa_aligned.fasta); do
    OutDir=$(dirname $Alignment)
    TrimmedName=$(basename $Alignment .fasta)"_trimmed.fasta"
    echo $Alignment
    echo $OutDir
    echo $TrimmedName
    trimal -in $Alignment -out $OutDir/$TrimmedName -keepheader -automated1
  done
conda deactivate

grep 'CUCUMISMELO' /home/theaven/scratch/uncompressed/analysis/phylogeny/busco/host_viridiplantae_busco_aa/*/*_trimmed.fasta
```
```bash
#headers contain special characters, are longer than 60 characters and include contig information, in this form astral will not run and will consider each contig a different species, the headers must therefore be edited, prior to running RAxML.

for Alignment in $(ls analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/*/*_trimmed.fasta); do
New=$(dirname $Alignment)/$(basename $Alignment .fasta)_edit.fasta
echo $New
cat $Alignment  | cut -f1 -d '|' > $New 
sed -i 's@|@.@g' $New 
sed -i 's@>AMORPHOTHECARESINAEGCA003019875.1AMORE1@>A.RESINAE.GCA003019875@g' $New
sed -i 's@>AMORPHOTHECARESINAEGCA018167515.1ASM1816751V1@>A.RESINAE.GCA018167515@g' $New
sed -i 's@>ARACHNOPEZIZAARANEOSAARACHNOPEZIZAARANEOSAGCA003988855.1ASM398885V1@>A.ARANEOSA.GCA003988855@g' $New
sed -i 's@>ASCOCORYNESARCOIDESGCA000328965.1ASM32896V1@>A.SARCOIDES.GCA000328965@g' $New
sed -i 's@>BLUMERIAGRAMINISGCA000401675.1A6TRIMMEDCLCASSEMBLYFLT.FA.C@>B.GRAMINIS.GCA000401675@g' $New
sed -i 's@>BLUMERIAGRAMINISGCA000417025.1ASM41702V1.C@>B.GRAMINIS.GCA000417025@g' $New
sed -i 's@>BLUMERIAGRAMINISGCA000417865.1BGT942021.C@>B.GRAMINIS.GCA000417865@g' $New
sed -i 's@>BLUMERIAGRAMINISGCA000418435.1BGT454NEWBLERASSEMBLY.C@>B.GRAMINIS.GCA000418435@g' $New
sed -i 's@>BLUMERIAGRAMINISGCA000441875.1BGT701.C@>B.GRAMINIS.GCA000441875@g' $New
sed -i 's@>BLUMERIAGRAMINISGCA900237765.1BGHRACE1V1.C@>B.GRAMINIS.GCA900237765@g' $New
sed -i 's@>BLUMERIAGRAMINISGCA900239735.1BGHDH14V4.C@>B.GRAMINIS.GCA900239735@g' $New
sed -i 's@>BLUMERIAGRAMINISGCA900519115.1BGTGENOMEV3.16.C@>B.GRAMINIS.GCA900519115@g' $New
sed -i 's@>BLUMERIAGRAMINISGCA900638725.1BGHK1V2.C@>B.GRAMINIS.GCA900638725@g' $New
sed -i 's@>BLUMERIAGRAMINISGCA905067625.1BGTRITICALETHUN12GENOMEV12.C@>B.GRAMINIS.GCA905067625@g' $New
sed -i 's@>BLUMERIAGRAMINISS1201CONTIGSMIN500BP.C@>B.GRAMINIS.S1201@g' $New
sed -i 's@>BLUMERIAGRAMINISS1203CONTIGSMIN500BP.C@>B.GRAMINIS.S1203@g' $New
sed -i 's@>BLUMERIAGRAMINISS1391CONTIGSMIN500BP.C@>B.GRAMINIS.S1391@g' $New
sed -i 's@>BLUMERIAGRAMINISS1400CONTIGSMIN500BP.C@>B.GRAMINIS.S1400@g' $New
sed -i 's@>BLUMERIAGRAMINISS1459CONTIGSMIN500BP.C@>B.GRAMINIS.S1459@g' $New
sed -i 's@>CHLOROCIBORIAAERUGINASCENSGCA002276475.2CHLOROAERUV2@>C.AERUGINASCENC.GCA002276475@g' $New
sed -i 's@>DREPANOPEZIZABRUNNEADREPANOPEZIZABRUNNEAGCA000298775.1ASM29877V1@>D.BRUNNEA.GCA000298775@g' $New
sed -i 's@>ERYSIPHEALPHITOIDESERYSIPHEALPHITOIDESCLCBIOASSEMBLYCDHITEST0.95MORETHAN500BP.FASTA@>E.ALPHITOIDES.CDHITEST0@g' $New
sed -i 's@>ERYSIPHENECATORGCA000798715.1ASM79871V1.C@>E.NECATOR.GCA000798715@g' $New
sed -i 's@>ERYSIPHENECATORGCA000798735.1ASM79873V1.C@>E.NECATOR.GCA000798735@g' $New
sed -i 's@>ERYSIPHENECATORGCA000798755.1ASM79875V1.C@>E.NECATOR.GCA000798755@g' $New
sed -i 's@>ERYSIPHENECATORGCA000798775.1ASM79877V1.C@>E.NECATOR.GCA000798775@g' $New
sed -i 's@>ERYSIPHENECATORGCA000798795.1ASM79879V1.C@>E.NECATOR.GCA000798795@g' $New
sed -i 's@>ERYSIPHENECATORGCA016906895.1ASM1690689V1.C@>E.NECATOR.GCA016906895@g' $New
sed -i 's@>ERYSIPHEPISIGCA000208805.1ASM20880V1.C@>E.PISI.GCA000208805@g' $New
sed -i 's@>ERYSIPHEPISIGCA000214055.1ASM21405V1.C@>E.PISI.GCA000214055@g' $New
sed -i 's@>ERYSIPHEPULCHRAGCA002918395.1ASM291839V1.C@>E.PULCHRA.GCA002918395@g' $New
sed -i 's@>GLAREALOZOYENSISGCA000409485.1GLAREA@>G.LOZOYENSIS.GCA000409485@g' $New
sed -i 's@>GOLOVINOMYCESCICHORACEARUMGCA003611195.1ASM361119V1.C@>G.CICHORACEARUM.GCA003611195@g' $New
sed -i 's@>GOLOVINOMYCESCICHORACEARUMGCA003611215.1ASM361121V1.C@>G.CICHORACEARUM.GCA003611215@g' $New
sed -i 's@>GOLOVINOMYCESCICHORACEARUMGCA003611235.1ASM361123V1.C@>G.CICHORACEARUM.GCA003611235@g' $New
sed -i 's@>GOLOVINOMYCESMAGNICELLULATUSGCA006912115.1ASM691211V1.C@>G.MAGNICELLULATUS.GCA006912115@g' $New
sed -i 's@>GOLOVINOMYCESORONTIIGOLOVINOMYCESORONTIIASSEMBLYSCAFFOLDS.FASTA@>G.ORONTII.1@g' $New
sed -i 's@>MARSSONINABRUNNEAGCA000298775.1ASM29877V1@>M.BRUNNEA.GCA000298775@g' $New
sed -i 's@>MOLLISIASCOPIFORMISMOLLISIASCOPIFORMISGCA001500285.1PHISC1@>M.SCOPIFORMIS.GCA001500285@g' $New
sed -i 's@>NEOBULGARIAALBAGCA003988965.1ASM398896V1@>N.ALBA.GCA003988965@g' $New
sed -i 's@>OIDIODENDRONMAIUSGCA000827325.1OIDIODENDRONMAIUSZNV1.0@>O.MAIUS.GCA000827325@g' $New
sed -i 's@>OIDIUMHEVEAEGCA003957845.1ASM395784V1.C@>O.HEVEAE.GCA003957845@g' $New
sed -i 's@>OIDIUMNEOLYCOPERSICIMGCA003610855.1ASM361085V1.C@>O.NEOLYCOPERSICUM.GCA003610855@g' $New
sed -i 's@>PHIALOCEPHALA1GCA900073065.1PACVERSION1@>P.1.GCA900073065@g' $New
sed -i 's@>PHIALOCEPHALASCOPIFORMISGCA001500285.1PHISC1@>P.SCOPIFORMIS.GCA001500285@g' $New
sed -i 's@>PHYLLACTINIAMORICOLAPHYLLACTINIAMORICOLAGCA019455665.1ASM1945566V1@>P.MORICOLA.GCA019455665@g' $New
sed -i 's@>PLEOCHAETASHIRAIANAPLEOCHAETASHIRAIANAGCA019455505.1ASM1945550V1@>P.SHIRAIANA.GCA019455505@g' $New
sed -i 's@>PODOSPHAERAAPHANISTHEAVENDRCT720201.C@>P.APHANIS.DRCT72020@g' $New
sed -i 's@>PODOSPHAERAAPHANISTHEAVENDRCT720211.C@>P.APHANIS.DRCT72021@g' $New
sed -i 's@>PODOSPHAERAAPHANISTHEAVENSCOTT20201.C@>P.APHANIS.SCOTT2020@g' $New
sed -i 's@>PODOSPHAERACERASIGCA018398735.1WSUPSPOC1.0.C@>P.CERASII.GCA018398735@g' $New
sed -i 's@>PODOSPHAERALEUCOTRICHAJAATOF01.C@>P.LEUCOTRICHA.JAATOF01@g' $New
sed -i 's@>PODOSPHAERALEUCOTRICHATHEAVENP111.C@>P.LEUCOTRICHA.P112020@g' $New
sed -i 's@>PODOSPHAERALEUCOTRICHATHEAVENPOGB20191.C@>P.LEUCOTRICHA.OGB2019@g' $New
sed -i 's@>PODOSPHAERALEUCOTRICHATHEAVENPOGB20211.C@>P.LEUCOTRICHA.OGB2021@g' $New
sed -i 's@>PODOSPHAERAXANTHIIGCA010015925.1POXANNIABASSEMBLY.C@>P.XANTHII.GCA010015925@g' $New
sed -i 's@>PODOSPHAERAXANTHIIGCA014884795.1ASM1488479V1.C@>P.XANTHII.GCA014884795@g' $New
sed -i 's@>SACCHAROMYCESCEREVISIAEGCF000146045.2R64@>S.CEREVISIAE.GCF000146045@g' $New
done

for Alignment in $(ls analysis/phylogeny/busco/host_viridiplantae_busco_aa/*/*aa_aligned_trimmed.fasta); do
New=$(dirname $Alignment)/$(basename $Alignment .fasta)_edit.fasta
echo $New
cat $Alignment  | cut -f1 -d '|' > $New 
sed -i 's@|@.@g' $New 
sed -i 's@>ARABIDOPSISTHALIANAGCA000001735.2TAIR10.1@>A.THALIANA.GCA000001735@g' $New
sed -i 's@>CAPSICUMANNUUMGCA002878395.3UCD10XV1.1@>C.ANNUUM.GCA002878395@g' $New
sed -i 's@>CUCUMISSATIVUSGCA000004075.3CUCUMBER9930V3@>C.SATIVUS.GCA000004075@g' $New
sed -i 's@>CUCURBITAPEPOGCA002806865.2ASM280686V2@>C.PEPO.GCA002806865@g' $New
sed -i 's@>FRAGARIAVESCAGCA000184155.1FRAVESHAWAII1.0.C@>F.VESCA.HAWAII@g' $New
sed -i 's@>FRAGARIAANANASSAFANACAMAROSA6-28-17.C@>F.ANANASSA.CAMAROSA@g' $New
sed -i 's@>HEVEABRASILIENSISGCA001654055.1ASM165405V1@>H.BRASILIENSIS.GCA001654055@g' $New
sed -i 's@>HORDEUMVULGAREGCA904849725.1MOREXV3PSEUDOMOLECULESASSEMBLY@>H.VULGARE.GCA904849725@g' $New
sed -i 's@>MALUSDOMESTICAGDDH131-1FORMATTED@>M.DOMESTICA.GDDH131@g' $New
sed -i 's@>MORUSALBAGCA012066045.3ASM1206604V3@>M.ALBA.GCA012066045@g' $New
sed -i 's@>NICOTIANATABACUMGCA000715135.1NTAB-TN90@>N.TABACUM.GCA000715135@g' $New
sed -i 's@>PISUMSATIVUMGCA900700895.2PISUMSATIVUMV1A@>P.SATIVUM.GCA900700895@g' $New
sed -i 's@>PRUNUSAVIUMGCA002207925.1PAVR1.0@>P.AVIUM.GCA002207925@g' $New
sed -i 's@>QUERCUSROBURGCA932294415.1DHQUEROBU3.1@>Q.ROBUR.GCA932294415@g' $New
sed -i 's@>RUBUSIDAEUSANITRACURATEDEDHIC.C@>R.IDAEUS.ANITRA@g' $New
sed -i 's@>RUBUSIDAEUSMEDIA-5.C@>R.IDAEUS.MEDIA5@g' $New
sed -i 's@>RUBUSOCCIDENTALISRUBUSOCCV310-12-17.C@>R.OCCIDENTALIS.V3@g' $New
sed -i 's@>SACCHAROMYCESCEREVISIAEGCF000146045.2R64@>S.CEREVISIAE.GCF000146045@g' $New
sed -i 's@>SECALECEREALEGCA016097815.1HAUWEININGV1.0@>S.CEREALE.GCA016097815@g' $New
sed -i 's@>SOLANUMLYCOPERSICUMGCA000188115.3SL3.0@>S.LYCOPERSICUM.GCA000188115@g' $New
sed -i 's@>VITUSVINIFERAGCA000003745.212X@>V.VINEFERA.GCA000003745@g' $New
sed -i 's@>CUCUMISMELOGCA025177605.1USDACMELOAY1.0@>C.MELO.GCA025177605@g' $New
done

#Is there a reason to use an array rather than a loop as below? Seem to make things more commpicated to rerun.
for Alignment in $(ls analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/*/*_trimmed_edit.fasta); do
Jobs=$(squeue -u theaven | wc -l)
echo x
while [ $Jobs -gt 128 ]; do
sleep 2s
printf "."
Jobs=$(squeue -u theaven | wc -l)
done   
printf "\n" >> raxmllog.txt
Prefix=$(basename $Alignment | cut -f1 -d '_')
echo $Prefix >> raxmllog.txt
OutDir=analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/RAxML2/$Prefix
ProgDir=/home/theaven/scratch/apps/phylogeny
sbatch $ProgDir/sub_RAxML.sh $Alignment $Prefix $OutDir 2>&1 >> pathraxmllog.txt
done
#3217974
for Alignment in $(ls analysis/phylogeny/busco/host_viridiplantae_busco_aa/*/*aa_aligned_trimmed_edit.fasta); do
Jobs=$(squeue -u theaven | wc -l)
echo x
while [ $Jobs -gt 64 ]; do
sleep 2s
printf "."
Jobs=$(squeue -u theaven | wc -l)
done   
printf "\n" >> raxmllog.txt
Prefix=$(basename $Alignment | cut -f1 -d '_')
echo $Prefix >> raxmllog.txt
OutDir=analysis/phylogeny/busco/host_viridiplantae_busco_aa/RAxML3/$Prefix
ProgDir=/home/theaven/scratch/apps/phylogeny
sbatch $ProgDir/sub_RAxML.sh $Alignment $Prefix $OutDir 2>&1 >> hostraxmllog2.txt
done
scontrol show job 3184121

mkdir -p /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/host/busco_nt/iqtree2
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/host/busco_nt/iqtree2
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/AlignDir2
cpu=4
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m MFA -T AUTO --threads-max $cpu -redo
#6290051

#Akaike Information Criterion:           Q.plant+F+R6
#Corrected Akaike Information Criterion: Q.plant+F+R6
#Bayesian Information Criterion:         Q.plant+F+R6
#Best-fit model: Q.plant+F+R6 chosen according to BIC

#Analysis results written to:
#  IQ-TREE report:                /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/suzz.iqtree
#  Tree used for ModelFinder:     /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/suzz.treefile
#  Screen log file:               /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/suzz.log

mv /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/suzz /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/host/busco_nt/iqtree2/AlignDir
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/host/busco_nt/iqtree2
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/host/busco_nt/iqtree2/AlignDir3
cpu=4
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m Q.plant+F+R6 -B 1000 -T AUTO --threads-max $cpu
#6323037

#Analysis results written to:
#  IQ-TREE report:                /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/host/busco_nt/iqtree2/AlignDir3.iqtree
#  Maximum-likelihood tree:       /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/host/busco_nt/iqtree2/AlignDir3.treefile
#  Likelihood distances:          /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/host/busco_nt/iqtree2/AlignDir3.mldist

#Ultrafast bootstrap approximation results written to:
#  Split support values:          /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/host/busco_nt/iqtree2/AlignDir3.splits.nex
#  Consensus tree:                /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/host/busco_nt/iqtree2/AlignDir3.contree
#  Screen log file:               /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/host/busco_nt/iqtree2/AlignDir3.log


```
```bash
for Alignment in $(ls analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/*/*_trimmed.fasta); do
#Jobs=$(squeue -u theaven | wc -l)
#echo x
#while [ $Jobs -gt 2000000 ]; do
#sleep 2s
#printf "."
#Jobs=$(squeue -u theaven | wc -l)
#done   
printf "\n" >> raxmllog.txt
Prefix=$(basename $Alignment | cut -f1 -d '_')
echo $Prefix >> raxmllog.txt
OutDir=analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/RAxML/$Prefix
ProgDir=/home/theaven/scratch/apps/phylogeny
sbatch $ProgDir/sub_RAxML.sh $Alignment $Prefix $OutDir 2>&1 >> pathraxmllog.txt
done
for Alignment in $(ls analysis/phylogeny/busco/host_viridiplantae_busco_aa/*/*_trimmed.fasta); do
#Jobs=$(squeue -u theaven | wc -l)
#echo x
#while [ $Jobs -gt 2000000 ]; do
#sleep 2s
#printf "."
#Jobs=$(squeue -u theaven | wc -l)
#done   
printf "\n" >> raxmllog.txt
Prefix=$(basename $Alignment | cut -f1 -d '_')
echo $Prefix >> raxmllog.txt
OutDir=analysis/phylogeny/busco/host_viridiplantae_busco_aa/RAxML/$Prefix
ProgDir=/home/theaven/scratch/apps/phylogeny
sbatch $ProgDir/sub_RAxML.sh $Alignment $Prefix $OutDir 2>&1 >> hostraxmllog.txt
done
```
```bash
conda activate astral
OutDir=/home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/ASTRAL_boot
mkdir -p $OutDir
cat analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/RAxML2/*/RAxML_bipartitionsBranchLabels.*  | sed -r "s/CTG.\w+:/:/g" > $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.tre
ProgDir=apps/astral/Astral/
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.tre -o $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.tre | tee 2> $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.log
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -q $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.tre -i $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.tre -o $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.scored.tre 2> $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.scored.log
ls analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/RAxML2/*/RAxML_bootstrap.* >  $OutDir/bs-files
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.tre -b $OutDir/bs-files -r 1000 -o $OutDir/leotiomycetes_Nd_phylogeny.bootstrapped.astral.tre 2> $OutDir/leotiomycetes_Nd_phylogeny.bootstrapped.astral.log


OutDir=/home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa/ASTRAL_boot
mkdir -p $OutDir
cat analysis/phylogeny/busco/host_viridiplantae_busco_aa/RAxML3/*/RAxML_bipartitionsBranchLabels.*  | sed -r "s/CTG.\w+:/:/g" > $OutDir/viridiplantae_Nd_phylogeny.boot.appended.tre
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/viridiplantae_Nd_phylogeny.boot.appended.tre -o $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.tre | tee 2> $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.log
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -q $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.tre -i $OutDir/viridiplantae_Nd_phylogeny.boot.appended.tre -o $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.scored.tre 2> $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.scored.log
ls analysis/phylogeny/busco/host_viridiplantae_busco_aa/RAxML3/*/RAxML_bootstrap.* >  $OutDir/bs-files
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/viridiplantae_Nd_phylogeny.boot.appended.tre -b $OutDir/bs-files -r 1000 -o $OutDir/viridiplantae_Nd_phylogeny.bootstrapped.astral.tre 2> $OutDir/viridiplantae_Nd_phylogeny.bootstrapped.astral.log


conda activate astral
OutDir=/home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/ASTRAL_boot
mkdir -p $OutDir
cat analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/RAxML2/*/RAxML_bipartitionsBranchLabels.*  | sed -r "s/CTG.\w+:/:/g" > $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.tre
#download + reupload to NIAB HPC
OutDir=/projects/nano_diagnostics/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/ASTRAL
ProgDir=~/git_repos/tools/astral/Astral
/home/heavet/git_repos/tools/nw_ed $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.tre 'i & b<=10' o > $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.trimmed.tre
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.tre -o $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.tre | tee 2> $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.log
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -q $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.tre -i $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.tre -o $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.scored.tre 2> $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.scored.log

java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.trimmed.tre -o $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.trimmed.tre | tee 2> $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.trimmed.log
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -q $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.trimmed.tre -i $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.trimmed.tre -o $OutDir/leotiomycetes_Nd_phylogen.boot.consensus.scored.trimmed.tre 2> $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.scored.trimmed.log



OutDir=/home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa/ASTRAL_boot
mkdir -p $OutDir
cat analysis/phylogeny/busco/host_viridiplantae_busco_aa/RAxML3/*/RAxML_bipartitionsBranchLabels.*  | sed -r "s/CTG.\w+:/:/g" > $OutDir/viridiplantae_Nd_phylogeny.boot.appended.tre
#download + reupload to NIAB HPC
OutDir=/projects/nano_diagnostics/analysis/phylogeny/busco/host_viridiplantae_busco_aa/ASTRAL
ProgDir=~/git_repos/tools/astral/Astral
/home/heavet/git_repos/tools/nw_ed $OutDir/viridiplantae_Nd_phylogeny.boot.appended.tre 'i & b<=10' o > $OutDir/viridiplantae_Nd_phylogeny.boot.appended.trimmed.tre
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/viridiplantae_Nd_phylogeny.boot.appended.tre -o $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.tre | tee 2> $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.log
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -q $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.tre -i $OutDir/viridiplantae_Nd_phylogeny.boot.appended.tre -o $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.scored.tre 2> $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.scored.log

java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/viridiplantae_Nd_phylogeny.boot.appended.trimmed.tre -o $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.trimmed.tre | tee 2> $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.trimmed.log
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -q $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.trimmed.tre -i $OutDir/viridiplantae_Nd_phylogeny.boot.appended.trimmed.tre -o $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.scored.trimmed.tre 2> $OutDir/viridiplantae_Nd_phylogeny.boot.consensus.scored.trimmed.log



conda activate astral
OutDir=/home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/ASTRAL3
mkdir -p $OutDir
cat analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/RAxML2/*/RAxML_bestTree.*  | sed -r "s/CTG.\w+:/:/g" > $OutDir/leotiomycetes_Nd_phylogeny.appended.tre
#download + reupload to NIAB HPC
OutDir=/projects/nano_diagnostics/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/ASTRAL
ProgDir=~/git_repos/tools/astral/Astral
/home/heavet/git_repos/tools/nw_ed $OutDir/leotiomycetes_Nd_phylogeny.appended.tre 'i & b<=10' o > $OutDir/leotiomycetes_Nd_phylogeny.appended.trimmed.tre
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/leotiomycetes_Nd_phylogeny.appended.tre -o $OutDir/leotiomycetes_Nd_phylogeny.consensus.tre | tee 2> $OutDir/leotiomycetes_Nd_phylogeny.consensus.log
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -q $OutDir/leotiomycetes_Nd_phylogeny.consensus.tre -i $OutDir/leotiomycetes_Nd_phylogeny.appended.tre -o $OutDir/leotiomycetes_Nd_phylogeny.consensus.scored.tre 2> $OutDir/leotiomycetes_Nd_phylogeny.consensus.scored.log

java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/leotiomycetes_Nd_phylogeny.appended.trimmed.tre -o $OutDir/leotiomycetes_Nd_phylogeny.consensus.trimmed.tre | tee 2> $OutDir/leotiomycetes_Nd_phylogeny.consensus.trimmed.log
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -q $OutDir/leotiomycetes_Nd_phylogeny.consensus.trimmed.tre -i $OutDir/leotiomycetes_Nd_phylogeny.appended.trimmed.tre -o $OutDir/leotiomycetes_Nd_phylogeny.consensus.scored.trimmed.tre 2> $OutDir/leotiomycetes_Nd_phylogeny.consensus.scored.trimmed.log




OutDir=/home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa/ASTRAL3
mkdir -p $OutDir
cat analysis/phylogeny/busco/host_viridiplantae_busco_aa/RAxML3/*/RAxML_bestTree.*  | sed -r "s/CTG.\w+:/:/g" > $OutDir/viridiplantae_Nd_phylogeny.appended.tre
#download + reupload to NIAB HPC
OutDir=/projects/nano_diagnostics/analysis/phylogeny/busco/host_viridiplantae_busco_aa/ASTRAL
ProgDir=~/git_repos/tools/astral/Astral
/home/heavet/git_repos/tools/nw_ed $OutDir/viridiplantae_Nd_phylogeny.appended.tre 'i & b<=10' o > $OutDir/viridiplantae_Nd_phylogeny.appended.trimmed.tre
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/viridiplantae_Nd_phylogeny.appended.tre -o $OutDir/viridiplantae_Nd_phylogeny.consensus.tre | tee 2> $OutDir/viridiplantae_Nd_phylogeny.consensus.log
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -q $OutDir/viridiplantae_Nd_phylogeny.consensus.tre -i $OutDir/viridiplantae_Nd_phylogeny.appended.tre -o $OutDir/viridiplantae_Nd_phylogeny.consensus.scored.tre 2> $OutDir/viridiplantae_Nd_phylogeny.consensus.scored.log

java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/viridiplantae_Nd_phylogeny.appended.trimmed.tre -o $OutDir/viridiplantae_Nd_phylogeny.consensus.trimmed.tre | tee 2> $OutDir/viridiplantae_Nd_phylogeny.consensus.trimmed.log
java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -q $OutDir/viridiplantae_Nd_phylogeny.consensus.trimmed.tre -i $OutDir/viridiplantae_Nd_phylogeny.appended.trimmed.tre -o $OutDir/viridiplantae_Nd_phylogeny.consensus.scored.trimmed.tre 2> $OutDir/viridiplantae_Nd_phylogeny.consensus.scored.trimmed.log

```
```R
setwd("C:/Users/heavt/OneDrive - NIAB/Desktop")
install.packages("ape")
install.packages("ggplot2")
install.packages("rlang")
library(BiocManager)
BiocManager::install("ggtree")
install.packages("phangorn")
install.packages("treeio")
library(ape)
library(ggplot2)
library(ggtree)
library(phangorn)
library(treeio)

#Import tree data and  reroot to yeast outgroup:
tree <- read.newick("leotiomycetes_GENIE.boot.consensus.scored.tre")
x<-root(tree, outgroup = "'S.CEREVISIAE.GCF000146045'", edgelabel = TRUE)
a<-ggtree(x)+geom_tiplab(size=4)

tree2 <- read.newick("viridiplantae_GENIE.boot.consensus.scored.tre")
x2<-root(tree2, outgroup = "'S.CEREVISIAE.GCF000146045'", edgelabel = TRUE)
a2<-ggtree(x2)+geom_tiplab(size=4)

a
a2

#Inspect the data:
y <- as_tibble(x)
print((y),n = 116)

y2 <- as_tibble(x2)
print((y2),n = 43)

#Plot with labelled nodes
a + geom_text(aes(label=node))
a2 + geom_text(aes(label=node))

#Assign nodes to groups and use groups to plot with colours
p1 <- groupClade(a, c(49, 41, 46, 39, 37, 36, 35, 90, 91, 92, 93, 38, 86, 113, 5, 47, 43, 53, 111, 52, 42, 83, 22, 21, 78, 15, 16), 'group') + aes(color=group, label=branch.length) +
  theme(legend.position="right")+ geom_tiplab(size=4) +
  xlim(-.1, 30)+
  scale_color_manual(values = c("black", "red", "darkgoldenrod1", "dodgerblue", "chocolate1", "chocolate1", "chocolate1", "chocolate1", "mediumpurple4", "mediumpurple4", "mediumpurple4", "mediumpurple4", "springgreen4", "springgreen4", "darkred", "darkred", "olivedrab", "olivedrab", "mediumblue", "tan4", "magenta3", "limegreen", "indianred4", "firebrick1", "royalblue4", "sienna1", "maroon4", "seagreen4")
  )


p2 <- groupClade(a2, c(18, 17, 16, 21, 20, 19, 14, 12, 13, 11, 8, 22, 5, 2, 6, 7, 9, 10), 'group') + aes(color=group, label=branch.length) + geom_tiplab(size=4) + xlim(-.1, 20)+
  scale_color_manual(values = c("black", "red", "darkgoldenrod1", "dodgerblue", "chocolate1", "mediumpurple4", "springgreen4", "darkred", "olivedrab", "mediumblue", "tan4", "magenta3", "limegreen", "indianred4", "firebrick1", "royalblue4", "sienna1", "maroon4", "seagreen4"))

#rearrange nodes of host plot to better match pathogen plot
p2<-flip(p2, 37, 39)%>% flip(40, 42)%>% flip(6,7)%>% flip(4,5)%>% flip(27, 25)%>% flip(22, 28)%>% flip(8, 30)%>% flip(14, 35)%>% flip(11,32)%>%flip(34, 36)

#Add support values where support is less than 1 and replot
nodes <- p1$data
nodes2 <- p2$data
nodes$label <- as.numeric(nodes[nodes$label,]) #will give error due to tip labels but work for internal support labels
as.numeric(nodes$label)
nodes2$label <- as.numeric(nodes2[nodes2$label,]) #will give error due to tip labels but work for interal support labels
as.numeric(nodes2$label)
nodes$support[nodes$isTip] <- 'supported' #again gives error but works 
nodes$support[(!nodes$isTip) & (nodes$label > 0.99)] <- 'supported'
nodes$support[(!nodes$isTip) & (nodes$label < 0.99)] <- 'unsupported'
nodes$support[(!nodes$isTip) & (nodes$label == '')] <- 'supported'
nodes2$support[nodes2$isTip] <- 'supported' #again gives error but works 
nodes2$support[(!nodes2$isTip) & (nodes2$label > 0.99)] <- 'supported'
nodes2$support[(!nodes2$isTip) & (nodes2$label < 0.99)] <- 'unsupported'
nodes2$support[(!nodes2$isTip) & (nodes2$label == '')] <- 'supported'
p1 <- p1 + aes(linetype=nodes$support)
nodes$label[nodes$label > 0.99] <- ''
p2 <- p2 + aes(linetype=nodes2$support)
nodes2$label[nodes2$label > 0.99] <- ''

p1 <- p1+ geom_nodelab(data=nodes, size=4, hjust=1.5, color="black")
p2 <- p2+ geom_nodelab(data=nodes2, size=4, hjust=-0.05, color="black")
p1
p2

#Flip host plot and replot
d1 <- p1$data
d2 <- p2$data
d2$x <- max(d2$x) - d2$x + max(d1$x)
a3<-ggtree(d2)+geom_tiplab(size=4, hjust = 1.1)+  xlim(-1, 50)
p3 <- groupClade(a3, c(18, 17, 16, 21, 20, 19, 14, 12, 13, 11, 8, 22, 5, 2, 6, 7, 9, 10), 'group') + aes(color=group, label=branch.length) + geom_tiplab(size=4, hjust = 1.1) + xlim(-1, 50)+
  scale_color_manual(values = c("black", "red", "darkgoldenrod1", "dodgerblue", "chocolate1", "mediumpurple4", "springgreen4", "darkred", "olivedrab", "mediumblue", "tan4", "magenta3", "limegreen", "indianred4", "firebrick1", "royalblue4", "sienna1", "maroon4", "seagreen4"))
nodes3 <- p3$data
nodes3$label <- as.numeric(nodes3[nodes3$label,]) #will give error due to tip labels but work for interal support labels
as.numeric(nodes3$label)
nodes3$support[nodes3$isTip] <- 'supported' #again gives error but works 
nodes3$support[(!nodes3$isTip) & (nodes3$label > 0.99)] <- 'supported'
nodes3$support[(!nodes3$isTip) & (nodes3$label < 0.99)] <- 'unsupported'
nodes3$support[(!nodes3$isTip) & (nodes3$label == '')] <- 'supported'
p3 <- p3 + aes(linetype=nodes3$support)
nodes3$label[nodes3$label > 0.99] <- ''
p3 <- p3+ geom_nodelab(data=nodes3, size=4, hjust=-0.4, color="black")

#Plot host and pathogen togerher
p1 <- p1 +  theme(legend.position = "none")
pp <- p1 + p3
#Add connecting lines
#R will draw lines between nodes in the same group on the same tree, I can see no way of forcing R the draw to the opposing tree therefor lines drawn manually in powerpoint
```
Partitionfinder
(nucleotide sequence evolution model)
```bash
mkdir analysis/phylogeny/busco/host_viridiplantae_busco_aa/trimmed
cp analysis/phylogeny/busco/host_viridiplantae_busco_aa/*/*_trimmed.fasta analysis/phylogeny/busco/host_viridiplantae_busco_aa/trimmed/.

scp /projects/oldhome/sobczm/bin/PartitionFinder1.1.1/partition_finder.cfg theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/tools
scp /projects/oldhome/armita/git_repos/emr_repos/scripts/popgen/phylogenetics/fasta2phylip.pl theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/tools
scp /projects/oldhome/armita/git_repos/emr_repos/scripts/popgen/phylogenetics/Fasta2Nexus.pl theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/tools
scp /projects/oldhome/armita/git_repos/emr_repos/scripts/popgen/phylogenetics/sub_partition_finder.sh theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/tools
for file in $(ls /home/theaven/scratch/apps/tools/*.pl); do
sed -i 's@#!/usr/bin/perl@#!/home/theaven/scratch/apps/conda/envs/braker/bin/perl@g' $file
sed -i 's@#!/usr/bin/env perl@#!/home/theaven/scratch/apps/conda/envs/braker/bin/perl@g' $file
done
scp /projects/oldhome/sobczm/bin/PartitionFinder1.1.1/PartitionFinder.py theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/apps/tools

mkdir analysis/phylogeny/NEXUS







screen -S partition
config_template=/home/theaven/scratch/apps/tools/partition_finder/partition_finder.cfg 
ct=$(basename "$config_template")
cd analysis/phylogeny
conda activate predector2.7
# prepare directory for PartitionFinder run:
for f in $(ls busco/host_viridiplantae_busco_aa/trimmed/*.fasta); do
  ID=$(echo $f | rev | cut -f1 -d '/' | rev | cut -f1 -d '_') 
  Jobs=$(squeue -u theaven| grep 'Partion_'  | wc -l)
  echo x
  while [ $Jobs -gt 64 ]; do
    sleep 2s
    printf "."
    Jobs=$(squeue -u theaven| grep 'Partion_' | wc -l)
  done 
  echo $ID>>partition_finder.log
  sed -i 's/:/_/g' $f
  #perl -MBio::SeqIO -e 'my $seqin = Bio::SeqIO->new(-fh => \*STDIN, -format => 'fasta'); while (my $seq = $seqin->next_seq) { print ">",$seq->id,"\n",$seq->seq,"\n"; }' < $f > ${ID}_nowrap.fasta
  c="$(cat ${ID}_nowrap.fasta | awk 'NR%2==0' | awk '{print length($1)}' | head -1)"
  echo $c>>partition_finder.log
  rm ${ID}_nowrap.fasta
  p="${ID}_aa.phy"
  echo $p
  n="${ID}_aa.NEXUS"
  echo $n
  dir="${f%.fasta}"
  echo $dir
  mkdir $dir
  cp $config_template $dir/.

  # Substitute the name of the alignment file and the sequence length in the config file to become correct for the current run.
  sed -i 's,^\(alignment = \).*,\1'"$p;"',' $dir/$ct
  sed -i 's,^\(Gene1_pos1 = \).*,\1'"1-$c\\\3;"',' $dir/$ct
  sed -i 's,^\(Gene1_pos2 = \).*,\1'"2-$c\\\3;"',' $dir/$ct
  sed -i 's,^\(Gene1_pos3 = \).*,\1'"3-$c\\\3;"',' $dir/$ct
 
  # Convert FASTA to phylip for the Partition Finder run
  ProgDir=/home/theaven/scratch/apps/tools
  $ProgDir/fasta2phylip.pl $f>$dir/$p

  # Convert FASTA to NEXUS for the BEAST run
  $ProgDir/Fasta2Nexus.pl $f>$dir/$n

  #Problems running PartitionFinder on the cluster. May have to be run locally on your Mac or Windows machine.
  sbatch $ProgDir/sub_partition_finder.sh $dir 2>&1 >>partition_finder.log
done #3387587-93

for file in $(ls -d busco/host_viridiplantae_busco_aa/trimmed/*_aa_aligned_host_aligned_trimmed/analysis); do
ls $file/best_scheme.txt
done

rm missing.txt
for file in $(ls -d busco/mildew_leotiomycetes_busco_aa/trimmed/*_aa_aligned_path_aligned_trimmed/analysis); do
ls $file/best_scheme.txt 2>> missing.txt
done
sed -i 's@/analysis/best_scheme.txt@.fasta@g' missing.txt
sed -i 's@: No such file or directory@@g' missing.txt
sed -i 's@ls: cannot access @@g' missing.txt
sed -ie 's|["'\'']||g'  missing.txt

screen -S partition2
mkdir analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/trimmed
cp analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/*/*_trimmed.fasta analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/trimmed/.
config_template=/home/theaven/scratch/apps/tools/partition_finder/partition_finder.cfg 
ct=$(basename "$config_template")
cd analysis/phylogeny
conda activate predector2.7
# prepare directory for PartitionFinder run:
for f in $(cat missing.txt); do
  ID=$(echo $f | rev | cut -f1 -d '/' | rev | cut -f1 -d '_')  
  Jobs=$(squeue -u theaven| grep 'PartionF'  | wc -l)
  echo x
  while [ $Jobs -gt 39 ]; do
    sleep 2s
    printf "."
    Jobs=$(squeue -u theaven| grep 'PartionF' | wc -l)
  done 
  echo ID:${ID}>>path_partition_finder.log
  sed -i 's/:/_/g' $f
  #perl -MBio::SeqIO -e 'my $seqin = Bio::SeqIO->new(-fh => \*STDIN, -format => 'fasta'); while (my $seq = $seqin->next_seq) { print ">",$seq->id,"\n",$seq->seq,"\n"; }' < $f > ${ID}_nowrap2.fasta #perl must be performed outside of a screen
  c="$(cat ${ID}_nowrap2.fasta | awk 'NR%2==0' | awk '{print length($1)}' | head -1)"
  echo LENGTH:${c}>>path_partition_finder.log
  rm ${ID}_nowrap2.fasta
  p="${ID}_aa.phy"
  echo $p
  n="${ID}_aa.NEXUS"
  echo $n
  dir="${f%.fasta}"
  echo $dir
  mkdir $dir
  cp $config_template $dir/.

  # Substitute the name of the alignment file and the sequence length in the config file to become correct for the current run.
  sed -i 's,^\(alignment = \).*,\1'"$p;"',' $dir/$ct
  sed -i 's,^\(Gene1_pos1 = \).*,\1'"1-$c\\\3;"',' $dir/$ct
  sed -i 's,^\(Gene1_pos2 = \).*,\1'"2-$c\\\3;"',' $dir/$ct
  sed -i 's,^\(Gene1_pos3 = \).*,\1'"3-$c\\\3;"',' $dir/$ct
 
  # Convert FASTA to phylip for the Partition Finder run
  ProgDir=/home/theaven/scratch/apps/tools
  $ProgDir/fasta2phylip.pl $f>$dir/$p

  # Convert FASTA to NEXUS for the BEAST run
  $ProgDir/Fasta2Nexus.pl $f>$dir/$n

  #Problems running PartitionFinder on the cluster. May have to be run locally on your Mac or Windows machine.
  sbatch $ProgDir/sub_partition_finder2.sh $dir 2>&1 >>path_partition_finder.log
done
```

















































# After this point pipeline is work in progress
Duplicate gene predictions have been spotted in our gene files, these genes will need to be removed from future analysis
```bash
for Logfile in $(ls gene_pred/*/*/codingquarry/rep_modeling/final/final_genes_appended_renamed.log); do
Output=$(dirname $Logfile)/$(echo $Logfile |cut -f3 -d '/')_duplicated_genes
echo $Output
rm $Output
for prediction in $(cat $Logfile |cut -f1|sort|uniq -c|sort -nr | awk '$1>1' | awk '{print $2}'); do
    printf ">\n" >> $Output
    grep -w $prediction $Logfile | awk '{print $3}' >> $Output
done
sed -e '/>/,+1d' ${Output} > ${Output}.txt #removed one of each duplicate from the removal list
done

scp gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/THeavenDRCT72020_1_duplicated_genes.txt theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/THeavenDRCT72020_1_duplicated_genes.txt
scp gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/THeavenDRCT72021_1_duplicated_genes.txt theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/THeavenDRCT72021_1_duplicated_genes.txt
scp gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/THeavenSCOTT2020_1_duplicated_genes.txt theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/THeavenSCOTT2020_1_duplicated_genes.txt
scp gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/THeavenp11_1_duplicated_genes.txt theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/THeavenp11_1_duplicated_genes.txt
scp gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/THeavenpOGB2019_1_duplicated_genes.txt theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/THeavenpOGB2019_1_duplicated_genes.txt
scp gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/THeavenpOGB2021_1_duplicated_genes.txt theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/THeavenpOGB2021_1_duplicated_genes.txt
```
### Predector
```bash
scp /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/
scp /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/
scp /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/
scp /projects/nano_diagnostics/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/
scp /projects/nano_diagnostics/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/
scp /projects/nano_diagnostics/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/

conda activate predector
for proteome in $(ls /home/theaven/scratch/gene_pred/*/*/codingquarry/rep_modeling/final/*.fasta); do
ProgDir=/home/theaven/scratch/apps/predector
OutDir=$(echo $proteome|cut -f1,2,3,4,5,6,7 -d '/')/predector_singularity2
sbatch $ProgDir/predector_singularity.sh $proteome 1.2.6
sleep 30
done
conda deactivate
#2860718,21,25,26,27,28, 2864314-19
#3038774-9
#3038780-5,6,7

for file in $(ls gene_pred/*/*/predector_singularity2/results/final_genes_appended_renamed.pep/final_genes_appended_renamed.pep-ranked.tsv); do
Organism=$(echo $file|cut -f2 -d '/')
Strain=$(echo $file|cut -f3 -d '/')
OutDir=$(dirname $file)
echo ${Organism}-${Strain}
cp $file ${OutDir}/${Organism}-${Strain}-ranked.tsv
done

#Remove discovered duplicates:
for file in $(ls /home/theaven/scratch/gene_pred/*/*/codingquarry/rep_modeling/final/*_duplicated_genes.txt); do
  Organism=$(echo $file|cut -f6 -d '/')
  Strain=$(echo $file|cut -f7 -d '/')
  tsv=$(echo $file | cut -f1,2,3,4,5,6,7 -d '/')/predector_singularity2/results/final_genes_appended_renamed.pep/${Organism}-${Strain}-ranked.tsv
  echo $tsv
  for var1 in $(cat $file); do
  sed -i "/$var1/d" "$tsv"
done
done
```

### Looking for transcription factors
```bash
conda activate predector2.7
  for Interpro in $(ls gene_pred/*/*/interproscan/NRI/*_interproscan.tsv); do
    Organism=$(echo $Interpro | rev | cut -f5 -d '/' | rev)
    Strain=$(echo $Interpro | rev | cut -f4 -d '/' | rev)
    echo "$Organism - $Strain"
    OutDir=gene_pred/$Organism/$Strain/transcription_factors
    mkdir -p $OutDir
    ProgDir=/home/theaven/scratch/apps/tools
    python2.7 $ProgDir/interpro2TFs.py --InterPro $Interpro > $OutDir/"$Strain"_TF_domains.tsv
        for var1 in $(cat /home/theaven/scratch/gene_pred/${Organism}/${Strain}/codingquarry/rep_modeling/final/${Strain}_duplicated_genes.txt); do
        sed -i "/$var1/d" "$OutDir/"$Strain"_TF_domains.tsv"
        done #remove discovered duplicates
    echo "$Organism - $Strain " >> TFreport.txt
    printf "total number of transcription factors: \t" >> TFreport.txt
    cat $OutDir/"$Strain"_TF_domains.tsv | cut -f1 | sort | uniq > $OutDir/"$Strain"_TF_gene_headers.txt
    cat $OutDir/"$Strain"_TF_gene_headers.txt | wc -l >> TFreport.txt 
    # Gene ID rather than transcript ID
    cat $OutDir/"$Strain"_TF_gene_headers.txt | sed -e "s/.t.*//g" > $OutDir/"$Strain"_TF_geneid_headers.txt
  done
conda deactivate
mv *report.txt reports/.
```
P_aphanis - THeavenDRCT72020_1
total number of transcription factors:  1162
P_aphanis - THeavenDRCT72021_1
total number of transcription factors:  1034
P_aphanis - THeavenSCOTT2020_1
total number of transcription factors:  1035
P_leucotricha - THeavenp11_1
total number of transcription factors:  994
P_leucotricha - THeavenpOGB2019_1
total number of transcription factors:  1015
P_leucotricha - THeavenpOGB2021_1
total number of transcription factors:  991

### Sectretome
Proteins with a predicted signal peptide and no predicted transmembrane domains were extracted.
```bash
conda activate predector2.7
for file in $(ls gene_pred/*/*/predector_singularity2/results/final_genes_appended_renamed.pep/final_genes_appended_renamed.pep-ranked.tsv); do
  Organism=$(echo $file|cut -f2 -d '/')
  Strain=$(echo $file|cut -f3 -d '/')
  echo "$Organism - $Strain"
  Proteome=$(ls /home/theaven/scratch/gene_pred/${Organism}/${Strain}/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
  Sequential_Proteome=$(dirname $Proteome)/${Strain}.pep.fasta
  Outfile=$(dirname $file)/${Strain}_secretome.tsv
  Outfile2=$(dirname $file)/${Strain}_secretome.pep.fasta
  rm $Outfile
  rm $Outfile2
  head -n 1 $file >> $Outfile
  awk '$25==1' $file |awk '$27==0' |awk '$28==0' >> $Outfile
#  perl -MBio::SeqIO -e 'my $seqin = Bio::SeqIO->new(-fh => \*STDIN, -format => 'fasta'); while (my $seq = $seqin->next_seq) { print ">",$seq->id,"\n",$seq->seq,"\n"; }' < $Proteome > $Sequential_Proteome
  cat $Outfile | cut -f1 | grep -A 1 -f - $Sequential_Proteome >> $Outfile2
done
conda  deactivate
```

### SSCP
Small cysteine rich proteins were identified within proteomes. These proteins may be identified by EffectorP, but this approach allows direct control over what constitutes a SSCP.

```bash
conda activate predector2.7
for Proteome in $(ls /home/theaven/scratch/gene_pred/*/*/predector_singularity2/results/final_genes_appended_renamed.pep/*_secretome.pep.fasta); do
Organism=$(echo $Proteome|cut -f6 -d '/')
Strain=$(echo $Proteome|cut -f7 -d '/')
echo "$Organism - $Strain"
OutDir=gene_pred/$Organism/$Strain/sscp
mkdir $OutDir
ProgDir=/home/theaven/scratch/apps/tools
python2.7 $ProgDir/sscp_filter.py --inp_fasta $Proteome --max_length 300 --threshold 3 --out_fasta $OutDir/"$Strain"_sscp_all_results.fa
cat $OutDir/"$Strain"_sscp_all_results.fa | grep 'Yes' > $OutDir/"$Strain"_sscp.fa
echo "$Organism - $Strain " >> sscpreport.txt
printf "number of SSC-rich genes:\t" >> sscpreport.txt
cat $OutDir/"$Strain"_sscp.fa | grep '>' | tr -d '>' | cut -f1 -d '.' | sort | uniq | wc -l >> sscpreport.txt
done
conda deactivate
mv *report.txt reports/.
```
P_aphanis - THeavenDRCT72020_1
number of SSC-rich genes:       52
P_aphanis - THeavenDRCT72021_1
number of SSC-rich genes:       59
P_aphanis - THeavenSCOTT2020_1
number of SSC-rich genes:       44
P_leucotricha - THeavenp11_1
number of SSC-rich genes:       85
P_leucotricha - THeavenpOGB2019_1
number of SSC-rich genes:       89
P_leucotricha - THeavenpOGB2021_1
number of SSC-rich genes:       90

### CAZY proteins
Carbohydrte active enzymes were idnetified using CAZYfollowing recomendations at http://csbl.bmb.uga.edu/dbCAN/download/readme.txt :
```bash
conda activate cazy
for Proteome in $(ls gene_pred/*/*/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do
Organism=$(echo $Proteome|cut -f2 -d '/')
Strain=$(echo $Proteome|cut -f3 -d '/')
echo "$Organism - $Strain"
OutDir=gene_pred/$Organism/$Strain/cazy
mkdir $OutDir
Prefix="$Strain"_CAZY
CazyHmm=apps/tools/dbCAN/dbCAN/dbCAN-fam-HMMs.txt
ProgDir=/home/theaven/scratch/apps/tools
sbatch $ProgDir/hmm_scan.sh $CazyHmm $Proteome $Prefix $OutDir
done
#3054426-31
conda deactivate
mv *report.txt reports/.


```
The Hmm parser was used to filter hits by an E-value of E1x10-5 or E1x10-e3 if they had a hit over a length of X %.

Those proteins with a signal peptide were extracted from the list and gff files representing these proteins made.
```bash
for File in $(ls gene_pred/*/*/cazy/*CAZY.out.dm); do
Organism=$(echo $File|cut -f2 -d '/')
Strain=$(echo $File|cut -f3 -d '/')
echo "$Organism - $Strain"
    for var1 in $(cat /home/theaven/scratch/gene_pred/${Organism}/${Strain}/codingquarry/rep_modeling/final/${Strain}_duplicated_genes.txt); do
    sed -i "/$var1/d" "gene_pred/"${Organism}"/"${Strain}"/cazy/"$Strain"_CAZY.out.dm"  
    done #remove discovered duplicates
OutDir=$(dirname $File)
ProgDir=/home/theaven/scratch/apps/tools/dbCAN/dbCAN
$ProgDir/hmmscan-parser.sh $OutDir/"$Strain"_CAZY.out.dm > $OutDir/"$Strain"_CAZY.out.dm.ps
CazyHeaders=$(echo $File | sed 's/.out.dm/_headers.txt/g')
rm $OutDir/"$Strain"_CAZY.out.dm.ps.f
awk '$5<0.00000000000000001' $OutDir/"$Strain"_CAZY.out.dm.ps |awk '$10>0.45' >> $OutDir/"$Strain"_CAZY.out.dm.ps.f #For fungi, use E-value < 1e-17 and coverage > 0.45
cat $OutDir/"$Strain"_CAZY.out.dm.ps.f | cut -f3 | sort | uniq > $CazyHeaders
echo $CazyHeaders
head $CazyHeaders
Gff=$(ls gene_pred/${Organism}/${Strain}/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3)
CazyGff=${OutDir}/${Strain}_CAZY.gff
ProgDir=/home/theaven/scratch/apps/tools
$ProgDir/extract_gff_for_sigP_hits.pl $CazyHeaders $Gff CAZyme ID > $CazyGff
echo $CazyGff
head $CazyGff
SecretedProts=gene_pred/${Organism}/${Strain}/predector_singularity2/results/final_genes_appended_renamed.pep/*_secretome.pep.fasta
SecretedHeaders=$(echo $SecretedProts | sed 's/.pep.fasta/_headers.txt/g')
cat $SecretedProts | grep '>' | tr -d '>' > $SecretedHeaders
CazyGffSecreted=$OutDir/${Strain}_CAZY_secreted.gff
$ProgDir/extract_gff_for_sigP_hits.pl $SecretedHeaders $CazyGff Secreted_CAZyme ID > $CazyGffSecreted
echo $CazyGffSecreted
head $CazyGffSecreted
cat $CazyGffSecreted | grep -w 'mRNA' | cut -f9 | tr -d 'ID=' | cut -f1 -d ';' > $OutDir/"$Strain"_CAZY_secreted_headers.txt

echo "$Organism - $Strain" >> cazyreport.txt
echo "number of CAZY proteins identified:" >> cazyreport.txt
cat $CazyHeaders | wc -l >> cazyreport.txt
echo "number of CAZY genes identified:" >> cazyreport.txt
cat $CazyGff | grep -w 'gene' | wc -l >> cazyreport.txt
echo "number of Secreted CAZY proteins identified:">> cazyreport.txt
cat $OutDir/"$Strain"_CAZY_secreted_headers.txt | wc -l >> cazyreport.txt
echo "number of Secreted CAZY genes identified:">> cazyreport.txt
cat $CazyGffSecreted | grep -w 'gene' | wc -l >> cazyreport.txt
done
```

P_aphanis - THeavenDRCT72020_1
number of CAZY proteins identified:
138
number of CAZY genes identified:
138
number of Secreted CAZY proteins identified:
58
number of Secreted CAZY genes identified:
58
P_aphanis - THeavenDRCT72021_1
number of CAZY proteins identified:
190
number of CAZY genes identified:
190
number of Secreted CAZY proteins identified:
89
number of Secreted CAZY genes identified:
89
P_aphanis - THeavenSCOTT2020_1
number of CAZY proteins identified:
139
number of CAZY genes identified:
139
number of Secreted CAZY proteins identified:
58
number of Secreted CAZY genes identified:
58
P_leucotricha - THeavenp11_1
number of CAZY proteins identified:
144
number of CAZY genes identified:
144
number of Secreted CAZY proteins identified:
57
number of Secreted CAZY genes identified:
57
P_leucotricha - THeavenpOGB2019_1
number of CAZY proteins identified:
170
number of CAZY genes identified:
170
number of Secreted CAZY proteins identified:
66
number of Secreted CAZY genes identified:
66
P_leucotricha - THeavenpOGB2021_1
number of CAZY proteins identified:
145
number of CAZY genes identified:
145
number of Secreted CAZY proteins identified:
58
number of Secreted CAZY genes identified:
58

```bash
conda activate predector2.7
for File in $(ls gene_pred/*/*/cazy/*_CAZY.out.dm.ps.f); do
Organism=$(echo $File|cut -f2 -d '/')
Strain=$(echo $File|cut -f3 -d '/')
echo "$Organism - $Strain"
OutDir=$(dirname $File)
Secreted=$(ls gene_pred/${Organism}/${Strain}/predector_singularity2/results/final_genes_appended_renamed.pep/*_secretome_headers.txt)
Gff=$(ls gene_pred/${Organism}/${Strain}/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3)
ProgDir=/home/theaven/scratch/apps/tools/CAZY
python2.7 $ProgDir/summarise_CAZY.py --cazy $File --inp_secreted $Secreted --inp_gff $Gff --summarise_family --trim_gene_id 2 --kubicek_2014
done
conda deactivate
```
P_aphanis - THeavenDRCT72020_1
A-Galactosidases - 1
Cellulases - 2
other - 54
Polygalacturonase - 1

P_aphanis - THeavenDRCT72021_1
B-Galactosidases - 1
Polygalacturonase - 1
A-Arabinosidases - 2
Xylanases - 2
Polygalacturonate lyases - 2
A-Galactosidases - 1
B-Glycosidases - 1
Cellulases - 4
other - 75

P_aphanis - THeavenSCOTT2020_1
A-Galactosidases - 1
Cellulases - 2
other - 54
Polygalacturonase - 1

P_leucotricha - THeavenp11_1
A-Galactosidases - 1
Cellulases - 2
other - 53
Polygalacturonase - 1

P_leucotricha - THeavenpOGB2019_1
A-Galactosidases - 1
Cellulases - 2
other - 62
Polygalacturonase - 1

P_leucotricha - THeavenpOGB2021_1
A-Galactosidases - 1
Cellulases - 2
other - 54
Polygalacturonase - 1

### Secondary metabolites (Antismash and SMURF)
Antismash was run to identify clusters of secondary metabolite genes within the genome. Antismash was run using the webserver at: http://antismash.secondarymetabolites.org Results of web-annotation of gene clusters within the assembly were downloaded to the following directories:
```bash
/home/theaven/scratch/gene_pred/*/*/antismash/
```

SMURF was also run to identify secondary metabolite gene clusters.

Genes needed to be parsed into a specific tsv format prior to submission on the SMURF webserver.

```bash
conda activate predector2.7
for File in $(ls gene_pred/*/*/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3); do
  Organism=$(echo $File|cut -f2 -d '/')
  Strain=$(echo $File|cut -f3 -d '/')
  echo "$Organism - $Strain"
  OutDir=gene_pred/$Organism/$Strain/smurf
  mkdir $OutDir
  ProgDir=/home/theaven/scratch/apps/tools/secondary_metabolites
  python2.7 $ProgDir/gff2smurf.py --gff $File > $OutDir/${Strain}_genes_smurf.tsv
  cp $OutDir/"$Strain"_genes_smurf.tsv .
done
conda deactivate
```
SMURF server shutdown?

## Orthology analysis

### Format fasta files
```bash
  ProjDir=/projects/nano_diagnostics
  cd $ProjDir
  IsolateAbrv=All6_isolates
  WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
  mkdir -p $WorkDir
  mkdir -p $WorkDir/formatted
  mkdir -p $WorkDir/goodProteins
  mkdir -p $WorkDir/badProteins  
  ProgDir=/home/heavet/git_repos/tools/gene_prediction

  ProjDir=/projects/nano_diagnostics
  cd $ProjDir
  IsolateAbrv=Aphanis_isolates
  WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
  mkdir -p $WorkDir
  mkdir -p $WorkDir/formatted
  mkdir -p $WorkDir/goodProteins
  mkdir -p $WorkDir/badProteins  
  ProgDir=/home/heavet/git_repos/tools/gene_prediction

  ProjDir=/projects/nano_diagnostics
  cd $ProjDir
  IsolateAbrv=Leucotricha_isolates
  WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
  mkdir -p $WorkDir
  mkdir -p $WorkDir/formatted
  mkdir -p $WorkDir/goodProteins
  mkdir -p $WorkDir/badProteins  
  ProgDir=/home/heavet/git_repos/tools/gene_prediction

  ProjDir=/projects/nano_diagnostics
  cd $ProjDir
  IsolateAbrv=Besthost_isolates
  WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
  mkdir -p $WorkDir
  mkdir -p $WorkDir/formatted
  mkdir -p $WorkDir/goodProteins
  mkdir -p $WorkDir/badProteins  
  ProgDir=/home/heavet/git_repos/tools/gene_prediction

  ProjDir=/projects/nano_diagnostics
  cd $ProjDir
  IsolateAbrv=Bestspecies_isolates
  WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
  mkdir -p $WorkDir
  mkdir -p $WorkDir/formatted
  mkdir -p $WorkDir/goodProteins
  mkdir -p $WorkDir/badProteins  
  ProgDir=/home/heavet/git_repos/tools/gene_prediction

Taxon_code=ST20
Fasta_file=$(ls /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
Id_field=1
$ProgDir/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta

Taxon_code=ST21
Fasta_file=$(ls /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
Id_field=1
$ProgDir/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta

Taxon_code=RA20
Fasta_file=$(ls /projects/nano_diagnostics/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
Id_field=1
$ProgDir/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta

Taxon_code=AP19
Fasta_file=$(ls /projects/nano_diagnostics/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
Id_field=1
$ProgDir/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta

Taxon_code=AP20
Fasta_file=$(ls /projects/nano_diagnostics/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
Id_field=1
$ProgDir/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta

Taxon_code=AP21
Fasta_file=$(ls /projects/nano_diagnostics/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta)
Id_field=1
$ProgDir/orthomclAdjustFasta.pl  $Taxon_code $Fasta_file $Id_field
mv "$Taxon_code".fasta $WorkDir/formatted/"$Taxon_code".fasta
```
For all 6:
OrthoFinder assigned 102145 genes (96.4% of total) to 18296 orthogroups. Fifty percent of all genes were in orthogroups with 6 or more genes (G50 was 6) and were contained in the largest 5190 orthogroups (O50 was 5190). There were 7207 orthogroups with all species present and 4800 of these consisted entirely of single-copy genes.

For the 3 P.aphanis:
OrthoFinder assigned 46655 genes (95.0% of total) to 12465 orthogroups. Fifty percent of all genes were in orthogroups with 3 or more genes (G50 was 3) and were contained in the largest 4271 orthogroups (O50 was 4271). There were 8930 orthogroups with all species present and 6370 of these consisted entirely of single-copy genes.

For the 3 P.leucotricha:
OrthoFinder assigned 55528 genes (97.7% of total) to 16217 orthogroups. Fifty percent of all genes were in orthogroups with 3 or more genes (G50 was 3) and were contained in the largest 6625 orthogroups (O50 was 6625). There were 14129 orthogroups with all species present and 11463 of these consisted entirely of single-copy genes.

For the best aphanis and leucotricha assembly
OrthoFinder assigned 31680 genes (87.4% of total) to 9601 orthogroups. Fifty percent of all genes were in orthogroups with 3 or more genes (G50 was 3) and were contained in the largest 2854 orthogroups (O50 was 2854). There were 8142 orthogroups with all species present and 6069 of these consisted entirely of single-copy genes.

For the best genome from apple, strawberry and raspberry
OrthoFinder assigned 46194 genes (89.8% of total) to 11482 orthogroups. Fifty percent of all genes were in orthogroups with 3 or more genes (G50 was 3) and were contained in the largest 3951 orthogroups (O50 was 3951). There were 7504 orthogroups with all species present and 5537 of these consisted entirely of single-copy genes.

### Filter proteins into good an poor sets
```bash
for WorkDir in $(ls -d analysis/orthology/orthofinder/*); do
ProgDir=/home/heavet/git_repos/tools/gene_prediction
Input_dir=$WorkDir/formatted
Min_length=10
Max_percent_stops=20
Good_proteins_file=$WorkDir/goodProteins/goodProteins.fasta
Poor_proteins_file=$WorkDir/badProteins/poorProteins.fasta
$ProgDir/orthomclFilterFasta.pl $Input_dir $Min_length $Max_percent_stops $Good_proteins_file $Poor_proteins_file
done
```
### Orthofinder
```bash
scp -r /projects/nano_diagnostics/analysis/orthology theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/analysis/.
```
```bash
  ProjDir=/projects/nano_diagnostics
  cd $ProjDir

screen -S orthofinder
srun -p himem -J orthofinder --cpus-per-task=144 --pty bash
conda activate orthofinder2.7
for analysis in $(ls -d analysis/orthology/orthofinder/*); do
cd $analysis
orthofinder -f formatted -t 144 -a 10 2>&1 | tee -a orthofinder_report.txt
cd $ProjDir
done
conda deactivate


```
### Extracting fasta files for orthogroups
```bash
conda activate orthofinder2.7
for WorkDir in $(ls -d analysis/orthology/orthofinder/All6_isolates); do
ProgDir=/home/heavet/git_repos/tools/gene_prediction
OrthogroupsTxt=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
GoodProts=$WorkDir/goodProteins/goodProteins.fasta
OutDir=$WorkDir/orthogroups_fasta
mkdir -p $OutDir
python $ProgDir/orthoMCLgroups2fasta.py --orthogroups $OrthogroupsTxt --fasta $GoodProts --out_dir $OutDir
done
conda deactivate
```
```bash
#Discovered duplicate gene should not affect the number of orthogroups? As there is still one legitimate gene of each. However will affect the number of genes in a given orthogroup if not removed:

WorkDir=analysis/orthology/orthofinder/All6_isolates

for Proteome in $(ls /home/theaven/scratch/gene_pred/*/*/predector_singularity2/results/final_genes_appended_renamed.pep/*_secretome.pep.fasta); do
Organism=$(echo $Proteome|cut -f6 -d '/')
Strain=$(echo $Proteome|cut -f7 -d '/')
echo $Orangism - $Strain
    for var1 in $(cat /home/theaven/scratch/gene_pred/${Organism}/${Strain}/codingquarry/rep_modeling/final/${Strain}_duplicated_genes.txt); do
    sed -i "s/ AP19|${var1}.t1//g" analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt
    sed -i "s/ AP20|${var1}.t1//g" analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt
    sed -i "s/ AP21|${var1}.t1//g" analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt
    sed -i "s/ ST20|${var1}.t1//g" analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt
    sed -i "s/ ST21|${var1}.t1//g" analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt
    sed -i "s/ RA20|${var1}.t1//g" analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt  
    done #remove discovered duplicates
done
#From this ^ discovered that genes can be in multiple orthogroups?

awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $WorkDir/goodProteins/goodProteins.fasta > linearized.fasta
for Proteome in $(ls /home/theaven/scratch/gene_pred/*/*/predector_singularity2/results/final_genes_appended_renamed.pep/*_secretome.pep.fasta); do
Organism=$(echo $Proteome|cut -f6 -d '/')
Strain=$(echo $Proteome|cut -f7 -d '/')
echo $Orangism - $Strain
    for var1 in $(cat /home/theaven/scratch/gene_pred/${Organism}/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/${Strain}_duplicated_genes.txt); do
    sed -i "/>RA20|${var1}.t1/d" linearized.fasta
    done #remove discovered duplicates
        for var1 in $(cat /home/theaven/scratch/gene_pred/${Organism}/THeavenDRCT72020_1/codingquarry/rep_modeling/final/${Strain}_duplicated_genes.txt); do
    sed -i "/>ST20|${var1}.t1/d" linearized.fasta
    done #remove discovered duplicates
        for var1 in $(cat /home/theaven/scratch/gene_pred/${Organism}/THeavenDRCT72021_1/codingquarry/rep_modeling/final/${Strain}_duplicated_genes.txt); do
    sed -i "/>ST21|${var1}.t1/d" linearized.fasta
    done #remove discovered duplicates
        for var1 in $(cat /home/theaven/scratch/gene_pred/${Organism}/THeavenp11_1/codingquarry/rep_modeling/final/${Strain}_duplicated_genes.txt); do
    sed -i "/>AP20|${var1}.t1/d" linearized.fasta
    done #remove discovered duplicates
        for var1 in $(cat /home/theaven/scratch/gene_pred/${Organism}/THeavenpOGB2019_1/codingquarry/rep_modeling/final/${Strain}_duplicated_genes.txt); do
    sed -i "/>AP19|${var1}.t1/d" linearized.fasta
    done #remove discovered duplicates
        for var1 in $(cat /home/theaven/scratch/gene_pred/${Organism}/THeavenpOGB2021_1/codingquarry/rep_modeling/final/${Strain}_duplicated_genes.txt); do
    sed -i "/>AP21|${var1}.t1/d" linearized.fasta
    done #remove discovered duplicates
done
tr "\t" "\n" < linearized.fasta | fold -w 60 > goodProteins.fasta 
cp goodProteins.fasta $WorkDir/goodProteins/goodProteins.fasta

WorkDir=analysis/orthology/orthofinder/Aphanis_isolates

for Proteome in $(ls /home/theaven/scratch/gene_pred/*/*/predector_singularity2/results/final_genes_appended_renamed.pep/*_secretome.pep.fasta); do
Organism=$(echo $Proteome|cut -f6 -d '/')
Strain=$(echo $Proteome|cut -f7 -d '/')
echo $Orangism - $Strain
    for var1 in $(cat /home/theaven/scratch/gene_pred/${Organism}/${Strain}/codingquarry/rep_modeling/final/${Strain}_duplicated_genes.txt); do
    sed -i "s/ AP19|${var1}.t1//g" analysis/orthology/orthofinder/Aphanis_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt
    sed -i "s/ AP20|${var1}.t1//g" analysis/orthology/orthofinder/Aphanis_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt
    sed -i "s/ AP21|${var1}.t1//g" analysis/orthology/orthofinder/Aphanis_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt
    sed -i "s/ ST20|${var1}.t1//g" analysis/orthology/orthofinder/Aphanis_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt
    sed -i "s/ ST21|${var1}.t1//g" analysis/orthology/orthofinder/Aphanis_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt
    sed -i "s/ RA20|${var1}.t1//g" analysis/orthology/orthofinder/Aphanis_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt  
    done #remove discovered duplicates
done
```
#### Orthogroups only containing P. leucotricha genes were extracted:
```bash
WorkDir=analysis/orthology/orthofinder/All6_isolates
Orthogroups=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
GoodProts=$WorkDir/goodProteins/goodProteins.fasta

for num in 1; do
UniqDir=$WorkDir/leucotricha_unique
Uniq_leucotricha_groups=$UniqDir/leucotricha_unique.txt
mkdir -p $UniqDir
cat $Orthogroups | grep -v -e 'RA20' | grep -v -e 'ST20' | grep -v -e 'ST21' | grep -e 'AP19' | grep -e 'AP20' | grep -e 'AP21'> $Uniq_leucotricha_groups
echo "The number of orthogroups unique to podosphaera leucotricha are:"
cat $Uniq_leucotricha_groups | wc -l
echo "The following number genes from apple 2019 are contained in these orthogorups:"
cat $Uniq_leucotricha_groups | grep -o -e 'AP19' | wc -l
echo "The following number genes from apple 2020 2020 are contained in these orthogorups:"
cat $Uniq_leucotricha_groups | grep -o -e 'AP20' | wc -l
echo "The following number genes from apple 2021 2021 are contained in these orthogorups:"
cat $Uniq_leucotricha_groups | grep -o -e 'AP21' | wc -l
done
```
The number of orthogroups unique to podosphaera leucotricha are:
4405
The following number genes from apple 2019 are contained in these orthogorups:
5046
The following number genes from apple 2020 2020 are contained in these orthogorups:
5066
The following number genes from apple 2021 2021 are contained in these orthogorups:
5056

#### Orthogroups only containing P. aphanis genes were extracted:
```bash
WorkDir=analysis/orthology/orthofinder/All6_isolates
Orthogroups=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
GoodProts=$WorkDir/goodProteins/goodProteins.fasta

for num in 1; do
UniqDir=$WorkDir/aphanis_unique
Uniq_aphanis_groups=$UniqDir/aphanis_unique.txt
mkdir -p $UniqDir
cat $Orthogroups | grep -e 'RA20' | grep -e 'ST20' | grep -e 'ST21' | grep -v -e 'AP19' | grep -v -e 'AP20' | grep -v -e 'AP21'> $Uniq_aphanis_groups
echo "The number of orthogroups unique to podosphaera aphanis are:"
cat $Uniq_aphanis_groups | wc -l
echo "The following number genes from raspberry are contained in these orthogorups:"
cat $Uniq_aphanis_groups | grep -o -e 'RA20' | wc -l
echo "The following number genes from Strawberry 2020 are contained in these orthogorups:"
cat $Uniq_aphanis_groups | grep -o -e 'ST20' | wc -l
echo "The following number genes from strawberry 2021 are contained in these orthogorups:"
cat $Uniq_aphanis_groups | grep -o -e 'ST21' | wc -l
done
```
The number of orthogroups unique to podosphaera aphanis are:
1332
The following number genes from raspberry are contained in these orthogorups:
2028
The following number genes from Strawberry 2020 are contained in these orthogorups:
2018
The following number genes from strawberry 2021 are contained in these orthogorups:
1819

#### Orthogroups only containing P. aphanis strawberry genes were extracted:
```bash
WorkDir=analysis/orthology/orthofinder/All6_isolates
Orthogroups=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
GoodProts=$WorkDir/goodProteins/goodProteins.fasta

for num in 1; do
UniqDir=$WorkDir/strawberryaphanis_unique
Uniq_strawberryaphanis_groups=$UniqDir/strawberryaphanis_unique.txt
mkdir -p $UniqDir
cat $Orthogroups | grep -v -e 'RA20' | grep -e 'ST20' | grep -e 'ST21' | grep -v -e 'AP19' | grep -v -e 'AP20' | grep -v -e 'AP21'> $Uniq_strawberryaphanis_groups
echo "The number of orthogroups unique to strawberry podosphaera aphanis are:"
cat $Uniq_strawberryaphanis_groups | wc -l
echo "The following number genes from Strawberry 2020 are contained in these orthogorups:"
cat $Uniq_strawberryaphanis_groups | grep -o -e 'ST20' | wc -l
echo "The following number genes from strawberry 2021 are contained in these orthogorups:"
cat $Uniq_strawberryaphanis_groups | grep -o -e 'ST21' | wc -l
done
```
The number of orthogroups unique to strawberry podosphaera aphanis are:
1390
The following number genes from Strawberry 2020 are contained in these orthogorups:
1569
The following number genes from strawberry 2021 are contained in these orthogorups:
1561

#### Orthogroups only containing P. aphanis raspberry genes were extracted:
```bash
WorkDir=analysis/orthology/orthofinder/All6_isolates
Orthogroups=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
GoodProts=$WorkDir/goodProteins/goodProteins.fasta

for num in 1; do
UniqDir=$WorkDir/raspberryaphanis_unique
Uniq_raspberryaphanis_groups=$UniqDir/raspberryaphanis_unique.txt
mkdir -p $UniqDir
cat $Orthogroups | grep -e 'RA20' | grep -v -e 'ST20' | grep -v -e 'ST21' | grep -v -e 'AP19' | grep -v -e 'AP20' | grep -v -e 'AP21'> $Uniq_raspberryaphanis_groups
echo "The number of orthogroups unique to raspberry podosphaera aphanis are:"
cat $Uniq_raspberryaphanis_groups | wc -l
echo "The following number genes from raspberry are contained in these orthogorups:"
cat $Uniq_raspberryaphanis_groups | grep -o -e 'RA20' | wc -l
done
```
The number of orthogroups unique to raspberry podosphaera aphanis are:
894
The following number genes from raspberry are contained in these orthogorups:
991

#### Venn diagrams
```bash
conda activate orthofinder2.7
#ProgDir=/home/heavet/git_repos/tools/gene_prediction
ProgDir=/home/theaven/scratch/apps/tools

WorkDir=analysis/orthology/orthofinder/All6_isolates
GoodProts=$WorkDir/goodProteins/goodProteins.fasta
$ProgDir/orthoMCLgroups2tab.py $GoodProts $WorkDir/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt > $WorkDir/formatted/All6_isolates_orthogroups.tab

IsolateAbrv=Aphanis_isolates
WorkDir=analysis/orthology/orthofinder/$IsolateAbrv
GoodProts=$WorkDir/goodProteins/goodProteins.fasta
$ProgDir/orthoMCLgroups2tab.py $GoodProts $WorkDir/formatted/OrthoFinder/Results_Jul20/Orthogroups/Orthogroups.txt > $WorkDir/formatted/${IsolateAbrv}_orthogroups.tab
```
```R
setwd("C:/Users/tchea/Desktop")
install.packages("optparse")
install.packages("colorspace")
install.packages("VennDiagram")
install.packages("grid")
install.packages("ggVennDiagram")
install.packages("ggvenn")
install.packages("devtools")
library("devtools")
devtools::install_github("yanlinlin82/ggvenn")
library("ggvenn")
library("ggVennDiagram")
library(optparse)
library(colorspace)
library(VennDiagram)
require(dendextend)
require(installr)
require(colorspace)

orthotabs <- read.table("Leucotricha_isolates_orthogroups.tab")
df1 <- t(orthotabs)
df <- data.frame(df1)
ap19<-which(df$AP19 == 1)
ap20<-which(df$AP20 == 1)
ap21<-which(df$AP21 == 1)
x <- list(ap19,ap20,ap21)
ggVennDiagram(x)
names(x) <- c("Apple 2019","Apple 2020","Apple 2021")
plot1 <- ggvenn(
  x, 
  fill_color = c("#0073C2FF", "#EFC000FF", "#868686FF"),
  stroke_size = 0.5, text_size = 6, set_name_size = 5
)

orthotabs <- read.table("Aphanis_isolates_orthogroups.tab")
df1 <- t(orthotabs)
df2 <- data.frame(df1)
ra20<-which(df2$RA20 == 1)
st20<-which(df2$ST20 == 1)
st21<-which(df2$ST21 == 1)
y <- list(ra20,st20,st21)
ggVennDiagram(y)
names(y) <- c("Raspberry 2020","Strawberry 2020","Strawberry 2021")
plot2 <- ggvenn(
  y, 
  fill_color = c("#0073C2FF", "#EFC000FF", "#868686FF"),
  stroke_size = 0.5, text_size = 6, set_name_size = 5 
)

orthotabs <- read.table("All6_isolates_orthogroups.tab")
df1 <- t(orthotabs)
df3 <- data.frame(df1)
APH<-which(df3$RA20 == 1 & df3$ST20 == 1 & df3$ST21 == 1)
LEU<-which(df3$AP20 == 1 & df3$AP21 == 1 & df3$AP19 == 1)
z <- list(APH, LEU)
length(APH)
length(LEU)
ggVennDiagram(z)
names(z) <- c("P. aphanis","P. leucotricha")
plot3 <- ggvenn(
  z, 
  fill_color = c("#0073C2FF", "#EFC000FF"),
  stroke_size = 0.5, text_size = 4, set_name_size = 5, auto_scale = TRUE
)

STR<-which(df3$ST20 == 1 & df3$ST21 == 1)
RAS<-which(df3$RA20 == 1)
a <- list(STR, RAS)
ggVennDiagram(a)
names(a) <- c("Stawberry","Raspberry")
plot4 <- ggvenn(
  a, 
  fill_color = c("#0073C2FF", "#EFC000FF"),
  stroke_size = 0.5, set_name_size = 5, auto_scale = TRUE
)

STR20<-which(df3$ST20 == 1)
STR21<-which(df3$ST21 == 1)
b <- list(STR20, STR21)
ggVennDiagram(b)
names(b) <- c("Strawberry 2020","Strawberry 2021")
plot5 <- ggvenn(
  b, 
  fill_color = c("#0073C2FF", "#EFC000FF"),
  stroke_size = 0.5, set_name_size = 5, auto_scale = TRUE
)

APP19<-which(df3$AP19 == 1)
APP20<-which(df3$AP20 == 1)
APP21<-which(df3$AP21 == 1)
c <- list(APP20, APP21)
ggVennDiagram(c)
names(c) <- c("Apple 2020","Apple 2021")
plot6 <- ggvenn(
  c, 
  fill_color = c("#0073C2FF", "#EFC000FF"),
  stroke_size = 0.5, set_name_size = 5, auto_scale = TRUE
)

d <- list(APP19, APP20)
ggVennDiagram(c)
names(d) <- c("Apple 2019","Apple 2020")
plot7 <- ggvenn(
  d, 
  fill_color = c("#0073C2FF", "#EFC000FF"),
  stroke_size = 0.5, set_name_size = 5, auto_scale = TRUE
)

e <- list(APP19, APP21)
ggVennDiagram(e)
names(e) <- c("Apple 2019","Apple 2021")
plot8 <- ggvenn(
  e, 
  fill_color = c("#0073C2FF", "#EFC000FF"),
  stroke_size = 0.5, text_size = 4, set_name_size = 5, auto_scale = TRUE
)

jpeg(file="venn1.jpeg", width=700, height=700)
plot(plot1)
dev.off()
jpeg(file="venn2.jpeg", width=700, height=700)
plot(plot2)
dev.off()
jpeg(file="venn3.jpeg", width=500, height=500)
plot(plot3)
dev.off()
jpeg(file="venn4.jpeg", width=500, height=500)
plot(plot4)
dev.off()
jpeg(file="venn5.jpeg", width=500, height=500)
plot(plot5)
dev.off()
jpeg(file="venn6.jpeg", width=500, height=500)
plot(plot6)
dev.off()
jpeg(file="venn7.jpeg", width=500, height=500)
plot(plot7)
dev.off()
jpeg(file="venn8.jpeg", width=500, height=500)
plot(plot8)
dev.off()
```
### Compare best examples of leucotricha and aphanis:
Extract P. lecuotricha and P. aphanis only gene names for the apple 2020 and strawberry 2020 samples.
```bash
WorkDir=analysis/orthology/orthofinder/All6_isolates
Orthogroups=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
GoodProts=$WorkDir/goodProteins/goodProteins.fasta

for num in 1; do
UniqDir=$WorkDir/speciescomp
mkdir -p $UniqDir
cat $Orthogroups | grep -e 'ST20' | grep -e 'ST21' | grep -e 'RA20' |  grep -e 'AP20' |  grep -e 'AP21' |  grep -e 'AP19' > $UniqDir/both.txt
cat $UniqDir/both.txt | wc -l #7,207
cat $Orthogroups | grep -v -e 'ST20' | grep -v -e 'ST21' | grep -v -e 'RA20' |  grep -e 'AP20' |  grep -e 'AP21' |  grep -e 'AP19' > $UniqDir/leucotricha.txt
cat $UniqDir/leucotricha.txt | wc -l #4,478
cat $Orthogroups |  grep -v -e 'AP20' |  grep -v -e 'AP21' |  grep -v -e 'AP19' | grep -e 'ST20' | grep -e 'ST21' | grep -e 'RA20' > $UniqDir/aphanis.txt
cat $UniqDir/aphanis.txt | wc -l #1,361

for gene in $(cat $UniqDir/both.txt | grep -o -P '(?<=ST20).*?(?=.t1)'| sed -e "s@|@@g"); do
echo ${gene}.t1 >>$UniqDir/both_ST20_genes.txt
done
for gene in $(cat $UniqDir/both.txt | grep -o -P '(?<=AP20).*?(?=.t1)'| sed -e "s@|@@g"); do
echo ${gene}.t1 >>$UniqDir/both_AP20_genes.txt
done
for gene in $(cat $UniqDir/aphanis.txt | grep -o -P '(?<=ST20).*?(?=.t1)'| sed -e "s@|@@g"); do
echo ${gene}.t1 >>$UniqDir/aphanis_ST20_genes.txt
done
for gene in $(cat $UniqDir/leucotricha.txt | grep -o -P '(?<=AP20).*?(?=.t1)'| sed -e "s@|@@g"); do
echo ${gene}.t1 >>$UniqDir/leucotricha_AP20_genes.txt
done
done



```
SecretomeP 2.0 for non-canonically secreted proteins:
```bash
mkdir split
cd split
for line in $(cat P_leucotricha-THeavenp11_1-leucotricha-ranked.tsv | grep -P '(?<=g).*?(?=.t1)' | cut -f1); do
echo $line>>temp.txt
grep -A 1 -f temp.txt /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/THeavenp11_1.pep.fasta | sed -e "s@-@N@g">> P_leucotricha-unique.fasta #10126
rm temp.txt
done

for line in $(cat P_aphanis-THeavenDRCT72020_1-aphanis-ranked.tsv | grep -P '(?<=g).*?(?=.t1)' | cut -f1); do
echo $line>>temp.txt
grep -A 1 -f temp.txt /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/THeavenDRCT72020_1.pep.fasta | sed -e "s@-@N@g">> P_aphanis-unique.fasta #4104
rm temp.txt
done

for line in $(cat P_leucotricha-THeavenp11_1-common-ranked.tsv | grep -P '(?<=g).*?(?=.t1)' | cut -f1); do
echo $line>>temp.txt
grep -A 1 -f temp.txt /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/THeavenp11_1.pep.fasta | sed -e "s@-@N@g">> P_leucotricha-common.fasta #19114
rm temp.txt
done

for line in $(cat P_aphanis-THeavenDRCT72020_1-common-ranked.tsv | grep -P '(?<=g).*?(?=.t1)' | cut -f1); do
echo $line>>temp.txt
grep -A 1 -f temp.txt /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/THeavenDRCT72020_1.pep.fasta | sed -e "s@-@N@g">> P_aphanis-common.fasta #21298
rm temp.txt
done

awk '/^>/{val=$0;next} length($0)>40{print val ORS $0}' P_leucotricha-unique.fasta > P_leucotricha-unique_40.fasta #9884
awk '/^>/{val=$0;next} length($0)>40{print val ORS $0}' P_aphanis-unique.fasta > P_aphanis-unique_40.fasta #4090
awk '/^>/{val=$0;next} length($0)>40{print val ORS $0}' P_leucotricha-common.fasta > P_leucotricha-common_40.fasta #19102
awk '/^>/{val=$0;next} length($0)>40{print val ORS $0}' P_aphanis-common.fasta > P_aphanis-common_40.fasta #21284

split -l 200 P_leucotricha-unique_40.fasta P_leucotricha-unique_split_
split -l 200 P_leucotricha-common_40.fasta P_leucotricha-common_split_
split -l 200 P_aphanis-unique_40.fasta P_aphanis-unique_split_
split -l 200 P_aphanis-common_40.fasta P_aphanis-common_split_
mkdir x
cp *_split_* x/.
#split files downloaded for submission to SecretomeP 2.0 server

#Secretome1:
screen -S secretomep
srun -J SecretomeP -p long --mem-per-cpu 8G --cpus-per-task 8 --pty bash
conda activate jellyfish
cat /home/theaven/scratch/split/P_leucotricha-unique_40.fasta | sed -e "s@X@@g" > /home/theaven/scratch/split/P_leucotricha-unique_40.fsa
cat /home/theaven/scratch/split/P_leucotricha-common_40.fasta | sed -e "s@X@@g" > /home/theaven/scratch/split/P_leucotricha-common_40.fsa
cat /home/theaven/scratch/split/P_aphanis-unique_40.fasta | sed -e "s@X@@g" > /home/theaven/scratch/split/P_aphanis-unique_40.fsa
cat /home/theaven/scratch/split/P_aphanis-common_40.fasta | sed -e "s@X@@g" > /home/theaven/scratch/split/P_aphanis-common_40.fsa

/home/theaven/scratch/apps/secretomep/secretomep-1.0/secretomep -v -s /home/theaven/scratch/split/P_leucotricha-unique_40.fsa >& /home/theaven/scratch/P_leucotricha-unique_40_secretomep.out
/home/theaven/scratch/apps/secretomep/secretomep-1.0/secretomep -v -s /home/theaven/scratch/split/P_leucotricha-common_40.fsa >& /home/theaven/scratch/P_leucotricha-common_40_secretomep.out
/home/theaven/scratch/apps/secretomep/secretomep-1.0/secretomep -v -s /home/theaven/scratch/split/P_aphanis-unique_40.fsa >& /home/theaven/scratch/P_aphanis-unique_40_secretomep.out
/home/theaven/scratch/apps/secretomep/secretomep-1.0/secretomep -v -s /home/theaven/scratch/split/P_aphanis-common_40.fsa >& /home/theaven/scratch/P_aphanis-common_40_secretomep.out
echo finished
exit
exit

awk '/^>/{val=$0;next} length($0)<4000{print val ORS $0}' P_aphanis-common_split_ah

P_leucotricha-unique.fasta > P_leucotricha-unique_40.fasta
```
BLAST proteins:
```bash
#Extract name of gene from predector file to temp.txt, then get the protein fasta entry for that gene
conda activate blast+
cat P_leucotricha-THeavenp11_1-leucotricha-ranked.tsv | grep -v 'name'| cut -f1>temp.txt
seqtk subseq /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/THeavenp11_1.pep.fasta temp.txt > P_leucotricha-unique.fasta 

cat P_aphanis-THeavenDRCT72020_1-aphanis-ranked.tsv | grep -v 'name'| cut -f1>temp.txt
seqtk subseq /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/THeavenDRCT72020_1.pep.fasta temp.txt > P_aphanis-unique.fasta 

cat P_leucotricha-THeavenp11_1-common-ranked.tsv | grep -v 'name'| cut -f1>temp.txt
seqtk subseq /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/THeavenp11_1.pep.fasta temp.txt > P_leucotricha-common.fasta 

cat P_aphanis-THeavenDRCT72020_1-common-ranked.tsv | grep -v 'name'| cut -f1>temp.txt
seqtk subseq /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/THeavenDRCT72020_1.pep.fasta temp.txt > P_aphanis-common.fasta 
rm temp.txt


#Make blast database as in Praz et al., 2017
cat podosporaanserina_GCF_000226545.1_ASM22654v1_protein.faa neurosporacrassa_GCF_000182925.2_NC12_protein.faa > mydb.faa
mkdir db
makeblastdb -in mydb.faa -dbtype prot -title CSEPdb -out db/CSEPdb

#blast for matches
blastp -query P_leucotricha-unique.fasta -db db/CSEPdb -out P_leucotricha-unique_blast.tsv -evalue 1e-5 -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qseq sseq'
blastp -query P_leucotricha-common.fasta -db db/CSEPdb -out P_leucotricha-common_blast.tsv -evalue 1e-5 -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qseq sseq'
blastp -query P_aphanis-unique.fasta -db db/CSEPdb -out P_aphanis-unique_blast.tsv -evalue 1e-5 -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qseq sseq'
blastp -query P_aphanis-common.fasta -db db/CSEPdb -out P_aphanis-common_blast.tsv -evalue 1e-5 -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qseq sseq'

#Extract the gene name from blast results
cat P_leucotricha-unique_blast.tsv | cut -f1 |sort | uniq > P_leucotricha-unique_out_blast.txt
cat P_leucotricha-common_blast.tsv | cut -f1 |sort | uniq  > P_leucotricha-common_out_blast.txt
cat P_aphanis-unique_blast.tsv | cut -f1 |sort | uniq  > P_aphanis-unique_out_blast.txt
cat P_aphanis-common_blast.tsv | cut -f1 |sort | uniq > P_aphanis-common_out_blast.txt
#Add information to predector file
for f in P_leucotricha-unique_out_blast.txt; do sed -i "s/$/\t1/" $f; done
for f in P_leucotricha-common_out_blast.txt; do sed -i "s/$/\t1/" $f; done
for f in P_aphanis-unique_out_blast.txt; do sed -i "s/$/\t1/" $f; done
for f in P_aphanis-common_out_blast.txt; do sed -i "s/$/\t1/" $f; done
printf 'name\torthology match' >> P_leucotricha-unique_out_blast.txt
printf 'name\torthology match' >> P_leucotricha-common_out_blast.txt
printf 'name\torthology match' >> P_aphanis-unique_out_blast.txt
printf 'name\torthology match' >> P_aphanis-common_out_blast.txt
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84 <(sort P_leucotricha-THeavenp11_1-leucotricha-ranked.tsv) <(sort P_leucotricha-unique_out_blast.txt) > P_leucotricha-THeavenp11_1-leucotricha-ranked2.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84 <(sort P_aphanis-THeavenDRCT72020_1-aphanis-ranked.tsv) <(sort P_aphanis-unique_out_blast.txt) > P_aphanis-THeavenDRCT72020_1-aphanis-ranked2.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84 <(sort P_leucotricha-THeavenp11_1-common-ranked.tsv) <(sort P_leucotricha-common_out_blast.txt) > P_leucotricha-THeavenp11_1-common-ranked2.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84 <(sort P_aphanis-THeavenDRCT72020_1-common-ranked.tsv) <(sort P_aphanis-common_out_blast.txt) > P_aphanis-THeavenDRCT72020_1-common-ranked2.tsv
####################################################################################################################################################################################################

#Make blast database for mildews: B.hordei, B. graminis, B. graminis f.sp. triticale, G. cichoracearum, E. necator - downloaded proteins predictions from NCBI genome assembly projects

cat GCA_000151065.3_ASM15106v3_protein.faa GCA_900519115.1_Bgt_genome_v3.16_protein.faa GCA_905067625.1_Bgtriticale_THUN12_genome_v1_2_protein.faa GCA_024703715.1_EnE101_chr_assembly_v3_protein.faa GCA_003611235.1_ASM361123v1_protein.faa > mydb.faa
mkdir db2
makeblastdb -in mydb.faa -dbtype prot -title blumeriadb -out db2/blumeriadb

#blast for matches
blastp -query P_leucotricha-unique.fasta -db db2/blumeriadb -out temp1.tsv -evalue 1e-5 -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qseq sseq' 
blastp -query P_leucotricha-common.fasta -db db2/blumeriadb -out temp2.tsv -evalue 1e-5 -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qseq sseq' 
blastp -query P_aphanis-unique.fasta -db db2/blumeriadb -out temp3.tsv -evalue 1e-5 -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qseq sseq' 
blastp -query P_aphanis-common.fasta -db db2/blumeriadb -out temp4.tsv -evalue 1e-5 -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qseq sseq' 

#Extract the gene name from blast results
cat temp1.tsv | cut -f1 |sort | uniq  > P_leucotricha-unique_in_blast.txt
cat temp2.tsv | cut -f1 |sort | uniq  > P_leucotricha-common_in_blast.txt
cat temp3.tsv | cut -f1 |sort | uniq  > P_aphanis-unique_in_blast.txt
cat temp4.tsv | cut -f1 |sort | uniq  > P_aphanis-common_in_blast.txt
#Add information to predector file
for f in P_leucotricha-unique_in_blast.txt; do sed -i "s/$/\t1/" $f; done
for f in P_leucotricha-common_in_blast.txt; do sed -i "s/$/\t1/" $f; done
for f in P_aphanis-unique_in_blast.txt; do sed -i "s/$/\t1/" $f; done
for f in P_aphanis-common_in_blast.txt; do sed -i "s/$/\t1/" $f; done
printf 'name\tmildew match' >> P_leucotricha-unique_in_blast.txt
printf 'name\tmildew match' >> P_leucotricha-common_in_blast.txt
printf 'name\tmildew match' >> P_aphanis-unique_in_blast.txt
printf 'name\tmildew match' >> P_aphanis-common_in_blast.txt
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85 <(sort P_leucotricha-THeavenp11_1-leucotricha-ranked2.tsv) <(sort P_leucotricha-unique_in_blast.txt) > P_leucotricha-THeavenp11_1-leucotricha-ranked3.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85 <(sort P_aphanis-THeavenDRCT72020_1-aphanis-ranked2.tsv) <(sort P_aphanis-unique_in_blast.txt) > P_aphanis-THeavenDRCT72020_1-aphanis-ranked3.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85 <(sort P_leucotricha-THeavenp11_1-common-ranked2.tsv) <(sort P_leucotricha-common_in_blast.txt) > P_leucotricha-THeavenp11_1-common-ranked3.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85 <(sort P_aphanis-THeavenDRCT72020_1-common-ranked2.tsv) <(sort P_aphanis-common_in_blast.txt) > P_aphanis-THeavenDRCT72020_1-common-ranked3.tsv

for ome in $(ls /home/theaven/scratch/P_leucotricha-unique_40_secretomep.out); do 
sed -i -n '/SecretomeP 1.0g predictions/,$p' $ome 
sed -i '$d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
done
for ome in $(ls /home/theaven/scratch/P_leucotricha-common_40_secretomep.out); do 
sed -i -n '/SecretomeP 1.0g predictions/,$p' $ome 
sed -i '$d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
done
for ome in $(ls /home/theaven/scratch/P_aphanis-unique_40_secretomep.out); do 
sed -i -n '/SecretomeP 1.0g predictions/,$p' $ome 
sed -i '$d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
done
for ome in $(ls /home/theaven/scratch/P_aphanis-common_40_secretomep.out); do 
sed -i -n '/SecretomeP 1.0g predictions/,$p' $ome 
sed -i '$d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
done
printf 'name\tNN-score\tOdds\tWeighted\tWarning' >> /home/theaven/scratch/P_leucotricha-unique_40_secretomep.out
printf 'name\tNN-score\tOdds\tWeighted\tWarning' >> /home/theaven/scratch/P_leucotricha-common_40_secretomep.out
printf 'name\tNN-score\tOdds\tWeighted\tWarning' >> /home/theaven/scratch/P_aphanis-unique_40_secretomep.out
printf 'name\tNN-score\tOdds\tWeighted\tWarning' >> /home/theaven/scratch/P_aphanis-common_40_secretomep.out
awk -v OFS='\t' '{$1=$1}1' /home/theaven/scratch/P_leucotricha-unique_40_secretomep.out > /home/theaven/scratch/P_leucotricha-unique_40_secretomep.tsv
awk -v OFS='\t' '{$1=$1}1' /home/theaven/scratch/P_leucotricha-common_40_secretomep.out > /home/theaven/scratch/P_leucotricha-common_40_secretomep.tsv
awk -v OFS='\t' '{$1=$1}1' /home/theaven/scratch/P_aphanis-unique_40_secretomep.out > /home/theaven/scratch/P_aphanis-unique_40_secretomep.tsv
awk -v OFS='\t' '{$1=$1}1' /home/theaven/scratch/P_aphanis-common_40_secretomep.out > /home/theaven/scratch/P_aphanis-common_40_secretomep.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,2.3,2.4,2.5,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85,1.86 <(sort P_leucotricha-THeavenp11_1-leucotricha-ranked3.tsv) <(sort /home/theaven/scratch/P_leucotricha-unique_40_secretomep.tsv) > P_leucotricha-THeavenp11_1-leucotricha-ranked4.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,2.3,2.4,2.5,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85,1.86 <(sort P_aphanis-THeavenDRCT72020_1-aphanis-ranked3.tsv) <(sort /home/theaven/scratch/P_aphanis-common_40_secretomep.tsv) > P_aphanis-THeavenDRCT72020_1-aphanis-ranked4.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,2.3,2.4,2.5,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85,1.86 <(sort P_leucotricha-THeavenp11_1-common-ranked3.tsv) <(sort /home/theaven/scratch/P_leucotricha-unique_40_secretomep.tsv) > P_leucotricha-THeavenp11_1-common-ranked4.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,2.3,2.4,2.5,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85,1.86 <(sort P_aphanis-THeavenDRCT72020_1-common-ranked3.tsv) <(sort /home/theaven/scratch/P_aphanis-common_40_secretomep.tsv) > P_aphanis-THeavenDRCT72020_1-common-ranked4.tsv
```
Y/F/WxC
```bash
for proteome in $(echo GCA_000151065.3_ASM15106v3_protein.fsa); do
grep -B1 'YGC\|YAC\|YLC\|YMC\|YFC\|YWC\|YKC\|YQC\|YEC\|YSC\|YPC\|YVC\|YIC\|YYC\|YHC\|YRC\|YNC\|YDC\|YTC\|FGC\|FAC\|FLC\|FMC\|FFC\|FWC\|FKC\|FQC\|FEC\|FSC\|FPC\|FVC\|FIC\|FYC\|FHC\|FRC\|FNC\|FDC\|FTC\|WGC\|WAC\|WLC\|WMC\|WFC\|WWC\|WKC\|WQC\|WEC\|WSC\|WPC\|WVC\|WIC\|WYC\|WHC\|WRC\|WNC\|WDC\|WTC' $proteome | grep -v 'YGC\|YAC\|YLC\|YMC\|YFC\|YWC\|YKC\|YQC\|YEC\|YSC\|YPC\|YVC\|YIC\|YYC\|YHC\|YRC\|YNC\|YDC\|YTC\|FGC\|FAC\|FLC\|FMC\|FFC\|FWC\|FKC\|FQC\|FEC\|FSC\|FPC\|FVC\|FIC\|FYC\|FHC\|FRC\|FNC\|FDC\|FTC\|WGC\|WAC\|WLC\|WMC\|WFC\|WWC\|WKC\|WQC\|WEC\|WSC\|WPC\|WVC\|WIC\|WYC\|WHC\|WRC\|WNC\|WDC\|WTC\|--' > temp.txt
done
#returns about 1/3 regardless of input species
```
```bash
#Effectors:
#P. aphanis strawberry 2020
for file in $(ls /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-ranked.tsv); do
  head -n 1 /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-ranked.tsv > /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-common-ranked.tsv
  head -n 1 /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-ranked.tsv > /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-aphanis-ranked.tsv
  grep -w -f analysis/orthology/orthofinder/All6_isolates/speciescomp/both_ST20_genes.txt $file >> /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-common-ranked.tsv
  grep -w -f analysis/orthology/orthofinder/All6_isolates/speciescomp/aphanis_ST20_genes.txt $file >> /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-aphanis-ranked.tsv
done

#P. leucotricha apple 2020
for file in $(ls /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-ranked.tsv); do
  head -n 1 /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-ranked.tsv > /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-common-ranked.tsv
  head -n 1 /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-ranked.tsv > /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-leucotricha-ranked.tsv
  grep -w -f analysis/orthology/orthofinder/All6_isolates/speciescomp/both_AP20_genes.txt $file >> /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-common-ranked.tsv
  grep -w -f analysis/orthology/orthofinder/All6_isolates/speciescomp/leucotricha_AP20_genes.txt $file >> /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-leucotricha-ranked.tsv
done

#Transcription factors:
#P.aphanis
for file in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/transcription_factors/THeavenDRCT72020_1_TF_gene_headers.txt); do
  aphanis_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/aphanis_ST20_genes.txt)
  both_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/both_ST20_genes.txt)
  aphanis_ST20_genes_out=$(dirname $file)/$(basename $file .txt)_common.txt
  both_ST20_genes_out=$(dirname $file)/$(basename $file .txt)_aphanis.txt
  echo $aphanis_ST20_genes_out
  echo $both_ST20_genes_out
  grep -w -f $aphanis_ST20_genes $file > $aphanis_ST20_genes_out
  grep -w -f $both_ST20_genes $file > $both_ST20_genes_out
done
echo number of transcription factors in THeavenDRCT72020_1 >> TForthologyreport.txt 
echo unique to P.aphanis: >> TForthologyreport.txt  >> TForthologyreport.txt 
cat $aphanis_ST20_genes_out| wc -l >> TForthologyreport.txt 
echo shared with P.leucotricha: >> TForthologyreport.txt 
cat $both_ST20_genes_out| wc -l >> TForthologyreport.txt 
printf '\n'  >> TForthologyreport.txt
#P.leucotricha
for file in $(ls gene_pred/P_leucotricha/THeavenp11_1/transcription_factors/THeavenp11_1_TF_gene_headers.txt); do
  leucotricha_AP20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/leucotricha_AP20_genes.txt)
  both_AP20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/both_AP20_genes.txt)
  leucotricha_AP20_genes_out=$(dirname $file)/$(basename $file .txt)_common.txt
  both_AP20_genes_out=$(dirname $file)/$(basename $file .txt)_leucotricha.txt
  echo $leucotricha_AP20_genes_out
  echo $both_AP20_genes_out
  grep -w -f $leucotricha_AP20_genes $file > $leucotricha_AP20_genes_out
  grep -w -f $both_AP20_genes $file > $both_AP20_genes_out
done
echo number of transcription factors THeavenp11_1 >> TForthologyreport.txt 
echo unique to P.leucotricha: >> TForthologyreport.txt 
cat $leucotricha_AP20_genes_out| wc -l >> TForthologyreport.txt 
echo shared with P.aphanis: >> TForthologyreport.txt 
cat $both_AP20_genes_out| wc -l >> TForthologyreport.txt 
printf '\n'  >> TForthologyreport.txt

#SSCPs
#P.aphanis
for file in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/sscp/THeavenDRCT72020_1_sscp.fa); do
  aphanis_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/aphanis_ST20_genes.txt)
  both_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/both_ST20_genes.txt)
  aphanis_ST20_genes_out=$(dirname $file)/$(basename $file .txt)_common.txt
  both_ST20_genes_out=$(dirname $file)/$(basename $file .txt)_aphanis.txt
  echo $aphanis_ST20_genes_out
  echo $both_ST20_genes_out
  grep -w -f $aphanis_ST20_genes $file > $aphanis_ST20_genes_out
  grep -w -f $both_ST20_genes $file > $both_ST20_genes_out
done
echo number of SSCPs in THeavenDRCT72020_1 >> SSCPorthologyreport.txt 
echo unique to P.aphanis: >> TForthologyreport.txt  >> SSCPorthologyreport.txt 
cat $aphanis_ST20_genes_out| wc -l >> SSCPorthologyreport.txt 
echo shared with P.leucotricha: >> SSCPorthologyreport.txt 
cat $both_ST20_genes_out| wc -l >> SSCPorthologyreport.txt 
printf '\n'  >> SSCPorthologyreport.txt
#P.leucotricha
for file in $(ls gene_pred/P_leucotricha/THeavenp11_1/sscp/THeavenp11_1_sscp.fa); do
  leucotricha_AP20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/leucotricha_AP20_genes.txt)
  both_AP20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/both_AP20_genes.txt)
  leucotricha_AP20_genes_out=$(dirname $file)/$(basename $file .txt)_common.txt
  both_AP20_genes_out=$(dirname $file)/$(basename $file .txt)_leucotricha.txt
  echo $leucotricha_AP20_genes_out
  echo $both_AP20_genes_out
  grep -w -f $leucotricha_AP20_genes $file > $leucotricha_AP20_genes_out
  grep -w -f $both_AP20_genes $file > $both_AP20_genes_out
done
echo number of SSCPs THeavenp11_1 >> SSCPorthologyreport.txt 
echo unique to P.leucotricha: >> SSCPorthologyreport.txt 
cat $leucotricha_AP20_genes_out| wc -l >> SSCPorthologyreport.txt 
echo shared with P.aphanis: >> SSCPorthologyreport.txt 
cat $both_AP20_genes_out| wc -l >> SSCPorthologyreport.txt 
printf '\n'  >> SSCPorthologyreport.txt

#CAZYs
#P.aphanis
for file in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/cazy/THeavenDRCT72020_1_CAZY_secreted_headers.txt); do
  aphanis_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/aphanis_ST20_genes.txt)
  both_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/both_ST20_genes.txt)
  aphanis_ST20_genes_out=$(dirname $file)/$(basename $file .txt)_common.txt
  both_ST20_genes_out=$(dirname $file)/$(basename $file .txt)_aphanis.txt
  echo $aphanis_ST20_genes_out
  echo $both_ST20_genes_out
  grep -w -f $aphanis_ST20_genes $file > $aphanis_ST20_genes_out
  grep -w -f $both_ST20_genes $file > $both_ST20_genes_out
done
echo number of secreted CAZYs in THeavenDRCT72020_1 >> CAZYorthologyreport.txt 
echo unique to P.aphanis: >> TForthologyreport.txt  >> CAZYorthologyreport.txt 
cat $aphanis_ST20_genes_out| wc -l >> CAZYorthologyreport.txt 
echo shared with P.leucotricha: >> CAZYorthologyreport.txt 
cat $both_ST20_genes_out| wc -l >> CAZYorthologyreport.txt 
printf '\n'  >> CAZYorthologyreport.txt
#P.leucotricha
for file in $(ls gene_pred/P_leucotricha/THeavenp11_1/cazy/THeavenp11_1_CAZY_secreted_headers.txt); do
  leucotricha_AP20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/leucotricha_AP20_genes.txt)
  both_AP20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/both_AP20_genes.txt)
  leucotricha_AP20_genes_out=$(dirname $file)/$(basename $file .txt)_common.txt
  both_AP20_genes_out=$(dirname $file)/$(basename $file .txt)_leucotricha.txt
  echo $leucotricha_AP20_genes_out
  echo $both_AP20_genes_out
  grep -w -f $leucotricha_AP20_genes $file > $leucotricha_AP20_genes_out
  grep -w -f $both_AP20_genes $file > $both_AP20_genes_out
done
echo number of secreted CAZYs in THeavenp11_1 >> CAZYorthologyreport.txt 
echo unique to P.leucotricha: >> CAZYorthologyreport.txt 
cat $leucotricha_AP20_genes_out| wc -l >> CAZYorthologyreport.txt 
echo shared with P.aphanis: >> CAZYorthologyreport.txt 
cat $both_AP20_genes_out| wc -l >> CAZYorthologyreport.txt 
printf '\n'  >> CAZYorthologyreport.txt

#Interpro
#P.aphanis
for file in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/NRI/P.aphanis_strawberry2020_interproscan.tsv); do
  aphanis_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/aphanis_ST20_genes.txt)
  both_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/both_ST20_genes.txt)
  aphanis_ST20_genes_out=$(dirname $file)/$(basename $file .tsv)_common.tsv
  both_ST20_genes_out=$(dirname $file)/$(basename $file .tsv)_aphanis.tsv
  echo $aphanis_ST20_genes_out
  echo $both_ST20_genes_out
  grep -w -f $aphanis_ST20_genes $file > $aphanis_ST20_genes_out
  grep -w -f $both_ST20_genes $file > $both_ST20_genes_out
done

#P.leucotricha
for file in $(ls gene_pred/P_leucotricha/THeavenp11_1/interproscan/NRI/P.leucotricha_apple2020_interproscan.tsv); do
  leucotricha_AP20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/leucotricha_AP20_genes.txt)
  both_AP20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/speciescomp/both_AP20_genes.txt)
  leucotricha_AP20_genes_out=$(dirname $file)/$(basename $file .tsv)_common.tsv
  both_AP20_genes_out=$(dirname $file)/$(basename $file .tsv)_leucotricha.tsv
  echo $leucotricha_AP20_genes_out
  echo $both_AP20_genes_out
  grep -w -f $leucotricha_AP20_genes $file > $leucotricha_AP20_genes_out
  grep -w -f $both_AP20_genes $file > $both_AP20_genes_out
done

#Effector interproscan results:
#P.aphanis
for file in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/NRI/P.aphanis_strawberry2020_interproscan.tsv); do
  echo $file
  cat /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-aphanis-ranked.tsv | cut -f1 > x.txt
grep -w -f x.txt $file > $(dirname $file)/$(basename $file .tsv)_aphanis_effectors.tsv
done

#P.leucotricha
for file in $(ls gene_pred/P_leucotricha/THeavenp11_1/interproscan/NRI/P.leucotricha_apple2020_interproscan.tsv); do
  echo $file
  cat /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-leucotricha-ranked.tsv | cut -f1 > x.txt
grep -w -f x.txt $file > $(dirname $file)/$(basename $file .tsv)_leucotricha_effectors.tsv
done
```
```
gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/NRI/P.aphanis_strawberry2020_interproscan.tsv
gene_pred/P_aphanis/THeavenDRCT72021_1/interproscan/NRI/P.aphanis_strawberry2021_interproscan.tsv
gene_pred/P_aphanis/THeavenSCOTT2020_1/interproscan/NRI/P.aphanis_raspberry2020_interproscan.tsv
gene_pred/P_leucotricha/THeavenp11_1/interproscan/NRI/P.leucotricha_apple2020_interproscan.tsv
gene_pred/P_leucotricha/THeavenpOGB2019_1/interproscan/NRI/P.leucotricha_apple2019_interproscan.tsv
gene_pred/P_leucotricha/THeavenpOGB2021_1/interproscan/NRI/P.leucotricha_apple2021_interproscan.tsv
```
### Compare best of apple to best of strawberry only:
Extract Strawberry and Apple only gene names for the 2020 samples.
```bash
WorkDir=analysis/orthology/orthofinder/All6_isolates
Orthogroups=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
GoodProts=$WorkDir/goodProteins/goodProteins.fasta

for num in 1; do
UniqDir=$WorkDir/minusrasphostcomp
mkdir -p $UniqDir
cat $Orthogroups | grep -e 'ST20' | grep -e 'ST21' |  grep -e 'AP20' |  grep -e 'AP21' |  grep -e 'AP19' > $UniqDir/minusraspboth.txt
cat $UniqDir/minusraspboth.txt | wc -l #7,416
cat $Orthogroups | grep -v -e 'ST20' | grep -v -e 'ST21' | grep -e 'AP20' |  grep -e 'AP21' |  grep -e 'AP19' > $UniqDir/minusraspapple.txt
cat $UniqDir/minusraspapple.txt | wc -l #4,666
cat $Orthogroups |  grep -e 'ST20' |  grep -e 'ST21' |  grep -v -e 'AP20' |  grep -v -e 'AP21' |  grep -v -e 'AP19' > $UniqDir/minusraspstrawb.txt
cat $UniqDir/minusraspstrawb.txt | wc -l #2,722

for gene in $(cat $UniqDir/minusraspboth.txt | grep -o -P '(?<=ST20).*?(?=.t1)'| sed -e "s@|@@g"); do
echo ${gene}.t1 >>$UniqDir/minusraspboth_ST20_genes.txt
done
for gene in $(cat $UniqDir/minusraspboth.txt | grep -o -P '(?<=AP20).*?(?=.t1)'| sed -e "s@|@@g"); do
echo ${gene}.t1 >>$UniqDir/minusraspboth_AP20_genes.txt
done
for gene in $(cat $UniqDir/minusraspstrawb.txt | grep -o -P '(?<=ST20).*?(?=.t1)'| sed -e "s@|@@g"); do
echo ${gene}.t1 >>$UniqDir/minusraspstrawb_ST20_genes.txt
done
for gene in $(cat $UniqDir/minusraspapple.txt | grep -o -P '(?<=AP20).*?(?=.t1)'| sed -e "s@|@@g"); do
echo ${gene}.t1 >>$UniqDir/minusraspapple_AP20_genes.txt
done
done
```
```bash
#Effectors:
#P. aphanis strawberry 2020
for file in $(ls /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-ranked.tsv); do
  head -n 1 /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-ranked.tsv > /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-minusraspcommon-ranked.tsv
  head -n 1 /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-ranked.tsv > /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-minusraspaphanis-ranked.tsv
  grep -w -f analysis/orthology/orthofinder/All6_isolates/minusrasphostcomp/minusraspboth_ST20_genes.txt $file >> /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-minusraspcommon-ranked.tsv
  grep -w -f analysis/orthology/orthofinder/All6_isolates/minusrasphostcomp/minusraspstrawb_ST20_genes.txt $file >> /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-minusraspaphanis-ranked.tsv
done

#P. leucotricha apple 2020
for file in $(ls /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-ranked.tsv); do
  head -n 1 /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-ranked.tsv > /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-minusraspcommon-ranked.tsv
  head -n 1 /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-ranked.tsv > /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-minusraspleucotricha-ranked.tsv
  grep -w -f analysis/orthology/orthofinder/All6_isolates/minusrasphostcomp/minusraspboth_AP20_genes.txt $file >> /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-minusraspcommon-ranked.tsv
  grep -w -f analysis/orthology/orthofinder/All6_isolates/minusrasphostcomp/minusraspapple_AP20_genes.txt $file >> /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-minusraspleucotricha-ranked.tsv
done
```

### Compare best examples of raspberry and strawberry:
Extract Strawberry and Raspberry only gene names for the 2020 samples.
```bash
WorkDir=analysis/orthology/orthofinder/All6_isolates
Orthogroups=$(ls $WorkDir/formatted/OrthoFinder/*/Orthogroups/Orthogroups.txt)
GoodProts=$WorkDir/goodProteins/goodProteins.fasta

for num in 1; do
UniqDir=$WorkDir/aphanishostcomp
mkdir -p $UniqDir
cat $Orthogroups | grep -e 'ST20' | grep -e 'ST21' |  grep -e 'RA20' |  grep -v -e 'AP20' |  grep -v -e 'AP21' |  grep -v -e 'AP19' > $UniqDir/both.txt
cat $UniqDir/both.txt | wc -l #
cat $Orthogroups | grep -v -e 'ST20' | grep -v -e 'ST21' | grep -e 'RA20' |  grep -v -e 'AP20' |  grep -v -e 'AP21' |  grep -v -e 'AP19' > $UniqDir/rasp.txt
cat $UniqDir/rasp.txt | wc -l #
cat $Orthogroups |  grep -v -e 'RA20' |  grep -e 'ST20' |  grep -e 'ST21' |  grep -v -e 'AP20' |  grep -v -e 'AP21' |  grep -v -e 'AP19' > $UniqDir/strawb.txt
cat $UniqDir/strawb.txt | wc -l #

for gene in $(cat $UniqDir/both.txt | grep -o -P '(?<=ST20).*?(?=.t1)'| sed -e "s@|@@g"); do
echo ${gene}.t1 >>$UniqDir/both_ST20_genes.txt
done
for gene in $(cat $UniqDir/both.txt | grep -o -P '(?<=RA20).*?(?=.t1)'| sed -e "s@|@@g"); do
echo ${gene}.t1 >>$UniqDir/both_RA20_genes.txt
done
for gene in $(cat $UniqDir/strawb.txt | grep -o -P '(?<=ST20).*?(?=.t1)'| sed -e "s@|@@g"); do
echo ${gene}.t1 >>$UniqDir/strawb_ST20_genes.txt
done
for gene in $(cat $UniqDir/rasp.txt | grep -o -P '(?<=RA20).*?(?=.t1)'| sed -e "s@|@@g"); do
echo ${gene}.t1 >>$UniqDir/rasp_RA20_genes.txt
done
done
```
```bash
#Effectors:
#P. aphanis strawberry 2020
for file in $(ls /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-ranked.tsv); do
  head -n 1 /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-ranked.tsv > /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-aphaniscommon-ranked.tsv
  head -n 1 /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-ranked.tsv > /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-strawberryaphanis-ranked.tsv
  grep -w -f analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/both_ST20_genes.txt $file >> /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-aphaniscommon-ranked.tsv
  grep -w -f analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/strawb_ST20_genes.txt $file >> /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-strawberryaphanis-ranked.tsv
done

#P. aphanis raspberry 2020
for file in $(ls /home/theaven/scratch/gene_pred/P_aphanis/THeavenSCOTT2020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenSCOTT2020_1-ranked.tsv); do
  head -n 1 /home/theaven/scratch/gene_pred/P_aphanis/THeavenSCOTT2020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenSCOTT2020_1-ranked.tsv > /home/theaven/scratch/gene_pred/P_aphanis/THeavenSCOTT2020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenSCOTT2020_1-aphaniscommon-ranked.tsv
  head -n 1 /home/theaven/scratch/gene_pred/P_aphanis/THeavenSCOTT2020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenSCOTT2020_1-ranked.tsv > /home/theaven/scratch/gene_pred/P_aphanis/THeavenSCOTT2020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenSCOTT2020_1-raspberryaphanis-ranked.tsv
  grep -w -f analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/both_RA20_genes.txt $file >> /home/theaven/scratch/gene_pred/P_aphanis/THeavenSCOTT2020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenSCOTT2020_1-aphaniscommon-ranked.tsv
  grep -w -f analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/rasp_RA20_genes.txt $file >> /home/theaven/scratch/gene_pred/P_aphanis/THeavenSCOTT2020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenSCOTT2020_1-raspberryaphanis-ranked.tsv
done

#Transcription factors:
#Strawberry
for file in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/transcription_factors/THeavenDRCT72020_1_TF_gene_headers.txt); do
  strawb_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/strawb_ST20_genes.txt)
  both_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/both_ST20_genes.txt)
  strawb_ST20_genes_out=$(dirname $file)/$(basename $file .txt)_common.txt
  both_ST20_genes_out=$(dirname $file)/$(basename $file .txt)_aphanis.txt
  echo $strawb_ST20_genes_out
  echo $both_ST20_genes_out
  grep -w -f $strawb_ST20_genes $file > $strawb_ST20_genes_out
  grep -w -f $both_ST20_genes $file > $both_ST20_genes_out
done
echo number of transcription factors in THeavenDRCT72020_1 >> TForthologyreport.txt 
echo unique to strawberry: >> TForthologyreport.txt 
cat $aphanis_ST20_genes_out| wc -l >> TForthologyreport.txt 
echo shared with raspberry: >> TForthologyreport.txt 
cat $both_ST20_genes_out| wc -l >> TForthologyreport.txt
printf '\n'  >> TForthologyreport.txt
#Raspberry
for file in $(ls gene_pred/P_aphanis/THeavenSCOTT2020_1/transcription_factors/THeavenSCOTT2020_1_TF_gene_headers.txt); do
  rasp_RA20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/rasp_RA20_genes.txt)
  both_RA20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/both_RA20_genes.txt)
  rasp_RA20_genes_out=$(dirname $file)/$(basename $file .txt)_common.txt
  both_RA20_genes_out=$(dirname $file)/$(basename $file .txt)_aphanis.txt
  echo $rasp_RA20_genes_out
  echo $both_RA20_genes_out
  grep -w -f $rasp_RA20_genes $file > $rasp_RA20_genes_out
  grep -w -f $both_RA20_genes $file > $both_RA20_genes_out
done
echo number of transcription factors in THeavenSCOTT2020_1 >> TForthologyreport.txt 
echo unique to raspberry: >> TForthologyreport.txt 
cat $rasp_RA20_genes_out| wc -l >> TForthologyreport.txt 
echo shared with strawberry: >> TForthologyreport.txt 
cat $both_RA20_genes_out| wc -l >> TForthologyreport.txt
printf '\n'  >> TForthologyreport.txt

#SSCPs:
#Strawberry
for file in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/sscp/THeavenDRCT72020_1_sscp.fa); do
  strawb_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/strawb_ST20_genes.txt)
  both_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/both_ST20_genes.txt)
  strawb_ST20_genes_out=$(dirname $file)/$(basename $file .txt)_common.txt
  both_ST20_genes_out=$(dirname $file)/$(basename $file .txt)_aphanis.txt
  echo $strawb_ST20_genes_out
  echo $both_ST20_genes_out
  grep -w -f $strawb_ST20_genes $file > $strawb_ST20_genes_out
  grep -w -f $both_ST20_genes $file > $both_ST20_genes_out
done
echo number of SSCPs in THeavenDRCT72020_1 >> SSCPorthologyreport.txt 
echo unique to strawberry: >> TForthologyreport.txt  >> SSCPorthologyreport.txt 
cat $aphanis_ST20_genes_out| wc -l >> SSCPorthologyreport.txt 
echo shared with raspberry: >> SSCPorthologyreport.txt 
cat $both_ST20_genes_out| wc -l >> SSCPorthologyreport.txt
printf '\n'  >> SSCPorthologyreport.txt
#Raspberry
for file in $(ls gene_pred/P_aphanis/THeavenSCOTT2020_1/sscp/THeavenSCOTT2020_1_sscp.fa); do
  rasp_RA20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/rasp_RA20_genes.txt)
  both_RA20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/both_RA20_genes.txt)
  rasp_RA20_genes_out=$(dirname $file)/$(basename $file .txt)_common.txt
  both_RA20_genes_out=$(dirname $file)/$(basename $file .txt)_aphanis.txt
  echo $rasp_RA20_genes_out
  echo $both_RA20_genes_out
  grep -w -f $rasp_RA20_genes $file > $rasp_RA20_genes_out
  grep -w -f $both_RA20_genes $file > $both_RA20_genes_out
done
echo number of SSCPs in THeavenSCOTT2020_1 >> SSCPorthologyreport.txt 
echo unique to raspberry: >> SSCPorthologyreport.txt 
cat $rasp_RA20_genes_out| wc -l >> SSCPorthologyreport.txt 
echo shared with strawberry: >> SSCPorthologyreport.txt 
cat $both_RA20_genes_out| wc -l >> SSCPorthologyreport.txt
printf '\n'  >> SSCPorthologyreport.txt

#CAZYs:
#Strawberry
for file in $(ls gene_pred/P_aphanis/THeavenDRCT72020_1/cazy/THeavenDRCT72020_1_CAZY_secreted_headers.txt); do
  strawb_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/strawb_ST20_genes.txt)
  both_ST20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/both_ST20_genes.txt)
  strawb_ST20_genes_out=$(dirname $file)/$(basename $file .txt)_common.txt
  both_ST20_genes_out=$(dirname $file)/$(basename $file .txt)_aphanis.txt
  echo $strawb_ST20_genes_out
  echo $both_ST20_genes_out
  grep -w -f $strawb_ST20_genes $file > $strawb_ST20_genes_out
  grep -w -f $both_ST20_genes $file > $both_ST20_genes_out
done
echo number of secreted CAZYs in THeavenDRCT72020_1 >> CAZYorthologyreport.txt 
echo unique to strawberry: >> TForthologyreport.txt  >> CAZYorthologyreport.txt 
cat $aphanis_ST20_genes_out| wc -l >> CAZYorthologyreport.txt 
echo shared with raspberry: >> CAZYorthologyreport.txt 
cat $both_ST20_genes_out| wc -l >> CAZYorthologyreport.txt
printf '\n'  >> CAZYorthologyreport.txt
#Raspberry
for file in $(ls gene_pred/P_aphanis/THeavenSCOTT2020_1/cazy/THeavenSCOTT2020_1_CAZY_secreted_headers.txt); do
  rasp_RA20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/rasp_RA20_genes.txt)
  both_RA20_genes=$(echo analysis/orthology/orthofinder/All6_isolates/aphanishostcomp/both_RA20_genes.txt)
  rasp_RA20_genes_out=$(dirname $file)/$(basename $file .txt)_common.txt
  both_RA20_genes_out=$(dirname $file)/$(basename $file .txt)_aphanis.txt
  echo $rasp_RA20_genes_out
  echo $both_RA20_genes_out
  grep -w -f $rasp_RA20_genes $file > $rasp_RA20_genes_out
  grep -w -f $both_RA20_genes $file > $both_RA20_genes_out
done
echo number of secreted CAZYs in THeavenSCOTT2020_1 >> CAZYorthologyreport.txt 
echo unique to raspberry: >> CAZYorthologyreport.txt 
cat $rasp_RA20_genes_out| wc -l >> CAZYorthologyreport.txt 
echo shared with strawberry: >> CAZYorthologyreport.txt 
cat $both_RA20_genes_out| wc -l >> CAZYorthologyreport.txt
printf '\n'  >> CAZYorthologyreport.txt
```









































## Comparing to wider mildew clade:
```bash
sed -i 's@_paired_trimmed@@g' mildews/Erysiphealphitoides_CLCBIO_assembly_cdhitest_0.95_morethan500bp.fasta
-genomeSampleSizeMax 27000000
-genomeSampleSizeMax 81000000

conda activate repeatmasking
for Assembly in $(ls mildews/Erysiphealphitoides_CLCBIO_assembly_cdhitest_0.95_morethan500bp.fasta); do
    ID=$(basename $Assembly|cut -f1 -d '.')
    echo $ID
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=mildews/$ID/repeatmasking/rep_modeling
    mkdir -p $OutDir
    sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir $ID
done
#19926-77, 20149,20150,51,52, 20229
for Assembly in $(ls mildews/Blumeriagraminis_GCA_000418435.1_Bgt_454_newbler_assembly_genomic.c.fna); do
    ID=$(basename $Assembly|cut -f1 -d '.')
    echo $ID
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=mildews/$ID/repeatmasking/rep_modeling
    mkdir -p $OutDir
    sbatch $ProgDir/rep_modeling_5roundsonly.sh $Assembly $OutDir $ID
done
#20230
conda deactivate
conda activate repeatmasking
for Assembly in $(ls mildews/*.f*a); do
    ID=$(basename $Assembly|cut -f1 -d '.')
    echo $ID
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    Library=$(ls mildews/$ID/repeatmasking/rep_modeling/*-families.fa)
    OutDir=mildews/$ID/repeatmasking/rep_masker
    echo $Library
    mkdir -p $OutDir
    sbatch $ProgDir/rep_masker.sh $Assembly $Library $OutDir $ID
done #20308-61
conda deactivate
conda activate repeatmodeler1
for Assembly in $(ls mildews/GANAN*.f*); do
    ID=$(basename $Assembly|cut -f1 -d '.')
    echo $ID
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=mildews/$ID/repeatmasking/rep_modeling1
    mkdir -p $OutDir
    sbatch $ProgDir/rep_modeler1.sh $Assembly $OutDir $ID
done #20363,5,6 #does not produce families.fa file
conda deactivate
conda activate repeatmasking
for Assembly in $(ls mildews/GANAN*.f*a); do
    ID=$(basename $Assembly|cut -f1 -d '.')
    echo $ID
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    Library=$(ls mildews/$ID/repeatmasking/rep_modeling1/*-families.fa)
    OutDir=mildews/$ID/repeatmasking/rep_masker2
    echo $Library
    mkdir -p $OutDir
    sbatch $ProgDir/rep_masker.sh $Assembly $Library $OutDir $ID
done #
conda deactivate
conda activate transposonpsi
for Assembly in $(ls mildews/*_min_1000bp.f*); do
    ID=$(basename $Assembly|cut -f1 -d '.')
    echo $ID
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=mildews/$ID/repeatmasking/transposonPSI
    mkdir -p $OutDir
    sbatch $ProgDir/gomez_transposonPSI.sh $Assembly $OutDir $ID
done
#19977-20033, 20042-20094,20114,20153-4
conda deactivate

#Count the masked bases:
for Assembly in $(ls mildews/*.f*); do
    ID=$(basename $Assembly|cut -f1 -d '.')
RepMaskGff=mildews/$ID/repeatmasking/rep_modeling/*_contigs_hardmasked.gff
TransPSIGff=mildews/$ID/repeatmasking/transposonPSI/*_contigs_unmasked.fa.TPSI.allHits.chains.gff3
echo $ID"\n" >> mildews/repeatreport.txt
printf "The number of bases masked by RepeatMasker:\t" >> mildews/repeatreport.txt
sortBed -i $RepMaskGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}' >> mildews/repeatreport.txt
printf "The number of bases masked by TransposonPSI:\t" >> mildews/repeatreport.txt
sortBed -i $TransPSIGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}' >> mildews/repeatreport.txt
printf "The total number of masked bases are:\t" >> mildews/repeatreport.txt
cat $RepMaskGff $TransPSIGff | sortBed | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}' >> mildews/repeatreport.txt
done

#Merge the masking:
for Assembly in $(ls mildews/E*.f*); do
    ID=$(basename $Assembly|cut -f1 -d '.')
File=$(ls mildews/${ID}/repeatmasking/rep_modeling/${ID}_contigs_softmasked.fa)
OutDir=mildews/${ID}/repeatmasking/combined
mkdir $OutDir
TPSI=$(ls mildews/${ID}/repeatmasking/transposonPSI/${ID}_contigs_unmasked.fa.TPSI.allHits.chains.gff3)
OutFile=${OutDir}/$(basename $File | sed 's/_contigs_softmasked.fa/_contigs_softmasked_repeatmasker_TPSI_appended.fa/g')
echo "$OutFile"
bedtools maskfasta -soft -fi $File -bed $TPSI -fo ${OutFile}
echo $ID >> mildews/combinedrepeatreport.txt
echo "Number of bases:" >> mildews/combinedrepeatreport.txt
No=$(cat $OutFile | grep -v '>' | tr -d '\n' | wc -c)
echo $No >> mildews/combinedrepeatreport.txt
echo "Number of masked bases:" >> mildews/combinedrepeatreport.txt
No2=$(cat $OutFile | grep -v '>' | tr -d '\n' | awk '{print $0, gsub("[a-z]", ".")}' | cut -f2 -d ' ')
echo $No2 >> mildews/combinedrepeatreport.txt
echo "% of masked bases:" >> mildews/combinedrepeatreport.txt
echo "100/$No*$No2" | bc -l >> mildews/combinedrepeatreport.txt
printf "\n" >> mildews/combinedrepeatreport.txt
done

scp -r mildews/*/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/mildews/.

for Assembly in $(ls mildews/*_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
    ID=$(basename $Assembly|cut -f1 -d '.'| sed 's@_contigs_softmasked_repeatmasker_TPSI_appended@@g')
mkdir -p mildews/${ID}/repeatmasking/combined
echo $ID
mv ${Assembly} mildews/${ID}/repeatmasking/combined/.
done

conda activate braker
for Assembly in $(ls mildews/E*/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
  ID=$(basename $Assembly|cut -f1 -d '.'| sed 's@_contigs_softmasked_repeatmasker_TPSI_appended@@g')
  echo $ID
  OutDir=mildews/${ID}/gene_pred/prothint
  ProgDir=/home/theaven/scratch/apps/braker
  sbatch $ProgDir/prothint_fungi.sh $Assembly $OutDir
done
#3071721-51, 3086794-803, 3113135-45, 3160184-3160204
conda deactivate

#Braker was run in --epmode, with --hints provided from prothint run previously, --AUGUSTUS_ab_initio predictions were also generated. 
conda activate braker
for Assembly in $(ls mildews/*/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
  ID=$(basename $Assembly|cut -f1 -d '.'| sed 's@_contigs_softmasked_repeatmasker_TPSI_appended@@g')
  echo $ID
  OutDir=mildews/${ID}/gene_pred/braker
  GeneModelName=${ID}_genemodels
  Hintfile=mildews/${ID}/gene_pred/prothint/prothint_augustus.gff
  ProgDir=/home/theaven/scratch/apps/braker
  echo $OutDir
  echo $GeneModelName
  echo $Hintfile
  sbatch $ProgDir/braker_fungi_noRNA.sh $Assembly $OutDir $GeneModelName $Hintfile
done
#3149112-163, 3163883(introns to hints), 3174005-7, 3174340-
#outside conda env: 3160210, with augustus paths set: 3160697, with augustus paths set to jconnell directory: 3163222,3163272, within conda env augustus: 3163542
conda deactivate

ERROR in file /home/theaven/scratch/apps/braker/augustus/augustus-3.4.0/config/braker.pl at line 7009
/mnt/shared/scratch/theaven/braker/theaven_3149112/braker/errors/ensure_min_n_training_genes.stderr
FileNotFoundError: [Errno 2] No such file or directory: '/mnt/shared/scratch/theaven/braker/theaven_3149112/braker/GeneMark-EP/genemark.f.good.gtf'

/mnt/shared/scratch/theaven/apps/conda/envs/braker/bin/filterGenemark.pl


apps/braker/augustus/augustus-3.4.0/config/braker.pl

ERROR: in file /home/theaven/scratch/apps/braker/augustus/augustus-3.4.0/config/braker.pl at line 1948
FileNotFoundError: [Errno 2] No such file or directory: '/mnt/shared/scratch/theaven/braker/theaven_3149163/braker/GeneMark-EP/genemark.f.good.gtf'
--AUGUSTUS_SCRIPTS_PATH=/home/theaven/scratch/apps/braker/augustus/augustus-3.4.0/scripts
augustus/augustus-3.4.0/scripts

--AUGUSTUS_CONFIG_PATH=/home/theaven/scratch/apps/braker/augustus/augustus-3.4.0/config

--AUGUSTUS_SCRIPTS_PATH=/mnt/shared/scratch/jconnell/apps/Augustus/scripts
--AUGUSTUS_CONFIG_PATH=/mnt/shared/scratch/jconnell/apps/Augustus/config

--AUGUSTUS_CONFIG_PATH=/home/theaven/scratch/apps/conda/envs/augustus/config
--AUGUSTUS_SCRIPTS_PATH=/home/theaven/scratch/apps/conda/envs/augustus/bin

conda activate braker
for Assembly in $(ls assembly/metagenome/P_leucotricha/THeavenpOGB2021_1/SPAdes/17258/ncbi_edits/filteredmasked/rep_modeling/Assembled_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
OutDir=brakertest
AcceptedHits=$(ls alignment/P_leucotricha/THeavenpOGB2021_1/star/RNA/17258/star_aligmentAligned.sortedByCoord.out.bam)
GeneModelName=blarg
ProgDir=/home/theaven/scratch/apps/braker
sbatch $ProgDir/braker_fungi.sh $Assembly $OutDir $AcceptedHits $GeneModelName
done
#3163568
conda deactivate

sed -i 's@introns.gff@hints.gff@g' /home/theaven/scratch/apps/braker/augustus/augustus-3.4.0/config/braker.pl
```
```bash
#scripts use _ as delimiter, cannot have . in contig title, QYAM01002187.1 predictions do not sort correctly for some reasion for neobulgaria alba prothint prediction
sed -i 's@_NoIndex_L002_R1_R2_contig@@g' mildews/Erysiphealphitoides_CLCBIO_assembly_cdhitest_0/repeatmasking/combined/Erysiphealphitoides_CLCBIO_assembly_cdhitest_0_contigs_softmasked_repeatmasker_TPSI_appended.fa
sed -i 's@_NoIndex_L002_R1_R2_contig@@g' mildews/Erysiphealphitoides_CLCBIO_assembly_cdhitest_0/gene_pred/braker/braker.gff3
sed -i 's@_NoIndex_L002_R1_R2_contig@@g' mildews/Erysiphealphitoides_CLCBIO_assembly_cdhitest_0/gene_pred/braker/augustus.ab_initio.gff3
sed -i "/QYAM01002187.1/d" mildews/neobulgariaablba_GCA_003988965/gene_pred/braker/braker.gff3 
sed -i "/QYAM01002187.1/d" mildews/neobulgariaablba_GCA_003988965/gene_pred/braker/augustus.ab_initio.gff3

conda activate predector2.7
for Assembly in $(ls mildews/*/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
  #remove dupllicates and rename:
  ID=$(basename $Assembly|cut -f1 -d '.'| sed 's@_contigs_softmasked_repeatmasker_TPSI_appended@@g')
  echo $ID
  Gff=$(ls mildews/${ID}/gene_pred/braker/braker.gff3)
  ab_gff=$(ls mildews/${ID}/gene_pred/braker/augustus.ab_initio.gff3)
  FinalDir=mildews/${ID}/gene_pred/braker/final_2
  mkdir $FinalDir
  GffFiltered=$FinalDir/filtered_duplicates.gff
  ab_GffFiltered=$FinalDir/ab_initio_filtered_duplicates.gff
  ProgDir=/home/theaven/scratch/apps/tools
  #ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction 
  $ProgDir/remove_dup_features.py --inp_gff $Gff --out_gff $GffFiltered
  $ProgDir/remove_dup_features.py --inp_gff $ab_gff --out_gff $ab_GffFiltered
  awk '{ gsub("\\.","_",$1); print}' $GffFiltered > ${GffFiltered}.2
  awk '{ gsub("\\.","_",$1); print}' $ab_GffFiltered > ${ab_GffFiltered}.2
  GffRenamed=$FinalDir/final_genes_renamed.gff3 
  LogFile=$FinalDir/final_genes_renamed.log 
  ab_GffRenamed=$FinalDir/ab_initio_final_genes_renamed.gff3 
  ab_LogFile=$FinalDir/ab_initio_final_genes_renamed.log
  $ProgDir/gff_rename_genes.py --inp_gff ${GffFiltered}.2 --conversion_log $LogFile > $GffRenamed 
  $ProgDir/gff_rename_genes.py --inp_gff ${ab_GffFiltered}.2 --conversion_log $ab_LogFile > $ab_GffRenamed  
  awk '{ gsub("\\.","_"); print}' $Assembly > ${Assembly}.2
  $ProgDir/gff2fasta.pl ${Assembly}.2 $GffRenamed $FinalDir/final_genes_renamed
  $ProgDir/gff2fasta.pl ${Assembly}.2 $ab_GffRenamed $FinalDir/ab_initio_final_genes_renamed
  sed -i 's/*/X/g' $FinalDir/final_genes_renamed.pep.fasta
  sed -i 's/*/X/g' $FinalDir/ab_initio_final_genes_renamed.pep.fasta
  #remove any discovered duplicates
  Output=$(dirname $LogFile)/$(echo $LogFile |cut -f2 -d '/')_duplicated_genes
  ab_Output=$(dirname $ab_LogFile)/$(echo $ab_LogFile |cut -f2 -d '/')ab_initio_duplicated_genes
  for prediction in $(cat $LogFile |cut -f1|sort|uniq -c|sort -nr | awk '$1>1' | awk '{print $2}'); do
    printf ">\n" >> $Output
    grep -w $prediction $LogFile | awk '{print $3}' >> $Output
  done
  sed -e '/>/,+1d' ${Output} > ${Output}.txt #removed one of each duplicate from the removal list
  awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $FinalDir/final_genes_renamed.cdna.fasta > linearized.fasta
  for var1 in $(cat ${Output}.txt); do
    sed -i "/>${var1}.t1/d" linearized.fasta
  done
  tr "\t" "\n" < linearized.fasta | fold -w 60 > $FinalDir/final_genes_renamed.cdna.fasta
  awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $FinalDir/final_genes_renamed.pep.fasta > linearized.fasta
  for var1 in $(cat ${Output}.txt); do
    sed -i "/>${var1}.t1/d" linearized.fasta
  done
  tr "\t" "\n" < linearized.fasta | fold -w 60 > $FinalDir/final_genes_renamed.pep.fasta
  for prediction in $(cat $ab_LogFile |cut -f1|sort|uniq -c|sort -nr | awk '$1>1' | awk '{print $2}'); do
    printf ">\n" >> $ab_Output
    grep -w $prediction $ab_LogFile | awk '{print $3}' >> $ab_Output
  done
  sed -e '/>/,+1d' ${ab_Output} > ${ab_Output}.txt #removed one of each duplicate from the removal list
  awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $FinalDir/ab_initio_final_genes_renamed.cdna.fasta > linearized.fasta
  for var1 in $(cat ${ab_Output}.txt); do
    sed -i "/>${var1}.t1/d" linearized.fasta
  done
  tr "\t" "\n" < linearized.fasta | fold -w 60 > $FinalDir/ab_initio_final_genes_renamed.cdna.fasta
  awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $FinalDir/ab_initio_final_genes_renamed.pep.fasta > linearized.fasta
  for var1 in $(cat ${ab_Output}.txt); do
    sed -i "/>${var1}.t1/d" linearized.fasta
  done
  tr "\t" "\n" < linearized.fasta | fold -w 60 > $FinalDir/ab_initio_final_genes_renamed.pep.fasta
  rm $Output
  rm $ab_Output
  #count predicated genes
  cat $FinalDir/final_genes_renamed.cdna.fasta | grep '>' > $FinalDir/genenames.txt
  echo ""  >> mildews/brakerreport.txt
  echo $ID >> mildews/brakerreport.txt
  echo No. of prothint guided genes: >> mildews/brakerreport.txt
  grep -c -i '>' $FinalDir/final_genes_renamed.cdna.fasta >> mildews/brakerreport.txt
  cat $FinalDir/ab_initio_final_genes_renamed.cdna.fasta | grep '>' > $FinalDir/ab_initio_genenames.txt
  echo No. of ab initio predicted genes: >> mildews/brakerreport.txt
  grep -c -i '>' $FinalDir/ab_initio_final_genes_renamed.cdna.fasta >> mildews/brakerreport.txt
  rm ${Assembly}.2
  rm ${GffFiltered}.2
  rm ${ab_GffFiltered}.2
done
```
### Interproscan
```bash
for Genes in $(ls mildews/*/gene_pred/braker/final/final_genes_renamed.pep.fasta); do
    Jobs=$(squeue -u theaven | wc -l)
    echo x
    while [ $Jobs -gt 25 ]; do
      sleep 2s
      printf "."
      Jobs=$(squeue -u theaven | wc -l)
    done 
    ProgDir=/home/theaven/scratch/apps/tools/Feature_annotation
    ID=$(echo $Genes|cut -f2 -d '/' | sed 's@HEAVEN_apple@Podosphaeraleucotricha_HEAVEN_apple@g'| sed 's@HEAVEN_strawberry@Podosphaeraaphanis_HEAVEN_strawberry@g'| sed 's@HEAVEN_raspberry@Podosphaeraaphanis_HEAVEN_raspberry@g'| sed 's@GANAN_apple@Podosphaeraleucotricha_HEAVEN_apple@g'|sed 's@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@Erysiphealphitoides_CLCBIO_assembly@g'|sed 's@Oidiodendron_maius@Oidiodendronmaius@g'|sed 's@phialocephalasubalpina-GCA_900073065@phialocephalasubalpina_GCA_900073065@g')
    Organism=$(echo $ID|cut -f1 -d '_')
    Strain=$(echo $ID|cut -f2,3 -d '_')
    OutDir=mildews/${ID}/gene_pred/interproscan/prothint
    mkdir -p $OutDir
    echo $Genes
    echo $Strain
    echo $Organism
    $ProgDir/interproscan.sh $Genes $Organism $Strain $OutDir
done 2>&1 | tee -a interproscan_submisison_.log
# Following interproscan annotation split files were combined using the following commands:

  for Proteins in $(ls gene_pred/codingquary/v.*/*/*/final_genes_combined.pep.fasta); do
    Strain=$(echo $Proteins | rev | cut -d '/' -f3 | rev)
    Organism=$(echo $Proteins | rev | cut -d '/' -f4 | rev)
    echo "$Organism - $Strain"
    echo $Strain
    InterProRaw=gene_pred/interproscan/$Organism/$Strain/raw
    $ProgDir/append_interpro.sh $Proteins $InterProRaw $Organism $Strain $OutDir
  done

for Genes in $(ls mildews/*/gene_pred/braker/final/ab_initio_final_genes_renamed.pep.fasta); do
    Jobs=$(squeue -u theaven | wc -l)
    echo x
    while [ $Jobs -gt 25 ]; do
      sleep 2s
      printf "."
      Jobs=$(squeue -u theaven | wc -l)
    done
    ProgDir=/home/theaven/scratch/apps/tools/Feature_annotation
    ID=$(echo $Genes|cut -f2 -d '/' | sed 's@HEAVEN_apple@Podosphaeraleucotricha_HEAVEN_apple@g'| sed 's@HEAVEN_strawberry@Podosphaeraaphanis_HEAVEN_strawberry@g'| sed 's@HEAVEN_raspberry@Podosphaeraaphanis_HEAVEN_raspberry@g'| sed 's@GANAN_apple@Podosphaeraleucotricha_HEAVEN_apple@g'|sed 's@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@Erysiphealphitoides_CLCBIO_assembly@g'|sed 's@Oidiodendron_maius@Oidiodendronmaius@g'|sed 's@phialocephalasubalpina-GCA_900073065@phialocephalasubalpina_GCA_900073065@g')
    Organism=$(echo $ID|cut -f1 -d '_')
    Strain=$(echo $ID|cut -f2,3 -d '_')
    OutDir=mildews/${ID}/gene_pred/interproscan/abinitio
    mkdir -p $OutDir
    echo $Genes
    echo $Strain
    echo $Organism
    $ProgDir/interproscan.sh $Genes $Organism $Strain $OutDir
done 2>&1 | tee -a interproscan_submisison_2.log
```
### Predector
```bash
screen -S predector
conda activate predector
for proteome in $(ls mildews/*/gene_pred/braker/final/final_genes_renamed.pep.fasta | grep -v 'Erysiphealphitoides'); do
  Jobs=$(squeue -u theaven | grep 'predecto' | wc -l)
    while [ $Jobs -gt 19 ]; do
      sleep 2s
      printf "."
      Jobs=$(squeue -u theaven | grep 'predecto' | wc -l)
    done
    ID=$(echo $proteome|cut -f2 -d '/' | sed 's@HEAVEN_apple@Podosphaeraleucotricha_HEAVEN_apple@g'| sed 's@HEAVEN_strawberry@Podosphaeraaphanis_HEAVEN_strawberry@g'| sed 's@HEAVEN_raspberry@Podosphaeraaphanis_HEAVEN_raspberry@g'| sed 's@GANAN_apple@Podosphaeraleucotricha_Ganan_apple@g'|sed 's@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@Erysiphealphitoides_CLCBIO_assembly@g'|sed 's@Oidiodendron_maius@Oidiodendronmaius@g'|sed 's@phialocephalasubalpina-GCA_900073065@phialocephalasubalpina_GCA_900073065@g')
    Organism=$(echo $ID|cut -f1 -d '_')
    Strain=$(echo $ID|cut -f2,3 -d '_')
    OutDir=mildews/${ID}/gene_pred/predector/Prothint
    ProgDir=/home/theaven/scratch/apps/predector
    echo $ID
    echo $ID >> predectorpathlog.txt
sbatch $ProgDir/predector_singularity.sh $proteome 1.2.6 $OutDir  2>&1 >> predectorpathlog.txt
sleep 30
done #3232622, 3237571,3238262
conda deactivate
rm -r mildews/*/gene_pred/predector/prothint/work

conda activate predector
for proteome in $(ls mildews/S*/gene_pred/braker/final/ab_initio_final_genes_renamed.pep.fasta | grep -v 'Erysiphealphitoides'); do
  Jobs=$(squeue -u theaven | grep 'predecto' | wc -l)
   # while [ $Jobs -gt 5 ]; do
   #   sleep 2s
   #   printf "."
   #   Jobs=$(squeue -u theaven | grep 'predecto' | wc -l)
   # done
    ID=$(echo $proteome|cut -f2 -d '/' | sed 's@HEAVEN_apple@Podosphaeraleucotricha_HEAVEN_apple@g'| sed 's@HEAVEN_strawberry@Podosphaeraaphanis_HEAVEN_strawberry@g'| sed 's@HEAVEN_raspberry@Podosphaeraaphanis_HEAVEN_raspberry@g'| sed 's@GANAN_apple@Podosphaeraleucotricha_Ganan_apple@g'|sed 's@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@Erysiphealphitoides_CLCBIO_assembly@g'|sed 's@Oidiodendron_maius@Oidiodendronmaius@g'|sed 's@phialocephalasubalpina-GCA_900073065@phialocephalasubalpina_GCA_900073065@g')
    Organism=$(echo $ID|cut -f1 -d '_')
    Strain=$(echo $ID|cut -f2,3 -d '_')
    OutDir=mildews/${ID}/gene_pred/predector/abinitio
    ProgDir=/home/theaven/scratch/apps/predector
    echo $ID
    echo $ID >> abinitiopredectorpathlog.txt
sbatch $ProgDir/predector_singularity.sh $proteome 1.2.6 $OutDir  2>&1 >> abinitiopredectorpathlog.txt
sleep 30
done
conda deactivate
```
```bash
Colletotrichum higginsianum
Magnaporthe  oryzae
Fusarium  graminearum
Sclerotinia sclerotiorum
Botrytis cinerea.
Puccinia graminis f. sp. tritici
Melampsora laricis-populina
Hyaloperonospora arabidopsidis 
Aspergillus nidulans 
Neurospora crassa

mkdir other
cd other
wget https://ftp.ncbi.nlm.nih.gov/genomes/genbank/fungi/Colletotrichum_higginsianum/latest_assembly_versions/GCA_001672515.1_ASM167251v1/GCA_001672515.1_ASM167251v1_genomic.fna.gz 
mv GCA_001672515.1_ASM167251v1_genomic.fna.gz Colletotrichumhigginsianum_GCA_001672515.1_ASM167251v1_genomic.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/genbank/fungi/Pyricularia_oryzae/latest_assembly_versions/GCA_000002495.2_MG8/GCA_000002495.2_MG8_genomic.fna.gz
mv GCA_000002495.2_MG8_genomic.fna.gz Pyriculariaoryzae_GCA_000002495.2_MG8_genomic.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/genbank/fungi/Fusarium_graminearum/latest_assembly_versions/GCA_000240135.3_ASM24013v3/GCA_000240135.3_ASM24013v3_genomic.fna.gz 
mv GCA_000240135.3_ASM24013v3_genomic.fna.gz Fusariumgraminearum_GCA_000240135.3_ASM24013v3_genomic.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/genbank/fungi/Sclerotinia_sclerotiorum/latest_assembly_versions/GCA_000146945.2_ASM14694v2/GCA_000146945.2_ASM14694v2_genomic.fna.gz
mv GCA_000146945.2_ASM14694v2_genomic.fna.gz Sclerotiniasclerotiorum_GCA_000146945.2_ASM14694v2_genomic.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/genbank/fungi/Botrytis_cinerea/latest_assembly_versions/GCA_000143535.4_ASM14353v4/GCA_000143535.4_ASM14353v4_genomic.fna.gz
mv GCA_000143535.4_ASM14353v4_genomic.fna.gz Botrytiscinerea_GCA_000143535.4_ASM14353v4_genomic.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/genbank/fungi/Puccinia_graminis/latest_assembly_versions/GCA_000149925.1_ASM14992v1/GCA_000149925.1_ASM14992v1_genomic.fna.gz 
mv GCA_000149925.1_ASM14992v1_genomic.fna.gz Pucciniagraminis_GCA_000149925.1_ASM14992v1_genomic.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/204/055/GCA_000204055.1_v1.0/GCA_000204055.1_v1.0_genomic.fna.gz 
mv GCA_000204055.1_v1.0_genomic.fna.gz Melampsoralaricis-populina_GCA_000204055.1_v1.0_genomic.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/173/235/GCA_000173235.2_HyaAraEmoy2_2.0/GCA_000173235.2_HyaAraEmoy2_2.0_genomic.fna.gz 
mv GCA_000173235.2_HyaAraEmoy2_2.0_genomic.fna.gz Hyaloperonosporaarabidopsidis_GCA_000173235.2_HyaAraEmoy2_2.0_genomic.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/genbank/fungi/Aspergillus_nidulans/latest_assembly_versions/GCA_000149205.2_ASM14920v2/GCA_000149205.2_ASM14920v2_genomic.fna.gz 
mv GCA_000149205.2_ASM14920v2_genomic.fna.gz Aspergillusnidulans_GCA_000149205.2_ASM14920v2_genomic.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/genbank/fungi/Neurospora_crassa/latest_assembly_versions/GCA_000182925.2_NC12/GCA_000182925.2_NC12_genomic.fna.gz
mv GCA_000182925.2_NC12_genomic.fna.gz Neurosporacrassa_GCA_000182925.2_NC12_genomic.fna.gz
gunzip *
cd ..
conda activate repeatmasking
for Assembly in $(ls other/*fna); do
    ID=$(basename $Assembly|cut -f1,2,3 -d '_')
    echo $ID
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=other/$ID/repeatmasking/rep_modeling
    mkdir -p $OutDir
    sbatch $ProgDir/rep_modeling.sh $Assembly $OutDir $ID
done #2038#96-405
conda deactivate
conda activate transposonpsi
for Assembly in $(ls other/*fna); do
    ID=$(basename $Assembly|cut -f1,2,3 -d '_')
    echo $ID
    #ProgDir=~/scratch/apps/repeat_masking
    ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=other/$ID/repeatmasking/transposonPSI
    mkdir -p $OutDir
    sbatch $ProgDir/gomez_transposonPSI.sh $Assembly $OutDir $ID
done #20406-415
conda deactivate

#Count the masked bases:
for Assembly in $(ls other/*.f*); do
    ID=$(basename $Assembly|cut -f1,2,3 -d '_')
RepMaskGff=other/$ID/repeatmasking/rep_modeling/*_contigs_hardmasked.gff
TransPSIGff=other/$ID/repeatmasking/transposonPSI/*_contigs_unmasked.fa.TPSI.allHits.chains.gff3
echo $ID"\n" >> other/otherrepeatreport.txt
printf "The number of bases masked by RepeatMasker:\t" >> other/otherrepeatreport.txt
sortBed -i $RepMaskGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}' >> other/otherrepeatreport.txt
printf "The number of bases masked by TransposonPSI:\t" >> other/repeatreport.txt
sortBed -i $TransPSIGff | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}' >> other/otherrepeatreport.txt
printf "The total number of masked bases are:\t" >> other/otherrepeatreport.txt
cat $RepMaskGff $TransPSIGff | sortBed | bedtools merge | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}' >> other/otherrepeatreport.txt
done

#Merge the masking:
for Assembly in $(ls other/*.f*); do
    ID=$(basename $Assembly|cut -f1,2,3 -d '_')
File=$(ls other/${ID}/repeatmasking/rep_modeling/${ID}_contigs_softmasked.fa)
OutDir=other/${ID}/repeatmasking/combined
mkdir $OutDir
TPSI=$(ls other/${ID}/repeatmasking/transposonPSI/${ID}_contigs_unmasked.fa.TPSI.allHits.chains.gff3)
OutFile=${OutDir}/$(basename $File | sed 's/_contigs_softmasked.fa/_contigs_softmasked_repeatmasker_TPSI_appended.fa/g')
echo "$OutFile"
bedtools maskfasta -soft -fi $File -bed $TPSI -fo ${OutFile}
echo $ID >> other/othercombinedrepeatreport.txt
echo "Number of bases:" >> other/othercombinedrepeatreport.txt
No=$(cat $OutFile | grep -v '>' | tr -d '\n' | wc -c)
echo $No >> other/othercombinedrepeatreport.txt
echo "Number of masked bases:" >> other/othercombinedrepeatreport.txt
No2=$(cat $OutFile | grep -v '>' | tr -d '\n' | awk '{print $0, gsub("[a-z]", ".")}' | cut -f2 -d ' ')
echo $No2 >> other/othercombinedrepeatreport.txt
echo "% of masked bases:" >> other/othercombinedrepeatreport.txt
echo "100/$No*$No2" | bc -l >> other/othercombinedrepeatreport.txt
printf "\n" >> other/othercombinedrepeatreport.txt
done

scp -r other/*/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa theaven@gruffalo.cropdiversity.ac.uk:/home/theaven/scratch/other/.

for Assembly in $(ls other/*_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
    ID=$(basename $Assembly|cut -f1,2,3 -d '_'| sed 's@_contigs_softmasked_repeatmasker_TPSI_appended@@g')
mkdir -p other/${ID}/repeatmasking/combined
echo $ID
mv ${Assembly} other/${ID}/repeatmasking/combined/.
done

conda activate braker
for Assembly in $(ls other/*/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
  ID=$(basename $Assembly|cut -f1,2,3 -d '_'| sed 's@_contigs_softmasked_repeatmasker_TPSI_appended@@g')
  echo $ID
  OutDir=other/${ID}/gene_pred/prothint
  ProgDir=/home/theaven/scratch/apps/braker
  sbatch $ProgDir/prothint_fungi.sh $Assembly $OutDir
done
#3331230-239

for Assembly in $(ls other/*/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
  ID=$(basename $Assembly|cut -f1,2,3 -d '_'| sed 's@_contigs_softmasked_repeatmasker_TPSI_appended@@g')
  echo $ID
  OutDir=other/${ID}/gene_pred/braker
  GeneModelName=${ID}_genemodels
  Hintfile=other/${ID}/gene_pred/prothint/prothint_augustus.gff
  ProgDir=/home/theaven/scratch/apps/braker
  echo $OutDir
  echo $GeneModelName
  echo $Hintfile
  sbatch $ProgDir/braker_fungi_noRNA.sh $Assembly $OutDir $GeneModelName $Hintfile
done #3335831-840
conda deactivate
```
```bash
cat $ab_GffRenamed | awk '$4 > $5'

grep -v 'ID=g976;' $ab_GffRenamed > ${ab_GffRenamed}_edit

conda activate predector2.7
for Assembly in $(ls other/*/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
  #remove dupllicates and rename:
  ID=$(basename $Assembly|cut -f1,2,3 -d '_'| sed 's@_contigs_softmasked_repeatmasker_TPSI_appended@@g')
  echo $ID
  Gff=$(ls other/${ID}/gene_pred/braker/braker.gff3)
  ab_gff=$(ls other/${ID}/gene_pred/braker/augustus.ab_initio.gff3)
  FinalDir=other/${ID}/gene_pred/braker/final
  mkdir $FinalDir
  GffFiltered=$FinalDir/filtered_duplicates.gff
  ab_GffFiltered=$FinalDir/ab_initio_filtered_duplicates.gff
  ProgDir=/home/theaven/scratch/apps/tools
  #ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction 
  $ProgDir/remove_dup_features.py --inp_gff $Gff --out_gff $GffFiltered
  $ProgDir/remove_dup_features.py --inp_gff $ab_gff --out_gff $ab_GffFiltered
  awk '{ gsub("\\.","_",$1); print}' $GffFiltered > ${GffFiltered}.2
  awk '{ gsub("\\.","_",$1); print}' $ab_GffFiltered > ${ab_GffFiltered}.2
  GffRenamed=$FinalDir/final_genes_renamed.gff3 
  LogFile=$FinalDir/final_genes_renamed.log 
  ab_GffRenamed=$FinalDir/ab_initio_final_genes_renamed.gff3 
  ab_LogFile=$FinalDir/ab_initio_final_genes_renamed.log
  $ProgDir/gff_rename_genes.py --inp_gff ${GffFiltered}.2 --conversion_log $LogFile > $GffRenamed 
  $ProgDir/gff_rename_genes.py --inp_gff ${ab_GffFiltered}.2 --conversion_log $ab_LogFile > $ab_GffRenamed  
  awk '{ gsub("\\.","_"); print}' $Assembly > ${Assembly}.2
  $ProgDir/gff2fasta.pl ${Assembly}.2 $GffRenamed $FinalDir/final_genes_renamed
  $ProgDir/gff2fasta.pl ${Assembly}.2 $ab_GffRenamed $FinalDir/ab_initio_final_genes_renamed
  sed -i 's/*/X/g' $FinalDir/final_genes_renamed.pep.fasta
  sed -i 's/*/X/g' $FinalDir/ab_initio_final_genes_renamed.pep.fasta
  #remove any discovered duplicates
  Output=$(dirname $LogFile)/$(echo $LogFile |cut -f2 -d '/')_duplicated_genes
  ab_Output=$(dirname $ab_LogFile)/$(echo $ab_LogFile |cut -f2 -d '/')ab_initio_duplicated_genes
  for prediction in $(cat $LogFile |cut -f1|sort|uniq -c|sort -nr | awk '$1>1' | awk '{print $2}'); do
    printf ">\n" >> $Output
    grep -w $prediction $LogFile | awk '{print $3}' >> $Output
  done
  sed -e '/>/,+1d' ${Output} > ${Output}.txt #removed one of each duplicate from the removal list
  awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $FinalDir/final_genes_renamed.cdna.fasta > linearized.fasta
  for var1 in $(cat ${Output}.txt); do
    sed -i "/>${var1}.t1/d" linearized.fasta
  done
  tr "\t" "\n" < linearized.fasta | fold -w 60 > $FinalDir/final_genes_renamed.cdna.fasta
  awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $FinalDir/final_genes_renamed.pep.fasta > linearized.fasta
  for var1 in $(cat ${Output}.txt); do
    sed -i "/>${var1}.t1/d" linearized.fasta
  done
  tr "\t" "\n" < linearized.fasta | fold -w 60 > $FinalDir/final_genes_renamed.pep.fasta
  for prediction in $(cat $ab_LogFile |cut -f1|sort|uniq -c|sort -nr | awk '$1>1' | awk '{print $2}'); do
    printf ">\n" >> $ab_Output
    grep -w $prediction $ab_LogFile | awk '{print $3}' >> $ab_Output
  done
  sed -e '/>/,+1d' ${ab_Output} > ${ab_Output}.txt #removed one of each duplicate from the removal list
  awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $FinalDir/ab_initio_final_genes_renamed.cdna.fasta > linearized.fasta
  for var1 in $(cat ${ab_Output}.txt); do
    sed -i "/>${var1}.t1/d" linearized.fasta
  done
  tr "\t" "\n" < linearized.fasta | fold -w 60 > $FinalDir/ab_initio_final_genes_renamed.cdna.fasta
  awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $FinalDir/ab_initio_final_genes_renamed.pep.fasta > linearized.fasta
  for var1 in $(cat ${ab_Output}.txt); do
    sed -i "/>${var1}.t1/d" linearized.fasta
  done
  tr "\t" "\n" < linearized.fasta | fold -w 60 > $FinalDir/ab_initio_final_genes_renamed.pep.fasta
  rm $Output
  rm $ab_Output
  #count predicated genes
  cat $FinalDir/final_genes_renamed.cdna.fasta | grep '>' > $FinalDir/genenames.txt
  echo ""  >> other/brakerreport.txt
  echo $ID >> other/brakerreport.txt
  echo No. of prothint guided genes: >> other/brakerreport.txt
  grep -c -i '>' $FinalDir/final_genes_renamed.cdna.fasta >> other/brakerreport.txt
  cat $FinalDir/ab_initio_final_genes_renamed.cdna.fasta | grep '>' > $FinalDir/ab_initio_genenames.txt
  echo No. of ab initio predicted genes: >> other/brakerreport.txt
  grep -c -i '>' $FinalDir/ab_initio_final_genes_renamed.cdna.fasta >> other/brakerreport.txt
  rm ${Assembly}.2
  rm ${GffFiltered}.2
  rm ${ab_GffFiltered}.2
done
```
```bash
for Genes in $(ls other/Neurosporacrassa_*/gene_pred/braker/final/final_genes_renamed.pep.fasta | grep -v 'Aspergillusnidulans'| grep -v 'Fusariumgraminearum'| grep -v 'Colletotrichumhigginsianum'| grep -v 'Botrytiscinerea'); do 
  Jobs=$(squeue -u theaven | wc -l)
    echo x
    while [ $Jobs -gt 25 ]; do
      sleep 2s
      printf "."
      Jobs=$(squeue -u theaven |grep 'interpro'| wc -l)
    done
    ProgDir=/home/theaven/scratch/apps/tools/Feature_annotation
    ID=$(echo $Genes|cut -f2 -d '/')
    Organism=$(echo $ID|cut -f1 -d '_')
    Strain=$(echo $ID|cut -f2,3 -d '_')
    OutDir=other/${ID}/gene_pred/interproscan/prothint
    mkdir -p $OutDir
    echo $Genes
    echo $Strain
    echo $Organism
    $ProgDir/interproscan.sh $Genes $Organism $Strain $OutDir
done 2>&1 | tee -a interproscan_submisison_.log

for Genes in $(ls other/*/gene_pred/braker/final/ab_initio_final_genes_renamed.pep.fasta); do
    Jobs=$(squeue -u theaven | wc -l)
    echo x
    while [ $Jobs -gt 25 ]; do
      sleep 2s
      printf "."
      Jobs=$(squeue -u theaven |grep 'interpro'| wc -l)
    done
    ProgDir=/home/theaven/scratch/apps/tools/Feature_annotation
    ID=$(echo $Genes|cut -f2 -d '/')
    Organism=$(echo $ID|cut -f1 -d '_')
    Strain=$(echo $ID|cut -f2,3 -d '_')
    OutDir=other/${ID}/gene_pred/interproscan/abinitio
    mkdir -p $OutDir
    echo $Genes
    echo $Strain
    echo $Organism
    $ProgDir/interproscan.sh $Genes $Organism $Strain $OutDir
done 2>&1 | tee -a interproscan_submisison_2.log
```

```bash
screen -S predector
conda activate predector
for proteome in $(ls other/*/gene_pred/braker/final/final_genes_renamed.pep.fasta); do
  Jobs=$(squeue -u theaven | grep 'predecto' | wc -l)
    ID=$(echo $proteome|cut -f2 -d '/')
    Organism=$(echo $ID|cut -f1 -d '_')
    Strain=$(echo $ID|cut -f2,3 -d '_')
    OutDir=other/${ID}/gene_pred/predector/Prothint
    ProgDir=/home/theaven/scratch/apps/predector
    echo $ID
    echo $ID >> predectorpathlog.txt
sbatch $ProgDir/predector_singularity.sh $proteome 1.2.6 $OutDir  2>&1 >> predectorpathlog.txt
sleep 30
done 

for proteome in $(ls other/*/gene_pred/braker/final/ab_initio_final_genes_renamed.pep.fasta); do
  Jobs=$(squeue -u theaven | grep 'predecto' | wc -l)
    ID=$(echo $proteome|cut -f2 -d '/')
    Organism=$(echo $ID|cut -f1 -d '_')
    Strain=$(echo $ID|cut -f2,3 -d '_')
    OutDir=other/${ID}/gene_pred/predector/abinitio
    ProgDir=/home/theaven/scratch/apps/predector
    echo $ID
    echo $ID >> abinitiopredectorpathlog.txt
sbatch $ProgDir/predector_singularity.sh $proteome 1.2.6 $OutDir  2>&1 >> abinitiopredectorpathlog.txt
sleep 30
done
conda deactivate
```
SecretomeP 2.0 for non-canonically secreted proteins:
```bash
#Secretome1:
screen -S secretomep
conda activate jellyfish
#linearize and edit 
for proteome in $(ls */*/gene_pred/braker/final/final_genes_renamed.pep.fasta ); do
  Outfile=$(echo $proteome | cut -d '/' -f2 | cut -d '.' -f1)
  OutDir=$(dirname $proteome)
  ProgDir=/home/theaven/scratch/apps/secretomep
  echo ${OutDir}/${Outfile}_genes_40.fsa
  awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' $proteome | sed "s@file_1_@@g" | sed -e "s@-@N@g" | sed -e "s@X@@g" | awk '/^>/{val=$0;next} length($0)>40{print val ORS $0}' > ${OutDir}/${Outfile}_genes_40.fsa
  sbatch $ProgDir/secretomep.sh ${OutDir}/${Outfile}_genes_40.fsa ${OutDir} ${Outfile}_genes_40_secretomep.out 2>&1 >> secretomeplog.txt
done
#4152856

screen -S secretomep2
conda activate jellyfish
#linearize and edit 
for proteome in $(ls */*/gene_pred/braker/final/ab_initio_final_genes_renamed.pep.fasta); do
  Outfile=$(echo $proteome | cut -d '/' -f2 | cut -d '.' -f1)
  OutDir=$(dirname $proteome)
  ProgDir=/home/theaven/scratch/apps/secretomep
  echo ${OutDir}/${Outfile}abinitio_genes_40.fsa
  awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' $proteome | sed "s@file_1_@@g" | sed -e "s@-@N@g" | sed -e "s@X@@g" | awk '/^>/{val=$0;next} length($0)>40{print val ORS $0}' > ${OutDir}/${Outfile}abinitio_genes_40.fsa
  sbatch $ProgDir/secretomep.sh ${OutDir}/${Outfile}abinitio_genes_40.fsa ${OutDir} ${Outfile}abinitio_genes_40_secretomep.out 2>&1 >> abinitiosecretomeplog.txt
done

for ome in $(ls */*/gene_pred/braker/final/*_genes_40_secretomep.out); do 
sed -i -n '/SecretomeP 1.0g predictions/,$p' $ome 
sed -i '$d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
done

for x in $(ls */*/gene_pred/braker/final/final_genes_renamed.pep.fasta); do
ID=$(echo $x | cut -d '/' -f2 | cut -d '.' -f1)
cp $x downloadprothint/$ID.pep.fasta
done
for x in $(ls */*/gene_pred/braker/final/ab_initio_final_genes_renamed.pep.fasta); do
ID=$(echo $x | cut -d '/' -f2 | cut -d '.' -f1)
cp $x downloadabinitio/$ID.pep.fasta
done
```
```bash
#Extract name of gene from predector file to temp.txt, then get the protein fasta entry for that gene
screen -S blast
conda activate blast+
for proteome in $(ls */*/gene_pred/braker/final/final_genes_renamed.pep.fasta | grep -v 'amorphothecaresinae' ); do 
    Jobs=$(squeue -u theaven |grep 'blast'| wc -l)
    echo x
    while [ $Jobs -gt 10 ]; do
      sleep 120s
      printf "."
      Jobs=$(squeue -u theaven |grep 'blast'| wc -l)
    done
OutDir=$(dirname $proteome)
Database=db/CSEPdb
ProgDir=/home/theaven/scratch/apps/blast
sbatch $ProgDir/blastp.sh $proteome $Database $OutDir/outblast.tsv 2>&1 >> blastoutlog.txt
Database=db2/blumeriadb
sbatch $ProgDir/blastp.sh $proteome $Database $OutDir/inblast.tsv 2>&1 >> blastinlog.txt
done
#5255056,54

screen -S blast2
conda activate blast+
for proteome in $(ls */*/gene_pred/braker/final/ab_initio_final_genes_renamed.pep.fasta); do 
    Jobs=$(squeue -u theaven |grep 'blast'| wc -l)
    echo x
    while [ $Jobs -gt 10 ]; do
      sleep 120s
      printf "."
      Jobs=$(squeue -u theaven |grep 'blast'| wc -l)
    done
OutDir=$(dirname $proteome)
Database=db/CSEPdb
ProgDir=/home/theaven/scratch/apps/blast
sbatch $ProgDir/blastp.sh $proteome $Database $OutDir/abinitio_outblast.tsv 2>&1 >> abinitioblastoutlog.txt
Database=db2/blumeriadb
sbatch $ProgDir/blastp.sh $proteome $Database $OutDir/abinitio_inblast.tsv 2>&1 >> abinitioblastinlog.txt
done
```
Joining data into predector files
```bash
ls */*/gene_pred/predector/Prothint/results/*genes_renamed.pep/*ranked.tsv

ls */*/gene_pred/predector/abinitio/results/*genes_renamed.pep/*ranked.tsv


for proteome in $(ls */*/gene_pred/braker/final/final_genes_renamed.pep.fasta); do 
 ID=$( echo $proteome | cut -d '/' -f2 | sed 's@HEAVEN_apple@Podosphaeraleucotricha_HEAVEN_apple@g'| sed 's@HEAVEN_strawberry@Podosphaeraaphanis_HEAVEN_strawberry@g'| sed 's@HEAVEN_raspberry@Podosphaeraaphanis_HEAVEN_raspberry@g'| sed 's@GANAN_apple@Podosphaeraleucotricha_Ganan_apple@g'|sed 's@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@Erysiphealphitoides_CLCBIO_assembly@g'|sed 's@Oidiodendron_maius@Oidiodendronmaius@g'|sed 's@phialocephalasubalpina-GCA_900073065@phialocephalasubalpina_GCA_900073065@g')
 Annotations=$(ls */$ID/gene_pred/predector/Prothint/results/*genes_renamed.pep/*ranked.tsv)
 echo $Annotations
 blast=$(dirname $proteome)
 OutDir=$(echo */$ID/gene_pred/predector/Prothint)
 echo $OutDir
 cat ${blast}/inblast.tsv | cut -f1 |sort | uniq > ${blast}/ingenes.tsv
 cat ${blast}/outblast.tsv | cut -f1 |sort | uniq > ${blast}/outgenes.tsv
 for f in ${blast}/ingenes.tsv; do sed -i "s/$/\t1/" $f; done
 for f in ${blast}/outgenes.tsv; do sed -i "s/$/\t1/" $f; done
 printf 'name\tmildew orthology match' >> ${blast}/ingenes.tsv
 printf 'name\toutgroup orthology match' >> ${blast}/outgenes.tsv
 join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84 <(sort $Annotations) <(sort ${blast}/outgenes.tsv) > ${OutDir}/${ID}_annotations.tsv
 join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85 <(sort ${OutDir}/${ID}_annotations.tsv) <(sort ${blast}/ingenes.tsv) > ${OutDir}/${ID}_annotations2.tsv
 Secretomep=$(dirname $proteome)/$(echo $proteome | cut -d '/' -f2 | cut -d '.' -f1)_genes_40_secretomep
#cut -f1 $Annotations | grep -v 'name'> fakesecretome.out
# for f in fakesecretome.out; do sed -i "s/$/\t0/" $f; done
#  for f in fakesecretome.out; do sed -i "s/$/\t0/" $f; done
#   for f in fakesecretome.out; do sed -i "s/$/\t0/" $f; done
#    for f in fakesecretome.out; do sed -i "s/$/\t0/" $f; done
#    Secretomep=fakesecretome
 ls ${Secretomep}.out
 printf 'name\tNN-score\tOdds\tWeighted\tWarning' >> ${Secretomep}.out
 awk -v OFS='\t' '{$1=$1}1' ${Secretomep}.out > ${Secretomep}.tsv
 join -t $'\t' -a 1 -e 0 -o 0,2.2,2.3,2.4,2.5,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85,1.86 <(sort ${OutDir}/${ID}_annotations2.tsv) <(sort ${Secretomep}.tsv) > ${OutDir}/${ID}_annotations3.tsv
done
#file1_file1 genes are predictions from Prothint

for proteome in $(ls */*/gene_pred/braker/final/ab_initio_final_genes_renamed.pep.fasta); do 
 ID=$( echo $proteome | cut -d '/' -f2 | sed 's@HEAVEN_apple@Podosphaeraleucotricha_HEAVEN_apple@g'| sed 's@HEAVEN_strawberry@Podosphaeraaphanis_HEAVEN_strawberry@g'| sed 's@HEAVEN_raspberry@Podosphaeraaphanis_HEAVEN_raspberry@g'| sed 's@GANAN_apple@Podosphaeraleucotricha_Ganan_apple@g'|sed 's@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@Erysiphealphitoides_CLCBIO_assembly@g'|sed 's@Oidiodendron_maius@Oidiodendronmaius@g'|sed 's@phialocephalasubalpina-GCA_900073065@phialocephalasubalpina_GCA_900073065@g')
 Annotations=$(ls */$ID/gene_pred/predector/abinitio*/results/*genes_renamed.pep/*ranked.tsv)
 echo $Annotations
 blast=$(dirname $proteome)
 OutDir=$(echo */$ID/gene_pred/predector/abinitio)
 echo $OutDir
 cat ${blast}/abinitio_inblast.tsv | cut -f1 |sort | uniq > ${blast}/abinitio_ingenes.tsv
 cat ${blast}/abinitio_outblast.tsv | cut -f1 |sort | uniq > ${blast}/abinitio_outgenes.tsv
 for f in ${blast}/abinitio_ingenes.tsv; do sed -i "s/$/\t1/" $f; done
 for f in ${blast}/abinitio_outgenes.tsv; do sed -i "s/$/\t1/" $f; done
 printf 'name\tmildew orthology match' >> ${blast}/abinitio_ingenes.tsv
 printf 'name\toutgroup orthology match' >> ${blast}/abinitio_outgenes.tsv
 join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84 <(sort $Annotations) <(sort ${blast}/abinitio_outgenes.tsv) > ${OutDir}/${ID}_abinitio_annotations.tsv
 join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85 <(sort ${OutDir}/${ID}_abinitio_annotations.tsv) <(sort ${blast}/abinitio_ingenes.tsv) > ${OutDir}/${ID}_abinitio_annotations2.tsv
 Secretomep=$(dirname $proteome)/$(echo $proteome | cut -d '/' -f2 | cut -d '.' -f1)abinitio_genes_40_secretomep
#cut -f1 $Annotations | grep -v 'name'> fakesecretome.out
# for f in fakesecretome.out; do sed -i "s/$/\t0/" $f; done
#  for f in fakesecretome.out; do sed -i "s/$/\t0/" $f; done
#   for f in fakesecretome.out; do sed -i "s/$/\t0/" $f; done
#    for f in fakesecretome.out; do sed -i "s/$/\t0/" $f; done
#    Secretomep=fakesecretome
 ls ${Secretomep}.out
 printf 'name\tNN-score\tOdds\tWeighted\tWarning' >> ${Secretomep}.out
 awk -v OFS='\t' '{$1=$1}1' ${Secretomep}.out > ${Secretomep}.tsv
 join -t $'\t' -a 1 -e 0 -o 0,2.2,2.3,2.4,2.5,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85,1.86 <(sort ${OutDir}/${ID}_abinitio_annotations2.tsv) <(sort ${Secretomep}.tsv) > ${OutDir}/${ID}_abinitio_annotations3.tsv
done


screen -S busco
conda activate BUSCO
for assembly in $(ls mildews/*a); do
      Jobs=$(squeue -u theaven |grep 'busco'| wc -l)
    echo x
    while [ $Jobs -gt 5 ]; do
      sleep 120s
      printf "."
      Jobs=$(squeue -u theaven |grep 'busco'| wc -l)
    done
  ID=$( echo $assembly | cut -d '/' -f2 | cut -d '_' -f1,2,3  | cut -d '.' -f1 | sed 's@HEAVEN_apple@Podosphaeraleucotricha_HEAVEN_apple@g'| sed 's@HEAVEN_strawberry@Podosphaeraaphanis_HEAVEN_strawberry@g'| sed 's@HEAVEN_raspberry@Podosphaeraaphanis_HEAVEN_raspberry@g'| sed 's@GANAN_apple@Podosphaeraleucotricha_Ganan_apple@g'|sed 's@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@Erysiphealphitoides_CLCBIO_assembly@g'|sed 's@Oidiodendron_maius@Oidiodendronmaius@g'|sed 's@phialocephalasubalpina-GCA_900073065@phialocephalasubalpina_GCA_900073065@g')
  OutDir=$(ls -d */$ID*/gene_pred/predector/Prothint)/BUSCO
  echo $OutDir
  ProgDir=~/scratch/apps/busco
  BuscoDB=ascomycota_odb10
  echo $BuscoDB
  if [ ! -d $OutDir ]
  then
    echo running for $ID
    echo $assembly 2>&1 >> buscolog.txt
    sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir 2>&1 >> buscolog.txt
  else
    echo already run
  fi
done


for file in $(ls */*/gene_pred/predector/Prothint/BUSCO/ascomycota_odb10/*/short_summary*.txt); do
ID=$(echo $file | cut -d '/' -f2 | sed 's@HEAVEN_apple@Podosphaeraleucotricha_HEAVEN_apple@g'| sed 's@HEAVEN_strawberry@Podosphaeraaphanis_HEAVEN_strawberry@g'| sed 's@HEAVEN_raspberry@Podosphaeraaphanis_HEAVEN_raspberry@g'| sed 's@GANAN_apple@Podosphaeraleucotricha_Ganan_apple@g'|sed 's@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@Erysiphealphitoides_CLCBIO_assembly@g'|sed 's@Oidiodendron_maius@Oidiodendronmaius@g'|sed 's@phialocephalasubalpina-GCA_900073065@phialocephalasubalpina_GCA_900073065@g')
percent=$(grep 'C:' $file)
no1=$(grep 'Complete and single-copy BUSCOs (S)' $file | sed 's@Complete and single-copy BUSCOs (S)@@g')
cent1=$(echo $percent|cut -d ':' -f2 | sed 's@\[S@@g')
no2=$(grep 'Complete and duplicated BUSCOs (D)' $file | sed 's@Complete and duplicated BUSCOs (D)@@g')
cent2=$(echo $percent|cut -d ':' -f4 | sed 's@\],F@@g')
no3=$(grep 'Missing BUSCOs (M)' $file| sed 's@Missing BUSCOs (M)@@g')
cent3=$(echo $percent|cut -d ':' -f6 | sed 's@,n@@g')
echo $ID $no1 $cent1 $no2 $cent2 $no3 $cent3 >> BUSCOreportallmildews.txt
done

#2463015-2463068,2488280-2488332, 2569873-77, 3057081-101
conda deactivate
exit
echo finished

#Making report files
 echo Species+Assembly Predicted_genes pfamID pfam_virulence PHIbase_effector effector_ortholog canonical_SP noncanonical_SP SSCP CSEP Secreted_effectorP3 Secreted_CAZY newSSCP newCSEP newSecreted_effectorP3 all > EffectorPredictionReport.txt
for proteome in $(ls */*/gene_pred/braker/final/final_genes_renamed.pep.fasta); do 
 ID=$( echo $proteome | cut -d '/' -f2 | sed 's@HEAVEN_apple@Podosphaeraleucotricha_HEAVEN_apple@g'| sed 's@HEAVEN_strawberry@Podosphaeraaphanis_HEAVEN_strawberry@g'| sed 's@HEAVEN_raspberry@Podosphaeraaphanis_HEAVEN_raspberry@g'| sed 's@GANAN_apple@Podosphaeraleucotricha_Ganan_apple@g'|sed 's@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@Erysiphealphitoides_CLCBIO_assembly@g'|sed 's@Oidiodendron_maius@Oidiodendronmaius@g'|sed 's@phialocephalasubalpina-GCA_900073065@phialocephalasubalpina_GCA_900073065@g')
 OutDir=$(echo */$ID/gene_pred/predector/Prothint)
 Annotations=${OutDir}/${ID}_annotations3.tsv
 Predictedgenes=$(cut -f1 $Annotations| grep -v 'name' | wc -l)
 pfamID=$(awk '$18 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 pfamvirulence=$(awk '$20 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 PHIbaseeffector=$(awk '$15 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 effectorortholog=$(awk '$11 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 canonicalsp=$(awk '$31 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 noncanonical=$(awk '$31 != "1" && $5 != 'signal' && $2 > 0.6 {print $1}' $Annotations| grep -v 'name' | wc -l)
 sscp=$(awk '$31 == "1" && $36 <= 300 && $39 > 3 {print $1}' $Annotations| grep -v 'name' | wc -l)
 csep=$(awk '$31 == "1" && $7 == "0" {print $1}' $Annotations| grep -v 'name' | wc -l)
 secretedeffector=$(awk '$31 == "1" && $27 == "." && $7 == "0" {print $1}' $Annotations| grep -v 'name' | wc -l)
 secretedcazy=$(awk '$31 == "1" && $21 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 newsscp=$(awk '$31 == "1" && $36 <= 300 && $39 > 3 && $11 == "." && $15 != "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 newcsep=$(awk '$31 == "1" && $7 == "0" && $11 == "." && $15 != "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 newsecretedeffector=$(awk '$31 == "1" && $27 == "." && $11 == "." && $15 != "1" && $7 == "0" {print $1}'  $Annotations| grep -v 'name' | wc -l)
 PHIbaseororthologeffector=$(awk '$15 == "1" || $11 != "." || ($31 == "1" && $27 == "." && $7 == "0") {print $1}' $Annotations| grep -v 'name' | wc -l)
 echo $ID $Predictedgenes $pfamID $pfamvirulence $PHIbaseeffector $effectorortholog $canonicalsp $noncanonical $sscp $csep $secretedeffector $secretedcazy $newsscp $newcsep $newsecretedeffector $PHIbaseororthologeffector >> EffectorPredictionReport.txt
done

echo Species+Assembly Predicted_genes pfamID pfam_virulence PHIbase_effector effector_ortholog canonical_SP noncanonical_SP SSCP CSEP Secreted_effectorP3 Secreted_CAZY newSSCP newCSEP newSecreted_effectorP3 csep_val all > AbinitioEffectorPredictionReport.txt
for proteome in $(ls */*/gene_pred/braker/final/ab_initio_final_genes_renamed.pep.fasta); do 
 ID=$( echo $proteome | cut -d '/' -f2 | sed 's@HEAVEN_apple@Podosphaeraleucotricha_HEAVEN_apple@g'| sed 's@HEAVEN_strawberry@Podosphaeraaphanis_HEAVEN_strawberry@g'| sed 's@HEAVEN_raspberry@Podosphaeraaphanis_HEAVEN_raspberry@g'| sed 's@GANAN_apple@Podosphaeraleucotricha_Ganan_apple@g'|sed 's@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@Erysiphealphitoides_CLCBIO_assembly@g'|sed 's@Oidiodendron_maius@Oidiodendronmaius@g'|sed 's@phialocephalasubalpina-GCA_900073065@phialocephalasubalpina_GCA_900073065@g')
 OutDir=$(echo */$ID/gene_pred/predector/abinitio)
 Annotations=${OutDir}/${ID}_abinitio_annotations3.tsv
 Predictedgenes=$(cut -f1 $Annotations| grep -v 'name' | wc -l)
 pfamID=$(awk '$18 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 pfamvirulence=$(awk '$20 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 PHIbaseeffector=$(awk '$15 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 effectorortholog=$(awk '$11 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 canonicalsp=$(awk '$31 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 noncanonical=$(awk '$31 != "1" && $5 != 'signal' && $2 > 0.6 {print $1}' $Annotations| grep -v 'name' | wc -l)
 sscp=$(awk '$31 == "1" && $36 <= 300 && $39 > 3 {print $1}' $Annotations| grep -v 'name' | wc -l)
 csep=$(awk '$31 == "1" && $7 == "0" {print $1}' $Annotations| grep -v 'name' | wc -l)
 secretedeffector=$(awk '$31 == "1" && $27 == "." && $7 == "0" {print $1}' $Annotations| grep -v 'name' | wc -l)
 secretedcazy=$(awk '$31 == "1" && $21 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 newsscp=$(awk '$31 == "1" && $36 <= 300 && $39 > 3 && $11 == "." && $15 != "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 newcsep=$(awk '$31 == "1" && $7 == "0" && $11 == "." && $15 != "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 newsecretedeffector=$(awk '$31 == "1" && $27 == "." && $11 == "." && $15 != "1" && $7 == "0" {print $1}'  $Annotations| grep -v 'name' | wc -l)
 all=$(awk '$15 == "1" || $11 != "." || ($31 == "1" && $27 == "." && $7 == "0") {print $1}' $Annotations| grep -v 'name' | wc -l)
 csep_val=$(awk '$11 != "." || ($31 == "1" && $27 == "." && $7 == "0") {print $1}' $Annotations| grep -v 'name' | wc -l)
 echo $ID $Predictedgenes $pfamID $pfamvirulence $PHIbaseeffector $effectorortholog $canonicalsp $noncanonical $sscp $csep $secretedeffector $secretedcazy $newsscp $newcsep $newsecretedeffector $csep_val $all >> AbinitioEffectorPredictionReport.txt
done

```
All inhouse assemblies - Secretomep and blast
```bash
conda activate blast+
for proteome in $(ls /home/theaven/scratch/gene_pred/P*/T*/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do 
OutDir=$(dirname $proteome)
Database=db/CSEPdb
ProgDir=/home/theaven/scratch/apps/blast
sbatch $ProgDir/blastp.sh $proteome $Database $OutDir/outblast.tsv 2>&1 >> blastoutlog.txt
Database=db2/blumeriadb
sbatch $ProgDir/blastp.sh $proteome $Database $OutDir/inblast.tsv 2>&1 >> blastinlog.txt
done

conda activate jellyfish
#linearize and edit 
for proteome in $(ls gene_pred/P*/T*/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do
  Outfile=$(echo $proteome | cut -d '/' -f3 | cut -d '.' -f1)_
  OutDir=$(dirname $proteome)
  ProgDir=/home/theaven/scratch/apps/secretomep
  echo ${OutDir}/${Outfile}abinitio_genes_40.fsa
  awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' $proteome | sed "s@file_1_@@g" | sed -e "s@-@N@g" | sed -e "s@X@@g" | awk '/^>/{val=$0;next} length($0)>40{print val ORS $0}' > ${OutDir}/${Outfile}abinitio_genes_40.fsa
  sbatch $ProgDir/secretomep.sh ${OutDir}/${Outfile}abinitio_genes_40.fsa ${OutDir} ${Outfile}abinitio_genes_40_secretomep.out 2>&1 >> abinitiosecretomeplog.txt
done

for ome in $(ls /home/theaven/scratch/gene_pred/P*/T*/codingquarry/rep_modeling/final/*_genes_40_secretomep.out); do 
sed -i -n '/SecretomeP 1.0g predictions/,$p' $ome 
sed -i '$d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 
sed -i '1d' $ome 

for proteome in $(ls gene_pred/P*/T*/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do 
 ID=$( echo $proteome | cut -d '/' -f3)
 Annotations=$(ls gene_pred/P*/${ID}/predector_singularity3/results/final_genes_appended_renamed.pep/P*_1-ranked.tsv)
 echo $Annotations
 blast=$(dirname $proteome)
 OutDir=$(echo gene_pred/P*/${ID}/predector_singularity3)
 echo $OutDir
 cat ${blast}/inblast.tsv | cut -f1 |sort | uniq > ${blast}/abinitio_ingenes.tsv
 cat ${blast}/outblast.tsv | cut -f1 |sort | uniq > ${blast}/abinitio_outgenes.tsv
 for f in ${blast}/abinitio_ingenes.tsv; do sed -i "s/$/\t1/" $f; done
 for f in ${blast}/abinitio_outgenes.tsv; do sed -i "s/$/\t1/" $f; done
 printf 'name\tmildew orthology match' >> ${blast}/abinitio_ingenes.tsv
 printf 'name\toutgroup orthology match' >> ${blast}/abinitio_outgenes.tsv
 join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84 <(sort $Annotations) <(sort ${blast}/abinitio_outgenes.tsv) > ${OutDir}/${ID}_abinitio_annotations.tsv
 join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85 <(sort ${OutDir}/${ID}_abinitio_annotations.tsv) <(sort ${blast}/abinitio_ingenes.tsv) > ${OutDir}/${ID}_abinitio_annotations2.tsv
 Secretomep=$(dirname $proteome)/$(echo $proteome | cut -d '/' -f3 | cut -d '.' -f1)_abinitio_genes_40_secretomep
 ls ${Secretomep}.out
 printf 'name\tNN-score\tOdds\tWeighted\tWarning' >> ${Secretomep}.out
 awk -v OFS='\t' '{$1=$1}1' ${Secretomep}.out > ${Secretomep}.tsv
 join -t $'\t' -a 1 -e 0 -o 0,2.2,2.3,2.4,2.5,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85,1.86 <(sort ${OutDir}/${ID}_abinitio_annotations2.tsv) <(sort ${Secretomep}.tsv) > ${OutDir}/${ID}_abinitio_annotations3.tsv
done

 echo Species+Assembly Predicted_genes pfamID pfam_virulence PHIbase_effector effector_ortholog canonical_SP noncanonical_SP SSCP CSEP Secreted_effectorP3 Secreted_CAZY newSSCP newCSEP newSecreted_effectorP3 > all6EffectorPredictionReport.txt
for proteome in $(ls gene_pred/P*/T*/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do 
 ID=$( echo $proteome | cut -d '/' -f3)
 OutDir=$(echo gene_pred/P*/${ID}/predector_singularity3)
 Annotations=${OutDir}/${ID}_abinitio_annotations3.tsv
 echo $Annotations
 Predictedgenes=$(cut -f1 $Annotations| grep -v 'name' | wc -l)
 pfamID=$(awk '$18 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 pfamvirulence=$(awk '$20 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 PHIbaseeffector=$(awk '$15 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 effectorortholog=$(awk '$11 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 canonicalsp=$(awk '$31 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 noncanonical=$(awk '$31 != "1" && $5 != 'signal' && $2 > 0.6 {print $1}' $Annotations| grep -v 'name' | wc -l)
 sscp=$(awk '$31 == "1" && $36 <= 300 && $39 > 3 {print $1}' $Annotations| grep -v 'name' | wc -l)
 csep=$(awk '$31 == "1" && $7 == "0" {print $1}' $Annotations| grep -v 'name' | wc -l)
 secretedeffector=$(awk '$31 == "1" && $27 == "." && $7 == "0" {print $1}' $Annotations| grep -v 'name' | wc -l)
 secretedcazy=$(awk '$31 == "1" && $21 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 newsscp=$(awk '$31 == "1" && $36 <= 300 && $39 > 3 && $11 == "." && $15 != "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 newcsep=$(awk '$31 == "1" && $7 == "0" && $11 == "." && $15 != "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 newsecretedeffector=$(awk '$31 == "1" && $27 == "." && $11 == "." && $15 != "1" && $7 == "0" {print $1}'  $Annotations| grep -v 'name' | wc -l)
 echo $ID $Predictedgenes $pfamID $pfamvirulence $PHIbaseeffector $effectorortholog $canonicalsp $noncanonical $sscp $csep $secretedeffector $secretedcazy $newsscp $newcsep $newsecretedeffector >> all6EffectorPredictionReport.txt
done

####################################################################################################################
#find the no. of orthogroups for gene features
P_aphanis-THeavenDRCT72020_1-common-ranked4.tsv 
P_leucotricha-THeavenp11_1-common-ranked4.tsv
P_leucotricha-THeavenp11_1-leucotricha-ranked4.tsv

Predictedgenes=$(cut -f1 P_aphanis-THeavenDRCT72020_1-aphanis-ranked4.tsv| grep -v 'name' | wc -l)
pfamID=$(awk '$18 != "." {print $1}' P_aphanis-THeavenDRCT72020_1-aphanis-ranked4.tsv| grep -v 'name' | wc -l)
pfamvirulence=$(awk '$20 == "1" {print $1}' P_aphanis-THeavenDRCT72020_1-aphanis-ranked4.tsv| grep -v 'name' | wc -l)
PHIbaseeffector=$(awk '$15 == "1" {print $1}' P_aphanis-THeavenDRCT72020_1-aphanis-ranked4.tsv| grep -v 'name' | wc -l)
effectorortholog=$(awk '$11 != "." {print $1}' P_aphanis-THeavenDRCT72020_1-aphanis-ranked4.tsv| grep -v 'name' | wc -l)
canonicalsp=$(awk '$31 == "1" {print $1}' P_aphanis-THeavenDRCT72020_1-aphanis-ranked4.tsv| grep -v 'name' | wc -l)
non-canonical=$(awk '$31 != "1" && $5 != 'signal' && $2 > 0.6 {print $1}' P_aphanis-THeavenDRCT72020_1-aphanis-ranked4.tsv| grep -v 'name' | wc -l)
sscp=$(awk '$31 == "1" && $36 <= 300 && $39 > 3 {print $1}' P_aphanis-THeavenDRCT72020_1-aphanis-ranked4.tsv| grep -v 'name' | wc -l)
 csep=$(awk '$31 == "1" && $7 == "0" {print $1}' $Annotations| grep -v 'name' | wc -l)
 secretedeffector=$(awk '$31 == "1" && $27 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 secretedcazy=$(awk '$31 == "1" && $21 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 
 echo Species+Assembly Predicted_genes pfamID pfam_virulence PHIbase_effector effector_ortholog canonical_SP noncanonical_SP SSCP CSEP Secreted_effectorP3 Secreted_CAZY newSSCP newCSEP newSecreted_effectorP3 > OwnEffectorPredictionReport.txt
 for file in $(ls *-ranked4.tsv); do
 ID=$(echo $file | cut -d '-' -f2,3)
 echo $ID
 Annotations=$file
  echo $Annotations
 Predictedgenes=$(cut -f1 $Annotations| grep -v 'name' | wc -l)
 pfamID=$(awk '$18 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 pfamvirulence=$(awk '$20 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 PHIbaseeffector=$(awk '$15 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 effectorortholog=$(awk '$11 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 canonicalsp=$(awk '$31 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 noncanonical=$(awk '$31 != "1" && $5 != 'signal' && $2 > 0.6 {print $1}' $Annotations| grep -v 'name' | wc -l)
 sscp=$(awk '$31 == "1" && $36 <= 300 && $39 > 3 {print $1}' $Annotations| grep -v 'name' | wc -l)
 csep=$(awk '$31 == "1" && $7 == "0" {print $1}' $Annotations| grep -v 'name' | wc -l)
 secretedeffector=$(awk '$31 == "1" && $27 == "." && $7 == "0" {print $1}' $Annotations| grep -v 'name' | wc -l)
 secretedcazy=$(awk '$31 == "1" && $21 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 newsscp=$(awk '$31 == "1" && $36 <= 300 && $39 > 3 && $11 == "." && $15 != "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 newcsep=$(awk '$31 == "1" && $7 == "0" && $11 == "." && $15 != "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 newsecretedeffector=$(awk '$31 == "1" && $27 == "." && $11 == "." && $15 != "1" && $7 == "0" {print $1}'  $Annotations| grep -v 'name' | wc -l)
 echo $ID $Predictedgenes $pfamID $pfamvirulence $PHIbaseeffector $effectorortholog $canonicalsp $noncanonical $sscp $csep $secretedeffector $secretedcazy $newsscp $newcsep $newsecretedeffector >> OwnEffectorPredictionReport.txt
 done






echo Orthogroups >> OwnEffectorPredictionReport.txt
#Predicted genes=
for Annotations in $(ls P_aphanis-THeavenDRCT72020_1-*-ranked4.tsv); do
ID=$(echo $Annotations | cut -d '-' -f2,3)
cut -f1 $Annotations| grep -v 'name' > ob1.txt
sed -i -e 's/^/ST20|/' ob1.txt
x1=$(grep -f ob1.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#TFs
#pfamID=
awk '$18 != "." {print $1}' $Annotations| grep -v 'name' > ob1x.txt
sed -i -e 's/^/ST20|/' ob1x.txt
x2=$(grep -f ob1x.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#pfamvirulence=
awk '$20 == "1" {print $1}' $Annotations| grep -v 'name' > ob1xx.txt
sed -i -e 's/^/ST20|/' ob1xx.txt
x3=$(grep -f ob1xx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#PHIbaseeffector=
awk '$15 == "1" {print $1}' $Annotations| grep -v 'name' > ob1xxx.txt
sed -i -e 's/^/ST20|/' ob1xxx.txt
x4=$(grep -f ob1xxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#effectorortholog=
awk '$11 != "." {print $1}' $Annotations| grep -v 'name' > ob1xxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxx.txt
x5=$(grep -f ob1xxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#canonicalsp=
awk '$31 == "1" {print $1}' $Annotations| grep -v 'name' > ob1xxxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxxx.txt
x6=$(grep -f ob1xxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#non-canonical=
awk '$31 != "1" && $5 != 'signal' && $2 > 0.6 {print $1}' $Annotations| grep -v 'name' > ob1xxxxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxxxx.txt
x7=$(grep -f ob1xxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#sscp=
awk '$31 == "1" && $36 <= 300 && $39 > 3 {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxxxxx.txt
x8=$(grep -f ob1xxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#csep=
awk '$31 == "1" && $7 == "0" {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxxxxxx.txt
x9=$(grep -f ob1xxxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#secretedeffector=
awk '$31 == "1" && $27 != "." {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxxxxxxx.txt
x10=$(grep -f ob1xxxxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#secretedcazy=
awk '$31 == "1" && $21 != "." {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxxxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxxxxxxxx.txt
x11=$(grep -f ob1xxxxxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
echo $ID $x1 $x2 $x3 $x4 $x5 $x6 $x7 $x8 $x9 $x10 $x11 >> OwnEffectorPredictionReport.txt
done

for Annotations in $(ls P_leucotricha-THeavenp11_1*-ranked4.tsv); do
ID=$(echo $Annotations | cut -d '-' -f2,3)
cut -f1 $Annotations| grep -v 'name' > ob1.txt
sed -i -e 's/^/AP20|/' ob1.txt
x1=$(grep -f ob1.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#TFs
#pfamID=
awk '$18 != "." {print $1}' $Annotations| grep -v 'name' > ob1x.txt
sed -i -e 's/^/AP20|/' ob1x.txt
x2=$(grep -f ob1x.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#pfamvirulence=
awk '$20 == "1" {print $1}' $Annotations| grep -v 'name' > ob1xx.txt
sed -i -e 's/^/AP20|/' ob1xx.txt
x3=$(grep -f ob1xx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#PHIbaseeffector=
awk '$15 == "1" {print $1}' $Annotations| grep -v 'name' > ob1xxx.txt
sed -i -e 's/^/AP20|/' ob1xxx.txt
x4=$(grep -f ob1xxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#effectorortholog=
awk '$11 != "." {print $1}' $Annotations| grep -v 'name' > ob1xxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxx.txt
x5=$(grep -f ob1xxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#canonicalsp=
awk '$31 == "1" {print $1}' $Annotations| grep -v 'name' > ob1xxxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxxx.txt
x6=$(grep -f ob1xxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#non-canonical=
awk '$31 != "1" && $5 != 'signal' && $2 > 0.6 {print $1}' $Annotations| grep -v 'name' > ob1xxxxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxxxx.txt
x7=$(grep -f ob1xxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#sscp=
awk '$31 == "1" && $36 <= 300 && $39 > 3 {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxxxxx.txt
x8=$(grep -f ob1xxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#csep=
awk '$31 == "1" && $7 == "0" {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxxxxxx.txt
x9=$(grep -f ob1xxxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#secretedeffector=
awk '$31 == "1" && $27 != "." {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxxxxxxx.txt
x10=$(grep -f ob1xxxxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#secretedcazy=
awk '$31 == "1" && $21 != "." {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxxxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxxxxxxxx.txt
x11=$(grep -f ob1xxxxxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
echo $ID $x1 $x2 $x3 $x4 $x5 $x6 $x7 $x8 $x9 $x10 $x11 >> OwnEffectorPredictionReport.txt
done


####################################################################################################################
#MINUs RASPBERRY gene orthologies

cut -f1 /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-minusraspcommon-ranked.tsv > aphanis-rasp-common.txt
cut -f1 /home/theaven/scratch/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_aphanis-THeavenDRCT72020_1-minusraspaphanis-ranked.tsv > aphanis-rasp-unique.txt
cut -f1 /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-minusraspcommon-ranked.tsv > leucotricha-rasp-common.txt
cut -f1 /home/theaven/scratch/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity2/results/final_genes_appended_renamed.pep/P_leucotricha-THeavenp11_1-minusraspleucotricha-ranked.tsv > leucotricha-rasp-unique.txt

ls gene_pred/P*/*/predector_singularity3/*_abinitio_annotations3.tsv

grep -f aphanis-rasp-common.txt gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity3/THeavenDRCT72020_1_abinitio_annotations3.tsv > aphanis-rasp-common.tsv
grep -f aphanis-rasp-unique.txt gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity3/THeavenDRCT72020_1_abinitio_annotations3.tsv > aphanis-rasp-unique.tsv
grep -f leucotricha-rasp-common.txt gene_pred/P_leucotricha/THeavenp11_1/predector_singularity3/THeavenp11_1_abinitio_annotations3.tsv > leucotricha-rasp-common.tsv
grep -f leucotricha-rasp-unique.txt gene_pred/P_leucotricha/THeavenp11_1/predector_singularity3/THeavenp11_1_abinitio_annotations3.tsv > leucotricha-rasp-unique.tsv

 echo Species+Assembly Predicted_genes pfamID pfam_virulence PHIbase_effector effector_ortholog canonical_SP noncanonical_SP SSCP CSEP Secreted_effectorP3 Secreted_CAZY newSSCP newCSEP newSecreted_effectorP3 > raspPredictionReport.txt
 for file in $(ls *-rasp-*.tsv); do
 ID=$(echo $file | cut -d '.' -f1)
 echo $ID
 Annotations=$file
 Predictedgenes=$(cut -f1 $Annotations| grep -v 'name' | wc -l)
 pfamID=$(awk '$18 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 pfamvirulence=$(awk '$20 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 PHIbaseeffector=$(awk '$15 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 effectorortholog=$(awk '$11 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 canonicalsp=$(awk '$31 == "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 noncanonical=$(awk '$31 != "1" && $5 != 'signal' && $2 > 0.6 {print $1}' $Annotations| grep -v 'name' | wc -l)
 sscp=$(awk '$31 == "1" && $36 <= 300 && $39 > 3 {print $1}' $Annotations| grep -v 'name' | wc -l)
 csep=$(awk '$31 == "1" && $7 == "0" {print $1}' $Annotations| grep -v 'name' | wc -l)
 secretedeffector=$(awk '$31 == "1" && $27 == "." && $7 == "0" {print $1}' $Annotations| grep -v 'name' | wc -l)
 secretedcazy=$(awk '$31 == "1" && $21 != "." {print $1}' $Annotations| grep -v 'name' | wc -l)
 newsscp=$(awk '$31 == "1" && $36 <= 300 && $39 > 3 && $11 == "." && $15 != "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 newcsep=$(awk '$31 == "1" && $7 == "0" && $11 == "." && $15 != "1" {print $1}' $Annotations| grep -v 'name' | wc -l)
 newsecretedeffector=$(awk '$31 == "1" && $27 == "." && $11 == "." && $15 != "1" && $7 == "0" {print $1}'  $Annotations| grep -v 'name' | wc -l)
 echo $ID $Predictedgenes $pfamID $pfamvirulence $PHIbaseeffector $effectorortholog $canonicalsp $noncanonical $sscp $csep $secretedeffector $secretedcazy $newsscp $newcsep $newsecretedeffector >> raspPredictionReport.txt
 done

for Annotations in $(ls leucotricha-rasp*.tsv); do
ID=$(echo $Annotations | cut -d '.' -f1)
cut -f1 $Annotations| grep -v 'name' > ob1.txt
sed -i -e 's/^/AP20|/' ob1.txt
x1=$(grep -f ob1.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#TFs
#pfamID=
awk '$18 != "." {print $1}' $Annotations| grep -v 'name' > ob1x.txt
sed -i -e 's/^/AP20|/' ob1x.txt
x2=$(grep -f ob1x.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#pfamvirulence=
awk '$20 == "1" {print $1}' $Annotations| grep -v 'name' > ob1xx.txt
sed -i -e 's/^/AP20|/' ob1xx.txt
x3=$(grep -f ob1xx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#PHIbaseeffector=
awk '$15 == "1" {print $1}' $Annotations| grep -v 'name' > ob1xxx.txt
sed -i -e 's/^/AP20|/' ob1xxx.txt
x4=$(grep -f ob1xxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#effectorortholog=
awk '$11 != "." {print $1}' $Annotations| grep -v 'name' > ob1xxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxx.txt
x5=$(grep -f ob1xxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#canonicalsp=
awk '$31 == "1" {print $1}' $Annotations| grep -v 'name' > ob1xxxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxxx.txt
x6=$(grep -f ob1xxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#non-canonical=
awk '$31 != "1" && $5 != 'signal' && $2 > 0.6 {print $1}' $Annotations| grep -v 'name' > ob1xxxxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxxxx.txt
x7=$(grep -f ob1xxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#sscp=
awk '$31 == "1" && $36 <= 300 && $39 > 3 {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxxxxx.txt
x8=$(grep -f ob1xxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#csep=
awk '$31 == "1" && $7 == "0" {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxxxxxx.txt
x9=$(grep -f ob1xxxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#secretedeffector=
awk '$31 == "1" && $27 != "." {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxxxxxxx.txt
x10=$(grep -f ob1xxxxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#secretedcazy=
awk '$31 == "1" && $21 != "." {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxxxxx.txt
sed -i -e 's/^/AP20|/' ob1xxxxxxxxxx.txt
x11=$(grep -f ob1xxxxxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
echo $ID $x1 $x2 $x3 $x4 $x5 $x6 $x7 $x8 $x9 $x10 $x11 >> raspPredictionReport.txt
done

for Annotations in $(ls aphanis-rasp*.tsv); do
ID=$(echo $Annotations | cut -d '.' -f1)
cut -f1 $Annotations| grep -v 'name' > ob1.txt
sed -i -e 's/^/ST20|/' ob1.txt
x1=$(grep -f ob1.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#TFs
#pfamID=
awk '$18 != "." {print $1}' $Annotations| grep -v 'name' > ob1x.txt
sed -i -e 's/^/ST20|/' ob1x.txt
x2=$(grep -f ob1x.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#pfamvirulence=
awk '$20 == "1" {print $1}' $Annotations| grep -v 'name' > ob1xx.txt
sed -i -e 's/^/ST20|/' ob1xx.txt
x3=$(grep -f ob1xx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#PHIbaseeffector=
awk '$15 == "1" {print $1}' $Annotations| grep -v 'name' > ob1xxx.txt
sed -i -e 's/^/ST20|/' ob1xxx.txt
x4=$(grep -f ob1xxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#effectorortholog=
awk '$11 != "." {print $1}' $Annotations| grep -v 'name' > ob1xxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxx.txt
x5=$(grep -f ob1xxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#canonicalsp=
awk '$31 == "1" {print $1}' $Annotations| grep -v 'name' > ob1xxxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxxx.txt
x6=$(grep -f ob1xxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#non-canonical=
awk '$31 != "1" && $5 != 'signal' && $2 > 0.6 {print $1}' $Annotations| grep -v 'name' > ob1xxxxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxxxx.txt
x7=$(grep -f ob1xxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#sscp=
awk '$31 == "1" && $36 <= 300 && $39 > 3 {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxxxxx.txt
x8=$(grep -f ob1xxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#csep=
awk '$31 == "1" && $7 == "0" {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxxxxxx.txt
x9=$(grep -f ob1xxxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#secretedeffector=
awk '$31 == "1" && $27 != "." {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxxxxxxx.txt
x10=$(grep -f ob1xxxxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
#secretedcazy=
awk '$31 == "1" && $21 != "." {print $1}' $Annotations| grep -v 'name' > ob1xxxxxxxxxx.txt
sed -i -e 's/^/ST20|/' ob1xxxxxxxxxx.txt
x11=$(grep -f ob1xxxxxxxxxx.txt analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | uniq | wc -l)
echo $ID $x1 $x2 $x3 $x4 $x5 $x6 $x7 $x8 $x9 $x10 $x11 >> raspPredictionReport.txt
done
```
```bash
python3 refs.py >> refs.txt
grep ', 1\|, 2' refs.txt >> reflist.txt
sed -i 's/(//g' reflist.txt
sed -i 's/)//g' reflist.txt

```
Identifying mating types
```bash
#P.leucotricha MAT primers from ganan et al.
for assembly in $(ls mildews/HEA*.fna); do
grep -B 1 'CGTCCCAACCAAGGTTTAAG\|TGCTGCTGAAATTATTGACCA' $assembly > MAT1-1-1forward.txt
grep -B 1 'TGGTCAATAATTTCAGCAGCA\|CTTAAACCTTGGTTGGGACG' $assembly > MAT1-1-1reverse.txt
grep '>' MAT1-1-1forward.txt > temp.txt
echo $assembly >> MAT1-1-1.txt
grep -f temp.txt MAT1-1-1reverse.txt >> MAT1-1-1.txt
done

for assembly in $(ls mildews/HEA*.fna); do
grep -B 1 'CCCTCCAAACTCGTGGATTT\|AAATCCACGAGTTTGGAGGG' $assembly > MAT1-2-1forward.txt
grep -B 1 'CCCGCATACGGTTTCTCTTT\|AAAGAGAAACCGTATGCGGG' $assembly > MAT1-2-1reverse.txt
grep '>' MAT1-2-1forward.txt > temp.txt
echo $assembly >> MAT1-2-1.txt
grep -f temp.txt MAT1-2-1reverse.txt >> MAT1-2-1.txt
done

#DRCT72021:
#DRCT72020:
#SCOTT2020:
#OGB2021:contig_1528 MAT1-2 CCCGCATACGGTTTCTCTTTTGACGCCGCTTCACTTCCGATGATTTTCGTGGTTTATAACGGTATCCAGGATTTTGAACAGCATGTTGACGCTTTGCACGATCTGCGAGATCCTTGTACGTATTTCGAACTTCGTTTGGCTCTCTAGCCCACATTGTAGAGATTAAGGTTGCTAGAAAATACATATGAGAATAAGAATCATACTAGATAGACAAGCTTACATATTTGGTTATTACTTAGACCAGGGTTCTGAGCCACAGTTTCTTCATGTTTAGCCTTTCGATATAAAATCCACGAGTTTGGAGGG
#P112020:contig_1488 MAT1-2 CCCTCCAAACTCGTGGATTTTATATCGAAAGGCTAAACATGAAGAAACTGTGGCTCAGAACCCTGGTCTAAGTAATAACCAAATATGTAAGCTTGTCTATCTAGTATGATTCTTATTCTCATATGTATTTTCTAGCAACCTTAATCTCTACAATGTGGGCTAGAGAGCCAAACGAAGTTCGAAATACGTACAAGGATCTCGCAGATCGTGCAAAGCGTCAACATGCTGTTCAAAATCCTGGATACCGTTATAAACCACGAAAATCATCGGAAGTGAAGCGGCGTCAAAAGAGAAACCGTATGCGGG
#OGB2019:contig_1598 MAT1-2 CCCTCCAAACTCGTGGATTTTATATCGAAAGGCTAAACATGAAGAAACTGTGGCTCAGAACCCTGGTCTAAGTAATAACCAAATATGTAAGCTTGTCTATCTAGTATGATTCTTATTCTCATATGTATTTTCTAGCAACCTTAATCTCTACAATGTGGGCTAGAGAGCCAAACGAAGTTCGAAATACGTACAAGGATCTCGCAGATCGTGCAAAGCGTCAACATGCTGTTCAAAATCCTGGATACCGTTATAAACCACGAAAATCATCGGAAGTGAAGCGGCGTCAAAAGAGAAACCGTATGCGGG

##############################################################################
#P.aphanis MAT primers from asalf et al.
for assembly in $(ls mildews/HEA*.fna); do
grep -B 1 'GGCTTCAGAAGTATGTCTCAATCAA\|TTGATTGAGACATACTTCTGAAGCC' $assembly > aMAT1-1-1forward.txt
grep -B 1 'TTCCACAATTTCGTCAGAAGAG\|CTCTTCTGACGAAATTGTGGAA' $assembly > aMAT1-1-1reverse.txt
grep '>' aMAT1-1-1forward.txt > atemp.txt
echo $assembly >> aMAT1-1-1.txt
grep -f atemp.txt aMAT1-1-1reverse.txt >> aMAT1-1-1.txt
echo ${assembly}_1-1
done

for assembly in $(ls mildews/HEA*.fna); do
grep -B 1 'AAAGGCTAAACACGAAGAAACTGT\|ACAGTTTCTTCGTGTTTAGCCTTT' $assembly > aMAT1-2-1forward.txt
grep -B 1 'TTGTAACGGTAACCAGGATTTTC\|GAAAATCCTGGTTACCGTTACAA' $assembly > aMAT1-2-1reverse.txt
grep '>' aMAT1-2-1forward.txt > atemp.txt
echo $assembly >> aMAT1-2-1.txt
grep -f atemp.txt aMAT1-2-1reverse.txt >> aMAT1-2-1.txt
echo ${assembly}_1-2
done

#DRCT72021:contig_3816 MAT1-2 AAAGGCTAAACACGAAGAAACTGTAGCCCGCAACCCTGGTCTTAGCAACAATCAAATATGTAAGCTTGTTTTTTTAGTATCAATTTTATTCTAATCAAATTCTTCTTTAGCAACCTTGATCTCTTCAATGTGGGCTACAGAGTCGAACGAAGTTCGGAATGTCTACAAGGATCTCGCCGATCGTGCAAAGCGCCAACATGCCGTTGAAAATCCTGGTTACCGTTACAA
#DRCT72020:contig_3763 MAT1-2 TTGTAACGGTAACCAGGATTTTCAACGGCATGTTGGCGCTTTGCACGATCGGCGAGATCCTTGTAGACATTCCGAACTTCGTTCGACTCTGTAGCCCACATTGAAGAGATCAAGGTTGCTAAAGAAGAATTTGATTAGAATAAAATTGATACTAAAAAAACAAGCTTACATATTTGATTGTTGCTAAGACCAGGGTTGCGGGCTACAGTTTCTTCGTGTTTAGCCTTT
#SCOTT2020:contig_4023 MAT1-2 TTGTAACGGTAACCAGGATTTTCAACGGCATGTTGGCGCTTTGCACGATCGGCGAGATCCTTGTAGGCATGTCGAACTTCGTTCGACTCTGTAGCCCACATTGAAGAGATCAAGGTTGCTAAAGAAGAATTTGATTAGAATAAAATTGATACTAAAAAAACAAGCTTACATATTTGATTGTTGCTAAGACCAGGGTTGCGGGCTACAGTTTCTTCGTGTTTAGCCTTT
#OGB2021:
#P112020:
#OGB2019:

#BLASTP with published 1-1 and 1-2 P.leucotricha MAT loci
awk 'BEGIN{FS=" "}{if(!/>/){print toupper($0)}else{print $1}}' mat.fna > MAT.fna
makeblastdb -in MAT.fna -dbtype nucl -title matdb -out db/matdb
for assembly in $(ls mildews/HEA*.fna); do
  output=$(echo $assembly | cut -d '/' -f2 | cut -d '.' -f1)
  echo $output
blastn -query $assembly -db db/matdb -out ${output}_mat.tsv -evalue 1e-5 -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qseq sseq'
done

#DRCT72021:
#DRCT72020:
#SCOTT2020:
#OGB2021:contig_1528 MAT1-2
#P112020:contig_1488 MAT1-2
#OGB2019:contig_1598 MAT1-2

grep -A 1 '>contig_3763' mildews/HEAVEN_strawberry2020.fna > contig_3763.txt
grep -A 1 '>contig_3816' mildews/HEAVEN_strawberry2021.fna > contig_3816.txt
grep -A 1 '>contig_4023' mildews/HEAVEN_raspberry2020.fna > contig_4023.txt
grep -A 1 '>contig_1598' mildews/HEAVEN_apple2019.fna > contig_1598.txt
grep -A 1 '>contig_1488' mildews/HEAVEN_apple2020.fna > contig_1488.txt
grep -A 1 '>contig_1528' mildews/HEAVEN_apple2021.fna > contig_1528.txt
```
## MCAGs
```bash
mkdir mcag
cd mcag
for file in $(ls /home/theaven/scratch/uncompressed/mildews/*/gene_pred/braker/*/final_genes_renamed.pep.fasta); do
name=$(echo $file | cut -d '/' -f7 | sed 's@Podosphaeraxanthii@P_x@g' | sed 's@Podosphaeracerasii@P_c@g' | sed 's@pleochaetashiraiana@Pl_s@g' | sed 's@phyllactiniamoricola@Phy_m@g' | sed 's@phialocephalasubalpina@Phi_s@g' | sed 's@Oidiumheveae@O_h@g' | sed 's@Oidiodendron_maius@Oi_m@g' | sed 's@neobulgariaablba@N_a@g' | sed 's@mollisiascopiformis@M_s@g' | sed 's@leveillulataurrica@L_t@g' | sed 's@HEAVEN_strawberry@P_a_frg@g' | sed 's@HEAVEN_raspberry@P_a_rub@g' | sed 's@HEAVEN_apple@P_l@g' | sed 's@Golovinomycesorontii_AssemblyScaffolds@G_o@g' | sed 's@Golovinomycesmagnicellulatus@G_m@g' | sed 's@Golovinomycescichoracearum@G_c@g' | sed 's@glareaiozoyensis@Gl_i@g' | sed 's@GANAN_apple@P_l_ganan@g' | sed 's@Erysiphepulchra@E_pu@g' | sed 's@Erysiphepisi@E_pi@g' | sed 's@Erysipheneolycopersici@E_neol@g' | sed 's@Erysiphenecator@E_neca@g' | sed 's@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@E_alph@g' | sed 's@drepanopezizabrunnea@D_b@g' | sed 's@chlorociboriaaeruginascens@C_a@g' | sed 's@Blumeriahordei@B_h@g' | sed 's@Blumeriagraminis@B_g@g' | sed 's@ascocorynesarcoides@A_s@g' | sed 's@arachnopezizaaraneosa@Ar_a@g' | sed 's@Amorphothecaresinae@Am_c@g' | sed 's@amorphothecaresinae@Am_c@g')
echo $name
cp $file ./${name}_$(basename $file)
sed -i "s/>/>${name}_/g" ${name}_$(basename $file)
done

for file in $(ls *final_genes_renamed.pep.fasta); do
seqkit rmdup $file > temp.fasta && mv temp.fasta $file
done

mkdir db
cat *final_genes_renamed.pep.fasta > db/db.faa
cd db
makeblastdb -in db.faa -input_type fasta -dbtype prot  -title mildew+db  -parse_seqids -out mildew+db

for file in $(ls ../prot/*); do
name=$(basename $file | cut -d '.' -f1)
blastp -query $file -db mildew+db -out ../${name}_results -evalue 1e-5 -outfmt 6 -num_threads 1
done
```
```bash
mkdir results
cd results

echo '##' > results.txt
for file in $(ls ../*final_genes_renamed.pep.fasta); do
name=$(echo $file | cut -d '/' -f2 | sed 's@_final_genes_renamed.pep.fasta@@g')
echo $name >> results.txt
done

for file in $(ls *protein_results); do
x=$(head -n 1 $file | awk '{print $1}')
sed -i "1s/^/${x}\t/" results.txt
done

#!/bin/bash

# Loop through each line in results.txt
while IFS= read -r line; do
    name=$(echo "$line" | awk '{print $1}' )

    # Loop through each protein_results file
    for file in *protein_results; do
        x=$(grep -m 1 "$name" "$file" | awk '{print $11}')
        if [ -z "$x" ]; then
            x="missing"
        fi
        # Debugging: Print variables
        echo "name: $name, x: $x"
        # Append the value of x to the line in results.txt
        awk -v val="$x" -v n="$name" '{if ($1 == n) print $0"\t"val; else print $0}' results.txt > results_tmp.txt && mv results_tmp.txt results.txt
    done
done < <(grep -v '##' results.txt)

cat results.txt | sed 's@P_x@Podosphaeraxanthii@g' | sed 's@P_c@Podosphaeracerasii@g' | sed 's@Pl_s@pleochaetashiraiana@g' | sed 's@Phy_m@phyllactiniamoricola@g' | sed 's@Phi_s@phialocephalasubalpina@g' | sed 's@O_h@Oidiumheveae@g' | sed 's@Oi_m@Oidiodendron_maius@g' | sed 's@N_a@neobulgariaablba@g' | sed 's@M_s@mollisiascopiformis@g' | sed 's@L_t@leveillulataurrica@g' | sed 's@P_a_frg@HEAVEN_strawberry@g' | sed 's@P_a_rub@HEAVEN_raspberry@g' | sed 's@P_l@HEAVEN_apple@g' | sed 's@G_o@Golovinomycesorontii_AssemblyScaffolds@g' | sed 's@G_m@Golovinomycesmagnicellulatus@g' | sed 's@G_c@Golovinomycescichoracearum@g' | sed 's@Gl_i@glareaiozoyensis@g' | sed 's@P_l_ganan@GANAN_apple@g' | sed 's@E_pu@Erysiphepulchra@g' | sed 's@E_pi@Erysiphepisi@g' | sed 's@E_neol@Erysipheneolycopersici@g' | sed 's@E_neca@Erysiphenecator@g' | sed 's@E_alph@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@g' | sed 's@D_b@drepanopezizabrunnea@g' | sed 's@C_a@chlorociboriaaeruginascens@g' | sed 's@B_h@Blumeriahordei@g' | sed 's@B_g@Blumeriagraminis@g' | sed 's@A_s@ascocorynesarcoides@g' | sed 's@Ar_a@arachnopezizaaraneosa@g' | sed 's@Am_c@Amorphothecaresinae@g' | sed 's@Am_c@amorphothecaresinae@g' > results_tmp.txt && mv results_tmp.txt results.txt

```




##################################################################################################################################################################################################################################################################################
#### BUSCO
```bash
for assembly in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/*a); do
    Database=/jic/research-groups/Saskia-Hogenhout/BUSCO_sets/v5/fungi_odb10
    ProgDir=~/git_repos/Wrappers/NBI
    OutDir=$(dirname $assembly)/BUSCO
    OutFile=$(echo $assembly | cut -d '/' -f9,10,11 | sed 's@/@_@g')
    Jobs=$(squeue -u did23faz| grep 'busco'  | wc -l)
    echo x
    while [ $Jobs -gt 3 ]; do
      sleep 900s
      printf "."
      Jobs=$(squeue -u did23faz| grep 'busco'  | wc -l)
    done
    mkdir $OutDir 
    sleep 30s
    sbatch $ProgDir/run_busco_keep.sh $assembly $Database $OutDir $OutFile
done
#...58940846

for assembly in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/*a); do
    Database=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/databases/busco/leotiomycetes_odb10
    ProgDir=~/git_repos/Wrappers/NBI
    OutDir=$(dirname $assembly)/BUSCO
    OutFile=$(echo $assembly | cut -d '/' -f9,10,11 | sed 's@/@_@g')
    Jobs=$(squeue -u did23faz| grep 'busco'  | wc -l)
    echo x
    while [ $Jobs -gt 3 ]; do
      sleep 900s
      printf "."
      Jobs=$(squeue -u did23faz| grep 'busco'  | wc -l)
    done
    mkdir $OutDir 
    sleep 30s
    sbatch $ProgDir/run_busco_keep.sh $assembly $Database $OutDir $OutFile
done

#Extract complete busco IDs, keep those present in at least 3 genomes:
for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/BUSCO/fungi_odb10/run_fungi_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids.txt;
done

for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/BUSCO/leotiomycetes_odb10/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leotiomycetes_complete_busco_ids.txt;
done

sort /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids.txt |uniq -c > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids_with_counts.txt
grep -v " 2 " /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids_with_counts.txt | grep -v " 1 " > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids.txt
awk '{print $2}' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids.txt > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids_3.txt

sort /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leotiomycetes_complete_busco_ids.txt |uniq -c > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leotiomycetes_complete_busco_ids_with_counts.txt
grep -v " 2 " /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leotiomycetes_complete_busco_ids_with_counts.txt | grep -v " 1 " > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leotiomycetes_complete_busco_ids.txt
awk '{print $2}' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leotiomycetes_complete_busco_ids.txt > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leotiomycetes_complete_busco_ids_3.txt

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt
for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/BUSCO/fungi_odb10/run_fungi_odb10/busco_sequences/single_copy_busco_sequences.tar.gz); do
cd $(dirname $file)
tar -xzvf single_copy_busco_sequences.tar.gz
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/Genomes
done

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt
for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/BUSCO/leotiomycetes_odb10/run_leotiomycetes_odb10/busco_sequences/single_copy_busco_sequences.tar.gz); do
cd $(dirname $file)
tar -xzvf single_copy_busco_sequences.tar.gz
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/Genomes
done

#Give unique names to the complete busco genes from each assembly:
for dir in $(ls -d /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/BUSCO/fungi_odb10/run_fungi_odb10/busco_sequences/single_copy_busco_sequences); do
  sppname=$(echo $dir |cut -f9,10,11 -d "/" | sed 's@/@_@g');
  abbrv=$(echo $dir | cut -d '/' -f9 | cut -c 1-3)_$(echo $dir | cut -d '/' -f10 | cut -c 1-3)_$(echo $dir | cut -d '/' -f11)
  echo $sppname
  echo $abbrv
  for file in ${dir}/*.fna; do
    out=$(echo $file |rev |cut -f 1 -d "/"|rev)
    cp $file /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/${sppname}_${out}
    sed -i 's/^>/>'${abbrv}'|/g' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/${sppname}_${out}
  cut -f 1 -d ":" /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/${sppname}_${out}.1 && mv /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/${sppname}_${out}.1 /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/${sppname}_${out}  
  done
done

for dir in $(ls -d /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/BUSCO/leotiomycetes_odb10/run_leotiomycetes_odb10/busco_sequences/single_copy_busco_sequences); do
  sppname=$(echo $dir |cut -f9,10,11 -d "/" | sed 's@/@_@g');
  abbrv=$(echo $dir | cut -d '/' -f9 | cut -c 1-3)_$(echo $dir | cut -d '/' -f10 | cut -c 1-3)_$(echo $dir | cut -d '/' -f11)
  echo $sppname
  echo $abbrv
  for file in ${dir}/*.fna; do
    out=$(echo $file |rev |cut -f 1 -d "/"|rev)
    cp $file /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt/${sppname}_${out}
    sed -i 's/^>/>'${abbrv}'|/g' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt/${sppname}_${out}
  cut -f 1 -d ":" /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt/${sppname}_${out} | tr '[:lower:]' '[:upper:]' > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt/${sppname}_${out}.1 && mv /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt/${sppname}_${out}.1 /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt/${sppname}_${out}  
  done
done

#Combine genes from each assembly into a single file per gene:
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt
buscos=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids_3.txt
lines=$(cat $buscos)
for line in $lines; do
  for fna in $(ls *_$line.fna); do
  output=$(echo $line)_nt.fasta
  cat $fna >> $output
  done
done
rm *.fna

cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt
buscos=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leotiomycetes_complete_busco_ids_3.txt
lines=$(cat $buscos)
for line in $lines; do
  for fna in $(ls *_$line.fna); do
  output=$(echo $line)_nt.fasta
  cat $fna >> $output
  done
done
rm *.fna

#58940918

#Align the gene sequences;
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt
for file in $(ls ${AlignDir}/*_nt.fasta); do
OutFile=$(basename $file | sed 's@_nt.fasta@_nt_aligned.fasta@g')
Jobs=$(squeue -u did23faz| grep 'mafft'  | wc -l)
while [ $Jobs -gt 100 ]; do
    sleep 300s
    printf "."
    Jobs=$(squeue -u did23faz| grep 'mafft'| wc -l)
done
OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt
ProgDir=~/git_repos/Wrappers/NBI
echo "$file" >> mafft_log.txt
sbatch $ProgDir/sub_mafft_alignment.sh $file $OutDir $OutFile 2>&1 >> mafft_log.txt
done

AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt
for file in $(ls ${AlignDir}/*_nt.fasta); do
OutFile=$(basename $file | sed 's@_nt.fasta@_nt_aligned.fasta@g')
Jobs=$(squeue -u did23faz| grep 'mafft'  | wc -l)
while [ $Jobs -gt 150 ]; do
    sleep 300s
    printf "."
    Jobs=$(squeue -u did23faz| grep 'mafft'| wc -l)
done
OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt
ProgDir=~/git_repos/Wrappers/NBI
echo "$file" >> mafft_log.txt
sbatch $ProgDir/sub_mafft_alignment.sh $file $OutDir $OutFile 2>&1 >> mafft_log.txt
done

for gene in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/*_aligned.fasta); do
  ID=$(basename $gene |sed 's@_nt_aligned.fasta@@g')
  echo $ID
  mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/$ID
  cp $gene /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/$ID
done

for gene in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt/*_aligned.fasta); do
  ID=$(basename $gene |sed 's@_nt_aligned.fasta@@g')
  echo $ID
  mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt/$ID
  cp $gene /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt/$ID
done

#Trim the alignments:
for Alignment in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/*/*_aligned.fasta); do
  OutDir=$(dirname $Alignment)
  TrimmedName=$(basename $Alignment .fasta)"_trimmed.fasta"
  echo $Alignment
  echo $OutDir
  echo $TrimmedName
  sed -i 's/n/N/g' $Alignment
  singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/trimal1.4.1.sif trimal -in $Alignment -out $OutDir/$TrimmedName -keepheader -automated1
done

for Alignment in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt/*/*_aligned.fasta); do
  OutDir=$(dirname $Alignment)
  TrimmedName=$(basename $Alignment .fasta)"_trimmed.fasta"
  echo $Alignment
  echo $OutDir
  echo $TrimmedName
  sed -i '/^>/! s/[yrmwn]/N/g' "$Alignment" #trimal does not like all IUPAC symbols, just atgcn
  singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/trimal1.4.1.sif trimal -in $Alignment -out $OutDir/$TrimmedName -keepheader -automated1
done

#Trim header names as RAxML need <60 characters in length:
for Alignment in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/*/*_aligned_trimmed.fasta); do
New=$(dirname $Alignment)/$(basename $Alignment .fasta)_edit.fasta
cat $Alignment  | cut -f1 -d '|'  > $New
done

for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/*/*_edit.fasta); do
while IFS= read -r line; do
    if [[ "$line" =~ ^\>.+ ]]; then
        echo "$line" | wc -c
    fi
done < $file
done

for Alignment in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt/*/*_aligned_trimmed.fasta); do
New=$(dirname $Alignment)/$(basename $Alignment .fasta)_edit.fasta
cat $Alignment  | cut -f1 -d '|'  > $New
done

for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/leo_busco_nt/*/*_edit.fasta); do
while IFS= read -r line; do
    if [[ "$line" =~ ^\>.+ ]]; then
        echo "$line" | wc -c
    fi
done < $file
done

#Run RAxML
#In practice, one should use specialized tools such as ModelTest-NG, IQTree/ModelFinder or PartitionFinder for model selection
conda activate raxml
for Alignment in $(ls /home/theaven/scratch/uncompressed/analysis/phylogeny/busco/busco_nt/*/*_edit.fasta); do
Prefix=$(basename $Alignment | cut -f1 -d '_')
OutDir=/home/theaven/scratch/uncompressed/analysis/phylogeny/busco/mildew_fungi_busco_nt/RAxML/$Prefix
ProgDir=/home/theaven/scratch/apps/phylogeny
mkdir -p $OutDir
Jobs=$(squeue -u theaven| grep 'RAxML'  | wc -l)
while [ $Jobs -gt 99 ]; do
    sleep 300s
    printf "."
    Jobs=$(squeue -u theaven| grep 'RAxML'| wc -l)
done
sbatch $ProgDir/run_RAxML_msa.sh $Alignment $OutDir $Prefix 
done
conda deactivate

conda activate raxml
for Alignment in $(ls /home/theaven/scratch/uncompressed/analysis/phylogeny/busco/leo_busco_nt/*/*_edit.fasta); do
Prefix=$(basename $Alignment | cut -f1 -d '_')
OutDir=/home/theaven/scratch/uncompressed/analysis/phylogeny/busco/mildew_leo_busco_nt/RAxML/$Prefix
ProgDir=/home/theaven/scratch/apps/phylogeny
mkdir -p $OutDir
if [ ! -f ${OutDir}/${Prefix}.raxml.bestTree ]; then
Jobs=$(squeue -u theaven| grep 'RAxML'  | wc -l)
while [ $Jobs -gt 16 ]; do
    sleep 300s
    printf "."
    Jobs=$(squeue -u theaven| grep 'RAxML'| wc -l)
done
model=SYM+I+R9
sbatch $ProgDir/run_RAxML_msa.sh $Alignment $OutDir $Prefix $model 2>&1 >> raxmllog.txt
echo $Prefix >> raxmllog.txt
tail -n 2 raxmllog.txt
else
echo $Prefix already done
fi
done
conda deactivate

conda activate raxml
for Alignment in $(ls /home/theaven/scratch/uncompressed/analysis/phylogeny/busco/leo_busco_nt/*/*_edit.fasta); do
Prefix=$(basename $Alignment | cut -f1 -d '_')
OutDir=/home/theaven/scratch/uncompressed/analysis/phylogeny/busco/mildew_leo_busco_nt/RAxML-2/$Prefix
ProgDir=/home/theaven/scratch/apps/phylogeny
mkdir -p $OutDir
if [ ! -f ${OutDir}/${Prefix}.raxml.bestTree ]; then
Jobs=$(squeue -u theaven| grep 'RAxML'  | wc -l)
while [ $Jobs -gt 63 ]; do
    sleep 300s
    printf "."
    Jobs=$(squeue -u theaven| grep 'RAxML'| wc -l)
done
model=GTR+G
sbatch $ProgDir/run_RAxML_msa.sh $Alignment $OutDir $Prefix $model 2>&1 >> raxmllog2.txt
echo $Prefix >> raxmllog2.txt
tail -n 2 raxmllog.txt
else
echo $Prefix already done
fi
done
conda deactivate


#Combine individual gene trees into a consensus tree:
srun -p medium --mem 64G --cpus-per-task 32 --pty bash
conda activate astral
ProgDir=../apps/astral/Astral/
cat /home/theaven/scratch/uncompressed/analysis/phylogeny/busco/mildew_leo_busco_nt/RAxML/*/*.raxml.bestTree > /home/theaven/scratch/uncompressed/analysis/phylogeny/tree-files.txt
ls /home/theaven/scratch/uncompressed/analysis/phylogeny/busco/mildew_leo_busco_nt/RAxML/*/*.raxml.bootstraps > /home/theaven/scratch/uncompressed/analysis/phylogeny/bs-files.txt
java -Xmx60000M -jar $ProgDir/astral.5.7.8.jar -i /home/theaven/scratch/uncompressed/analysis/phylogeny/tree-files.txt -o /home/theaven/scratch/uncompressed/analysis/phylogeny/leotiomycetes_phylogeny+++.astral.tre
java -Xmx60000M -jar $ProgDir/astral.5.7.8.jar -t 4 -i /home/theaven/scratch/uncompressed/analysis/phylogeny/tree-files.txt -b /home/theaven/scratch/uncompressed/analysis/phylogeny/bs-files.txt -r 100 -o /home/theaven/scratch/uncompressed/analysis/phylogeny/leotiomycetes_phylogeny+++.bootstrapped.astral.tre-4

tail -n 1 /home/theaven/scratch/uncompressed/analysis/phylogeny/leotiomycetes_phylogeny+++.bootstrapped.astral.tre-2 > /home/theaven/scratch/uncompressed/analysis/phylogeny/leotiomycetes_phylogeny+++.bootstrapped.consensus2.astral.tre
head -n 100 /home/theaven/scratch/uncompressed/analysis/phylogeny/leotiomycetes_phylogeny+++.bootstrapped.astral.tre-2 > /home/theaven/scratch/uncompressed/analysis/phylogeny/leotiomycetes_phylogeny+++.bootstraps.astral.tre
java -Xmx60000M -jar $ProgDir/astral.5.7.8.jar -t 32 -q /home/theaven/scratch/uncompressed/analysis/phylogeny/leotiomycetes_phylogeny+++.bootstrapped.consensus2.astral.tre -i /home/theaven/scratch/uncompressed/analysis/phylogeny/leotiomycetes_phylogeny+++.bootstraps.astral.tre -o /home/theaven/scratch/uncompressed/analysis/phylogeny/leotiomycetes_phylogeny+++.bootstrapped.scored2.astral.tre 
java -Xmx60000M -jar $ProgDir/astral.5.7.8.jar -t 32 -i /home/theaven/scratch/uncompressed/analysis/phylogeny/tree-files.txt -q /home/theaven/scratch/uncompressed/analysis/phylogeny/leotiomycetes_phylogeny+++.bootstrapped.consensus2.astral.tre -o /home/theaven/scratch/uncompressed/analysis/phylogeny/leotiomycetes_phylogeny+++.bootstrapped.localposteriorprobabilityscored2.astral.tre 2> astral-scored.log

#OutDir=/home/theaven/scratch/analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/ASTRAL_boot
#mkdir -p $OutDir
#cat analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/RAxML2/*/RAxML_bipartitionsBranchLabels.*  | sed -r "s/CTG.\w+:/:/g" > $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.tre
#java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.tre -o $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.tre | tee 2> $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.log
#java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -q $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.tre -i $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.tre -o $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.scored.tre 2> $OutDir/leotiomycetes_Nd_phylogeny.boot.consensus.scored.log
#ls analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa/RAxML2/*/RAxML_bootstrap.* >  $OutDir/bs-files
#java -Xmx1000M -jar $ProgDir/astral.5.7.8.jar -i $OutDir/leotiomycetes_Nd_phylogeny.boot.appended.tre -b $OutDir/bs-files -r 1000 -o $OutDir/leotiomycetes_Nd_phylogeny.bootstrapped.astral.tre 2> $OutDir/leotiomycetes_Nd_phylogeny.bootstrapped.astral.log

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir
for gene in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/*/*_edit.fasta); do
ln -s $gene /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir/.
done

#Randomly select 100 BUSCO genes and use these for model selection, also select the GTR model as almost certainly best base model
mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-100
ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir/ | shuf -n 100 | xargs -I {} ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir/{} /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-100/{}
mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m MFA -T AUTO --threads-max $cpu
#59524339, 59531606 (all)
#Best-fit model: SYM+I+R9 chosen according to BIC, with 100 only SYM+I+R7 was chosen

#Analysis results written to:
#  IQ-TREE report:                /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir.iqtree
#  Tree used for ModelFinder:     /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir.treefile
#  Screen log file:               /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir.log

mv /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/Psyllidae/analysis/phylogeny/busco_nt/iqtree2-test/.
mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m SYM+I+R9 -B 1000 -T AUTO --threads-max $cpu
#59546091

#Consensus tree written to /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir.contree
#Reading input trees file /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir.contree
#Log-likelihood of consensus tree: -37228500.941

#Analysis results written to:
#  IQ-TREE report:                /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir.iqtree
#  Maximum-likelihood tree:       /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir.treefile
#  Likelihood distances:          /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir.mldist

#Ultrafast bootstrap approximation results written to:
#  Split support values:          /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir.splits.nex
#  Consensus tree:                /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir.contree
#  Screen log file:               /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir.log

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2/.

cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/RAxML2/*/*.raxml.bestTree > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/Psyllidae/analysis/phylogeny/tree-files.txt
ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/RAxML2/*/*.raxml.bestTree > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/Psyllidae/analysis/phylogeny/tree-files2.txt
ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir/*_edit.fasta > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/align-files.txt
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -t /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2/AlignDir.contree --gcf /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/Psyllidae/analysis/phylogeny/tree-files.txt --prefix concord -T 1
#Tree with concordance factors written to concord.cf.tree
#Annotated tree (best viewed in FigTree) written to concord.cf.tree.nex
#Tree with branch IDs written to concord.cf.branch
#Concordance factors per branch printed to concord.cf.stat

singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -te /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2/AlignDir.contree -p /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir/ --scfl 100 --prefix concord2 -T 8
#59546576

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-2
for gene in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/*/*_edit.fasta); do
ln -s $gene /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-2/.
done
mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-2
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-2
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-2
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m JTT+I+G4+F -B 1000 -T AUTO --threads-max $cpu
#1944889

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-2* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-2/.

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-3
for gene in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/*/*_edit.fasta); do
ln -s $gene /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-3/.
done
mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-3
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-3
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-3
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m GTR+G4 -B 1000 -T AUTO --threads-max $cpu
#1944890

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-3* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-3/.




mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-4
for gene in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/leo_busco_nt/*_nt_aligned_trimmed_edit.fasta); do
ln -s $gene /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-4/.
done
mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-4
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-4
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-4
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m JTT+I+G4+F -B 1000 -T AUTO --threads-max $cpu
#2042821

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-4* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-4/.

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-5
for gene in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/leo_busco_nt/*_nt_aligned_trimmed_edit.fasta); do
ln -s $gene /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-5/.
done
mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-5
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-5
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-5
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m GTR+G4 -B 1000 -T AUTO --threads-max $cpu
#2042814

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-5* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-5/.

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-6
for gene in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/leo_busco_nt/*_nt_aligned_trimmed_edit.fasta); do
ln -s $gene /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-6/.
done
mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-6
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-6
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-6
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m SYM+I+R9 -B 1000 -T AUTO --threads-max $cpu
#2042808

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-6* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-6/.


mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-7
for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-3/*_nt_aligned_trimmed_edit.fasta); do
    x=$(grep '>' "$file" | wc -l)
    if [ "$x" -gt 69 ]; then
        count=$((count + 1))
        ln -s $file /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-7/.
      else
        echo "$file"
        echo $x
    fi
done

echo "Number of files with 70 or more sequences: $count" #716

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-7
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-7
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-7
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m SYM+I+R9 -B 1000 -T AUTO --threads-max $cpu
#2042796

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-7* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-7/.



mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-8
count=0
for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/leo_busco_nt/*_nt_aligned_trimmed_edit.fasta); do
    x=$(grep '>' "$file" | wc -l)
    if [ "$x" -gt 63 ]; then
        count=$((count + 1))
        ln -s $file /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-8/.
      else
        echo "$file"
        echo $x
    fi
done

echo "Number of files with 64 (the number of leotiomycetes) or more sequences: $count" #2442

cp -r /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-8 /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-9
cp -r /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-8 /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-10

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-8
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-8
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-8
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m JTT+I+G4+F -B 1000 -T AUTO --threads-max $cpu
#2042785

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-8* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-8/.

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-9
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-9
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-9
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m SYM+I+R9 -B 1000 -T AUTO --threads-max $cpu
#2042771

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-9* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-9/.

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-10
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-10
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-10
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m GTR+G4 -B 1000 -T AUTO --threads-max $cpu
#2042747

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-10* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-10/.


singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/python3.sif python3 ~/git_repos/Scripts/NBI/collpse_newick_single_node_leaves.py /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/trimmed-6.txt /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/trimmed-6.tree
nano /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-6/AlignDir-6.iqtree #3926774 sites
source package /nbi/software/testing/bin/r8s-1.80
echo "#NEXUS" > r8s_ctl_file-m.txt
echo "begin trees;" >> r8s_ctl_file-m.txt
#echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/orthology/orthofinder/All_mildew-ara/formatted/orthofinder52000-7/Results_all_mildew/Species_Tree/SpeciesTree_rooted-rerooted.txt)" >> r8s_ctl_file-m.txt
echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/trimmed-6.tree)" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt
echo "begin rates;" >> r8s_ctl_file-m.txt
echo "blformat nsites=3926774 lengths=persite ultrametric=no;" >> r8s_ctl_file-m.txt
echo "collapse;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_1 BLU_HOR_GCA_900237765.1 POD_APH_DRCT72020;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_2 BLU_HOR_GCA_900237765.1 PAR_POL_PARPO1;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_3 BLU_HOR_GCA_900237765.1 BLU_HOR_GCA_900519115.1;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_4 ERY_NEC_GCA_000798795.1 GOL_CIC_GCA_003611215.1;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_5 ERY_NEC_GCA_000798795.1 BLU_HOR_GCA_900237765.1;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_1 min_age=75.0 max_age=75.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_2 min_age=79.0 max_age=79.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_3 min_age=0.01 max_age=11.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_4 min_age=57.0 max_age=57.0;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_5 min_age=53.2 max_age=75.0;" >> r8s_ctl_file-m.txt
echo "divtime method=lf algorithm=tn cvStart=0 cvInc=0.5 cvNum=8 crossv=yes;" >> r8s_ctl_file-m.txt
echo "describe plot=chronogram;" >> r8s_ctl_file-m.txt
echo "describe plot=tree_description;" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt

r8s -b -f r8s_ctl_file-m.txt > temp_r8s-m.txt
tail -n 1 temp_r8s-m.txt > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/trimmed-6-r8s.tree

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-11
for gene in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/leo_busco_nt/*_nt_aligned_trimmed_edit.fasta); do
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/python3.sif python3 ~/git_repos/Scripts/NBI/seq_get.py --id_file temp.txt --input $gene --output /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-11/$(basename $gene)
done
for gene in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-11/*_nt_aligned_trimmed_edit.fasta); do
x=$(grep '>' $gene | wc -l)
if [ ! "$x" -gt 2 ]; then
    rm "$gene"
fi
done #25 removed, 3,207 remaining
mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-11
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-11
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-11
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m JTT+I+G4+F -B 1000 -T AUTO --threads-max $cpu
#2059447

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-11* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-11/.

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-12
for gene in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-11/*_nt_aligned_trimmed_edit.fasta); do
ln -s $gene /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-12/.
done
mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-12
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-12
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-12
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m GTR+G4 -B 1000 -T AUTO --threads-max $cpu
#2059448

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-12* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-12/.

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-13
for gene in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-11/*_nt_aligned_trimmed_edit.fasta); do
ln -s $gene /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-13/.
done
mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-13
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-13
AlignDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-13
cpu=32
singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/iqtree_2.3.0.sif iqtree2 -s $AlignDir -m SYM+I+R9 -B 1000 -T AUTO --threads-max $cpu
#2059449

cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/AlignDir-13* /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-13/.

singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/python3.sif python3 ~/git_repos/Scripts/NBI/collpse_newick_single_node_leaves.py /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/trimmed-6.txt /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/ortho/analysis/cafe/trimmed-6.tree
nano /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-11/AlignDir-11.iqtree #2580589 sites
nano /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-12/AlignDir-12.iqtree #2580589
nano /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/iqtree2-13/AlignDir-13.iqtree #2580589
source package /nbi/software/testing/bin/r8s-1.80
echo "#NEXUS" > r8s_ctl_file-m.txt2
echo "begin trees;" >> r8s_ctl_file-m.txt2
echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/13.txt)" >> r8s_ctl_file-m.txt2
echo "end;" >> r8s_ctl_file-m.txt2
echo "begin rates;" >> r8s_ctl_file-m.txt2
echo "blformat nsites=2580589 lengths=persite ultrametric=no;" >> r8s_ctl_file-m.txt2
echo "collapse;" >> r8s_ctl_file-m.txt2
#echo "mrca callibration_node_1 BLU_HOR_GCA_900237765.1 POD_APH_DRCT72020;" >> r8s_ctl_file-m.txt2
echo "mrca callibration_node_2 BLU_HOR_GCA_900237765.1 PAR_POL_PARPO1;" >> r8s_ctl_file-m.txt2
#echo "mrca callibration_node_3 BLU_HOR_GCA_900237765.1 BLU_HOR_GCA_900519115.1;" >> r8s_ctl_file-m.txt2
#echo "mrca callibration_node_4 ERY_NEC_GCA_000798795.1 GOL_CIC_GCA_003611215.1;" >> r8s_ctl_file-m.txt2
#echo "mrca callibration_node_5 ERY_NEC_GCA_000798795.1 BLU_HOR_GCA_900237765.1;" >> r8s_ctl_file-m.txt2
#echo "constrain taxon=callibration_node_1 min_age=75.0 max_age=75.0;" >> r8s_ctl_file-m.txt2
echo "constrain taxon=callibration_node_2 min_age=79.0 max_age=79.0;" >> r8s_ctl_file-m.txt2
#echo "constrain taxon=callibration_node_3 min_age=0.01 max_age=11.0;" >> r8s_ctl_file-m.txt2
#echo "constrain taxon=callibration_node_4 min_age=57.0 max_age=57.0;" >> r8s_ctl_file-m.txt2
#echo "constrain taxon=callibration_node_5 min_age=53.2 max_age=75.0;" >> r8s_ctl_file-m.txt2
echo "divtime method=pl algorithm=tn cvStart=0 cvInc=0.5 cvNum=25 crossv=yes;" >> r8s_ctl_file-m.txt2
echo "describe plot=chronogram;" >> r8s_ctl_file-m.txt2
echo "describe plot=tree_description;" >> r8s_ctl_file-m.txt2
echo "end;" >> r8s_ctl_file-m.txt2

r8s -b -f r8s_ctl_file-m.txt2 > temp_r8s-m.txt2
```
#### R8s
Making the species tree ultrametric CAFE requires a tree that is ultramatric. There are many ways to obtain ultrametric trees (also known as timetrees, these are phylogenetic trees scaled to time, where all paths from root to tips have the same length). Here, we use a fast program called r8s. You will need to know the number of sites in the alignment used to estimate the species tree (the one you want to make ultrametric), and then you can specify one or more calibration points (ideally, the age or age window of a documented fossil) to scale branch lengths into time units. We provide you with a script that prepares the control file for running r8s on the species tree above (the number of sites is 35157236, and the calibration point for cats and humans is 94). In your shell, type:

```bash
source package /nbi/software/testing/bin/r8s-1.80

echo "#NEXUS" > r8s_ctl_file-m.txt
echo "begin trees; " >> r8s_ctl_file-m.txt
#echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/mildew-iq-reroot.txt)" >> r8s_ctl_file-m.txt
echo "tree hemiptera_tree = [&R] $(cat /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/mildew-tree.txt)" >> r8s_ctl_file-m.txt
echo "End;" >> r8s_ctl_file-m.txt
echo "begin rates;" >> r8s_ctl_file-m.txt
echo "blformat nsites=3121748 lengths=persite ultrametric=no;" >> r8s_ctl_file-m.txt
echo "collapse;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_1 BLU_GRA_GCA_000417025.1 ERY_PIS_GCA_000208805.1;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_2 POD_APH_DRCT72020 ERY_PIS_GCA_000208805.1;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_3 POD_APH_DRCT72020 BOT_CIN_GCA_000143535.4;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_4 POD_APH_DRCT72020 FUS_OXY_GCF_013085055.1;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_5 POD_APH_DRCT72020 TUB_MEL_GCF_000151645.1;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_6 TUB_MEL_GCF_000151645.1 UST_MAY_GCA_000328475.2;" >> r8s_ctl_file-m.txt
echo "mrca callibration_node_7 PUC_GRA_GCA_000149925.1 UST_MAY_GCA_000328475.2;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_1 min_age=53.2 max_age=75;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_2 min_age=53.2 max_age=75;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_3 min_age=131.4 max_age=222;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_4 min_age=239.7 max_age=320;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_5 min_age=387.7 max_age=723;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_6 min_age=583.2 max_age=749;" >> r8s_ctl_file-m.txt
echo "constrain taxon=callibration_node_7 min_age=428.4 max_age=551;" >> r8s_ctl_file-m.txt
echo "divtime method=pl algorithm=tn cvStart=0 cvInc=0.5 cvNum=8 crossv=yes;" >> r8s_ctl_file-m.txt
echo "describe plot=chronogram;" >> r8s_ctl_file-m.txt
echo "describe plot=tree_description;" >> r8s_ctl_file-m.txt
echo "end;" >> r8s_ctl_file-m.txt

r8s -b -f r8s_ctl_file-m.txt > temp_r8s-m.txt
#tail -n 1 temp_r8s-m.txt | cut -c 16- > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/iqtree_rerooted_r8s.txt
tail -n 1 temp_r8s-m.txt | cut -c 16- > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/mildew-tree_r8s.txt
```
```bash
ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/*_final_genes_renamed.pep.fasta > existing_protein_files.txt


for assembly in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/*a); do
  mkdir $(dirname $assembly)/braker2_prothint
done

ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/Am_c_GCA_003019875_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Amorphotheca/resinae/GCA_003019875.1/braker2_prothint/Amo_res_GCA_003019875.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/Am_c_GCA_018167515_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Amorphotheca/resinae/GCA_018167515.1/braker2_prothint/Amo_res_GCA_018167515.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/Ar_a_GCA_003988855_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Arachnopeziza/araneosa/GCA_003988855.1/braker2_prothint/Ara_ara_GCA_003988855.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/A_s_GCA_000328965_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Ascocoryne/sarcoides/GCA_000328965.1/braker2_prothint/Asc_sar_GCA_000328965.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/B_g_GCA_000417025_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Blumeria/graminis/GCA_000417025.1/braker2_prothint/Blu_gra_GCA_000417025.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/B_g_GCA_000417865_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Blumeria/graminis/GCA_000417865.1/braker2_prothint/Blu_gra_GCA_000417865.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/B_g_GCA_000418435_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Blumeria/graminis/GCA_000418435.1/braker2_prothint/Blu_gra_GCA_000418435.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/B_g_GCA_000441875_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Blumeria/graminis/GCA_000441875.1/braker2_prothint/Blu_gra_GCA_000441875.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/B_g_GCA_900519115_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Blumeria/hordei/GCA_900519115.1/braker2_prothint/Blu_hor_GCA_900519115.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/B_g_GCA_905067625_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Blumeria/graminis-triticale/GCA_905067625.1/braker2_prothint/Blu_gra_GCA_905067625.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/B_h_GCA_000401675_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Blumeria/hordei/GCA_000401675.1/braker2_prothint/Blu_hor_GCA_000401675.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/B_h_GCA_900237765_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Blumeria/hordei/GCA_900237765.1/braker2_prothint/Blu_hor_GCA_900237765.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/B_h_GCA_900239735_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Blumeria/hordei/GCA_900239735.1/braker2_prothint/Blu_hor_GCA_900239735.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/B_h_GCA_900638725_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Blumeria/hordei/GCA_900638725.1/braker2_prothint/Blu_hor_GCA_900638725.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/C_a_GCA_002276475_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Chlorociboria/aeruginascens/GCA_002276475.2/braker2_prothint/Chl_aer_GCA_002276475.2_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/D_b_GCA_000298775_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Drepanopeziza/brunnea/GCF_000298775.1/braker2_prothint/Dre_bru_GCF_000298775.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/E_alph_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Erysiphe/alphitoides/CLCBIO_7.0.3/braker2_prothint/Ery_alp_CLCBIO_7.0.3_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/E_neca_GCA_000798715_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Erysiphe/necator/GCA_000798715.1/braker2_prothint/Ery_nec_GCA_000798715.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/E_neca_GCA_000798735_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Erysiphe/necator/GCA_000798735.1/braker2_prothint/Ery_nec_GCA_000798735.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/E_neca_GCA_000798755_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Erysiphe/necator/GCA_000798755.1/braker2_prothint/Ery_nec_GCA_000798755.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/E_neca_GCA_000798775_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Erysiphe/necator/GCA_000798775.1/braker2_prothint/Ery_nec_GCA_000798775.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/E_neca_GCA_000798795_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Erysiphe/necator/GCA_000798795.1/braker2_prothint/Ery_nec_GCA_000798795.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/E_neca_GCA_016906895_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Erysiphe/necator/GCA_016906895.2/braker2_prothint/Ery_nec_GCA_016906895.2_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/E_neol_GCA_003610855_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Erysiphe/neolycopersici/GCA_003610855.1/braker2_prothint/Ery_neo_GCA_003610855.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/E_pi_GCA_000208805_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Erysiphe/pisi/GCA_000208805.1/braker2_prothint/Ery_pis_GCA_000208805.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/E_pi_GCA_000214055_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Erysiphe/pisi/GCA_000214055.1/braker2_prothint/Ery_pis_GCA_000214055.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/E_pu_GCA_002918395_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Erysiphe/pulchra/GCA_002918395.1/braker2_prothint/Ery_pul_GCA_002918395.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/G_c_GCA_003611195_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Golovinomyces/cichoracearum/GCA_003611195.1/braker2_prothint/Gol_cic_GCA_003611195.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/G_c_GCA_003611215_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Golovinomyces/cichoracearum/GCA_003611215.1/braker2_prothint/Gol_cic_GCA_003611215.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/G_c_GCA_003611235_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Golovinomyces/cichoracearum/GCA_003611235.1/braker2_prothint/Gol_cic_GCA_003611235.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/Gl_i_GCA_000409485_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Glarea/lozoyensis/GCF_000409485.1/braker2_prothint/Gla_loz_GCF_000409485.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/G_m_GCA_006912115_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Golovinomyces/magnicellulatus/GCA_006912115.1/braker2_prothint/Gol_mag_GCA_006912115.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/G_o_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Golovinomyces/orontii/MGH1/braker2_prothint/Gol_oro_MGH1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/L_t_CADEPA01_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Leveillula/taurica/CADEPA01/braker2_prothint/Lev_tau_CADEPA01_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/M_s_GCA_001500285_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Mollisia/scopiformis/GCF_001500285.1/braker2_prothint/Mol_sco_GCF_001500285.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/N_a_GCA_003988965_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Neobulgaria/alba/GCA_003988965.1/braker2_prothint/Neo_alb_GCA_003988965.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/O_h_GCA_003957845_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Erysiphe/quercicola/GCA_003957845.1/braker2_prothint/Ery_que_GCA_003957845.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/Oi_m_GCA_000827325_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Oidiodendron/maius/GCA_000827325.1/braker2_prothint/Oid_mai_GCA_000827325.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/P_a_frg2020_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Podosphaera/aphanis/DRCT72020/braker2_prothint/Pod_aph_DRCT72020_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/P_a_frg2021_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Podosphaera/aphanis/DRCT72021/braker2_prothint/Pod_aph_DRCT72021_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/P_a_rub2020_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Podosphaera/aphanis/SCOTT2020/braker2_prothint/Pod_aph_SCOTT2020_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/P_c_GCA_018398735_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Podosphaera/cerasi/GCA_018398735.1/braker2_prothint/Pod_cer_GCA_018398735.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/Phi_s-GCA_900073065_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Phialocephala/subalpina/GCA_900073065.1/braker2_prothint/Phi_sub_GCA_900073065.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/Phy_m_GCA_019455665_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Phyllactinia/moricola/GCA_019455665.1/braker2_prothint/Phy_mor_GCA_019455665.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/P_l2019_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Podosphaera/leucotricha/P112019/braker2_prothint/Pod_leu_P112019_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/P_l2020_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Podosphaera/leucotricha/OGB2020/braker2_prothint/Pod_leu_OGB2020_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/P_l2021_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Podosphaera/leucotricha/OGB2021/braker2_prothint/Pod_leu_OGB2021_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/P_l_ganan_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Podosphaera/leucotricha/GCA_013170925.1/braker2_prothint/Pod_leu_GCA_013170925.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/Pl_s_GCA_019455505_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Pleochaeta/shiraiana/GCA_019455505.1/braker2_prothint/Ple_shi_GCA_019455505.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/P_x_GCA_010015925_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Podosphaera/xanthii/GCA_010015925.1/braker2_prothint/Pod_xan_GCA_010015925.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/P_x_GCA_014884795_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Podosphaera/xanthii/GCA_014884795.1/braker2_prothint/Pod_xan_GCA_014884795.1_final_genes_renamed.pep.fasta
ln -s /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/Scereviseae_GCF_000146045_final_genes_renamed.pep.fasta /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Saccharomyces/cerevisiae/GCF_001500285.1/braker2_prothint/Sac_cer_GCF_001500285.1_final_genes_renamed.pep.fasta

for assembly in /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/*a; do
  peptide_file=$(ls $(dirname "$assembly")/braker2_prothint/*_final_genes_renamed.pep.fasta)
  Dir=$(echo $assembly | cut -d '/' -f9,10,11)
  if [[ ! -f $peptide_file ]]; then
    echo "no peptides for $assembly"
    mkdir -p temp_genomes/$Dir
    cp $assembly temp_genomes/$Dir/.
  fi
done

for Genome in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/temp_genomes/Parauncinula/*/*/*a); do
OutFile=$(basename $Genome | sed 's@.fa@@g')
OutDir=$(dirname $Genome)/repeatmodeler
ProgDir=~/git_repos/Wrappers/NBI
mkdir $OutDir
sbatch $ProgDir/run_repeatmodeler.sh $Genome $OutFile $OutDir
done
#58170701, 58940849

for Genome in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/temp_genomes/Parauncinula/*/*/*a); do
Species=$(echo $Genome | cut -d '/' -f9,10 | sed 's@/@_@g')
Repeat_library=$(ls $(dirname $Genome)/repeatmodeler/*/consensi.fa.classified)
OutFile=$(basename $Genome | sed 's@.fa@@g')
OutDir=$(dirname $Genome)/repeatmasker
ProgDir=~/git_repos/Wrappers/NBI
mkdir $OutDir
sbatch $ProgDir/run_repeatmasker4.1.5.sh $Genome $OutFile $OutDir $Species $Repeat_library
done
#58734862-58734887, 58941051

for Dir in $(ls -d /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/temp_genomes/*/*/*/repeatmasker/); do
path=$(echo $Dir | cut -d '/' -f9,10,11)
ls ${Dir}hardmask/*.fna.out.gff
ls ${Dir}softmask/*.fna.masked
mkdir -p temp_download/${path}
cp ${Dir}hardmask/*.fna.out.gff temp_download/${path}/.
cp ${Dir}softmask/*.fna.masked temp_download/${path}/.
done

#move to gruffalo

screen -S repeats

conda activate transposonpsi
for assembly in $(ls temp_genomes/*/*/*/*na); do
    ID=$(echo $assembly | cut -d '/' -f2 | cut -c 1-3)_$(echo $assembly | cut -d '/' -f3 | cut -c 1-3)_$(echo $assembly | cut -d '/' -f4)
    echo $ID
    ProgDir=~/scratch/apps/repeat_masking
    #ProgDir=~/git_repos/tools/seq_tools/repeat_masking
    OutDir=$(dirname $assembly)/transposonpsi
    mkdir -p $OutDir
    if [[ ! -f ${OutDir}/formatdb.log ]]; then
    echo missing for $ID
    sbatch $ProgDir/gomez_transposonPSI.sh $assembly $OutDir $ID
    else 
    echo done for $ID
    fi
done
conda deactivate
#16614879-85, 16619084-5, 17931618, 17931637

conda activate bedtools
#Merge the masking:
for Assembly in $(ls temp_genomes/*/*/*/*.f*); do
    ID=$(dirname $Assembly | cut -d '/' -f2,3,4)
File=$(ls temp_download/$ID/*.fna.masked)
OutDir=$(dirname $Assembly)/repeatmasking/combined
TPSI=$(ls temp_genomes/${ID}/transposonpsi/*allHits.chains.gff3)
OutFile=${OutDir}/$(basename $File | sed 's/.fna.masked/_contigs_softmasked_repeatmasker_TPSI_appended.fa/g')
if [[ ! -f ${OutFile} ]]; then
if [[ -f ${TPSI} && -f ${File} ]]; then
mkdir -p $OutDir
echo "$OutFile"
bedtools maskfasta -soft -fi $File -bed $TPSI -fo ${OutFile}
No=$(cat $OutFile | grep -v '>' | tr -d '\n' | wc -c)
No2=$(cat $OutFile | grep -v '>' | tr -d '\n' | awk '{print $0, gsub("[a-z]", ".")}' | cut -f2 -d ' ')
echo $ID >> mildews/combinedrepeatreport.txt
echo "Number of bases:" >> mildews/combinedrepeatreport.txt
echo $No >> mildews/combinedrepeatreport.txt
echo "Number of masked bases:" >> mildews/combinedrepeatreport.txt
echo $No2 >> mildews/combinedrepeatreport.txt
echo "% of masked bases:" >> mildews/combinedrepeatreport.txt
echo "100/$No*$No2" | bc -l >> mildews/combinedrepeatreport.txt
printf "\n" >> mildews/combinedrepeatreport.txt
else 
echo "inputs missing for $ID"
fi
else
echo "already run for $ID"
fi 
done
conda deactivate


conda activate braker
for assembly in $(ls temp_genomes/*/*/*/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
  ID=$(echo $assembly | cut -d '/' -f2 | cut -c 1-3)_$(echo $assembly | cut -d '/' -f3 | cut -c 1-3)_$(echo $assembly | cut -d '/' -f4)
  OutDir=mildews/${ID}/gene_pred/prothint
  ProgDir=/home/theaven/scratch/apps/braker
  if [[ ! -f ${OutDir}/prothint.gff ]]; then
  if [[ -f ${assembly} ]]; then
    echo "running for $ID"
  sbatch $ProgDir/prothint_fungi.sh $assembly $OutDir
  else 
  echo "inputs missing for $ID"
  fi
  else
  echo "already run for $ID"
  fi 
done
#17883503,17885380-97,17936567,17999831
conda deactivate

conda activate braker
for Assembly in $(ls /home/theaven/scratch/uncompressed/genomes/Sclerotinia/sclerotiorum/GCF_000146945.1/fcs/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
  ID=$(echo $Assembly | cut -d '/' -f7 | cut -c 1-3)_$(echo $Assembly | cut -d '/' -f8 | cut -c 1-3)_$(echo $Assembly | cut -d '/' -f9)
  echo $ID
  OutDir=/home/theaven/scratch/uncompressed/genomes/Sclerotinia/sclerotiorum/GCF_000146945.1/fcs/gene_pred/braker2
  GeneModelName=${ID}_genemodels4
  Hintfile=/home/theaven/scratch/uncompressed/genomes/Sclerotinia/sclerotiorum/GCF_000146945.1/fcs/gene_pred/prothint/prothint_augustus.gff
  ProgDir=/home/theaven/scratch/apps/braker
  if [[ ! -f ${OutDir}/braker.gff3 ]]; then
  if [[ -f ${Hintfile} ]]; then
    echo "running for $ID"
    mkdir -p $OutDir
  sbatch $ProgDir/braker_fungi_noRNA.sh $Assembly $OutDir $GeneModelName $Hintfile
  else 
  echo "inputs missing for $ID"
  fi
  else
  echo "already run for $ID"
  fi 
done #19242548-19242574
#19320471-2
#19323176
conda deactivate

for job in $(ls -d braker/* | cut -d '/' -f2 | cut -d '_' -f2); do
file=slurm-${job}.out
#echo $job
head -n 1 $file
sacct -j $job --format=JobID,JobName,ReqMem,MaxRSS,TotalCPU,AllocCPUS,Elapsed,State,ExitCode,Ntasks,NCPUS,User | head -n 3 | tail -n 1
done

cp -r braker/theaven_19242587/braker/* mildews/Blu_gra_GCA_000151065.3/gene_pred/braker/.  
cp -r braker/theaven_19242588/braker/* mildews/Blu_gra_SRR2153116/gene_pred/braker/.    
cp -r braker/theaven_19242589/braker/* mildews/Blu_gra_SRR2153117/gene_pred/braker/.     
cp -r braker/theaven_19242590/braker/* mildews/Blu_gra_SRR2153118/gene_pred/braker/. 
cp -r braker/theaven_19242591/braker/* mildews/Blu_gra_SRR2153119/gene_pred/braker/.         
cp -r braker/theaven_19242592/braker/* mildews/Blu_gra_SRR2153120/gene_pred/braker/.         
cp -r braker/theaven_19242593/braker/* mildews/Bot_cin_GCA_000143535.4/gene_pred/braker/.        
cp -r braker/theaven_19242594/braker/* mildews/Col_hig_broad_KN1394/gene_pred/braker/.         
cp -r braker/theaven_19242595/braker/* mildews/Cop_cin_GCA_000182895.1/gene_pred/braker/.        
cp -r braker/theaven_19242596/braker/* mildews/Cry_neo_GCF_000091045.1/gene_pred/braker/.        
cp -r braker/theaven_19242597/braker/* mildews/Ery_nec_GCA_024703715.1/gene_pred/braker/.       
cp -r braker/theaven_19242598/braker/* mildews/Fus_gra_GCA_000240135.3/gene_pred/braker/.     
cp -r braker/theaven_19242599/braker/* mildews/Fus_oxy_GCF_013085055.1/gene_pred/braker/.        
cp -r braker/theaven_19242600/braker/* mildews/Mag_ory_GCF_000002495.2/gene_pred/braker/.       
cp -r braker/theaven_19242601/braker/* mildews/Par_pol_Parp01/gene_pred/braker/.        
cp -r braker/theaven_19242602/braker/* mildews/Ple_ost_GCA_014466165.1/gene_pred/braker/.       
cp -r braker/theaven_19242603/braker/* mildews/Pod_fus_GCA_030378345.1/gene_pred/braker/.     
cp -r braker/theaven_19242604/braker/* mildews/Pod_xan_GCA_028751805.1/gene_pred/braker/.       
cp -r braker/theaven_19242605/braker/* mildews/Psi_cub_GCA_017499595.2/gene_pred/braker/.       
cp -r braker/theaven_19242606/braker/* mildews/Puc_gra_GCA_000149925.1/gene_pred/braker/.       
cp -r braker/theaven_19242607/braker/* mildews/Puc_str_GCA_021901695.1/gene_pred/braker/.       
cp -r braker/theaven_19242608/braker/* mildews/Puc_tri_GCA_000151525.2/gene_pred/braker/.        
cp -r braker/theaven_19242609/braker/* mildews/Sch_com_GCA_000143185.2/gene_pred/braker/.       
cp -r braker/theaven_19242610/braker/* mildews/Scl_scl_GCA_000146945.2/gene_pred/braker/.       
cp -r braker/theaven_19242613/braker/* mildews/Ust_may_GCA_000328475.2/gene_pred/braker/.       

cp -r other/Melampsoralaricis-populina_GCA_000204055.1/gene_pred /home/theaven/scratch/uncompressed/mildews/Melampsoralaricis-populina_GCA_000204055.1/.
cp -r other/Neurosporacrassa_GCA_000182925.2/gene_pred /home/theaven/scratch/uncompressed/mildews/Neurosporacrassa_GCA_000182925.2/.
cp -r other/Pyriculariaoryzae_GCA_000002495.2/gene_pred /home/theaven/scratch/uncompressed/mildews/Pyriculariaoryzae_GCA_000002495.2/. 
cp -r other/Aspergillusnidulans_GCA_000149205.2/gene_pred /home/theaven/scratch/uncompressed/mildews/Aspergillusnidulans_GCA_000149205.2/.

cp -r other/Sclerotiniasclerotiorum_GCA_000146945.2/gene_pred /home/theaven/scratch/uncompressed/mildews/Sclerotiniasclerotiorum_GCA_000146945.2/.
cp -r other/Pucciniagraminis_GCA_000149925.1/gene_pred /home/theaven/scratch/uncompressed/mildews/Pucciniagraminis_GCA_000149925.1/.
cp -r other/Colletotrichumhigginsianum_GCA_001672515.1/gene_pred /home/theaven/scratch/uncompressed/mildews/Colletotrichumhigginsianum_GCA_001672515.1/.

ln -s temp_genomes/Blumeria/graminis/GCA_000151065.3/repeatmasking /home/theaven/scratch/uncompressed/mildews/Blu_gra_GCA_000151065.3/. 
ln -s temp_genomes/Blumeria/graminis-secale/SRR2153116/repeatmasking /home/theaven/scratch/uncompressed/mildews/Blu_gra_SRR2153116/.
ln -s temp_genomes/Blumeria/graminis-secale/SRR2153117/repeatmasking /home/theaven/scratch/uncompressed/mildews/Blu_gra_SRR2153117/.
ln -s temp_genomes/Blumeria/graminis-secale/SRR2153118/repeatmasking /home/theaven/scratch/uncompressed/mildews/Blu_gra_SRR2153118/.
ln -s temp_genomes/Blumeria/graminis-secale/SRR2153119/repeatmasking /home/theaven/scratch/uncompressed/mildews/Blu_gra_SRR2153119/.
ln -s temp_genomes/Blumeria/graminis-secale/SRR2153120/repeatmasking /home/theaven/scratch/uncompressed/mildews/Blu_gra_SRR2153120/.
ln -s temp_genomes/Botrytis/cineria/GCA_000143535.4/repeatmasking /home/theaven/scratch/uncompressed/mildews/Bot_cin_GCA_000143535.4/.
ln -s temp_genomes/Colletotrichum/higginsianum/broad_KN1394/repeatmasking /home/theaven/scratch/uncompressed/mildews/Col_hig_broad_KN1394/.
ln -s temp_genomes/Coprinus/cinereus/GCA_000182895.1/repeatmasking /home/theaven/scratch/uncompressed/mildews/Cop_cin_GCA_000182895.1/.
ln -s temp_genomes/Cryptococcus/neoformans/GCF_000091045.1/repeatmasking /home/theaven/scratch/uncompressed/mildews/Cry_neo_GCF_000091045.1/.
ln -s temp_genomes/Erysiphe/necator/GCA_024703715.1/repeatmasking /home/theaven/scratch/uncompressed/mildews/Ery_nec_GCA_024703715.1/.
ln -s temp_genomes/Fusarium/graminearum/GCA_000240135.3/repeatmasking /home/theaven/scratch/uncompressed/mildews/Fus_gra_GCA_000240135.3/.
ln -s temp_genomes/Fusarium/oxysporum/GCF_013085055.1/repeatmasking /home/theaven/scratch/uncompressed/mildews/Fus_oxy_GCF_013085055.1/.
ln -s temp_genomes/Magnaporthe/oryzae/GCF_000002495.2/repeatmasking /home/theaven/scratch/uncompressed/mildews/Mag_ory_GCF_000002495.2/.
ln -s temp_genomes/Parauncinula/polyspora/Parp01/repeatmasking /home/theaven/scratch/uncompressed/mildews/Par_pol_Parp01/.
ln -s temp_genomes/Pleurotus/ostreatus/GCA_014466165.1/repeatmasking /home/theaven/scratch/uncompressed/mildews/Ple_ost_GCA_014466165.1/.
ln -s temp_genomes/Podosphaera/fusca/GCA_030378345.1/repeatmasking /home/theaven/scratch/uncompressed/mildews/Pod_fus_GCA_030378345.1/.
ln -s temp_genomes/Podosphaera/xanthii/GCA_028751805.1/repeatmasking /home/theaven/scratch/uncompressed/mildews/Pod_xan_GCA_028751805.1/.
ln -s temp_genomes/Psilocybe/cubensis/GCA_017499595.2/repeatmasking /home/theaven/scratch/uncompressed/mildews/Psi_cub_GCA_017499595.2/.
ln -s temp_genomes/Puccinia/graminis/GCA_000149925.1/repeatmasking /home/theaven/scratch/uncompressed/mildews/Puc_gra_GCA_000149925.1/.
ln -s temp_genomes/Puccinia/striiformis/GCA_021901695.1/repeatmasking /home/theaven/scratch/uncompressed/mildews/Puc_str_GCA_021901695.1/.
ln -s temp_genomes/Puccinia/triticina/GCA_000151525.2/repeatmasking /home/theaven/scratch/uncompressed/mildews/Puc_tri_GCA_000151525.2/.
ln -s temp_genomes/Schizophyllum/commune/GCA_000143185.2/repeatmasking /home/theaven/scratch/uncompressed/mildews/Sch_com_GCA_000143185.2/.
ln -s temp_genomes/Scleotinia/sclerotiorum/GCA_000146945.2/repeatmasking /home/theaven/scratch/uncompressed/mildews/Scl_scl_GCA_000146945.2/.
ln -s temp_genomes/Scleotinia/sclerotiorum/GCF_000146945.1/repeatmasking /home/theaven/scratch/uncompressed/mildews/Scl_scl_GCF_000146945.1/.
ln -s temp_genomes/Tuber/melanosporum/GCF_000151645.1/repeatmasking /home/theaven/scratch/uncompressed/mildews/Tub_mel_GCF_000151645.1/.
ln -s temp_genomes/Ustilago/maydis/GCA_000328475.2/repeatmasking /home/theaven/scratch/uncompressed/mildews/Ust_may_GCA_000328475.2/.

mv /home/theaven/scratch/uncompressed/mildews/amorphothecaresinae_GCA_003019875/gene_pred /home/theaven/scratch/uncompressed/genomes/Amorphotheca/resinae/GCA_003019875.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/amorphothecaresinae_GCA_003019875/repeatmasking /home/theaven/scratch/uncompressed/genomes/Amorphotheca/resinae/GCA_003019875.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Amorphothecaresinae_GCA_018167515/gene_pred /home/theaven/scratch/uncompressed/genomes/Amorphotheca/resinae/GCA_018167515.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Amorphothecaresinae_GCA_018167515/repeatmasking /home/theaven/scratch/uncompressed/genomes/Amorphotheca/resinae/GCA_018167515.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/arachnopezizaaraneosa_GCA_003988855/gene_pred /home/theaven/scratch/uncompressed/genomes/Arachnopeziza/araneosa/GCA_003988855.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/arachnopezizaaraneosa_GCA_003988855/repeatmasking /home/theaven/scratch/uncompressed/genomes/Arachnopeziza/araneosa/GCA_003988855.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/ascocorynesarcoides_GCA_000328965/gene_pred /home/theaven/scratch/uncompressed/genomes/Ascocoryne/sarcoides/GCA_000328965.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/ascocorynesarcoides_GCA_000328965/repeatmasking /home/theaven/scratch/uncompressed/genomes/Ascocoryne/sarcoides/GCA_000328965.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Aspergillusnidulans_GCA_000149205.2/gene_pred /home/theaven/scratch/uncompressed/genomes/Aspergillus/nidulans/GCA_000149205.2/fcs/
mv other/Aspergillusnidulans_GCA_000149205.2/repeatmasking /home/theaven/scratch/uncompressed/genomes/Aspergillus/nidulans/GCA_000149205.2/fcs/

mv temp_genomes/Blumeria/graminis/GCA_000151065.3/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000151065.3/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Blu_gra_GCA_000151065.3/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000151065.3/fcs/
 
mv /home/theaven/scratch/uncompressed/mildews/Blumeriagraminis_GCA_000417025/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000417025.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Blumeriagraminis_GCA_000417025/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000417025.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blumeriagraminis_GCA_000417865/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000417865.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Blumeriagraminis_GCA_000417865/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000417865.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blumeriagraminis_GCA_000418435/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000418435.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Blumeriagraminis_GCA_000418435/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000418435.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blumeriagraminis_GCA_000441875/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000441875.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Blumeriagraminis_GCA_000441875/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000441875.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blumeriagraminis_GCA_900519115/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_900519115.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Blumeriagraminis_GCA_900519115/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_900519115.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blumeriagraminis_GCA_905067625/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_905067625.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Blumeriagraminis_GCA_905067625/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_905067625.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blu_gra_SRR2153116/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153116/fcs/
mv temp_genomes/Blumeria/graminis-secale/SRR2153116/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153116/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blu_gra_SRR2153117/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153117/fcs/
mv temp_genomes/Blumeria/graminis-secale/SRR2153117/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153117/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blu_gra_SRR2153118/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153118/fcs/
mv temp_genomes/Blumeria/graminis-secale/SRR2153118/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153118/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blu_gra_SRR2153119/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153119/fcs/
mv temp_genomes/Blumeria/graminis-secale/SRR2153119/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153119/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blu_gra_SRR2153120/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153120/fcs/
mv temp_genomes/Blumeria/graminis-secale/SRR2153120/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153120/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blumeriahordei_GCA_000401675/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_000401675.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Blumeriahordei_GCA_000401675/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_000401675.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blumeriahordei_GCA_900237765/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900237765.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Blumeriahordei_GCA_900237765/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900237765.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blumeriahordei_GCA_900239735/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900239735.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Blumeriahordei_GCA_900239735/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900239735.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Blumeriahordei_GCA_900638725/gene_pred /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900638725.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Blumeriahordei_GCA_900638725/repeatmasking /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900638725.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Bot_cin_GCA_000143535.4/gene_pred /home/theaven/scratch/uncompressed/genomes/Botrytis/cineria/GCA_000143535.4/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Botrytiscinerea_GCA_000143535.4/repeatmasking /home/theaven/scratch/uncompressed/genomes/Botrytis/cineria/GCA_000143535.4/fcs/

mv /home/theaven/scratch/uncompressed/mildews/chlorociboriaaeruginascens_GCA_002276475/gene_pred /home/theaven/scratch/uncompressed/genomes/Chlorociboria/aeruginascens/GCA_002276475.2/fcs/ 
mv /home/theaven/scratch/uncompressed/mildews/chlorociboriaaeruginascens_GCA_002276475/repeatmasking /home/theaven/scratch/uncompressed/genomes/Chlorociboria/aeruginascens/GCA_002276475.2/fcs/ 

mv /home/theaven/scratch/uncompressed/mildews/Col_hig_broad_KN1394/gene_pred /home/theaven/scratch/uncompressed/genomes/Colletotrichum/higginsianum/broad_KN1394/fcs/
mv temp_genomes/Colletotrichum/higginsianum/broad_KN1394/repeatmasking /home/theaven/scratch/uncompressed/genomes/Colletotrichum/higginsianum/broad_KN1394/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Colletotrichumhigginsianum_GCA_001672515.1/gene_pred /home/theaven/scratch/uncompressed/genomes/Colletotrichum/higginsianum/GCA_001672515.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Colletotrichumhigginsianum_GCA_001672515.1/repeatmasking /home/theaven/scratch/uncompressed/genomes/Colletotrichum/higginsianum/GCA_001672515.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Cop_cin_GCA_000182895.1/gene_pred /home/theaven/scratch/uncompressed/genomes/Coprinus/cinereus/GCA_000182895.1/fcs/
mv temp_genomes/Coprinus/cinereus/GCA_000182895.1/repeatmasking /home/theaven/scratch/uncompressed/genomes/Coprinus/cinereus/GCA_000182895.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Cry_neo_GCF_000091045.1/gene_pred /home/theaven/scratch/uncompressed/genomes/Cryptococcus/neoformans/GCF_000091045.1/fcs/
mv temp_genomes/Cryptococcus/neoformans/GCF_000091045.1/repeatmasking /home/theaven/scratch/uncompressed/genomes/Cryptococcus/neoformans/GCF_000091045.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/drepanopezizabrunnea_GCA_000298775/gene_pred /home/theaven/scratch/uncompressed/genomes/Drepanopeziza/brunnea/GCA_000298775.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/drepanopezizabrunnea_GCA_000298775/repeatmasking /home/theaven/scratch/uncompressed/genomes/Drepanopeziza/brunnea/GCA_000298775.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Erysiphealphitoides_CLCBIO_assembly_cdhitest_0/gene_pred /home/theaven/scratch/uncompressed/genomes/Erysiphe/alphitoides/CLCBIO/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Erysiphealphitoides_CLCBIO_assembly_cdhitest_0/repeatmasking /home/theaven/scratch/uncompressed/genomes/Erysiphe/alphitoides/CLCBIO/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Erysiphenecator_GCA_000798715/gene_pred /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798715.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Erysiphenecator_GCA_000798715/repeatmasking /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798715.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Erysiphenecator_GCA_000798735/gene_pred /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798735.1/fcs/ 
mv /home/theaven/scratch/uncompressed/mildews/Erysiphenecator_GCA_000798735/repeatmasking /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798735.1/fcs/ 

mv /home/theaven/scratch/uncompressed/mildews/Erysiphenecator_GCA_000798755/gene_pred /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798755.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Erysiphenecator_GCA_000798755/repeatmasking /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798755.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Erysiphenecator_GCA_000798775/gene_pred /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798775.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Erysiphenecator_GCA_000798775/repeatmasking /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798775.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Erysiphenecator_GCA_000798795/gene_pred /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798795.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Erysiphenecator_GCA_000798795/repeatmasking /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798795.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Erysiphenecator_GCA_016906895/gene_pred /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_016906895.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Erysiphenecator_GCA_016906895/repeatmasking /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_016906895.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Ery_nec_GCA_024703715.1/gene_pred /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_024703715.1/fcs/
mv temp_genomes/Erysiphe/necator/GCA_024703715.1/repeatmasking /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_024703715.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Erysipheneolycopersici_GCA_003610855/gene_pred /home/theaven/scratch/uncompressed/genomes/Erysiphe/neolycopersici/GCA_003610855.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Erysipheneolycopersici_GCA_003610855/repeatmasking /home/theaven/scratch/uncompressed/genomes/Erysiphe/neolycopersici/GCA_003610855.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Erysiphepisi_GCA_000208805/gene_pred /home/theaven/scratch/uncompressed/genomes/Erysiphe/pisi/GCA_000208805.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Erysiphepisi_GCA_000208805/repeatmasking /home/theaven/scratch/uncompressed/genomes/Erysiphe/pisi/GCA_000208805.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Erysiphepisi_GCA_000214055/gene_pred /home/theaven/scratch/uncompressed/genomes/Erysiphe/pisi/GCA_000214055.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Erysiphepisi_GCA_000214055/repeatmasking /home/theaven/scratch/uncompressed/genomes/Erysiphe/pisi/GCA_000214055.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Erysiphepulchra_GCA_002918395/gene_pred /home/theaven/scratch/uncompressed/genomes/Erysiphe/pulchra/GCA_002918395.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Erysiphepulchra_GCA_002918395/repeatmasking /home/theaven/scratch/uncompressed/genomes/Erysiphe/pulchra/GCA_002918395.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Fusariumgraminearum_GCA_000240135.3/repeatmasking /home/theaven/scratch/uncompressed/genomes/Fusarium/graminearum/GCA_000240135.3/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Fus_gra_GCA_000240135.3/gene_pred /home/theaven/scratch/uncompressed/genomes/Fusarium/graminearum/GCA_000240135.3/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Fus_oxy_GCF_013085055.1/gene_pred /home/theaven/scratch/uncompressed/genomes/Fusarium/oxysporum/GCF_013085055.1/fcs/
mv temp_genomes/Fusarium/oxysporum/GCF_013085055.1/repeatmasking /home/theaven/scratch/uncompressed/genomes/Fusarium/oxysporum/GCF_013085055.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/glareaiozoyensis_GCA_000409485/gene_pred /home/theaven/scratch/uncompressed/genomes/Glarea/lozoyensis/GCA_000409485.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/glareaiozoyensis_GCA_000409485/repeatmasking /home/theaven/scratch/uncompressed/genomes/Glarea/lozoyensis/GCA_000409485.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Golovinomycescichoracearum_GCA_003611195/gene_pred /home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611195.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Golovinomycescichoracearum_GCA_003611195/repeatmasking /home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611195.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Golovinomycescichoracearum_GCA_003611215/gene_pred /home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611215.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Golovinomycescichoracearum_GCA_003611215/repeatmasking /home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611215.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Golovinomycescichoracearum_GCA_003611235/gene_pred /home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611235.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Golovinomycescichoracearum_GCA_003611235/repeatmasking /home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611235.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Golovinomycesmagnicellulatus_GCA_006912115/gene_pred /home/theaven/scratch/uncompressed/genomes/Golovinomyces/magnicellulatus/GCA_006912115.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Golovinomycesmagnicellulatus_GCA_006912115/repeatmasking /home/theaven/scratch/uncompressed/genomes/Golovinomyces/magnicellulatus/GCA_006912115.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Golovinomycesorontii_AssemblyScaffolds/gene_pred /home/theaven/scratch/uncompressed/genomes/Golovinomyces/orontii/MGH1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Golovinomycesorontii_AssemblyScaffolds/repeatmasking /home/theaven/scratch/uncompressed/genomes/Golovinomyces/orontii/MGH1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/leveillulataurrica_CADEPA01/gene_pred /home/theaven/scratch/uncompressed/genomes/Leveillula/taurrica/CADEPA01/fcs/
mv /home/theaven/scratch/uncompressed/mildews/leveillulataurrica_CADEPA01/repeatmasking /home/theaven/scratch/uncompressed/genomes/Leveillula/taurrica/CADEPA01/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Mag_ory_GCF_000002495.2/gene_pred /home/theaven/scratch/uncompressed/genomes/Magnaporthe/oryzae/GCF_000002495.2/fcs/
mv temp_genomes/Magnaporthe/oryzae/GCF_000002495.2/repeatmasking /home/theaven/scratch/uncompressed/genomes/Magnaporthe/oryzae/GCF_000002495.2/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Melampsoralaricis-populina_GCA_000204055.1/gene_pred /home/theaven/scratch/uncompressed/genomes/Melampsora/laricis-populina/GCA_000204055.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Melampsoralaricis-populina_GCA_000204055.1/repeatmasking /home/theaven/scratch/uncompressed/genomes/Melampsora/laricis-populina/GCA_000204055.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/mollisiascopiformis_GCA_001500285/gene_pred /home/theaven/scratch/uncompressed/genomes/Mollisia/scopiformis/GCA_001500285.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/mollisiascopiformis_GCA_001500285/repeatmasking /home/theaven/scratch/uncompressed/genomes/Mollisia/scopiformis/GCA_001500285.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/neobulgariaablba_GCA_003988965/gene_pred /home/theaven/scratch/uncompressed/genomes/Neobulgaria/alba/GCA_003988965.1/fcs/ 
mv /home/theaven/scratch/uncompressed/mildews/neobulgariaablba_GCA_003988965/repeatmasking /home/theaven/scratch/uncompressed/genomes/Neobulgaria/alba/GCA_003988965.1/fcs/ 

mv /home/theaven/scratch/uncompressed/mildews/Neurosporacrassa_GCA_000182925.2/gene_pred /home/theaven/scratch/uncompressed/genomes/Neurospora/crassa/GCA_000182925.2/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Neurosporacrassa_GCA_000182925.2/repeatmasking /home/theaven/scratch/uncompressed/genomes/Neurospora/crassa/GCA_000182925.2/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Oidiodendron_maius_GCA_000827325/gene_pred /home/theaven/scratch/uncompressed/genomes/Oidiodendron/maius/GCA_000827325.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Oidiodendron_maius_GCA_000827325/repeatmasking /home/theaven/scratch/uncompressed/genomes/Oidiodendron/maius/GCA_000827325.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Oidiumheveae_GCA_003957845/gene_pred /home/theaven/scratch/uncompressed/genomes/Oidium/heveae/GCA_003957845.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Oidiumheveae_GCA_003957845/repeatmasking /home/theaven/scratch/uncompressed/genomes/Oidium/heveae/GCA_003957845.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Par_pol_Parp01/gene_pred /home/theaven/scratch/uncompressed/genomes/Parauncinula/polyspora/Parp01/fcs/
mv temp_genomes/Parauncinula/polyspora/Parp01/repeatmasking /home/theaven/scratch/uncompressed/genomes/Parauncinula/polyspora/Parp01/fcs/

mv /home/theaven/scratch/uncompressed/mildews/phialocephalasubalpina-GCA_900073065/gene_pred /home/theaven/scratch/uncompressed/genomes/Phialocephala/subalpina/GCA_900073065.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/phialocephalasubalpina-GCA_900073065/repeatmasking /home/theaven/scratch/uncompressed/genomes/Phialocephala/subalpina/GCA_900073065.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/phyllactiniamoricola_GCA_019455665/gene_pred /home/theaven/scratch/uncompressed/genomes/Phyllactinia/moricola/GCA_019455665.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/phyllactiniamoricola_GCA_019455665/repeatmasking /home/theaven/scratch/uncompressed/genomes/Phyllactinia/moricola/GCA_019455665.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/pleochaetashiraiana_GCA_019455505/gene_pred /home/theaven/scratch/uncompressed/genomes/Pleochaeta/shiraiana/GCA_019455505.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/pleochaetashiraiana_GCA_019455505/repeatmasking /home/theaven/scratch/uncompressed/genomes/Pleochaeta/shiraiana/GCA_019455505.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Ple_ost_GCA_014466165.1/gene_pred /home/theaven/scratch/uncompressed/genomes/Pleurotus/ostreatus/GCA_014466165.1/fcs/
mv temp_genomes/Pleurotus/ostreatus/GCA_014466165.1/repeatmasking /home/theaven/scratch/uncompressed/genomes/Pleurotus/ostreatus/GCA_014466165.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/HEAVEN_strawberry2020/gene_pred /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72020/fcs/
mv /home/theaven/scratch/uncompressed/mildews/HEAVEN_strawberry2020/repeatmasking /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72020/fcs/

mv /home/theaven/scratch/uncompressed/mildews/HEAVEN_strawberry2021/gene_pred /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72021/fcs/
mv /home/theaven/scratch/uncompressed/mildews/HEAVEN_strawberry2021/repeatmasking /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72021/fcs/

mv /home/theaven/scratch/uncompressed/mildews/HEAVEN_raspberry2020/gene_pred /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/SCOTT2020/fcs/
mv /home/theaven/scratch/uncompressed/mildews/HEAVEN_raspberry2020/repeatmasking /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/SCOTT2020/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Podosphaeracerasii_GCA_018398735/gene_pred /home/theaven/scratch/uncompressed/genomes/Podosphaera/cerasii/GCA_018398735.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Podosphaeracerasii_GCA_018398735/repeatmasking /home/theaven/scratch/uncompressed/genomes/Podosphaera/cerasii/GCA_018398735.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Pod_fus_GCA_030378345.1/gene_pred /home/theaven/scratch/uncompressed/genomes/Podosphaera/fusca/GCA_030378345.1/fcs/
mv temp_genomes/Podosphaera/fusca/GCA_030378345.1/repeatmasking /home/theaven/scratch/uncompressed/genomes/Podosphaera/fusca/GCA_030378345.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/GANAN_apple/gene_pred /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/GCA_013170925.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/GANAN_apple/repeatmasking /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/GCA_013170925.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/HEAVEN_apple2019/gene_pred /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2019/fcs/
mv /home/theaven/scratch/uncompressed/mildews/HEAVEN_apple2019/repeatmasking /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2019/fcs/

mv /home/theaven/scratch/uncompressed/mildews/HEAVEN_apple2021/gene_pred /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2021/fcs/ 
mv /home/theaven/scratch/uncompressed/mildews/HEAVEN_apple2021/repeatmasking /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2021/fcs/ 

mv /home/theaven/scratch/uncompressed/mildews/HEAVEN_apple2020/gene_pred /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGBp112020/fcs/
mv /home/theaven/scratch/uncompressed/mildews/HEAVEN_apple2020/repeatmasking /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGBp112020/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Podosphaeraxanthii_GCA_010015925/gene_pred /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_010015925.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Podosphaeraxanthii_GCA_010015925/repeatmasking /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_010015925.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Podosphaeraxanthii_GCA_014884795/gene_pred /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_014884795.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Podosphaeraxanthii_GCA_014884795/repeatmasking /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_014884795.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Pod_xan_GCA_028751805.1/gene_pred /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_028751805.1/fcs/
mv temp_genomes/Podosphaera/xanthii/GCA_028751805.1/repeatmasking /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_028751805.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Psi_cub_GCA_017499595.2/gene_pred /home/theaven/scratch/uncompressed/genomes/Psilocybe/cubensis/GCA_017499595.2/fcs/
mv temp_genomes/Psilocybe/cubensis/GCA_017499595.2/repeatmasking /home/theaven/scratch/uncompressed/genomes/Psilocybe/cubensis/GCA_017499595.2/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Pucciniagraminis_GCA_000149925.1/gene_pred /home/theaven/scratch/uncompressed/genomes/Puccinia/graminis/GCA_000149925.1/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Pucciniagraminis_GCA_000149925.1/repeatmasking /home/theaven/scratch/uncompressed/genomes/Puccinia/graminis/GCA_000149925.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Puc_str_GCA_021901695.1/gene_pred /home/theaven/scratch/uncompressed/genomes/Puccinia/striiformis/GCA_021901695.1/fcs/
mv temp_genomes/Puccinia/striiformis/GCA_021901695.1/repeatmasking /home/theaven/scratch/uncompressed/genomes/Puccinia/striiformis/GCA_021901695.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Puc_tri_GCA_000151525.2/gene_pred /home/theaven/scratch/uncompressed/genomes/Puccinia/triticina/GCA_000151525.2/fcs/
mv temp_genomes/Puccinia/triticina/GCA_000151525.2/repeatmasking /home/theaven/scratch/uncompressed/genomes/Puccinia/triticina/GCA_000151525.2/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Pyriculariaoryzae_GCA_000002495.2/gene_pred /home/theaven/scratch/uncompressed/genomes/Pyricularia/oryzae/GCA_000002495.2/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Pyriculariaoryzae_GCA_000002495.2/repeatmasking /home/theaven/scratch/uncompressed/genomes/Pyricularia/oryzae/GCA_000002495.2/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Scereviseae_GCF_000146045/gene_pred /home/theaven/scratch/uncompressed/genomes/Saccharomyces/cerevisiae/GCF_000146045.2/fcs/
mv /home/theaven/scratch/uncompressed/mildews/Scereviseae_GCF_000146045/repeatmasking /home/theaven/scratch/uncompressed/genomes/Saccharomyces/cerevisiae/GCF_000146045.2/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Sch_com_GCA_000143185.2/gene_pred /home/theaven/scratch/uncompressed/genomes/Schizophyllum/commune/GCA_000143185.2/fcs/
mv temp_genomes/Schizophyllum/commune/GCA_000143185.2/repeatmasking /home/theaven/scratch/uncompressed/genomes/Schizophyllum/commune/GCA_000143185.2/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Sclerotiniasclerotiorum_GCA_000146945.2/gene_pred /home/theaven/scratch/uncompressed/genomes/Sclerotinia/sclerotiorum/GCA_000146945.2/fcs/ 
mv /home/theaven/scratch/uncompressed/mildews/Sclerotiniasclerotiorum_GCA_000146945.2/repeatmasking /home/theaven/scratch/uncompressed/genomes/Sclerotinia/sclerotiorum/GCA_000146945.2/fcs/ 

mv /home/theaven/scratch/uncompressed/mildews/Scl_scl_GCF_000146945.1/gene_pred /home/theaven/scratch/uncompressed/genomes/Sclerotinia/sclerotiorum/GCF_000146945.1/fcs/ 
mv temp_genomes/Scleotinia/sclerotiorum/GCF_000146945.1/repeatmasking /home/theaven/scratch/uncompressed/genomes/Sclerotinia/sclerotiorum/GCF_000146945.1/fcs/

mv /home/theaven/scratch/uncompressed/mildews/Tub_mel_GCF_000151645.1/gene_pred /home/theaven/scratch/uncompressed/genomes/Tuber/melanosporum/GCF_000151645.1/fcs/ 
mv temp_genomes/Tuber/melanosporum/GCF_000151645.1/repeatmasking /home/theaven/scratch/uncompressed/genomes/Tuber/melanosporum/GCF_000151645.1/fcs/ 

mv /home/theaven/scratch/uncompressed/mildews/Ust_may_GCA_000328475.2/gene_pred /home/theaven/scratch/uncompressed/genomes/Ustilago/maydis/GCA_000328475.2/fcs/
mv temp_genomes/Ustilago/maydis/GCA_000328475.2/repeatmasking /home/theaven/scratch/uncompressed/genomes/Ustilago/maydis/GCA_000328475.2/fcs/
```
```bash
for file in $(ls -d /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs); do
  FinalDir=$(ls $file/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa)
  if [ ! "$FinalDir" ]; then
      ls $file/gene_pred/braker/*/final_genes_renamed.pep.fasta
  fi
done

conda activate predector2.7
for Assembly in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
  #remove duplicates and rename:
  ID=$(basename $Assembly|cut -f1,2,3 -d '_'| sed 's@_contigs_softmasked_repeatmasker_TPSI_appended@@g')
  echo $ID
  Gff=$(echo $Assembly | cut -d '/' -f1,2,3,4,5,6,7,8,9,10 )/gene_pred/braker/braker.gff3
  ab_gff=$(echo $Assembly | cut -d '/' -f1,2,3,4,5,6,7,8,9,10 )/gene_pred/braker/augustus.ab_initio.gff3
  FinalDir=$(echo $Assembly | cut -d '/' -f1,2,3,4,5,6,7,8,9,10 )/gene_pred/braker/final-02042924
  echo $FinalDir
  if [ ! -e "${FinalDir}/final_genes_renamed.pep.fasta" ]; then
  mkdir $FinalDir
  GffFiltered=$FinalDir/filtered_duplicates.gff
  ab_GffFiltered=$FinalDir/ab_initio_filtered_duplicates.gff
  ProgDir=/home/theaven/scratch/apps/tools
  #ProgDir=/home/gomeza/git_repos/scripts/bioinformatics_tools/Gene_prediction 
  $ProgDir/remove_dup_features.py --inp_gff $Gff --out_gff $GffFiltered
  $ProgDir/remove_dup_features.py --inp_gff $ab_gff --out_gff $ab_GffFiltered
  awk '{ gsub("\\.","_",$1); print}' $GffFiltered > ${GffFiltered}.2
  awk '{ gsub("\\.","_",$1); print}' $ab_GffFiltered > ${ab_GffFiltered}.2
  GffRenamed=$FinalDir/final_genes_renamed.gff3 
  LogFile=$FinalDir/final_genes_renamed.log 
  ab_GffRenamed=$FinalDir/ab_initio_final_genes_renamed.gff3 
  ab_LogFile=$FinalDir/ab_initio_final_genes_renamed.log
  $ProgDir/gff_rename_genes.py --inp_gff ${GffFiltered}.2 --conversion_log $LogFile > $GffRenamed 
  $ProgDir/gff_rename_genes.py --inp_gff ${ab_GffFiltered}.2 --conversion_log $ab_LogFile > $ab_GffRenamed  
  awk '{ gsub("\\.","_"); print}' $Assembly > ${Assembly}.2
  $ProgDir/gff2fasta.pl ${Assembly}.2 $GffRenamed $FinalDir/final_genes_renamed
  $ProgDir/gff2fasta.pl ${Assembly}.2 $ab_GffRenamed $FinalDir/ab_initio_final_genes_renamed
  sed -i 's/*/X/g' $FinalDir/final_genes_renamed.pep.fasta
  sed -i 's/*/X/g' $FinalDir/ab_initio_final_genes_renamed.pep.fasta
  #remove any discovered duplicates
  Output=$(dirname $LogFile)/$(echo $LogFile |cut -f2 -d '/')_duplicated_genes
  ab_Output=$(dirname $ab_LogFile)/$(echo $ab_LogFile |cut -f2 -d '/')ab_initio_duplicated_genes
  for prediction in $(cat $LogFile |cut -f1|sort|uniq -c|sort -nr | awk '$1>1' | awk '{print $2}'); do
    printf ">\n" >> $Output
    grep -w $prediction $LogFile | awk '{print $3}' >> $Output
  done
  sed -e '/>/,+1d' ${Output} > ${Output}.txt #removed one of each duplicate from the removal list
  awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $FinalDir/final_genes_renamed.cdna.fasta > linearized.fasta
  for var1 in $(cat ${Output}.txt); do
    sed -i "/>${var1}.t1/d" linearized.fasta
  done
  tr "\t" "\n" < linearized.fasta | fold -w 60 > $FinalDir/final_genes_renamed.cdna.fasta
  awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $FinalDir/final_genes_renamed.pep.fasta > linearized.fasta
  for var1 in $(cat ${Output}.txt); do
    sed -i "/>${var1}.t1/d" linearized.fasta
  done
  tr "\t" "\n" < linearized.fasta | fold -w 60 > $FinalDir/final_genes_renamed.pep.fasta
  for prediction in $(cat $ab_LogFile |cut -f1|sort|uniq -c|sort -nr | awk '$1>1' | awk '{print $2}'); do
    printf ">\n" >> $ab_Output
    grep -w $prediction $ab_LogFile | awk '{print $3}' >> $ab_Output
  done
  sed -e '/>/,+1d' ${ab_Output} > ${ab_Output}.txt #removed one of each duplicate from the removal list
  awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $FinalDir/ab_initio_final_genes_renamed.cdna.fasta > linearized.fasta
  for var1 in $(cat ${ab_Output}.txt); do
    sed -i "/>${var1}.t1/d" linearized.fasta
  done
  tr "\t" "\n" < linearized.fasta | fold -w 60 > $FinalDir/ab_initio_final_genes_renamed.cdna.fasta
  awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' < $FinalDir/ab_initio_final_genes_renamed.pep.fasta > linearized.fasta
  for var1 in $(cat ${ab_Output}.txt); do
    sed -i "/>${var1}.t1/d" linearized.fasta
  done
  tr "\t" "\n" < linearized.fasta | fold -w 60 > $FinalDir/ab_initio_final_genes_renamed.pep.fasta
  rm $Output
  rm $ab_Output
  #count predicated genes
  cat $FinalDir/final_genes_renamed.cdna.fasta | grep '>' > $FinalDir/genenames.txt
  echo ""  >> other/brakerreport.txt
  echo $ID >> other/brakerreport.txt
  echo No. of prothint guided genes: >> other/brakerreport.txt
  grep -c -i '>' $FinalDir/final_genes_renamed.cdna.fasta >> other/brakerreport.txt
  cat $FinalDir/ab_initio_final_genes_renamed.cdna.fasta | grep '>' > $FinalDir/ab_initio_genenames.txt
  echo No. of ab initio predicted genes: >> other/brakerreport.txt
  grep -c -i '>' $FinalDir/ab_initio_final_genes_renamed.cdna.fasta >> other/brakerreport.txt
  rm ${Assembly}.2
  rm ${GffFiltered}.2
  rm ${ab_GffFiltered}.2
  fi
done
```
```bash
for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/*_clean.fasta); do
grep '>' $file | cut -d ' ' -f1 | sed 's@>@@g'| sed 's@\.@_@g' > temp_contig_ids.txt
Dir=$(dirname $file)/gene_pred/braker
if [ -d "${Dir}/final-02042924" ]; then
gff=${Dir}/final-02042924/final_genes_renamed.gff3
fasta=${Dir}/final-02042924/final_genes_renamed.pep.fasta
out=${Dir}/final-02042924/clean_final_genes_renamed.pep.fasta
grep -f temp_contig_ids.txt $gff | grep 'mRNA'| cut -d ' ' -f9  | cut -d ';' -f1 | cut -d '=' -f2 > temp_gene_ids.txt
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file temp_gene_ids.txt --input $fasta --output $out
else
echo error
fi
#rm temp_contig_ids.txt
#rm temp_gene_ids.txt
done
```

```bash
mkdir mcag
cd mcag
for file in $(ls /home/theaven/scratch/uncompressed/mildews/*/gene_pred/braker/*/final_genes_renamed.pep.fasta); do
name=$(echo $file | cut -d '/' -f7 | sed 's@Podosphaeraxanthii@P_x@g' | sed 's@Podosphaeracerasii@P_c@g' | sed 's@pleochaetashiraiana@Pl_s@g' | sed 's@phyllactiniamoricola@Phy_m@g' | sed 's@phialocephalasubalpina@Phi_s@g' | sed 's@Oidiumheveae@O_h@g' | sed 's@Oidiodendron_maius@Oi_m@g' | sed 's@neobulgariaablba@N_a@g' | sed 's@mollisiascopiformis@M_s@g' | sed 's@leveillulataurrica@L_t@g' | sed 's@HEAVEN_strawberry@P_a_frg@g' | sed 's@HEAVEN_raspberry@P_a_rub@g' | sed 's@HEAVEN_apple@P_l@g' | sed 's@Golovinomycesorontii_AssemblyScaffolds@G_o@g' | sed 's@Golovinomycesmagnicellulatus@G_m@g' | sed 's@Golovinomycescichoracearum@G_c@g' | sed 's@glareaiozoyensis@Gl_i@g' | sed 's@GANAN_apple@P_l_ganan@g' | sed 's@Erysiphepulchra@E_pu@g' | sed 's@Erysiphepisi@E_pi@g' | sed 's@Erysipheneolycopersici@E_neol@g' | sed 's@Erysiphenecator@E_neca@g' | sed 's@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@E_alph@g' | sed 's@drepanopezizabrunnea@D_b@g' | sed 's@chlorociboriaaeruginascens@C_a@g' | sed 's@Blumeriahordei@B_h@g' | sed 's@Blumeriagraminis@B_g@g' | sed 's@ascocorynesarcoides@A_s@g' | sed 's@arachnopezizaaraneosa@Ar_a@g' | sed 's@Amorphothecaresinae@Am_c@g' | sed 's@amorphothecaresinae@Am_c@g')
echo $name
cp $file ./${name}_$(basename $file)
sed -i "s/>/>${name}_/g" ${name}_$(basename $file)
done

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

for file in $(ls *final_genes_renamed.pep.fasta); do
seqkit rmdup $file > temp.fasta && mv temp.fasta $file
done

mkdir db
cat *final_genes_renamed.pep.fasta > db/db.faa
cd db
makeblastdb -in db.faa -input_type fasta -dbtype prot  -title mildew+db  -parse_seqids -out mildew+db

for file in $(ls ../prot/*); do
name=$(basename $file | cut -d '.' -f1)
blastp -query $file -db mildew+db -out ../${name}_results -evalue 1e-5 -outfmt 6 -num_threads 1
done

ls *_results | wc -l


echo Gene: > out.tsv

for file2 in $(ls *_final_genes_renamed.pep.fasta); do
  name=$(echo $file2 | sed 's@_final_genes_renamed.pep.fasta@@g')
sed -i "\$s/\$/ $name/" out.tsv
done


for file in $(ls *_results); do
gene=$(awk '{print $1; exit}' $file)
echo $gene >> out.tsv
for file2 in $(ls *_final_genes_renamed.pep.fasta); do
  name=$(echo $file2 | sed 's@_final_genes_renamed.pep.fasta@@g')
x=$(grep -m 1 $name $file | awk '{print $11}')
if [ -z "$x" ]; then
    y=missing
else
    y=$x
fi
sed -i "\$s/\$/ $y/" out.tsv
done
done
```
Check to see if MCAGs that are present blast to distantly related species and are therefore likely contaminants rather than truely present MCAGs:
```bash
ls *_final_genes_renamed.pep.fasta | sed 's@_final_genes_renamed.pep.fasta@@g' > assemblies.txt

for assembly_id in $(cat assemblies.txt); do
for protein in $(ls results/*_protein_results); do
grep -m 1 "$assembly_id" $protein | awk '{print $2}' >> blast/${assembly_id}_proteins.txt
done
done

for file in $(ls blast/*_proteins.txt); do
sort $file > temp-temp.txt && mv temp-temp.txt $file
done


for file in $(ls blast/*_proteins.txt); do
  ID=$(basename $file | sed 's@_proteins.txt@@g')
  ls ${ID}_final_genes_renamed.pep.fasta
  singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/python3.sif python3 ~/git_repos/Scripts/NBI/seq_get.py --id_file $file --input ${ID}_final_genes_renamed.pep.fasta --output blast/${ID}_final_genes_renamed.pep.fasta
done

for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/*_final_genes_renamed.pep.fasta); do
Database=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/databases/blast/uniprot_01102023/Uniprot_01102023_reference_proteomes.dmnd
OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast
OutFile=$(basename $file | sed 's@_final_genes_renamed.pep.fasta@@g')
hits=5
ProgDir=~/git_repos/Wrappers/NBI
sbatch $ProgDir/run_diamond_blastp.sh $file $Database $OutDir $OutFile $hits
done
#58566040-91

for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast/*.out); do
cat $file | wc -l
done



for assembly_id in $(cat assemblies.txt); do
echo -e "MCAG\tTop_hit\tblast_1\tblast_2\tblast_3\tblast_4\tblast_5\tID_1\tID_2\tID_3\tID_4\tID_5" > blast/${assembly_id}_proteins_notes.txt
for protein in $(ls results/*_protein_results); do
x=$(echo $protein | sed 's@_protein_results@@g'| sed 's@results/@@g') 
y=$(grep -m 1 "$assembly_id" $protein | awk '{print $2}')
echo -e "$x\t$y" >> blast/${assembly_id}_proteins_notes.txt
done
done

for file in $(ls blast/*_proteins_notes.txt); do
awk 'BEGIN {FS=OFS="\t"} $2 == "" {$2="###"}1' $file > temp.txt && mv temp.txt $file
done

#There are many duplicate hits, eg different AAD proteins have blasted to the same gene.

for file in blast/*_proteins_notes.txt; do
    ID=$(basename "$file" | sed 's@_proteins_notes.txt@@g')
    while IFS=$'\t' read -r col1 col2 rest; do
        matches=$(grep "^$col2" "blast/${ID}.vs.Uniprot_01102023_reference_proteomes.dmnd.diamond_blastp.out" | awk -v col2="$col2" '$1 == col2 {printf "%s\t", $5}')
        if [ -n "$matches" ]; then
            matches="${matches%?}"  # Remove the last character (trailing tab)
        fi
        echo -e "$col1\t$col2\t$rest\t$matches"
    done < "$file" > "${ID}merged_notes.txt"
    awk 'BEGIN {FS=OFS="\t"} {print $1, $2, $4, $5, $6, $7, $8, $9}' ${ID}merged_notes.txt > $file
    rm ${ID}merged_notes.txt
done

for file in /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/uniprot/*.xlsx; do
    Out=$(echo $file | sed 's@.xlsx@.tsv@g')
    singularity exec /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/containers/python3.sif python3 ~/git_repos/Scripts/NBI/xlsx2tsv.py $file $Out
done

for notes in $(ls blast/*_proteins_notes.txt); do
tsv=uniprot/$(basename "$notes" | sed 's@_proteins_notes.txt@@g').tsv
output_file="edited_file.txt"
rm "$output_file"
touch "$output_file"
while IFS= read -r line; do
    id=$(echo "$line" | awk -F'\t' '{split($3, arr, "|"); print arr[2]}')
    fifth_column=$(awk -v var="$id" -F'\t' '$1 == var {print $5}' $tsv | cut -d ' ' -f1,2)
    edited_line="$line\t$fifth_column"
    echo -e "$edited_line" >> "$output_file"
done < $notes
mv "$output_file" $notes
rm "$output_file"
touch "$output_file"
while IFS= read -r line; do
    id=$(echo "$line" | awk -F'\t' '{split($4, arr, "|"); print arr[2]}')
    fifth_column=$(awk -v var="$id" -F'\t' '$1 == var {print $5}' $tsv | cut -d ' ' -f1,2)
    edited_line="$line\t$fifth_column"
    echo -e "$edited_line" >> "$output_file"
done < $notes
mv "$output_file" $notes
rm "$output_file"
touch "$output_file"
while IFS= read -r line; do
    id=$(echo "$line" | awk -F'\t' '{split($5, arr, "|"); print arr[2]}')
    fifth_column=$(awk -v var="$id" -F'\t' '$1 == var {print $5}' $tsv | cut -d ' ' -f1,2)
    edited_line="$line\t$fifth_column"
    echo -e "$edited_line" >> "$output_file"
done < $notes
mv "$output_file" $notes
rm "$output_file"
touch "$output_file"
while IFS= read -r line; do
    id=$(echo "$line" | awk -F'\t' '{split($6, arr, "|"); print arr[2]}')
    fifth_column=$(awk -v var="$id" -F'\t' '$1 == var {print $5}' $tsv | cut -d ' ' -f1,2)
    edited_line="$line\t$fifth_column"
    echo -e "$edited_line" >> "$output_file"
done < $notes
mv "$output_file" $notes
rm "$output_file"
touch "$output_file"
while IFS= read -r line; do
    id=$(echo "$line" | awk -F'\t' '{split($7, arr, "|"); print arr[2]}')
    fifth_column=$(awk -v var="$id" -F'\t' '$1 == var {print $5}' $tsv | cut -d ' ' -f1,2)
    edited_line="$line\t$fifth_column"
    echo -e "$edited_line" >> "$output_file"
done < $notes
mv "$output_file" $notes
done
```
```bash
/home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred
```
```python
import pandas as pd
import sys

def merge_notes_xlsx(notes_file, xlsx_file, output_file):
    # Read the .xlsx file
  xlsx_df = pd.read_excel(xlsx_file, header=None, names=['ID', 'Name', 'Accession', 'Description', 'Species'])
    # Read the .notes file
  notes_df = pd.read_csv(notes_file, sep='\t', header=None, names=['ID', 'Gene_IDs'])
    # Split the 'Gene_IDs' column in the .notes file by '|' and explode it into multiple rows
  notes_df['Gene_IDs'] = notes_df['Gene_IDs'].str.split('|')
  notes_df = notes_df.explode('Gene_IDs')
    # Merge the dataframes based on the 'ID' column in the .xlsx file and the 'Gene_IDs' column in the .notes file
  merged_df = pd.merge(notes_df, xlsx_df, left_on='Gene_IDs', right_on='ID', how='left')
    # Concatenate the 'Description' column from the .xlsx file to the matched rows in the .notes file
  merged_df['Notes_with_Description'] = merged_df['ID'] + '\t' + merged_df['Gene_IDs'] + '\t' + merged_df['Description'] + '\t' + merged_df['Species']
    # Group the concatenated data back into a single row for each ID in the .notes file
  final_df = merged_df.groupby('ID')['Notes_with_Description'].apply(lambda x: '\t'.join(x)).reset_index()
    # Save the final result to the output file
  final_df.to_csv(output_file, sep='\t', header=False, index=False)

if __name__ == "__main__":
  if len(sys.argv) != 4:
    print("Usage: python script.py notes_file.xlsx xlsx_file.xlsx output_file.notes")
    sys.exit(1)
  notes_file = sys.argv[1]
  xlsx_file = sys.argv[2]
  output_file = sys.argv[3]

merge_notes_xlsx(notes_file, xlsx_file, output_file)
```
```python
import pandas as pd
import sys

def convert_xlsx_to_tsv(input_file, output_file):
  try:
    # Read the .xlsx file
    df = pd.read_excel(input_file)
    # Write the DataFrame to a .tsv file
    df.to_csv(output_file, sep='\t', index=False)
    print(f"Conversion successful. TSV file saved as {output_file}")
  except Exception as e:
    print(f"Error converting file: {e}")

if __name__ == "__main__":
  if len(sys.argv) != 3:
    print("Usage: python convert_xlsx_to_tsv.py input_file.xlsx output_file.tsv")
  else:
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    convert_xlsx_to_tsv(input_file, output_file)


```
```bash
#Kraken 
for Assembly in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/*.fna /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/*.fasta); do
sleep 30s
      while  squeue -u did23faz | grep -q '(AssocMaxJobsLimit)\|(Resources)\|(Priority)'; do
        sleep 300s
        printf "."
    done
Jobs=$(squeue -u did23faz| grep 'kraken'  | wc -l)
      while [ $Jobs -gt 4 ]; do
          sleep 300s
            printf "."
          Jobs=$(squeue -u did23faz| grep 'kraken'| wc -l)
      done
OutPrefix=$(echo $Assembly | cut -d '/' -f9,10,11 | sed 's@/@_@g')_kraken2nt
OutDir=$(dirname $Assembly)/kraken2.1.3
Database=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/databases/kraken/nt_14092023
if [ ! -e "${OutDir}/${OutPrefix}_report.txt" ] || [ ! -s "${OutDir}/${OutPrefix}_report.txt" ]; then
echo $OutPrefix
mkdir $OutDir
sbatch $ProgDir/run_kraken2.sh $Assembly $Database $OutDir $OutPrefix
else
echo already done for $OutPrefix
fi
done

for report in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/kraken2.1.3/*_kraken2nt_report.txt); do
echo $(basename $report | sed 's@_kraken2nt_report.txt@@g')
grep 'Fungi' $report
grep 'Erysiphales' $report
done


#58072788

Genome=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/Psyllidae/assembly/genome/T_anthrisci/hifiasm_19.5/820m/48/1/10.0/0.25/break10x/purge_dups/sanger/MitoHifi/filtered/T_anthrisci_820m_48_1_10.0_0.25_break_TellSeqPurged_curated_nomito_filtered.fa
OutFile=$(basename $Genome | sed 's@.fa@@g')
OutDir=$(dirname $Genome)
RMsearch=arthropoda
ProgDir=~/git_repos/Wrappers/NBI
mkdir $OutDir
sbatch $ProgDir/run_earlgrey.sh $Genome $OutFile $OutDir $RMsearch
#58115057
```

#### Helixer
```bash
for file in $(ls mildews/*a); do
ln -s /home/theaven/scratch/uncompressed/$file /home/theaven/scratch/uncompressed/genomes/.
done

fasta=/home/theaven/scratch/uncompressed/genomes/Scereviseae_GCF_000146045.2_R64_genomic.fna
model_filepath=/home/theaven/scratch/apps/helixer/models/fungi_v0.3_a_0100/fungi_v0.3_a_0100.h5
lineage=fungi
species=$(basename $fasta | cut -d '.' -f1)
outfile=$(echo $species | sed 's@Podosphaeraxanthii@P_x@g' | sed 's@Podosphaeracerasii@P_c@g' | sed 's@pleochaetashiraiana@Pl_s@g' | sed 's@phyllactiniamoricola@Phy_m@g' | sed 's@phialocephalasubalpina@Phi_s@g' | sed 's@Oidiumheveae@O_h@g' | sed 's@Oidiodendron_maius@Oi_m@g' | sed 's@neobulgariaablba@N_a@g' | sed 's@mollisiascopiformis@M_s@g' | sed 's@leveillulataurrica@L_t@g' | sed 's@HEAVEN_strawberry@P_a_frg@g' | sed 's@HEAVEN_raspberry@P_a_rub@g' | sed 's@HEAVEN_apple@P_l@g' | sed 's@Golovinomycesorontii_AssemblyScaffolds@G_o@g' | sed 's@Golovinomycesmagnicellulatus@G_m@g' | sed 's@Golovinomycescichoracearum@G_c@g' | sed 's@glareaiozoyensis@Gl_i@g' | sed 's@GANAN_apple@P_l_ganan@g' | sed 's@Erysiphepulchra@E_pu@g' | sed 's@Erysiphepisi@E_pi@g' | sed 's@Erysipheneolycopersici@E_neol@g' | sed 's@Erysiphenecator@E_neca@g' | sed 's@Erysiphealphitoides_CLCBIO_assembly_cdhitest_0@E_alph@g' | sed 's@drepanopezizabrunnea@D_b@g' | sed 's@chlorociboriaaeruginascens@C_a@g' | sed 's@Blumeriahordei@B_h@g' | sed 's@Blumeriagraminis@B_g@g' | sed 's@ascocorynesarcoides@A_s@g' | sed 's@arachnopezizaaraneosa@Ar_a@g' | sed 's@Amorphothecaresinae@Am_c@g' | sed 's@amorphothecaresinae@Am_c@g' | sed 's@Scereviseae@S_cere@g')
outdir=/home/theaven/scratch/uncompressed/mildews/${species}/gene_pred/helixer
ProgDir=/home/theaven/scratch/apps
mkdir $outdir
sbatch $ProgDir/helixer/run_helixer.sh $fasta $model_filepath $lineage $species $outfile $outdir
#16601800,16601823,16601871, 16601894

```
## Comparmentalised genome?

See Frantzeskakis et al. (2019) (Parauncinula) and Armitage et al. (2018).

Gene density plot for Podosphaera - mark BUSCOs and CSEPs + Violin plot of CSEP vs non-CSEP gene to TE distance for Podosphaera.

```bash
ls ~/projects/niab/theaven/gene_pred/*/*/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3
ls ~/projects/niab/theaven/gene_pred/*/*/predector_singularity3/results/final_genes_appended_renamed.pep/P*-ranked.tsv

../apps/tools/find_intergenic_regions.py --Gff $GeneGff > $OutDir/10300_intergenic_regions.txt

#Find the 3' and 5' intergenic distances + match names to the predector output files
conda activate predector2.7
for Gff in $(ls ~/projects/niab/theaven/gene_pred/*/*/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3); do
  ID=$(echo $Gff | cut -d '/' -f9)
OutFile=$(dirname $Gff)/${ID}_intergenic_regions.txt
echo -e "name\tfive_prime\tthree_prime\tstrand" > $OutFile
python2.7 ../apps/tools/find_intergenic_regions.py --Gff $Gff >> $OutFile
head -n 1 $OutFile > temp.temp
tail -n +2 $OutFile | awk -F'\t' '{print $1 ".t1\t" $2 "\t" $3 "\t" $4}' >> temp.temp && mv temp.temp $OutFile
x=$(grep 'gene' $Gff | wc -l)
y=$(cat $OutFile | wc -l)
echo "Genes in $ID GFF: $x, intergenic regions found for: $y"
done
conda deactivate

#Investigate missing genes:
for Gff in $(ls ~/projects/niab/theaven/gene_pred/*/*/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3); do
file=$(dirname $Gff)/intergenic_regions.txt
while IFS= read -r value; do
    # Extract the value from the first column
    search_value=$(echo "$value" | grep 'mRNA' | awk '{print $9}' | cut -d ';' -f1 | cut -d '=' -f2)
    # Search for the value in the first column of the GFF file
    if ! grep -q "$search_value" "$file"; then
        # If no match found, print the value
        echo "$value" >> $(dirname $file)/missing.txt
    fi
done < "$Gff"
done

for file in $(ls ~/projects/niab/theaven/gene_pred/*/*/codingquarry/rep_modeling/final/intergenic_regions_nonest.txt); do 
echo $Gff | cut -d '/' -f9
max_column_2=$(awk 'NR>1 { if ($2 > max) max = $2 } END { print max }' "$file")
max_column_3=$(awk 'NR>1 { if ($3 > max) max = $3 } END { print max }' "$file")
echo "Maximum 5' value: $max_column_2"
echo "Maximum 3' value: $max_column_3"
done
```
```bash
screen -S blast
srun -p long --mem 10G --pty bash
conda activate blast+
mkdir busco_db
find gene_pred/Podosphaera/leucotricha/THeavenpOGB2019_1.c/BUSCO/leotiomycetes_odb10/THeavenpOGB2019_1.c/run_leotiomycetes_odb10/busco_sequences/single_copy_busco_sequences/ \
     gene_pred/Podosphaera/leucotricha/THeavenpOGB2021_1.c/BUSCO/leotiomycetes_odb10/THeavenpOGB2021_1.c/run_leotiomycetes_odb10/busco_sequences/single_copy_busco_sequences/ \
     gene_pred/Podosphaera/leucotricha/THeavenp11_1.c/BUSCO/leotiomycetes_odb10/THeavenp11_1.c/run_leotiomycetes_odb10/busco_sequences/single_copy_busco_sequences/ \
     gene_pred/Podosphaera/aphanis/THeavenDRCT72020_1.c/BUSCO/leotiomycetes_odb10/THeavenDRCT72020_1.c/run_leotiomycetes_odb10/busco_sequences/single_copy_busco_sequences/ \
     gene_pred/Podosphaera/aphanis/THeavenDRCT72021_1.c/BUSCO/leotiomycetes_odb10/THeavenDRCT72021_1.c/run_leotiomycetes_odb10/busco_sequences/single_copy_busco_sequences/ \
     gene_pred/Podosphaera/aphanis/THeavenSCOTT2020_1.c/BUSCO/leotiomycetes_odb10/THeavenSCOTT2020_1.c/run_leotiomycetes_odb10/busco_sequences/single_copy_busco_sequences/ \
     -name '*.faa' -exec cat {} >> busco_db/my_busco_db.faa \;

cd busco_db
makeblastdb -in my_busco_db.faa -dbtype prot -title buscodb -out buscodb

for file in $(ls ~/projects/niab/theaven/gene_pred/*/*/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do
  ID=$(echo $file | cut -d '/' -f9)
  blastp -query $file -db buscodb -out ${ID}_busco_blast.tsv -max_target_seqs 1 -evalue 1e-15 -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qseq sseq'
  echo -e "name\tmatch\tpident\tlength\tmismatch\tgapopen\tqstart\tqend\tsstart\tsend\tevalue\tbitscore\tqseq\tsseq" > temp.tsv
  cat ${ID}_busco_blast.tsv >> temp.tsv && mv temp.tsv ${ID}_busco_blast2.tsv
done

#Make blast database as in Praz et al., 2017
cat podosporaanserina_GCF_000226545.1_ASM22654v1_protein.faa neurosporacrassa_GCF_000182925.2_NC12_protein.faa > mydb.faa
mkdir /home/theaven/scratch/uncompressed/csep_db/db
makeblastdb -in mydb.faa -dbtype prot -title CSEPdb -out /home/theaven/scratch/uncompressed/csep_db/db/CSEPdb

#blast for matches
for file in $(ls ~/projects/niab/theaven/gene_pred/*/*/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta); do
  ID=$(echo $file | cut -d '/' -f9)
blastp -query $file -db /home/theaven/scratch/uncompressed/csep_db/db/CSEPdb -out ${ID}_csep_blast.tsv -max_target_seqs 1 -evalue 1e-5 -outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qseq sseq'
  echo -e "name\tmatch_1\tpident_1\tlength_1\tmismatch_1\tgapopen_1\tqstart_1\tqend_1\tsstart_1\tsend_1\tevalue_1\tbitscore_1\tqseq_1\tsseq_1" > temp.tsv
  cat ${ID}_csep_blast.tsv >> temp.tsv && mv temp.tsv ${ID}_csep_blast2.tsv
done

conda deactivate


join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84 \
<(sort /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenSCOTT2020_1/predector_singularity3/results/final_genes_appended_renamed.pep/final_genes_appended_renamed.pep-ranked.tsv) \
<(sort /home/theaven/scratch/uncompressed/THeavenSCOTT2020_1_csep_blast.tsv) | sed 's/match_1/csep_blast/g' | sort | uniq > P_aphanis-THeavenSCOTT2020_1-ranked.tsv

join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84 <(sort /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72020_1/predector_singularity3/results/final_genes_appended_renamed.pep/final_genes_appended_renamed.pep-ranked.tsv) <(sort /home/theaven/scratch/uncompressed/THeavenDRCT72020_1_csep_blast.tsv) | sed 's/match_1/csep_blast/g' | sort | uniq > P_aphanis-THeavenDRCT72020_1-ranked.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84 <(sort /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72021_1/predector_singularity3/results/final_genes_appended_renamed.pep/final_genes_appended_renamed.pep-ranked.tsv) <(sort /home/theaven/scratch/uncompressed/THeavenDRCT72021_1_csep_blast.tsv) | sed 's/match_1/csep_blast/g' | sort | uniq > P_aphanis-THeavenDRCT72021_1-ranked.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84 <(sort /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2019_1/predector_singularity3/results/final_genes_appended_renamed.pep/final_genes_appended_renamed.pep-ranked.tsv) <(sort /home/theaven/scratch/uncompressed/THeavenpOGB2019_1_csep_blast.tsv) | sed 's/match_1/csep_blast/g' | sort | uniq > P_leucotricha-THeavenpOGB2019_1-ranked.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84 <(sort /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenp11_1/predector_singularity3/results/final_genes_appended_renamed.pep/final_genes_appended_renamed.pep-ranked.tsv) <(sort /home/theaven/scratch/uncompressed/THeavenp11_1_csep_blast.tsv) | sed 's/match_1/csep_blast/g' | sort | uniq > P_leucotricha-THeavenp11_1-ranked.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84 <(sort /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2021_1/predector_singularity3/results/final_genes_appended_renamed.pep/final_genes_appended_renamed.pep-ranked.tsv) <(sort /home/theaven/scratch/uncompressed/THeavenpOGB2021_1_csep_blast.tsv) | sed 's/match_1/csep_blast/g' | sort | uniq > P_leucotricha-THeavenpOGB2021_1-ranked.tsv

gene_file=P_aphanis-THeavenSCOTT2020_1-ranked.tsv
taxon_code=RA20
echo -e "name\torthogroup" > temp.tsv
while IFS=$'\t' read -r line; do
    gene=$(echo "$line" | awk '{print $1}')
    gene_search="$taxon_code|$gene"
    orthogroup=$(grep "$gene_search" analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | cut -d ':' -f1)
    if [ $gene != "name" ]; then
    echo -e "$gene\t$orthogroup" >> temp.tsv
    fi
done < $gene_file
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85 <(sort $gene_file) <(sort temp.tsv) | sort | uniq > temp2.tsv && mv temp2.tsv $gene_file

gene_file=P_aphanis-THeavenDRCT72020_1-ranked.tsv
taxon_code=ST20
echo -e "name\torthogroup" > temp1.tsv
while IFS=$'\t' read -r line; do
    gene=$(echo "$line" | awk '{print $1}')
    gene_search="$taxon_code|$gene"
    orthogroup=$(grep "$gene_search" analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | cut -d ':' -f1)
    if [ $gene != "name" ]; then
    echo -e "$gene\t$orthogroup" >> temp1.tsv
    fi
done < $gene_file
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85 <(sort $gene_file) <(sort temp1.tsv) | sort | uniq > temp12.tsv && mv temp12.tsv $gene_file

gene_file=P_aphanis-THeavenDRCT72021_1-ranked.tsv
taxon_code=ST21
echo -e "name\torthogroup" > temp1.tsv
while IFS=$'\t' read -r line; do
    gene=$(echo "$line" | awk '{print $1}')
    gene_search="$taxon_code|$gene"
    orthogroup=$(grep "$gene_search" analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | cut -d ':' -f1)
    if [ $gene != "name" ]; then
    echo -e "$gene\t$orthogroup" >> temp1.tsv
    fi
done < $gene_file
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85 <(sort $gene_file) <(sort temp1.tsv) | sort | uniq > temp12.tsv && mv temp12.tsv $gene_file

gene_file=P_leucotricha-THeavenpOGB2019_1-ranked.tsv
taxon_code=AP19
echo -e "name\torthogroup" > temp.tsv
while IFS=$'\t' read -r line; do
    gene=$(echo "$line" | awk '{print $1}')
    gene_search="$taxon_code|$gene"
    orthogroup=$(grep "$gene_search" analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | cut -d ':' -f1)
    if [ $gene != "name" ]; then
    echo -e "$gene\t$orthogroup" >> temp.tsv
    fi
done < $gene_file
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85 <(sort $gene_file) <(sort temp.tsv) | sort | uniq > temp2.tsv && mv temp2.tsv $gene_file

gene_file=P_leucotricha-THeavenp11_1-ranked.tsv
taxon_code=AP20
echo -e "name\torthogroup" > temp1.tsv
while IFS=$'\t' read -r line; do
    gene=$(echo "$line" | awk '{print $1}')
    gene_search="$taxon_code|$gene"
    orthogroup=$(grep "$gene_search" analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | cut -d ':' -f1)
    if [ $gene != "name" ]; then
    echo -e "$gene\t$orthogroup" >> temp1.tsv
    fi
done < $gene_file
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85 <(sort $gene_file) <(sort temp1.tsv) | sort | uniq > temp12.tsv && mv temp12.tsv $gene_file

gene_file=P_leucotricha-THeavenpOGB2021_1-ranked.tsv
taxon_code=AP21
echo -e "name\torthogroup" > temp.tsv
while IFS=$'\t' read -r line; do
    gene=$(echo "$line" | awk '{print $1}')
    gene_search="$taxon_code|$gene"
    orthogroup=$(grep "$gene_search" analysis/orthology/orthofinder/All6_isolates/formatted/OrthoFinder/Results_Jul20_2/Orthogroups/Orthogroups.txt | cut -d ':' -f1)
    if [ $gene != "name" ]; then
    echo -e "$gene\t$orthogroup" >> temp.tsv
    fi
done < $gene_file
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18,1.19,1.20,1.21,1.22,1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30,1.31,1.32,1.33,1.34,1.35,1.36,1.37,1.38,1.39,1.40,1.41,1.42,1.43,1.44,1.45,1.46,1.47,1.48,1.49,1.50,1.51,1.52,1.53,1.54,1.55,1.56,1.57,1.58,1.59,1.60,1.61,1.62,1.63,1.64,1.65,1.66,1.67,1.68,1.69,1.70,1.71,1.72,1.73,1.74,1.75,1.76,1.77,1.78,1.79,1.80,1.81,1.82,1.83,1.84,1.85 <(sort $gene_file) <(sort temp.tsv) | sort | uniq > temp2.tsv && mv temp2.tsv $gene_file

while IFS=$'\t' read -r line; do
    awk -F'\t' '$27 == "1" && $23 == "." && $3 == "0" {print $2}' <<< "$line" | grep -v 'orthogroup' >> temp.txt
done < <(cat P_leucotricha-THeavenpOGB2021_1-ranked.tsv P_leucotricha-THeavenp11_1-ranked.tsv P_leucotricha-THeavenpOGB2019_1-ranked.tsv P_aphanis-THeavenDRCT72021_1-ranked.tsv P_aphanis-THeavenDRCT72020_1-ranked.tsv P_aphanis-THeavenSCOTT2020_1-ranked.tsv)


gene_file=P_leucotricha-THeavenpOGB2021_1-ranked.tsv
while IFS=$'\t' read -r line; do
    awk -F'\t' '$27 == "1" && $23 == "." && $3 == "0" {print $2}' <<< "$line" | grep -v 'orthogroup' 
done < $gene_file | awk '{count[$1]++} END {for (term in count) print term, count[term]}' > temp1.tsv

gene_file=P_leucotricha-THeavenp11_1-ranked.tsv
while IFS=$'\t' read -r line; do
    awk -F'\t' '$27 == "1" && $23 == "." && $3 == "0" {print $2}' <<< "$line" | grep -v 'orthogroup' 
done < $gene_file | awk '{count[$1]++} END {for (term in count) print term, count[term]}' > temp2.tsv

gene_file=P_leucotricha-THeavenpOGB2019_1-ranked.tsv
while IFS=$'\t' read -r line; do
    awk -F'\t' '$27 == "1" && $23 == "." && $3 == "0" {print $2}' <<< "$line" | grep -v 'orthogroup' 
done < $gene_file | awk '{count[$1]++} END {for (term in count) print term, count[term]}' > temp3.tsv

gene_file=P_aphanis-THeavenDRCT72021_1-ranked.tsv
while IFS=$'\t' read -r line; do
    awk -F'\t' '$27 == "1" && $23 == "." && $3 == "0" {print $2}' <<< "$line" | grep -v 'orthogroup' 
done < $gene_file | awk '{count[$1]++} END {for (term in count) print term, count[term]}' > temp4.tsv

gene_file=P_aphanis-THeavenDRCT72020_1-ranked.tsv
while IFS=$'\t' read -r line; do
    awk -F'\t' '$27 == "1" && $23 == "." && $3 == "0" {print $2}' <<< "$line" | grep -v 'orthogroup' 
done < $gene_file | awk '{count[$1]++} END {for (term in count) print term, count[term]}' > temp5.tsv

gene_file=P_aphanis-THeavenSCOTT2020_1-ranked.tsv
while IFS=$'\t' read -r line; do
    awk -F'\t' '$27 == "1" && $23 == "." && $3 == "0" {print $2}' <<< "$line" | grep -v 'orthogroup' 
done < $gene_file | awk '{count[$1]++} END {for (term in count) print term, count[term]}' > temp6.tsv

tr ' ' '\t' < temp1.tsv > temp_file && mv temp_file temp1.tsv
tr ' ' '\t' < temp2.tsv > temp_file && mv temp_file temp2.tsv
tr ' ' '\t' < temp3.tsv > temp_file && mv temp_file temp3.tsv
tr ' ' '\t' < temp4.tsv > temp_file && mv temp_file temp4.tsv
tr ' ' '\t' < temp5.tsv > temp_file && mv temp_file temp5.tsv
tr ' ' '\t' < temp6.tsv > temp_file && mv temp_file temp6.tsv

cat temp1.tsv temp2.tsv temp3.tsv temp4.tsv temp5.tsv temp6.tsv | awk '{print $1}' | sort | uniq > temp.tsv

join -t $'\t' -a 1 -e 0 -o 0,2.2 <(sort temp.tsv) <(sort temp1.tsv) > tempx.txt && mv tempx.txt temp.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2 <(sort temp.tsv) <(sort temp2.tsv) > tempx.txt && mv tempx.txt temp.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3 <(sort temp.tsv) <(sort temp3.tsv) > tempx.txt && mv tempx.txt temp.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4 <(sort temp.tsv) <(sort temp4.tsv) > tempx.txt && mv tempx.txt temp.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5 <(sort temp.tsv) <(sort temp5.tsv) > tempx.txt && mv tempx.txt temp.tsv
join -t $'\t' -a 1 -e 0 -o 0,2.2,1.2,1.3,1.4,1.5,1.6 <(sort temp.tsv) <(sort temp6.tsv) > tempx.txt && mv tempx.txt 6_OGs.tsv
```

```R
setwd("C:/Users/did23faz/OneDrive - Norwich Bioscience Institutes/Desktop/R")

library(ggplot2)
library(hexbin)
library(patchwork)

predector <- read.table("download/download/P_aphanis-THeavenDRCT72020_1-ranked.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nonest <- read.table("download/download/THeavenDRCT72020_1_intergenic_regions_nonest.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nest <- read.table("download/download/THeavenDRCT72020_1_intergenic_regions.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
names(nest)[2:4] <- paste0(names(nest)[2:4], "_2")
blast <- read.table("download/download/THeavenDRCT72020_1_busco_blast.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
csep_blast <- read.table("download/download/THeavenDRCT72020_1_csep_blast.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
merged_data <- merge(predector, nonest,  by = "name", all = TRUE)
merged_data2 <- merge(merged_data, nest, by = "name", all = TRUE)
merged_data3 <- merge(merged_data2, blast, by = "name", all = TRUE)
merged_data4 <- merge(merged_data3, csep_blast, by = "name", all = TRUE)

colnames(merged_data4) <- c('name','effector_score','manual_effector_score','manual_secretion_score','effector_matches','phibase_genes','phibase_phenotypes','phibase_ids','has_phibase_effector_match','has_phibase_virulence_match','has_phibase_lethal_match','pfam_ids','pfam_names','has_pfam_virulence_match','dbcan_matches','has_dbcan_virulence_match','effectorp1','effectorp2','effectorp3_cytoplasmic','effectorp3_apoplastic','effectorp3_noneffector','deepredeff_fungi','deepredeff_oomycete','apoplastp','is_secreted','any_signal_peptide','single_transmembrane','multiple_transmembrane','molecular_weight','residue_number','charge','isoelectric_point','aa_c_number','aa_tiny_number','aa_small_number','aa_aliphatic_number','aa_aromatic_number','aa_nonpolar_number','aa_charged_number','aa_basic_number','aa_acidic_number','fykin_gap','kex2_cutsites','rxlr_like_motifs','localizer_nucleus','localizer_chloro','localizer_mito','signal_peptide_cutsites','signalp3_nn','signalp3_hmm','signalp4','signalp5','signalp6','deepsig','phobius_sp','phobius_tmcount','phobius_tm_domains','tmhmm_tmcount','tmhmm_first_60','tmhmm_exp_aa','tmhmm_first_tm_sp_coverage','tmhmm_domains','targetp_secreted','targetp_secreted_prob','targetp_mitochondrial_prob','deeploc_membrane','deeploc_nucleus','deeploc_cytoplasm','deeploc_extracellular','deeploc_mitochondrion','deeploc_cell_membrane','deeploc_endoplasmic_reticulum','deeploc_plastid','deeploc_golgi','deeploc_lysosome','deeploc_peroxisome','signalp3_nn_d','signalp3_hmm_s','signalp4_d','signalp5_prob','signalp6_prob','deepsig_signal_prob','deepsig_transmembrane_prob','deepsig_other_prob','five_prime','three_prime','strand','five_prime_2','three_prime_2','strand_2','match','pident','length','mismatch','gapopen','qstart','qend','sstart','send','evalue','bitscore','qseq','sseq','match_1','pident_1','length_1','mismatch_1','gapopen_1','qstart_1','qend_1','sstart_1','send_1','evalue_1','bitscore_1','qseq_1','sseq_1')

merged_data4$five_prime <- abs(merged_data4$five_prime)
merged_data4$three_prime <- abs(merged_data4$three_prime)

merged_data4$group <- "Non SP"
merged_data4$group[!is.na(merged_data4$match)] <- "BUSCO"
merged_data4$group[is.na(merged_data4$match_1) & merged_data4$is_secreted == 1 & merged_data4$effectorp3_noneffector == "."] <- "CSEP"
merged_data4$group[merged_data4$effector_matches != "."] <- "Effector ortholog"

plot1 <- ggplot(merged_data4, aes(x= five_prime,y=three_prime)) +
  geom_hex(binwidth=c(0.05, 0.05))+
  #stat_bin2d(binwidth=c(0.05, 0.05))+
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000))+
  scale_x_log10(labels = scales::number_format()) +
  scale_y_log10(labels = scales::number_format()) +
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  #geom_point(data=subset(merged_data4, group == "BUSCO"), color = 'black', fill = 'grey',shape = 21,alpha = 0.7, size = 0.5)+
  geom_point(data=subset(merged_data4, group == "CSEP"), color = 'black', fill = 'white',shape = 21,alpha = 0.8, size = 1.5)+
  geom_point(data=subset(merged_data4, group == "Effector ortholog"), color = 'black', fill = 'red',shape = 21,alpha = 0.7, size = 1)+
  theme_minimal() +
    theme(panel.background = element_rect(fill = "grey90"), 
        panel.grid.major = element_line(color = "white"),  
        panel.grid.minor = element_line(color = "white", size = 0.2)) +
  ggtitle("Effector Intergenic Distances")+
  theme(plot.title = element_text(hjust = 0.5))

plot2 <- ggplot(merged_data4, aes(x= five_prime,y=three_prime)) +
  geom_hex(binwidth=c(0.05, 0.05))+
  #stat_bin2d(binwidth=c(0.05, 0.05))+
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000))+
  scale_x_log10(labels = scales::number_format()) +
  scale_y_log10(labels = scales::number_format()) +
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  geom_point(data=subset(merged_data4, group == "BUSCO"), color = 'black', fill = 'grey',shape = 21,alpha = 0.7, size = 0.5)+
  #geom_point(data=subset(merged_data4, group == "CSEP"), color = 'black', fill = 'white',shape = 21,alpha = 0.8, size = 1.5)+
  #geom_point(data=subset(merged_data4, group == "Effector ortholog"), color = 'black', fill = 'red',shape = 21,alpha = 0.7, size = 1)+
  theme_minimal() +
    theme(panel.background = element_rect(fill = "grey90"), 
        panel.grid.major = element_line(color = "white"),  
        panel.grid.minor = element_line(color = "white", size = 0.2)) +
  ggtitle("BUSCO Intergenic Distances")+
  theme(plot.title = element_text(hjust = 0.5))

combined_plots <- plot1 + plot2 + plot_layout(ncol = 2)
combined_plots_with_title <- combined_plots + plot_annotation(title = "THeavenDRCT72020", theme = theme(plot.title = element_text(hjust = 0.5)))

# Print the combined plots with title
print(combined_plots_with_title)

#####################################################################################################################################################################################################################################################################################
predector <- read.table("download/download/P_aphanis-THeavenDRCT72021_1-ranked.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nonest <- read.table("download/download/THeavenDRCT72021_1_intergenic_regions_nonest.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nest <- read.table("download/download/THeavenDRCT72021_1_intergenic_regions.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
names(nest)[2:4] <- paste0(names(nest)[2:4], "_2")
blast <- read.table("download/download/THeavenDRCT72021_1_busco_blast.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
csep_blast <- read.table("download/download/THeavenDRCT72021_1_csep_blast.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
merged_data <- merge(predector, nonest,  by = "name", all = TRUE)
merged_data2 <- merge(merged_data, nest, by = "name", all = TRUE)
merged_data3 <- merge(merged_data2, blast, by = "name", all = TRUE)
merged_data5 <- merge(merged_data3, csep_blast, by = "name", all = TRUE)

colnames(merged_data5) <- c('name','effector_score','manual_effector_score','manual_secretion_score','effector_matches','phibase_genes','phibase_phenotypes','phibase_ids','has_phibase_effector_match','has_phibase_virulence_match','has_phibase_lethal_match','pfam_ids','pfam_names','has_pfam_virulence_match','dbcan_matches','has_dbcan_virulence_match','effectorp1','effectorp2','effectorp3_cytoplasmic','effectorp3_apoplastic','effectorp3_noneffector','deepredeff_fungi','deepredeff_oomycete','apoplastp','is_secreted','any_signal_peptide','single_transmembrane','multiple_transmembrane','molecular_weight','residue_number','charge','isoelectric_point','aa_c_number','aa_tiny_number','aa_small_number','aa_aliphatic_number','aa_aromatic_number','aa_nonpolar_number','aa_charged_number','aa_basic_number','aa_acidic_number','fykin_gap','kex2_cutsites','rxlr_like_motifs','localizer_nucleus','localizer_chloro','localizer_mito','signal_peptide_cutsites','signalp3_nn','signalp3_hmm','signalp4','signalp5','signalp6','deepsig','phobius_sp','phobius_tmcount','phobius_tm_domains','tmhmm_tmcount','tmhmm_first_60','tmhmm_exp_aa','tmhmm_first_tm_sp_coverage','tmhmm_domains','targetp_secreted','targetp_secreted_prob','targetp_mitochondrial_prob','deeploc_membrane','deeploc_nucleus','deeploc_cytoplasm','deeploc_extracellular','deeploc_mitochondrion','deeploc_cell_membrane','deeploc_endoplasmic_reticulum','deeploc_plastid','deeploc_golgi','deeploc_lysosome','deeploc_peroxisome','signalp3_nn_d','signalp3_hmm_s','signalp4_d','signalp5_prob','signalp6_prob','deepsig_signal_prob','deepsig_transmembrane_prob','deepsig_other_prob','five_prime','three_prime','strand','five_prime_2','three_prime_2','strand_2','match','pident','length','mismatch','gapopen','qstart','qend','sstart','send','evalue','bitscore','qseq','sseq','match_1','pident_1','length_1','mismatch_1','gapopen_1','qstart_1','qend_1','sstart_1','send_1','evalue_1','bitscore_1','qseq_1','sseq_1')

merged_data5$five_prime <- abs(merged_data5$five_prime)
merged_data5$three_prime <- abs(merged_data5$three_prime)

merged_data5$group <- "Non SP"
merged_data5$group[!is.na(merged_data5$match)] <- "BUSCO"
merged_data5$group[is.na(merged_data5$match_1) & merged_data5$is_secreted == 1 & merged_data5$effectorp3_noneffector == "."] <- "CSEP"
merged_data5$group[merged_data5$effector_matches != "."] <- "Effector ortholog"

plot3 <- ggplot(merged_data5, aes(x= five_prime,y=three_prime)) +
  geom_hex(binwidth=c(0.05, 0.05))+
  #stat_bin2d(binwidth=c(0.05, 0.05))+
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000))+
  scale_x_log10(labels = scales::number_format()) +
  scale_y_log10(labels = scales::number_format()) +
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  #geom_point(data=subset(merged_data4, group == "BUSCO"), color = 'black', fill = 'grey',shape = 21,alpha = 0.7, size = 0.5)+
  geom_point(data=subset(merged_data5, group == "CSEP"), color = 'black', fill = 'white',shape = 21,alpha = 0.8, size = 1.5)+
  geom_point(data=subset(merged_data5, group == "Effector ortholog"), color = 'black', fill = 'red',shape = 21,alpha = 0.7, size = 1)+
  theme_minimal() +
    theme(panel.background = element_rect(fill = "grey90"), 
        panel.grid.major = element_line(color = "white"),  
        panel.grid.minor = element_line(color = "white", size = 0.2)) +
  ggtitle("Effector Intergenic Distances")+
  theme(plot.title = element_text(hjust = 0.5))

plot4 <- ggplot(merged_data5, aes(x= five_prime,y=three_prime)) +
  geom_hex(binwidth=c(0.05, 0.05))+
  #stat_bin2d(binwidth=c(0.05, 0.05))+
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000))+
  scale_x_log10(labels = scales::number_format()) +
  scale_y_log10(labels = scales::number_format()) +
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  geom_point(data=subset(merged_data5, group == "BUSCO"), color = 'black', fill = 'grey',shape = 21,alpha = 0.7, size = 0.5)+
  #geom_point(data=subset(merged_data4, group == "CSEP"), color = 'black', fill = 'white',shape = 21,alpha = 0.8, size = 1.5)+
  #geom_point(data=subset(merged_data4, group == "Effector ortholog"), color = 'black', fill = 'red',shape = 21,alpha = 0.7, size = 1)+
  theme_minimal() +
    theme(panel.background = element_rect(fill = "grey90"), 
        panel.grid.major = element_line(color = "white"),  
        panel.grid.minor = element_line(color = "white", size = 0.2)) +
  ggtitle("BUSCO Intergenic Distances")+
  theme(plot.title = element_text(hjust = 0.5))

combined_plots <- plot1 + plot2 + plot_layout(ncol = 2)
combined_plots_with_title <- combined_plots + plot_annotation(title = "THeavenDRCT72021", theme = theme(plot.title = element_text(hjust = 0.5)))

# Print the combined plots with title
print(combined_plots_with_title)

#####################################################################################################################################################################################################################################################################################
predector <- read.table("download/download/P_aphanis-THeavenSCOTT2020_1-ranked.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nonest <- read.table("download/download/THeavenSCOTT2020_1_intergenic_regions_nonest.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nest <- read.table("download/download/THeavenSCOTT2020_1_intergenic_regions.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
names(nest)[2:4] <- paste0(names(nest)[2:4], "_2")
blast <- read.table("download/download/THeavenSCOTT2020_1_busco_blast.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
csep_blast <- read.table("download/download/THeavenSCOTT2020_1_csep_blast.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
merged_data <- merge(predector, nonest,  by = "name", all = TRUE)
merged_data2 <- merge(merged_data, nest, by = "name", all = TRUE)
merged_data3 <- merge(merged_data2, blast, by = "name", all = TRUE)
merged_data6 <- merge(merged_data3, csep_blast, by = "name", all = TRUE)

colnames(merged_data6) <- c('name','effector_score','manual_effector_score','manual_secretion_score','effector_matches','phibase_genes','phibase_phenotypes','phibase_ids','has_phibase_effector_match','has_phibase_virulence_match','has_phibase_lethal_match','pfam_ids','pfam_names','has_pfam_virulence_match','dbcan_matches','has_dbcan_virulence_match','effectorp1','effectorp2','effectorp3_cytoplasmic','effectorp3_apoplastic','effectorp3_noneffector','deepredeff_fungi','deepredeff_oomycete','apoplastp','is_secreted','any_signal_peptide','single_transmembrane','multiple_transmembrane','molecular_weight','residue_number','charge','isoelectric_point','aa_c_number','aa_tiny_number','aa_small_number','aa_aliphatic_number','aa_aromatic_number','aa_nonpolar_number','aa_charged_number','aa_basic_number','aa_acidic_number','fykin_gap','kex2_cutsites','rxlr_like_motifs','localizer_nucleus','localizer_chloro','localizer_mito','signal_peptide_cutsites','signalp3_nn','signalp3_hmm','signalp4','signalp5','signalp6','deepsig','phobius_sp','phobius_tmcount','phobius_tm_domains','tmhmm_tmcount','tmhmm_first_60','tmhmm_exp_aa','tmhmm_first_tm_sp_coverage','tmhmm_domains','targetp_secreted','targetp_secreted_prob','targetp_mitochondrial_prob','deeploc_membrane','deeploc_nucleus','deeploc_cytoplasm','deeploc_extracellular','deeploc_mitochondrion','deeploc_cell_membrane','deeploc_endoplasmic_reticulum','deeploc_plastid','deeploc_golgi','deeploc_lysosome','deeploc_peroxisome','signalp3_nn_d','signalp3_hmm_s','signalp4_d','signalp5_prob','signalp6_prob','deepsig_signal_prob','deepsig_transmembrane_prob','deepsig_other_prob','five_prime','three_prime','strand','five_prime_2','three_prime_2','strand_2','match','pident','length','mismatch','gapopen','qstart','qend','sstart','send','evalue','bitscore','qseq','sseq','match_1','pident_1','length_1','mismatch_1','gapopen_1','qstart_1','qend_1','sstart_1','send_1','evalue_1','bitscore_1','qseq_1','sseq_1')

merged_data6$five_prime <- abs(merged_data6$five_prime)
merged_data6$three_prime <- abs(merged_data6$three_prime)

merged_data6$group <- "Non SP"
merged_data6$group[!is.na(merged_data6$match)] <- "BUSCO"
merged_data6$group[is.na(merged_data6$match_1) & merged_data6$is_secreted == 1 & merged_data6$effectorp3_noneffector == "."] <- "CSEP"
merged_data6$group[merged_data6$effector_matches != "."] <- "Effector ortholog"

plot5 <- ggplot(merged_data6, aes(x= five_prime,y=three_prime)) +
  geom_hex(binwidth=c(0.05, 0.05))+
  #stat_bin2d(binwidth=c(0.05, 0.05))+
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000))+
  scale_x_log10(labels = scales::number_format()) +
  scale_y_log10(labels = scales::number_format()) +
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  #geom_point(data=subset(merged_data4, group == "BUSCO"), color = 'black', fill = 'grey',shape = 21,alpha = 0.7, size = 0.5)+
  geom_point(data=subset(merged_data6, group == "CSEP"), color = 'black', fill = 'white',shape = 21,alpha = 0.8, size = 1.5)+
  geom_point(data=subset(merged_data6, group == "Effector ortholog"), color = 'black', fill = 'red',shape = 21,alpha = 0.7, size = 1)+
  theme_minimal() +
    theme(panel.background = element_rect(fill = "grey90"), 
        panel.grid.major = element_line(color = "white"),  
        panel.grid.minor = element_line(color = "white", size = 0.2)) +
  ggtitle("Effector Intergenic Distances")+
  theme(plot.title = element_text(hjust = 0.5))

plot6 <- ggplot(merged_data6, aes(x= five_prime,y=three_prime)) +
  geom_hex(binwidth=c(0.05, 0.05))+
  #stat_bin2d(binwidth=c(0.05, 0.05))+
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000))+
  scale_x_log10(labels = scales::number_format()) +
  scale_y_log10(labels = scales::number_format()) +
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  geom_point(data=subset(merged_data6, group == "BUSCO"), color = 'black', fill = 'grey',shape = 21,alpha = 0.7, size = 0.5)+
  #geom_point(data=subset(merged_data4, group == "CSEP"), color = 'black', fill = 'white',shape = 21,alpha = 0.8, size = 1.5)+
  #geom_point(data=subset(merged_data4, group == "Effector ortholog"), color = 'black', fill = 'red',shape = 21,alpha = 0.7, size = 1)+
  theme_minimal() +
    theme(panel.background = element_rect(fill = "grey90"), 
        panel.grid.major = element_line(color = "white"),  
        panel.grid.minor = element_line(color = "white", size = 0.2)) +
  ggtitle("BUSCO Intergenic Distances")+
  theme(plot.title = element_text(hjust = 0.5))

combined_plots <- plot1 + plot2 + plot_layout(ncol = 2)
combined_plots_with_title <- combined_plots + plot_annotation(title = "THeavenSCOTT2020", theme = theme(plot.title = element_text(hjust = 0.5)))

# Print the combined plots with title
print(combined_plots_with_title)

#####################################################################################################################################################################################################################################################################################
predector <- read.table("download/download/P_leucotricha-THeavenpOGB2019_1-ranked.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nonest <- read.table("download/download/THeavenpOGB2019_1_intergenic_regions_nonest.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nest <- read.table("download/download/THeavenpOGB2019_1_intergenic_regions.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
names(nest)[2:4] <- paste0(names(nest)[2:4], "_2")
blast <- read.table("download/download/THeavenpOGB2019_1_busco_blast.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
csep_blast <- read.table("download/download/THeavenpOGB2019_1_csep_blast.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
merged_data <- merge(predector, nonest,  by = "name", all = TRUE)
merged_data2 <- merge(merged_data, nest, by = "name", all = TRUE)
merged_data3 <- merge(merged_data2, blast, by = "name", all = TRUE)
merged_data7 <- merge(merged_data3, csep_blast, by = "name", all = TRUE)

colnames(merged_data7) <- c('name','effector_score','manual_effector_score','manual_secretion_score','effector_matches','phibase_genes','phibase_phenotypes','phibase_ids','has_phibase_effector_match','has_phibase_virulence_match','has_phibase_lethal_match','pfam_ids','pfam_names','has_pfam_virulence_match','dbcan_matches','has_dbcan_virulence_match','effectorp1','effectorp2','effectorp3_cytoplasmic','effectorp3_apoplastic','effectorp3_noneffector','deepredeff_fungi','deepredeff_oomycete','apoplastp','is_secreted','any_signal_peptide','single_transmembrane','multiple_transmembrane','molecular_weight','residue_number','charge','isoelectric_point','aa_c_number','aa_tiny_number','aa_small_number','aa_aliphatic_number','aa_aromatic_number','aa_nonpolar_number','aa_charged_number','aa_basic_number','aa_acidic_number','fykin_gap','kex2_cutsites','rxlr_like_motifs','localizer_nucleus','localizer_chloro','localizer_mito','signal_peptide_cutsites','signalp3_nn','signalp3_hmm','signalp4','signalp5','signalp6','deepsig','phobius_sp','phobius_tmcount','phobius_tm_domains','tmhmm_tmcount','tmhmm_first_60','tmhmm_exp_aa','tmhmm_first_tm_sp_coverage','tmhmm_domains','targetp_secreted','targetp_secreted_prob','targetp_mitochondrial_prob','deeploc_membrane','deeploc_nucleus','deeploc_cytoplasm','deeploc_extracellular','deeploc_mitochondrion','deeploc_cell_membrane','deeploc_endoplasmic_reticulum','deeploc_plastid','deeploc_golgi','deeploc_lysosome','deeploc_peroxisome','signalp3_nn_d','signalp3_hmm_s','signalp4_d','signalp5_prob','signalp6_prob','deepsig_signal_prob','deepsig_transmembrane_prob','deepsig_other_prob','five_prime','three_prime','strand','five_prime_2','three_prime_2','strand_2','match','pident','length','mismatch','gapopen','qstart','qend','sstart','send','evalue','bitscore','qseq','sseq','match_1','pident_1','length_1','mismatch_1','gapopen_1','qstart_1','qend_1','sstart_1','send_1','evalue_1','bitscore_1','qseq_1','sseq_1')

merged_data7$five_prime <- abs(merged_data7$five_prime)
merged_data7$three_prime <- abs(merged_data7$three_prime)

merged_data7$group <- "Non SP"
merged_data7$group[!is.na(merged_data7$match)] <- "BUSCO"
merged_data7$group[is.na(merged_data7$match_1) & merged_data7$is_secreted == 1 & merged_data7$effectorp3_noneffector == "."] <- "CSEP"
merged_data7$group[merged_data7$effector_matches != "."] <- "Effector ortholog"

plot7 <- ggplot(merged_data7, aes(x= five_prime,y=three_prime)) +
  geom_hex(binwidth=c(0.05, 0.05))+
  #stat_bin2d(binwidth=c(0.05, 0.05))+
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000))+
  scale_x_log10(labels = scales::number_format()) +
  scale_y_log10(labels = scales::number_format()) +
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  #geom_point(data=subset(merged_data4, group == "BUSCO"), color = 'black', fill = 'grey',shape = 21,alpha = 0.7, size = 0.5)+
  geom_point(data=subset(merged_data7, group == "CSEP"), color = 'black', fill = 'white',shape = 21,alpha = 0.8, size = 1.5)+
  geom_point(data=subset(merged_data7, group == "Effector ortholog"), color = 'black', fill = 'red',shape = 21,alpha = 0.7, size = 1)+
  theme_minimal() +
    theme(panel.background = element_rect(fill = "grey90"), 
        panel.grid.major = element_line(color = "white"),  
        panel.grid.minor = element_line(color = "white", size = 0.2)) +
  ggtitle("Effector Intergenic Distances")+
  theme(plot.title = element_text(hjust = 0.5))

plot8 <- ggplot(merged_data7, aes(x= five_prime,y=three_prime)) +
  geom_hex(binwidth=c(0.05, 0.05))+
  #stat_bin2d(binwidth=c(0.05, 0.05))+
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000))+
  scale_x_log10(labels = scales::number_format()) +
  scale_y_log10(labels = scales::number_format()) +
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  geom_point(data=subset(merged_data7, group == "BUSCO"), color = 'black', fill = 'grey',shape = 21,alpha = 0.7, size = 0.5)+
  #geom_point(data=subset(merged_data4, group == "CSEP"), color = 'black', fill = 'white',shape = 21,alpha = 0.8, size = 1.5)+
  #geom_point(data=subset(merged_data4, group == "Effector ortholog"), color = 'black', fill = 'red',shape = 21,alpha = 0.7, size = 1)+
  theme_minimal() +
    theme(panel.background = element_rect(fill = "grey90"), 
        panel.grid.major = element_line(color = "white"),  
        panel.grid.minor = element_line(color = "white", size = 0.2)) +
  ggtitle("BUSCO Intergenic Distances")+
  theme(plot.title = element_text(hjust = 0.5))

combined_plots <- plot1 + plot2 + plot_layout(ncol = 2)
combined_plots_with_title <- combined_plots + plot_annotation(title = "THeavenpOGB2019", theme = theme(plot.title = element_text(hjust = 0.5)))

# Print the combined plots with title
print(combined_plots_with_title)

#####################################################################################################################################################################################################################################################################################
predector <- read.table("download/download/P_leucotricha-THeavenp11_1-ranked.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nonest <- read.table("download/download/THeavenp11_1_intergenic_regions_nonest.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nest <- read.table("download/download/THeavenp11_1_intergenic_regions.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
names(nest)[2:4] <- paste0(names(nest)[2:4], "_2")
blast <- read.table("download/download/THeavenp11_1_busco_blast.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
csep_blast <- read.table("download/download/THeavenp11_1_csep_blast.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
merged_data <- merge(predector, nonest,  by = "name", all = TRUE)
merged_data2 <- merge(merged_data, nest, by = "name", all = TRUE)
merged_data3 <- merge(merged_data2, blast, by = "name", all = TRUE)
merged_data8 <- merge(merged_data3, csep_blast, by = "name", all = TRUE)

colnames(merged_data8) <- c('name','effector_score','manual_effector_score','manual_secretion_score','effector_matches','phibase_genes','phibase_phenotypes','phibase_ids','has_phibase_effector_match','has_phibase_virulence_match','has_phibase_lethal_match','pfam_ids','pfam_names','has_pfam_virulence_match','dbcan_matches','has_dbcan_virulence_match','effectorp1','effectorp2','effectorp3_cytoplasmic','effectorp3_apoplastic','effectorp3_noneffector','deepredeff_fungi','deepredeff_oomycete','apoplastp','is_secreted','any_signal_peptide','single_transmembrane','multiple_transmembrane','molecular_weight','residue_number','charge','isoelectric_point','aa_c_number','aa_tiny_number','aa_small_number','aa_aliphatic_number','aa_aromatic_number','aa_nonpolar_number','aa_charged_number','aa_basic_number','aa_acidic_number','fykin_gap','kex2_cutsites','rxlr_like_motifs','localizer_nucleus','localizer_chloro','localizer_mito','signal_peptide_cutsites','signalp3_nn','signalp3_hmm','signalp4','signalp5','signalp6','deepsig','phobius_sp','phobius_tmcount','phobius_tm_domains','tmhmm_tmcount','tmhmm_first_60','tmhmm_exp_aa','tmhmm_first_tm_sp_coverage','tmhmm_domains','targetp_secreted','targetp_secreted_prob','targetp_mitochondrial_prob','deeploc_membrane','deeploc_nucleus','deeploc_cytoplasm','deeploc_extracellular','deeploc_mitochondrion','deeploc_cell_membrane','deeploc_endoplasmic_reticulum','deeploc_plastid','deeploc_golgi','deeploc_lysosome','deeploc_peroxisome','signalp3_nn_d','signalp3_hmm_s','signalp4_d','signalp5_prob','signalp6_prob','deepsig_signal_prob','deepsig_transmembrane_prob','deepsig_other_prob','five_prime','three_prime','strand','five_prime_2','three_prime_2','strand_2','match','pident','length','mismatch','gapopen','qstart','qend','sstart','send','evalue','bitscore','qseq','sseq','match_1','pident_1','length_1','mismatch_1','gapopen_1','qstart_1','qend_1','sstart_1','send_1','evalue_1','bitscore_1','qseq_1','sseq_1')

merged_data8$five_prime <- abs(merged_data8$five_prime)
merged_data8$three_prime <- abs(merged_data8$three_prime)

merged_data8$group <- "Non SP"
merged_data8$group[!is.na(merged_data8$match)] <- "BUSCO"
merged_data8$group[is.na(merged_data8$match_1) & merged_data8$is_secreted == 1 & merged_data8$effectorp3_noneffector == "."] <- "CSEP"
merged_data8$group[merged_data8$effector_matches != "."] <- "Effector ortholog"

plot9 <- ggplot(merged_data8, aes(x= five_prime,y=three_prime)) +
  geom_hex(binwidth=c(0.05, 0.05))+
  #stat_bin2d(binwidth=c(0.05, 0.05))+
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000))+
  scale_x_log10(labels = scales::number_format()) +
  scale_y_log10(labels = scales::number_format()) +
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  #geom_point(data=subset(merged_data4, group == "BUSCO"), color = 'black', fill = 'grey',shape = 21,alpha = 0.7, size = 0.5)+
  geom_point(data=subset(merged_data8, group == "CSEP"), color = 'black', fill = 'white',shape = 21,alpha = 0.8, size = 1.5)+
  geom_point(data=subset(merged_data8, group == "Effector ortholog"), color = 'black', fill = 'red',shape = 21,alpha = 0.7, size = 1)+
  theme_minimal() +
    theme(panel.background = element_rect(fill = "grey90"), 
        panel.grid.major = element_line(color = "white"),  
        panel.grid.minor = element_line(color = "white", size = 0.2)) +
  ggtitle("Effector Intergenic Distances")+
  theme(plot.title = element_text(hjust = 0.5))

plot10 <- ggplot(merged_data8, aes(x= five_prime,y=three_prime)) +
  geom_hex(binwidth=c(0.05, 0.05))+
  #stat_bin2d(binwidth=c(0.05, 0.05))+
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000))+
  scale_x_log10(labels = scales::number_format()) +
  scale_y_log10(labels = scales::number_format()) +
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  geom_point(data=subset(merged_data8, group == "BUSCO"), color = 'black', fill = 'grey',shape = 21,alpha = 0.7, size = 0.5)+
  #geom_point(data=subset(merged_data4, group == "CSEP"), color = 'black', fill = 'white',shape = 21,alpha = 0.8, size = 1.5)+
  #geom_point(data=subset(merged_data4, group == "Effector ortholog"), color = 'black', fill = 'red',shape = 21,alpha = 0.7, size = 1)+
  theme_minimal() +
    theme(panel.background = element_rect(fill = "grey90"), 
        panel.grid.major = element_line(color = "white"),  
        panel.grid.minor = element_line(color = "white", size = 0.2)) +
  ggtitle("BUSCO Intergenic Distances")+
  theme(plot.title = element_text(hjust = 0.5))

combined_plots <- plot1 + plot2 + plot_layout(ncol = 2)
combined_plots_with_title <- combined_plots + plot_annotation(title = "THeavenp112020", theme = theme(plot.title = element_text(hjust = 0.5)))

# Print the combined plots with title
print(combined_plots_with_title)

#####################################################################################################################################################################################################################################################################################
predector <- read.table("download/download/P_leucotricha-THeavenpOGB2021_1-ranked.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nonest <- read.table("download/download/THeavenpOGB2021_1_intergenic_regions_nonest.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nest <- read.table("download/download/THeavenpOGB2021_1_intergenic_regions.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
names(nest)[2:4] <- paste0(names(nest)[2:4], "_2")
blast <- read.table("download/download/THeavenpOGB2021_1_busco_blast.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
csep_blast <- read.table("download/download/THeavenpOGB2021_1_csep_blast.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
merged_data <- merge(predector, nonest,  by = "name", all = TRUE)
merged_data2 <- merge(merged_data, nest, by = "name", all = TRUE)
merged_data3 <- merge(merged_data2, blast, by = "name", all = TRUE)
merged_data9 <- merge(merged_data3, csep_blast, by = "name", all = TRUE)

colnames(merged_data9) <- c('name','effector_score','manual_effector_score','manual_secretion_score','effector_matches','phibase_genes','phibase_phenotypes','phibase_ids','has_phibase_effector_match','has_phibase_virulence_match','has_phibase_lethal_match','pfam_ids','pfam_names','has_pfam_virulence_match','dbcan_matches','has_dbcan_virulence_match','effectorp1','effectorp2','effectorp3_cytoplasmic','effectorp3_apoplastic','effectorp3_noneffector','deepredeff_fungi','deepredeff_oomycete','apoplastp','is_secreted','any_signal_peptide','single_transmembrane','multiple_transmembrane','molecular_weight','residue_number','charge','isoelectric_point','aa_c_number','aa_tiny_number','aa_small_number','aa_aliphatic_number','aa_aromatic_number','aa_nonpolar_number','aa_charged_number','aa_basic_number','aa_acidic_number','fykin_gap','kex2_cutsites','rxlr_like_motifs','localizer_nucleus','localizer_chloro','localizer_mito','signal_peptide_cutsites','signalp3_nn','signalp3_hmm','signalp4','signalp5','signalp6','deepsig','phobius_sp','phobius_tmcount','phobius_tm_domains','tmhmm_tmcount','tmhmm_first_60','tmhmm_exp_aa','tmhmm_first_tm_sp_coverage','tmhmm_domains','targetp_secreted','targetp_secreted_prob','targetp_mitochondrial_prob','deeploc_membrane','deeploc_nucleus','deeploc_cytoplasm','deeploc_extracellular','deeploc_mitochondrion','deeploc_cell_membrane','deeploc_endoplasmic_reticulum','deeploc_plastid','deeploc_golgi','deeploc_lysosome','deeploc_peroxisome','signalp3_nn_d','signalp3_hmm_s','signalp4_d','signalp5_prob','signalp6_prob','deepsig_signal_prob','deepsig_transmembrane_prob','deepsig_other_prob','five_prime','three_prime','strand','five_prime_2','three_prime_2','strand_2','match','pident','length','mismatch','gapopen','qstart','qend','sstart','send','evalue','bitscore','qseq','sseq','match_1','pident_1','length_1','mismatch_1','gapopen_1','qstart_1','qend_1','sstart_1','send_1','evalue_1','bitscore_1','qseq_1','sseq_1')

merged_data9$five_prime <- abs(merged_data9$five_prime)
merged_data9$three_prime <- abs(merged_data9$three_prime)

merged_data9$group <- "Non SP"
merged_data9$group[!is.na(merged_data9$match)] <- "BUSCO"
merged_data9$group[is.na(merged_data9$match_1) & merged_data9$is_secreted == 1 & merged_data9$effectorp3_noneffector == "."] <- "CSEP"
merged_data9$group[merged_data9$effector_matches != "."] <- "Effector ortholog"

plot11 <- ggplot(merged_data9, aes(x= five_prime,y=three_prime)) +
  geom_hex(binwidth=c(0.05, 0.05))+
  #stat_bin2d(binwidth=c(0.05, 0.05))+
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000))+
  scale_x_log10(labels = scales::number_format()) +
  scale_y_log10(labels = scales::number_format()) +
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  #geom_point(data=subset(merged_data4, group == "BUSCO"), color = 'black', fill = 'grey',shape = 21,alpha = 0.7, size = 0.5)+
  geom_point(data=subset(merged_data9, group == "CSEP"), color = 'black', fill = 'white',shape = 21,alpha = 0.8, size = 1.5)+
  geom_point(data=subset(merged_data9, group == "Effector ortholog"), color = 'black', fill = 'red',shape = 21,alpha = 0.7, size = 1)+
  theme_minimal() +
    theme(panel.background = element_rect(fill = "grey90"), 
        panel.grid.major = element_line(color = "white"),  
        panel.grid.minor = element_line(color = "white", size = 0.2)) +
  ggtitle("Effector Intergenic Distances")+
  theme(plot.title = element_text(hjust = 0.5))

plot12 <- ggplot(merged_data9, aes(x= five_prime,y=three_prime)) +
  geom_hex(binwidth=c(0.05, 0.05))+
  #stat_bin2d(binwidth=c(0.05, 0.05))+
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000))+
  scale_x_log10(labels = scales::number_format()) +
  scale_y_log10(labels = scales::number_format()) +
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  geom_point(data=subset(merged_data9, group == "BUSCO"), color = 'black', fill = 'grey',shape = 21,alpha = 0.7, size = 0.5)+
  #geom_point(data=subset(merged_data4, group == "CSEP"), color = 'black', fill = 'white',shape = 21,alpha = 0.8, size = 1.5)+
  #geom_point(data=subset(merged_data4, group == "Effector ortholog"), color = 'black', fill = 'red',shape = 21,alpha = 0.7, size = 1)+
  theme_minimal() +
    theme(panel.background = element_rect(fill = "grey90"), 
        panel.grid.major = element_line(color = "white"),  
        panel.grid.minor = element_line(color = "white", size = 0.2)) +
  ggtitle("BUSCO Intergenic Distances")+
  theme(plot.title = element_text(hjust = 0.5))

combined_plots <- plot1 + plot2 + plot_layout(ncol = 2)
combined_plots_with_title <- combined_plots + plot_annotation(title = "THeavenpOGB2021", theme = theme(plot.title = element_text(hjust = 0.5)))

# Print the combined plots with title
print(combined_plots_with_title)
```
```R
library(ggplot2)
library(patchwork)
library(dplyr)

#See permutation_vs_busco.R for generation of merged_data4 - merged_data9

df_all <- merged_data4 #DRCT72020
#df_all <- merged_data5 #DRCT72021
#df_all <- merged_data6 #SCOTT2020
#df_all <- merged_data7 #OGB2019
#df_all <- merged_data8 #p112020
#df_all <- merged_data9 #OGB2021

df_all$BUSCO <- "Non BUSCO"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CSEP <- "Non SP"
df_all$CSEP[is.na(df_all$match_1) & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

df_all$cazy <- "Non CAZY"
df_all$cazy[df_all$dbcan_matches != "."] <- "CAZY"

df_all$ralph <- "Non RALPH"
df_all <- df_all %>%
  mutate(ralph = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", ralph))

df_all$eka <- "Non EKA"
df_all <- df_all %>%
  mutate(eka = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", eka))
df_all$eka[df_all$is_secreted == 1] <- "Non EKA"

# Plot 1
df_all$tempvar <- "Total"
plot101 <- ggplot(df_all, aes(x= five_prime, y=three_prime)) +
  geom_hex(binwidth=0.05) +
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000)) +
  scale_x_log10(labels = scales::number_format(), breaks = NULL) +
  scale_y_log10(labels = scales::number_format(), breaks = c(1, 10, 100, 1000, 10000, 100000)) +
  ylab("") +
  xlab("") +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "grey93"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

plot101 <- plot101 + facet_grid(. ~ tempvar) +
  theme(strip.background = element_rect(fill="grey35"),
        strip.text = element_text(size=15, colour="white"))

# Plot 2
df_all$tempvar <- "BUSCO"
plot102 <- ggplot(df_all, aes(x = five_prime, y = three_prime)) +
  geom_hex(binwidth = 0.05, fill = "grey") +
  scale_x_log10(labels = scales::number_format(), breaks = NULL) +
  scale_y_log10(labels = scales::number_format(), breaks = NULL) +
  ylab("") +
  xlab("") +
  geom_point(data=subset(df_all, BUSCO == "BUSCO"), color = 'black', fill = 'firebrick2',shape = 21,alpha = 0.7, size = 1) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "grey93"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

plot102 <- plot102 + facet_grid(. ~ tempvar) +
  theme(strip.background = element_rect(fill="grey35"),
        strip.text = element_text(size=15, colour="white"))

# Plot 3
df_all$tempvar <- "CAZY"
plot103 <- ggplot(df_all, aes(x = five_prime, y = three_prime)) +
  geom_hex(binwidth = 0.05, fill = "grey") +
  scale_x_log10(labels = scales::number_format(), breaks = NULL) +
  scale_y_log10(labels = scales::number_format(), breaks = c(1, 10, 100, 1000, 10000, 100000)) +
  ylab("5' prime intergenic length (bp)") +
  xlab("") +
  geom_point(data=subset(df_all, cazy == "CAZY"), color = 'black', fill = 'firebrick2',shape = 21,alpha = 0.7, size = 1.5) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "grey93"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) 

plot103 <- plot103 + facet_grid(. ~ tempvar) +
  theme(strip.background = element_rect(fill="grey35"),
        strip.text = element_text(size=15, colour="white"))

# Plot 4
df_all$tempvar <- "CSEP"
plot104 <- ggplot(df_all, aes(x = five_prime, y = three_prime)) +
  geom_hex(binwidth = 0.05, fill = "grey") +
  scale_x_log10(labels = scales::number_format(), breaks = NULL) +
  scale_y_log10(labels = scales::number_format(), breaks = NULL) +
  ylab("") +
  xlab("") +
  geom_point(data=subset(df_all, CSEP == "CSEP"), color = 'black', fill = 'firebrick2',shape = 21,alpha = 0.7, size = 1.5) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "grey93"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) 

plot104 <- plot104 + facet_grid(. ~ tempvar) +
  theme(strip.background = element_rect(fill="grey35"),
        strip.text = element_text(size=15, colour="white"))

# Plot 5
df_all$tempvar <- "EKA"
plot105 <- ggplot(df_all, aes(x = five_prime, y = three_prime)) +
  geom_hex(binwidth = 0.05, fill = "grey") +
  scale_x_log10(labels = scales::number_format(), breaks = c(1, 10, 100, 1000, 10000, 100000)) +
  scale_y_log10(labels = scales::number_format(), breaks = c(1, 10, 100, 1000, 10000, 100000)) +
  ylab("") +
  xlab("") +
  geom_point(data=subset(df_all, eka == "EKA"), color = 'black', fill = 'firebrick2',shape = 21,alpha = 0.7, size = 1.5) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "grey93"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) 

plot105 <- plot105 + facet_grid(. ~ tempvar) +
  theme(strip.background = element_rect(fill="grey35"),
        strip.text = element_text(size=15, colour="white"))

# Plot 6
df_all$tempvar <- "RALPH"
plot106 <- ggplot(df_all, aes(x = five_prime, y = three_prime)) +
  geom_hex(binwidth = 0.05, fill = "grey") +
  scale_x_log10(labels = scales::number_format(), breaks = c(1, 10, 100, 1000, 10000, 100000)) +
  scale_y_log10(labels = scales::number_format(), breaks = NULL) +
  ylab("") +
  xlab("3' prime intergenic length (bp)") +
  geom_point(data=subset(df_all, ralph == "RALPH"), color = 'black', fill = 'firebrick2',shape = 21,alpha = 0.7, size = 1.5) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "grey93"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title.x = element_text(hjust = -0.6, vjust = -1))  

plot106 <- plot106 + facet_grid(. ~ tempvar) +
  theme(strip.background = element_rect(fill="grey35"),
        strip.text = element_text(size=15, colour="white"))


# Combine plots with axis titles
combined_plot <- plot101 + plot102 + plot103 + plot104 + plot105 + plot106 +
  plot_layout(ncol = 2, nrow = 3, guides = 'collect') 

# Display combined plot
combined_plot

#Export as pdf to retain hexagonal bin shape
```
```R
library(ggplot2)
library(patchwork)
library(dplyr)

df_all <- merged_data4 #DRCT72020
#df_all <- merged_data5 #DRCT72021
#df_all <- merged_data6 #SCOTT2020
#df_all <- merged_data7 #OGB2019
#df_all <- merged_data8 #p112020
#df_all <- merged_data9 #OGB2021

df_all$BUSCO <- "Non BUSCO"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CSEP <- "Non SP"
df_all$CSEP[is.na(df_all$match_1) & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

df_all$cazy <- "Non CAZY"
df_all$cazy[df_all$dbcan_matches != "."] <- "CAZY"

df_all$ralph <- "Non RALPH"
df_all <- df_all %>%
  mutate(ralph = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", ralph))

df_all$eka <- "Non EKA"
df_all <- df_all %>%
  mutate(eka = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", eka))
df_all$eka[df_all$is_secreted == 1] <- "Non EKA"

# Plot 1
df_all$tempvar <- "Total"
plot101 <- ggplot(df_all, aes(x = five_prime, y = three_prime)) +
  geom_hex(binwidth = c(0.15, 0.15)) +
  scale_fill_distiller(palette = "Spectral", name = "Gene\ncount", trans = "log10", breaks = c(0, 10, 100, 1000, 4000)) +
  scale_x_continuous(trans = "log2", breaks = c(2, 8, 32, 128, 512, 2048, 8192, 32768)) +
  scale_y_continuous(trans = "log2", breaks = c(2, 8, 32, 128, 512, 2048, 8192, 32768)) +
  ylab("") +
  xlab("") +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "grey93"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

plot1011 <- plot101 + facet_grid(. ~ tempvar) +
  theme(strip.background = element_rect(fill = "grey35"),
        strip.text = element_text(size = 15, colour = "white"))

# Plot 2
df_all$tempvar <- "BUSCO"
plot102 <- ggplot(df_all, aes(x = five_prime, y = three_prime)) +
  geom_hex(binwidth = c(0.15, 0.15), fill = "grey") +
  scale_x_continuous(trans = "log2", breaks = c(2, 8, 32, 128, 512, 2048, 8192, 32768)) +
  scale_y_continuous(trans = "log2", breaks = c(2, 8, 32, 128, 512, 2048, 8192, 32768)) +
  ylab("") +
  xlab("") +
  geom_point(data = subset(df_all, BUSCO == "BUSCO"), color = 'black', fill = 'firebrick2', shape = 21, alpha = 0.7, size = 1.5) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "grey93"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

plot1022 <- plot102 + facet_grid(. ~ tempvar) +
  theme(strip.background = element_rect(fill = "grey35"),
        strip.text = element_text(size = 15, colour = "white"))

#Plot3
df_all$tempvar <- "CAZY"
plot103 <- ggplot(df_all, aes(x = five_prime, y = three_prime)) +
  geom_hex(binwidth = c(0.15, 0.15), fill = "grey") +
  scale_x_continuous(trans = "log2", breaks = NULL) +
  scale_y_continuous(trans = "log2", breaks = c(2, 8, 32, 128, 512, 2048, 8192, 32768)) +
  ylab("5' prime intergenic length (bp)") +
  xlab("") +
  geom_point(data = subset(df_all, cazy == "CAZY"), color = 'black', fill = 'firebrick2', shape = 21, alpha = 0.7, size = 2) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "grey93"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

plot1033 <- plot103 + facet_grid(. ~ tempvar) +
  theme(strip.background = element_rect(fill = "grey35"),
        strip.text = element_text(size = 15, colour = "white"))


# Plot 4
df_all$tempvar <- "CSEP"
plot104 <- ggplot(df_all, aes(x = five_prime, y = three_prime)) +
  geom_hex(binwidth = c(0.15, 0.15), fill = "grey") +
  scale_x_continuous(trans = "log2", breaks = NULL) +
  scale_y_continuous(trans = "log2", breaks = NULL) +
  ylab("") +
  xlab("") +
  geom_point(data=subset(df_all, CSEP == "CSEP"), color = 'black', fill = 'firebrick2',shape = 21,alpha = 0.7, size = 2) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "grey93"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) 

plot1044 <- plot104 + facet_grid(. ~ tempvar) +
  theme(strip.background = element_rect(fill="grey35"),
        strip.text = element_text(size=15, colour="white"))

# Plot 5
df_all$tempvar <- "EKA"
plot105 <- ggplot(df_all, aes(x = five_prime, y = three_prime)) +
  geom_hex(binwidth = c(0.15, 0.15), fill = "grey") +
  scale_x_continuous(trans = "log2", breaks = c(2, 8, 32, 128, 512, 2048, 8192, 32768)) +
  scale_y_continuous(trans = "log2", breaks = c(2, 8, 32, 128, 512, 2048, 8192, 32768)) +
  ylab("") +
  xlab("") +
  geom_point(data=subset(df_all, eka == "EKA"), color = 'black', fill = 'firebrick2',shape = 21,alpha = 0.7, size = 2) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "grey93"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) 

plot1055 <- plot105 + facet_grid(. ~ tempvar) +
  theme(strip.background = element_rect(fill="grey35"),
        strip.text = element_text(size=15, colour="white"))

# Plot 6
df_all$tempvar <- "RALPH"
plot1066 <- ggplot(df_all, aes(x = five_prime, y = three_prime)) +
  geom_hex(binwidth = c(0.15, 0.15), fill = "grey") +
  scale_x_continuous(trans = "log2", breaks = c(2, 8, 32, 128, 512, 2048, 8192, 32768)) +
  scale_y_continuous(trans = "log2", breaks = NULL) +
  ylab("") +
  xlab("3' prime intergenic length (bp)") +
  geom_point(data=subset(df_all, ralph == "RALPH"), color = 'black', fill = 'firebrick2',shape = 21,alpha = 0.7, size = 2) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "grey93"), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title.x = element_text(hjust = -0.6, vjust = -1))  

plot106 <- plot106 + facet_grid(. ~ tempvar) +
  theme(strip.background = element_rect(fill="grey35"),
        strip.text = element_text(size=15, colour="white"))


# Combine plots with axis titles
combined_plot <- plot101 + plot102 + plot103 + plot104 + plot105 + plot106 +
  plot_layout(ncol = 2, nrow = 3, guides = 'collect') 

# Display combined plot
combined_plot
```
```R
install.packages("ggthemr")
library(ggthemr)
ggthemr('dust')

ggplot(allte) +
  geom_point(aes(x=te_type, y=distance), alpha = 0.04, position = 'jitter') +
  geom_violin(aes(x=te_type, y=distance, fill=te_type)) +
  facet_wrap(~group+secr) +
  scale_fill_brewer(palette = "Spectral", name = "Types") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 9, hjust = 1), plot.title = element_text(hjust = 0.5)) +
  scale_y_log10() +
  ylab("Distance for start/stop codon (bp)") +
  xlab("Repetitive element type (bp)")


```
```R
#permutation test

#df <- merged_data4 #DRCT72020
#df <- merged_data5 #DRCT72021
#df <- merged_data6 #SCOTT2020
#df <- merged_data7 #OGB2019
df <- merged_data8 #p112020
#df <- merged_data9 #OGB2021

search <- read.table("p11_1_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[is.na(df_all$match_1) & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

df_all$cazy <- "Non"
df_all$cazy[df_all$dbcan_matches != "."] <- "CAZY"

df_all$ralph <- "Non"
df_all <- df_all %>%
  mutate(ralph = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", ralph))

df_all$eka <- "Non"
df_all <- df_all %>%
  mutate(eka = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", eka))
df_all$eka[df_all$is_secreted == 1] <- "Non"

#df_all <- read.xlsx(OBG2021_output.xlsx)
# 5-prime IG
#df_filtered <- df_all[!is.na(df_all$five_prime_2), ]
df_filtered <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime_2, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime_2, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)

# 3-prime IG
#df_filtered <- df_all[!is.na(df_all$three_prime_2), ]
df_filtered <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime_2, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime_2, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime_2), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime_2), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)

df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

#ggsave("p112020_CSEPs_total_IG_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
#ggsave("p112020_CSEPs_5_IG_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
#ggsave("p112020_CSEPs_3_IG_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")

print(paste("p112020 CSEPs total intergenic distance:", total_sig))
print(paste("p112020 CSEPs 5' intergenic distance:", sig_5))
print(paste("p112020 CSEPs 3' intergenic distance:", sig_3))

#OGB2019
#[1] -222.6766
#> obs_diff_three
#[1] 131.8372
#> obs_diff
#[1] -121.6358

#p11:
#> obs_diff_five
#[1] -239.8106
#> obs_diff_three
#[1] -133.9127
#> obs_diff
#[1] -354.4823
#Larger values means that treatment has greater intergenic distance than average
```
DRCT72020 BUSCOs total intergenic distance: 9999 -417.9701
DRCT72020 BUSCOs 5' intergenic distance: 9858 -183.9207
DRCT72020 BUSCOs 3' intergenic distance: 9999 -356.8109
DRCT72021 BUSCOs total intergenic distance: 9994 -172.3595
DRCT72021 BUSCOs 5' intergenic distance: 4191  -26.40291
DRCT72021 BUSCOs 3' intergenic distance: 9999  -230.5262
SCOTT2020 BUSCOs total intergenic distance: 9996 -241.4624
SCOTT2020 BUSCOs 5' intergenic distance: 8594 -136.1806
SCOTT2020 BUSCOs 3' intergenic distance: 9999 -316.6873
OGB2019 BUSCOs total intergenic distance: 9999 -560.0114
OGB2019 BUSCOs 5' intergenic distance: 9999 -245.8632
OGB2019 BUSCOs 3' intergenic distance: 9999 -391.0658
p112020 BUSCOs total intergenic distance: 9999 -602.9644
p112020 BUSCOs 5' intergenic distance: 9999 -291.3127
p112020 BUSCOs 3' intergenic distance: 9999 -421.7756
OGB2021 BUSCOs total intergenic distance: 9999 -563.4564
OGB2021 BUSCOs 5' intergenic distance: 9999 -252.8035
OGB2021 BUSCOs 3' intergenic distance: 9999 -433.852

DRCT72020 CSEPs total intergenic distance: 7949 -240.2212 -240.2212
DRCT72020 CSEPs 5' intergenic distance: 9865 -408.6646 -408.6646
DRCT72020 CSEPs 3' intergenic distance: 825 -5.500626 -5.500626
DRCT72021 CSEPs total intergenic distance: 9920 -240.2212 -705.1919
DRCT72021 CSEPs 5' intergenic distance: 9900 -519.6433 -352.3155
DRCT72021 CSEPs 3' intergenic distance: 9103 249.3098 -278.8598
SCOTT2020 CSEPs total intergenic distance: 9353 -121.8177 -625.3545
SCOTT2020 CSEPs 5' intergenic distance: 9680 -223.0411 -267.9205
SCOTT2020 CSEPs 3' intergenic distance: 6623 131.3029 -157.6641
OGB2019 CSEPs total intergenic distance: 9999 -121.8177 -888.3778
OGB2019 CSEPs 5' intergenic distance: 9991 -223.0411 -526.7162
OGB2019 CSEPs 3' intergenic distance: 9993 131.3029 -411.5581
p112020 CSEPs total intergenic distance: 9999 -354.6657 -869.7425
p112020 CSEPs 5' intergenic distance: 9996 -240.2913 -400.2325
p112020 CSEPs 3' intergenic distance: 9990 -134.4478 -415.7889
OGB2021 CSEPs total intergenic distance: 9998  -570.2163 -798.4079
OGB2021 CSEPs 5' intergenic distance: 9992 -354.4675 -475.466
OGB2021 CSEPs 3' intergenic distance: 9946 -170.8715 -372.2526

DRCT72020 CAZYs total intergenic distance: 7855
DRCT72020 CAZYs 5' intergenic distance: 9884
DRCT72020 CAZYs 3' intergenic distance: 783
DRCT72021 CAZYs total intergenic distance: 9913
DRCT72021 CAZYs 5' intergenic distance: 9890
DRCT72021 CAZYs 3' intergenic distance: 9140
SCOTT2020 CAZYs total intergenic distance: 9334
SCOTT2020 CAZYs 5' intergenic distance: 9626
SCOTT2020 CAZYs 3' intergenic distance: 6646
OGB2019 CAZYs total intergenic distance: 9999
OGB2019 CAZYs 5' intergenic distance: 9995
OGB2019 CAZYs 3' intergenic distance: 9992
p112020 CAZYs total intergenic distance: 9999
p112020 CAZYs 5' intergenic distance: 9999
p112020 CAZYs 3' intergenic distance: 9989
OGB2021 CAZYs total intergenic distance: 9999
OGB2021 CAZYs 5' intergenic distance: 9997
OGB2021 CAZYs 3' intergenic distance: 9940

DRCT72020 RALPHs total intergenic distance: 7969
DRCT72020 RALPHs 5' intergenic distance: 9892
DRCT72020 RALPHs 3' intergenic distance: 755
DRCT72021 RALPHs total intergenic distance: 9929
DRCT72021 RALPHs 5' intergenic distance: 9898
DRCT72021 RALPHs 3' intergenic distance: 9170
SCOTT2020 RALPHs total intergenic distance: 9314
SCOTT2020 RALPHs 5' intergenic distance: 9645
SCOTT2020 RALPHs 3' intergenic distance: 6658
OGB2019 RALPHs total intergenic distance: 9999
OGB2019 RALPHs 5' intergenic distance: 9998
OGB2019 RALPHs 3' intergenic distance: 9995
p112020 RALPHs total intergenic distance: 9998
p112020 RALPHs 5' intergenic distance: 9999
p112020 RALPHs 3' intergenic distance: 9297
OGB2021 RALPHs total intergenic distance: 9998
OGB2021 RALPHs 5' intergenic distance: 9993
OGB2021 RALPHs 3' intergenic distance: 9938

DRCT72020 EKAs total intergenic distance: 7923 
DRCT72020 EKAs 5' intergenic distance: 9875 
DRCT72020 EKAs 3' intergenic distance: 738 
DRCT72021 EKAs total intergenic distance: 9933
DRCT72021 EKAs 5' intergenic distance: 9870
DRCT72021 EKAs 3' intergenic distance: 9112
SCOTT2020 EKAs total intergenic distance: 9393
SCOTT2020 EKAs 5' intergenic distance: 9635
SCOTT2020 EKAs 3' intergenic distance: 6625
OGB2019 EKAs total intergenic distance: 9999
OGB2019 EKAs 5' intergenic distance: 9995
OGB2019 EKAs 3' intergenic distance: 9996
p112020 EKAs total intergenic distance: 77
p112020 EKAs 5' intergenic distance: 6454
p112020 EKAs 3' intergenic distance: 0
OGB2021 EKAs total intergenic distance: 9999 
OGB2021 EKAs 5' intergenic distance: 9989 
OGB2021 EKAs 3' intergenic distance: 9930 

Investigate short IG genes:
```R
df <- merged_data4 #DRCT72020
search <- read.table("DRCT72020_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)
filtered_rows <- df_all %>%
  filter(five_prime_2 >= 0 & five_prime_2 <= 200)
write.table(filtered_rows$name, "DRCT72020_low5.txt", row.names = FALSE, col.names = FALSE)
filtered_rows <- df_all %>%
  filter(five_prime_2 >= 0 & three_prime_2 <= 200)
write.table(filtered_rows$name, "DRCT72020_low3.txt", row.names = FALSE, col.names = FALSE)

df <- merged_data5 #DRCT72021
search <- read.table("DRCT72021_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)
filtered_rows <- df_all %>%
  filter(five_prime_2 >= 0 & five_prime_2 <= 200)
write.table(filtered_rows$name, "DRCT72021_low5.txt", row.names = FALSE, col.names = FALSE)
filtered_rows <- df_all %>%
  filter(five_prime_2 >= 0 & three_prime_2 <= 200)
write.table(filtered_rows$name, "DRCT72021_low3.txt", row.names = FALSE, col.names = FALSE)

df <- merged_data6 #SCOTT2020
search <- read.table("SCOTT2020_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)
filtered_rows <- df_all %>%
  filter(five_prime_2 >= 0 & five_prime_2 <= 200)
write.table(filtered_rows$name, "SCOTT2020_low5.txt", row.names = FALSE, col.names = FALSE)
filtered_rows <- df_all %>%
  filter(five_prime_2 >= 0 & three_prime_2 <= 200)
write.table(filtered_rows$name, "SCOTT2020_low3.txt", row.names = FALSE, col.names = FALSE)

df <- merged_data7 #OGB2019
search <- read.table("OGB2019_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)
filtered_rows <- df_all %>%
  filter(five_prime_2 >= 0 & five_prime_2 <= 200)
write.table(filtered_rows$name, "OGB2019_low5.txt", row.names = FALSE, col.names = FALSE)
filtered_rows <- df_all %>%
  filter(five_prime_2 >= 0 & three_prime_2 <= 200)
write.table(filtered_rows$name, "OGB2019_low3.txt", row.names = FALSE, col.names = FALSE)

df <- merged_data8 #p112020
search <- read.table("p11_1_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)
filtered_rows <- df_all %>%
  filter(five_prime_2 >= 0 & five_prime_2 <= 200)
write.table(filtered_rows$name, "p112020_low5.txt", row.names = FALSE, col.names = FALSE)
filtered_rows <- df_all %>%
  filter(five_prime_2 >= 0 & three_prime_2 <= 200)
write.table(filtered_rows$name, "p112020_low3.txt", row.names = FALSE, col.names = FALSE)

df <- merged_data9 #OGB2021
search <- read.table("OGB2021_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)
filtered_rows <- df_all %>%
  filter(five_prime_2 >= 0 & five_prime_2 <= 200)
write.table(filtered_rows$name, "OGB2021_low5.txt", row.names = FALSE, col.names = FALSE)
filtered_rows <- df_all %>%
  filter(three_prime_2 >= 0 & three_prime_2 <= 200)
write.table(filtered_rows$name, "OGB2021_low3.txt", row.names = FALSE, col.names = FALSE)
```
```bash
sed -i 's/"//g' *low3.txt
sed -i 's/"//g' *low5.txt
sed -i 's/[^[:print:]\t]//g' *low3.txt
sed -i 's/[^[:print:]\t]//g' *low5.txt

grep -f DRCT72020_low5.txt gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/NRI/P.aphanis_strawberry2020_interproscan.tsv | grep 'GO:' | awk -F'\t' '{split($NF, arr, "|"); for (i in arr) {print $1, arr[i]}}' | sort -u | awk '{print $2}' | awk '{count[$1]++} END {for (word in count) print word, count[word]}' | awk '{print $2, $1}' | sort -nr | awk '{print $2, $1}' > DRCT72020_sub200-5.tsv
grep -f DRCT72021_low5.txt gene_pred/P_aphanis/THeavenDRCT72021_1/interproscan/NRI/P.aphanis_strawberry2021_interproscan.tsv | grep 'GO:' | awk -F'\t' '{split($NF, arr, "|"); for (i in arr) {print $1, arr[i]}}' | sort -u | awk '{print $2}' | awk '{count[$1]++} END {for (word in count) print word, count[word]}' | awk '{print $2, $1}' | sort -nr | awk '{print $2, $1}' > DRCT72021_sub200-5.tsv
grep -f SCOTT2020_low5.txt gene_pred/P_aphanis/THeavenSCOTT2020_1/interproscan/NRI/P.aphanis_raspberry2020_interproscan.tsv | grep 'GO:' | awk -F'\t' '{split($NF, arr, "|"); for (i in arr) {print $1, arr[i]}}' | sort -u | awk '{print $2}' | awk '{count[$1]++} END {for (word in count) print word, count[word]}' | awk '{print $2, $1}' | sort -nr | awk '{print $2, $1}' > SCOTT2020_sub200-5.tsv
grep -f OGB2019_low5.txt gene_pred/P_leucotricha/THeavenpOGB2019_1/interproscan/NRI/P.leucotricha_apple2019_interproscan.tsv | grep 'GO:' | awk -F'\t' '{split($NF, arr, "|"); for (i in arr) {print $1, arr[i]}}' | sort -u | awk '{print $2}' | awk '{count[$1]++} END {for (word in count) print word, count[word]}' | awk '{print $2, $1}' | sort -nr | awk '{print $2, $1}' > OGB2019_sub200-5.tsv
grep -f p112020_low5.txt gene_pred/P_leucotricha/THeavenp11_1/interproscan/NRI/P.leucotricha_apple2020_interproscan.tsv | grep 'GO:' | awk -F'\t' '{split($NF, arr, "|"); for (i in arr) {print $1, arr[i]}}' | sort -u | awk '{print $2}' | awk '{count[$1]++} END {for (word in count) print word, count[word]}' | awk '{print $2, $1}' | sort -nr | awk '{print $2, $1}' > p112020_sub200-5.tsv
grep -f OGB2021_low5.txt gene_pred/P_leucotricha/THeavenpOGB2021_1/interproscan/NRI/P.leucotricha_apple2021_interproscan.tsv | grep 'GO:' | awk -F'\t' '{split($NF, arr, "|"); for (i in arr) {print $1, arr[i]}}' | sort -u | awk '{print $2}' | awk '{count[$1]++} END {for (word in count) print word, count[word]}' | awk '{print $2, $1}' | sort -nr | awk '{print $2, $1}' > OGB2021_sub200-5.tsv

grep -f DRCT72020_low3.txt gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/NRI/P.aphanis_strawberry2020_interproscan.tsv | grep 'GO:' | awk -F'\t' '{split($NF, arr, "|"); for (i in arr) {print $1, arr[i]}}' | sort -u | awk '{print $2}' | awk '{count[$1]++} END {for (word in count) print word, count[word]}' | awk '{print $2, $1}' | sort -nr | awk '{print $2, $1}' > DRCT72020_sub200-3.tsv
grep -f DRCT72021_low3.txt gene_pred/P_aphanis/THeavenDRCT72021_1/interproscan/NRI/P.aphanis_strawberry2021_interproscan.tsv | grep 'GO:' | awk -F'\t' '{split($NF, arr, "|"); for (i in arr) {print $1, arr[i]}}' | sort -u | awk '{print $2}' | awk '{count[$1]++} END {for (word in count) print word, count[word]}' | awk '{print $2, $1}' | sort -nr | awk '{print $2, $1}' > DRCT72021_sub200-3.tsv
grep -f SCOTT2020_low3.txt gene_pred/P_aphanis/THeavenSCOTT2020_1/interproscan/NRI/P.aphanis_raspberry2020_interproscan.tsv | grep 'GO:' | awk -F'\t' '{split($NF, arr, "|"); for (i in arr) {print $1, arr[i]}}' | sort -u | awk '{print $2}' | awk '{count[$1]++} END {for (word in count) print word, count[word]}' | awk '{print $2, $1}' | sort -nr | awk '{print $2, $1}' > SCOTT2020_sub200-3.tsv
grep -f OGB2019_low3.txt gene_pred/P_leucotricha/THeavenpOGB2019_1/interproscan/NRI/P.leucotricha_apple2019_interproscan.tsv | grep 'GO:' | awk -F'\t' '{split($NF, arr, "|"); for (i in arr) {print $1, arr[i]}}' | sort -u | awk '{print $2}' | awk '{count[$1]++} END {for (word in count) print word, count[word]}' | awk '{print $2, $1}' | sort -nr | awk '{print $2, $1}' > OGB2019_sub200-3.tsv
grep -f p112020_low3.txt gene_pred/P_leucotricha/THeavenp11_1/interproscan/NRI/P.leucotricha_apple2020_interproscan.tsv | grep 'GO:' | awk -F'\t' '{split($NF, arr, "|"); for (i in arr) {print $1, arr[i]}}' | sort -u | awk '{print $2}' | awk '{count[$1]++} END {for (word in count) print word, count[word]}' | awk '{print $2, $1}' | sort -nr | awk '{print $2, $1}' > p112020_sub200-3.tsv
grep -f OGB2021_low3.txt gene_pred/P_leucotricha/THeavenpOGB2021_1/interproscan/NRI/P.leucotricha_apple2021_interproscan.tsv | grep 'GO:' | awk -F'\t' '{split($NF, arr, "|"); for (i in arr) {print $1, arr[i]}}' | sort -u | awk '{print $2}' | awk '{count[$1]++} END {for (word in count) print word, count[word]}' | awk '{print $2, $1}' | sort -nr | awk '{print $2, $1}' > OGB2021_sub200-3.tsv

files=(DRCT72020_sub200-5.tsv DRCT72020_sub200-3.tsv DRCT72021_sub200-5.tsv DRCT72021_sub200-3.tsv SCOTT2020_sub200-5.tsv SCOTT2020_sub200-3.tsv OGB2019_sub200-5.tsv OGB2019_sub200-3.tsv p112020_sub200-5.tsv p112020_sub200-3.tsv OGB2021_sub200-5.tsv OGB2021_sub200-3.tsv)
for file in "${files[@]:1}"; do
    paste -d'\t' combined_lowIG.tsv <(cut -f1 "$file") > temp_merged_file.txt
    mv temp_merged_file.txt combined_lowIG.tsv
done

```

Müller et al. (2018) found that in the B. graminis genome the upstream regions of short CSEPs were enriched for LTRs of the Copia and Gypsy superfamilies, whereas upstream regions of longer CSEPs were enriched for LINEs and SINEs.
```bash
#put gene and TE annotations into one file and keep only annotations for 'cleaned' contigs:
awk '$3 == "gene"' /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 > /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/te.gff
cat /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72020/fcs/earlgreyte/Pod_aph_DRT72020/Pod_aph_DRT72020_EarlGrey/Pod___summaryFiles/Pod__.filteredRepeats.gff >> /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/te.gff
grep '>' /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72020/fcs/HEAVEN_strawberry2020_clean.fasta | sed 's@>@@g' > search.txt
awk 'FNR==NR {patterns[$0]; next} $1 in patterns' search.txt /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/te.gff > temp.txt && mv temp.txt /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/te.gff


awk '$3 == "gene"' /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 > /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/te.gff  
cat /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72021/fcs/earlgreyte/Pod_aph_DRT72021/Pod_aph_DRT72021_EarlGrey/Pod___summaryFiles/Pod__.filteredRepeats.gff >> /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/te.gff 
grep '>' /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72021/fcs/HEAVEN_strawberry2021_clean.fasta | sed 's@>@@g' > search.txt
awk 'FNR==NR {patterns[$0]; next} $1 in patterns' search.txt /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/te.gff > temp.txt && mv temp.txt /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/te.gff


awk '$3 == "gene"' /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 > /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/te.gff 
cat /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/SCOTT2020/fcs/earlgreyte/Pod_aph_SCOTT2020/Pod_aph_SCOTT2020_EarlGrey/Pod___summaryFiles/Pod__.filteredRepeats.gff >> /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/te.gff
grep '>' /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/SCOTT2020/fcs/HEAVEN_raspberry2020_clean.fasta | sed 's@>@@g' > search.txt
awk 'FNR==NR {patterns[$0]; next} $1 in patterns' search.txt /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/te.gff > temp.txt && mv temp.txt /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/te.gff


awk '$3 == "gene"' /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 > /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/te.gff 
cat /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGBp112020/fcs/earlgreyte/Pod_leu_OGBp112020/Pod_leu_OGBp112020_EarlGrey/Pod___summaryFiles/Pod__.filteredRepeats.gff >> /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/te.gff
grep '>' /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGBp112020/fcs/HEAVEN_apple2020_clean.fasta | sed 's@>@@g' > search.txt
awk 'FNR==NR {patterns[$0]; next} $1 in patterns' search.txt /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/te.gff > temp.txt && mv temp.txt /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/te.gff


awk '$3 == "gene"' /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 > /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/te.gff 
cat /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2019/fcs/earlgreyte/Pod_leu_OGB2019/Pod_leu_OGB2019_EarlGrey/Pod___summaryFiles/Pod__.filteredRepeats.gff >> /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/te.gff 
grep '>' /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2019/fcs/HEAVEN_apple2019_clean.fasta | sed 's@>@@g' > search.txt
awk 'FNR==NR {patterns[$0]; next} $1 in patterns' search.txt /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/te.gff > temp.txt && mv temp.txt /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/te.gff


awk '$3 == "gene"' /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 > /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/te.gff
cat /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2021/fcs/earlgreyte/Pod_leu_OGB2021/Pod_leu_OGB2021_EarlGrey/Pod___summaryFiles/Pod__.filteredRepeats.gff >> /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/te.gff
grep '>' /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2021/fcs/HEAVEN_apple2021_clean.fasta | sed 's@>@@g' > search.txt
awk 'FNR==NR {patterns[$0]; next} $1 in patterns' search.txt /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/te.gff > temp.txt && mv temp.txt /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/te.gff

sort /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72020/fcs/earlgreyte/Pod_aph_DRT72020/Pod_aph_DRT72020_EarlGrey/Pod___summaryFiles/Pod__.filteredRepeats.gff | uniq -c
awk '{count[$1]++} END {for (word in count) print word, count[word]}' /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72020/fcs/earlgreyte/Pod_aph_DRT72020/Pod_aph_DRT72020_EarlGrey/Pod___summaryFiles/Pod__.filteredRepeats.gff | wc -l
awk -F'\t' '{split($NF, arr, "|"); for (i in arr) {count[arr[i]]++}} END {for (word in count) print word, count[word]}' OGB2021_sub200-5-GO.tsv


awk '$3 ~ /gene/ {gsub("ID=", "", $9); gsub(";", "", $9); print $9".t1"}' /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/te.gff > OGB2021_good.txt
awk '$3 ~ /gene/ {gsub("ID=", "", $9); gsub(";", "", $9); print $9".t1"}' /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/te.gff > OGB2019_good.txt
awk '$3 ~ /gene/ {gsub("ID=", "", $9); gsub(";", "", $9); print $9".t1"}' /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/te.gff > p11_1_good.txt
awk '$3 ~ /gene/ {gsub("ID=", "", $9); gsub(";", "", $9); print $9".t1"}' /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/te.gff > SCOTT2020_good.txt
awk '$3 ~ /gene/ {gsub("ID=", "", $9); gsub(";", "", $9); print $9".t1"}' /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/te.gff > DRCT72021_good.txt
awk '$3 ~ /gene/ {gsub("ID=", "", $9); gsub(";", "", $9); print $9".t1"}' /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/te.gff > DRCT72020_good.txt

#Find the 3' and 5' te distances + match names to the predector output files
#script is written for earlgrey output only
conda activate predector2.7
for Gff in $(ls /home/theaven/projects/niab/theaven/gene_pred/P_*/*/codingquarry/rep_modeling/final/te.gff); do
  ID=$(echo $Gff | cut -d '/' -f9)
OutFile=$(dirname $Gff)/${ID}_flanking_tes.txt
echo -e "ID\tfive_prime_lgth\tfive_prime_family\tfive_prime_ID\tthree_prime_lgth\tthree_prime_family\tthree_prime_ID\tstrand" > $OutFile
python2.7 ../apps/tools/find_intergenic_te_regions.py --Gff $Gff >> $OutFile
head -n 1 $OutFile > temp.temp
tail -n +2 $OutFile | awk -F'\t' '{print $1 ".t1\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' >> temp.temp && mv temp.temp $OutFile
x=$(grep 'gene' $Gff | wc -l)
y=$(cat $OutFile | wc -l)
echo "Genes in $ID GFF: $x, TEs found for: $y"
done
conda deactivate

sort -t$'\t' -k1,1 -k4n /home/theaven/projects/niab/theaven/gene_pred/P_*/*OGB2019_1/codingquarry/rep_modeling/final/te.gff > temp.gff

contig_1049

contig_141      TE       Unknown 20703   21067   2137    -       .       TSTART=3;TEND=377;ID=RND-1_FAMILY-325;SHORTTE=F
contig_141      TE       LTR/Gypsy       21070   21174   396     +       .       TSTART=39;TEND=118;ID=RND-1_FAMILY-16;SHORTTE=F
contig_141      TE       Simple_repeat   21372   21467   34      +       .       TSTART=1;TEND=95;ID=(TTA)N;SHORTTE=F
contig_141      TE       Unknown 21526   21826   1481    +       .       TSTART=4;TEND=467;ID=RND-1_FAMILY-553;SHORTTE=F;TEGROUP=CTG_137|RND-1_FAMILY-553|1
contig_141      CodingQuarry_v2.0       gene    21825   21938   .       -       .       ID=g2769
contig_141      TE       LTR/Gypsy       22116   22374   844     -       .       TSTART=1;TEND=260;ID=RND-1_FAMILY-1148;SHORTTE=F
contig_141      AUGUSTUS        gene    22415   25478   0.22    -       .       ID=g2770;
contig_141      TE       LTR/Gypsy       22467   23107   2483    -       .       TSTART=2;TEND=524;ID=RND-1_FAMILY-509;SHORTTE=F
contig_141      TE       LTR/Gypsy       23110   23400   1662    -       .       TSTART=1;TEND=295;ID=RND-3_FAMILY-930;SHORTTE=F
contig_141      TE       LTR/Gypsy       23401   25987   9724    -       .       TSTART=21;TEND=3243;ID=RND-1_FAMILY-622;SHORTTE=F
contig_141      AUGUSTUS        gene    25714   26634   0.81    -       .       ID=g2771;
contig_141      TE       LTR/Gypsy       25988   26201   1143    +       .       TSTART=810;TEND=1128;ID=RND-1_FAMILY-1031;SHORTTE=F
contig_141      TE       LTR/Gypsy       26202   26427   737     -       .       TSTART=58;TEND=277;ID=RND-1_FAMILY-819;SHORTTE=F
contig_141      TE       Unknown 26719   27015   1472    +       .       TSTART=7;TEND=466;ID=RND-1_FAMILY-553;SHORTTE=F;TEGROUP=CTG_137|RND-1_FAMILY-553|2
contig_141      CodingQuarry_v2.0       gene    27034   27378   .       -       .       ID=g2772


#Find the 3' and 5' te distances + match names to the predector output files
#script is written for earlgrey output only
conda activate predector2.7
for Gff in $(ls /home/theaven/projects/niab/theaven/gene_pred/P_*/*/codingquarry/rep_modeling/final/te.gff); do
  ID=$(echo $Gff | cut -d '/' -f9)
OutFile=$(dirname $Gff)/${ID}_flanking_LINEs.txt
echo -e "ID\tfive_prime_lgth\tfive_prime_family\tfive_prime_ID\tthree_prime_lgth\tthree_prime_family\tthree_prime_ID\tstrand" > $OutFile
python2.7 ../apps/tools/find_intergenic_te_distances.py --Gff $Gff --Family LINE >> $OutFile
head -n 1 $OutFile > temp.temp
tail -n +2 $OutFile | awk -F'\t' '{print $1 ".t1\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' >> temp.temp && mv temp.temp $OutFile
x=$(grep 'gene' $Gff | wc -l)
y=$(cat $OutFile | wc -l)
echo "Genes in $ID GFF: $x, distances found for: $y"
done

for Gff in $(ls /home/theaven/projects/niab/theaven/gene_pred/P_*/*/codingquarry/rep_modeling/final/te.gff); do
  ID=$(echo $Gff | cut -d '/' -f9)
OutFile=$(dirname $Gff)/${ID}_flanking_LTRs.txt
echo -e "ID\tfive_prime_lgth\tfive_prime_family\tfive_prime_ID\tthree_prime_lgth\tthree_prime_family\tthree_prime_ID\tstrand" > $OutFile
python2.7 ../apps/tools/find_intergenic_te_distances.py --Gff $Gff --Family LTR >> $OutFile
head -n 1 $OutFile > temp.temp
tail -n +2 $OutFile | awk -F'\t' '{print $1 ".t1\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' >> temp.temp && mv temp.temp $OutFile
x=$(grep 'gene' $Gff | wc -l)
y=$(cat $OutFile | wc -l)
echo "Genes in $ID GFF: $x, distances found for: $y"
done

for Gff in $(ls /home/theaven/projects/niab/theaven/gene_pred/P_*/*/codingquarry/rep_modeling/final/te.gff); do
  ID=$(echo $Gff | cut -d '/' -f9)
OutFile=$(dirname $Gff)/${ID}_flanking_DNAs.txt
echo -e "ID\tfive_prime_lgth\tfive_prime_family\tfive_prime_ID\tthree_prime_lgth\tthree_prime_family\tthree_prime_ID\tstrand" > $OutFile
python2.7 ../apps/tools/find_intergenic_te_distances.py --Gff $Gff --Family DNA >> $OutFile
head -n 1 $OutFile > temp.temp
tail -n +2 $OutFile | awk -F'\t' '{print $1 ".t1\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' >> temp.temp && mv temp.temp $OutFile
x=$(grep 'gene' $Gff | wc -l)
y=$(cat $OutFile | wc -l)
echo "Genes in $ID GFF: $x, distances found for: $y"
done

for Gff in $(ls /home/theaven/projects/niab/theaven/gene_pred/P_*/*/codingquarry/rep_modeling/final/te.gff); do
  ID=$(echo $Gff | cut -d '/' -f9)
OutFile=$(dirname $Gff)/${ID}_flanking_Pogos.txt
echo -e "ID\tfive_prime_lgth\tfive_prime_family\tfive_prime_ID\tthree_prime_lgth\tthree_prime_family\tthree_prime_ID\tstrand" > $OutFile
python2.7 ../apps/tools/find_intergenic_te_distances.py --Gff $Gff --ID DNA/TcMar-Pogo >> $OutFile
head -n 1 $OutFile > temp.temp
tail -n +2 $OutFile | awk -F'\t' '{print $1 ".t1\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' >> temp.temp && mv temp.temp $OutFile
x=$(grep 'gene' $Gff | wc -l)
y=$(cat $OutFile | wc -l)
echo "Genes in $ID GFF: $x, distances found for: $y"
done

for Gff in $(ls /home/theaven/projects/niab/theaven/gene_pred/P_*/*/codingquarry/rep_modeling/final/te.gff); do
  ID=$(echo $Gff | cut -d '/' -f9)
OutFile=$(dirname $Gff)/${ID}_flanking_Mariners.txt
echo -e "ID\tfive_prime_lgth\tfive_prime_family\tfive_prime_ID\tthree_prime_lgth\tthree_prime_family\tthree_prime_ID\tstrand" > $OutFile
python2.7 ../apps/tools/find_intergenic_te_distances.py --Gff $Gff --ID DNA/TcMar >> $OutFile
head -n 1 $OutFile > temp.temp
tail -n +2 $OutFile | awk -F'\t' '{print $1 ".t1\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' >> temp.temp && mv temp.temp $OutFile
x=$(grep 'gene' $Gff | wc -l)
y=$(cat $OutFile | wc -l)
echo "Genes in $ID GFF: $x, distances found for: $y"
done

for Gff in $(ls /home/theaven/projects/niab/theaven/gene_pred/P_*/*/codingquarry/rep_modeling/final/te.gff); do
  ID=$(echo $Gff | cut -d '/' -f9)
OutFile=$(dirname $Gff)/${ID}_flanking_Tads.txt
echo -e "ID\tfive_prime_lgth\tfive_prime_family\tfive_prime_ID\tthree_prime_lgth\tthree_prime_family\tthree_prime_ID\tstrand" > $OutFile
python2.7 ../apps/tools/find_intergenic_te_distances.py --Gff $Gff --ID LINE/Tad1 >> $OutFile
head -n 1 $OutFile > temp.temp
tail -n +2 $OutFile | awk -F'\t' '{print $1 ".t1\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' >> temp.temp && mv temp.temp $OutFile
x=$(grep 'gene' $Gff | wc -l)
y=$(cat $OutFile | wc -l)
echo "Genes in $ID GFF: $x, distances found for: $y"
done

for Gff in $(ls /home/theaven/projects/niab/theaven/gene_pred/P_*/*/codingquarry/rep_modeling/final/te.gff); do
  ID=$(echo $Gff | cut -d '/' -f9)
OutFile=$(dirname $Gff)/${ID}_flanking_Gypsys.txt
echo -e "ID\tfive_prime_lgth\tfive_prime_family\tfive_prime_ID\tthree_prime_lgth\tthree_prime_family\tthree_prime_ID\tstrand" > $OutFile
python2.7 ../apps/tools/find_intergenic_te_distances.py --Gff $Gff --ID LTR/Gypsy >> $OutFile
head -n 1 $OutFile > temp.temp
tail -n +2 $OutFile | awk -F'\t' '{print $1 ".t1\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' >> temp.temp && mv temp.temp $OutFile
x=$(grep 'gene' $Gff | wc -l)
y=$(cat $OutFile | wc -l)
echo "Genes in $ID GFF: $x, distances found for: $y"
done

for Gff in $(ls /home/theaven/projects/niab/theaven/gene_pred/P_*/*/codingquarry/rep_modeling/final/te.gff); do
  ID=$(echo $Gff | cut -d '/' -f9)
OutFile=$(dirname $Gff)/${ID}_flanking_Copias.txt
echo -e "ID\tfive_prime_lgth\tfive_prime_family\tfive_prime_ID\tthree_prime_lgth\tthree_prime_family\tthree_prime_ID\tstrand" > $OutFile
python2.7 ../apps/tools/find_intergenic_te_distances.py --Gff $Gff --ID LTR/Copia >> $OutFile
head -n 1 $OutFile > temp.temp
tail -n +2 $OutFile | awk -F'\t' '{print $1 ".t1\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' >> temp.temp && mv temp.temp $OutFile
x=$(grep 'gene' $Gff | wc -l)
y=$(cat $OutFile | wc -l)
echo "Genes in $ID GFF: $x, distances found for: $y"
done
conda deactivate

for file in $(ls /home/theaven/projects/niab/theaven/gene_pred/P_*/*/codingquarry/rep_modeling/final/*.txt | grep -v 'intergenic'); do
cp $file tmp20082024/.
done
```
```python
from collections import Counter

# Open the file
with open('/home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/THeavenp11_1_flanking_tes.txt', 'r') as file:
    next(file)
    nested_strings_counter = Counter()
    for line in file:
        columns = line.split()
        if "Nested" in columns[2]:
            nested_strings_counter[columns[4]] += 1

# Print the occurrences of each unique string in the fourth column
for string, count in nested_strings_counter.items():
    print(f"{string}: {count} occurrences")

```
Note-copia and gypsy are LTRs and tad1 is an LINE, pogo is a DNA and mariner.
```R
setwd("C:/Users/did23faz/OneDrive - Norwich Bioscience Institutes/Desktop/R")

#search <- read.table("p11_1_good.txt", header = FALSE)
#search <- read.table("OGB2021_good.txt", header = FALSE)
#search <- read.table("OGB2019_good.txt", header = FALSE)
#search <- read.table("SCOTT2020_good.txt", header = FALSE)
search <- read.table("DRCT72021_good.txt", header = FALSE)
#search <- read.table("DRCT72020_good.txt", header = FALSE)

#prefix <- "THeavenp11"
#prefix <- "THeavenpOGB2021"
#prefix <- "THeavenpOGB2019"
#species <- "P_leucotricha"
#prefix <- "THeavenSCOTT2020"
#prefix <- "THeavenDRCT72020"
prefix <- "THeavenDRCT72021"
species <- "P_aphanis"

predector <- read.table(paste0("download/download/", species, "-", prefix, "_1-ranked.tsv"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nonest <- read.table(paste0("download/download/", prefix, "_1_intergenic_regions_nonest.txt"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)
nest <- read.table(paste0("download/download/", prefix, "_1_intergenic_regions.txt"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)
names(nest)[2:4] <- paste0(names(nest)[2:4], "_2")
blast <- read.table(paste0("download/download/", prefix, "_1_busco_blast.tsv"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)
csep_blast <- read.table(paste0("download/download/", prefix, "_1_csep_blast.tsv"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)

any_te <- read.table(paste0("download/download/", prefix, "_1_flanking_tes.txt"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)
colnames(any_te)[1] <- "name"

copia_te <- read.table(paste0("download/download/", prefix, "_1_flanking_Copias.txt"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)
colnames(copia_te)[1] <- "name"

DNA_te <- read.table(paste0("download/download/", prefix, "_1_flanking_DNAs.txt"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)
colnames(DNA_te)[1] <- "name"

Gypsy_te <- read.table(paste0("download/download/", prefix, "_1_flanking_Gypsys.txt"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)
colnames(Gypsy_te)[1] <- "name"

LINE_te <- read.table(paste0("download/download/", prefix, "_1_flanking_LINEs.txt"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)
colnames(LINE_te)[1] <- "name"

LTR_te <- read.table(paste0("download/download/", prefix, "_1_flanking_LTRs.txt"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)
colnames(LTR_te)[1] <- "name"

Mariner_te <- read.table(paste0("download/download/", prefix, "_1_flanking_Mariners.txt"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)
colnames(Mariner_te)[1] <- "name"

Pogo_te <- read.table(paste0("download/download/", prefix, "_1_flanking_Pogos.txt"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)
colnames(Pogo_te)[1] <- "name"

Tad_te <- read.table(paste0("download/download/", prefix, "_1_flanking_Tads.txt"), header = TRUE, sep = "\t", stringsAsFactors = FALSE)
colnames(Tad_te)[1] <- "name"

# Merging the data
merged_data <- merge(predector, nonest,  by = "name", all = TRUE)
merged_data2 <- merge(merged_data, nest, by = "name", all = TRUE)
merged_data3 <- merge(merged_data2, blast, by = "name", all = TRUE)
df <- merge(merged_data3, csep_blast, by = "name", all = TRUE)
df2 <- df[!duplicated(df[[1]]), ]
df3 <- df2 %>%
  filter(name %in% search$V1)

df3$sec_type <- 'Non CSEP'
df3$sec_type[is.na(df3$match_1) & df3$is_secreted == 1 & df3$effectorp3_noneffector == "." & df3$residue_number < 201] <- "Short CSEP"
df3$sec_type[is.na(df3$match_1) & df3$is_secreted == 1 & df3$effectorp3_noneffector == "." & df3$residue_number > 200] <- "Long CSEP"
df3$sec_type <- factor(df3$sec_type, levels = c("Non CSEP", "Short CSEP", "Long CSEP"))
count_short_csep <- sum(df3$sec_type == "Short CSEP")
count_long_csep <- sum(df3$sec_type == "Long CSEP")
count_non_csep <- sum(df3$sec_type == "Non CSEP")
merged_data4 <- df3

merged_data5 <- merge(merged_data4, any_te, by = "name", all = FALSE)
merged_data5$te_group <- 'Any TE'
merged_data6 <- merge(merged_data4, copia_te, by = "name", all = FALSE)
merged_data6$te_group <- 'Copia'
merged_data7 <- merge(merged_data4, DNA_te, by = "name", all = FALSE)
merged_data7$te_group <- 'DNA'
merged_data8 <- merge(merged_data4, Gypsy_te, by = "name", all = FALSE)
merged_data8$te_group <- 'Gypsy'
merged_data9 <- merge(merged_data4, LINE_te, by = "name", all = FALSE)
merged_data9$te_group <- 'LINE'
merged_data10 <- merge(merged_data4, LTR_te, by = "name", all = FALSE)
merged_data10$te_group <- 'LTR'
merged_data11 <- merge(merged_data4, Mariner_te, by = "name", all = FALSE)
merged_data11$te_group <- 'Mariner'
merged_data12 <- merge(merged_data4, Pogo_te, by = "name", all = FALSE)
merged_data12$te_group <- 'Pogo'
merged_data13 <- merge(merged_data4, Tad_te, by = "name", all = FALSE)
merged_data13$te_group <- 'Tad'

merged_data14 <- merge(merged_data4, any_te, by = "name", all = FALSE)
merged_data14$five_prime_lgth <- merged_data14$five_prime_2
merged_data14$five_prime_family <- 'gene'
merged_data14$five_prime_ID <- 'gene'
merged_data14$three_prime_lgth <- merged_data14$three_prime_2
merged_data14$three_prime_family <- 'gene'
merged_data14$three_prime_ID <- 'gene'
merged_data14$strand.y <- merged_data14$strand_2
merged_data14$te_group <- 'Gene'

df <- rbind(merged_data5,merged_data6,merged_data7,merged_data8,merged_data9,merged_data10,merged_data11,merged_data12,merged_data13,merged_data14)

allte <- df %>%
  filter(name %in% search$V1)

allte$three_prime_lgth[allte$three_prime_lgth == 'Nested TE'] <- 0
allte$five_prime_lgth[allte$five_prime_lgth == 'Nested TE'] <- 0

allte$three_prime_lgth[allte$three_prime_lgth == 'gene'] <- NA
allte$five_prime_lgth[allte$five_prime_lgth == 'gene'] <- NA

allte$three_prime_lgth[allte$three_prime_lgth == 'end'] <- NA
allte$five_prime_lgth[allte$five_prime_lgth == 'end'] <- NA

allte$three_prime_lgth <- as.numeric(allte$three_prime_lgth)
allte$five_prime_lgth <- as.numeric(allte$five_prime_lgth)

te_group_order <- c("Gene", "Any TE", "LINE", "Tad", "LTR", "Copia", "Gypsy", "DNA", "Mariner", "Pogo")
allte$te_group <- factor(allte$te_group, levels = te_group_order)

mean_3_gene_value <- mean(allte$three_prime_lgth[grepl("Gene", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_gene_value <- mean(allte$five_prime_lgth[grepl("Gene", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_AnyTE_value <- mean(allte$three_prime_lgth[grepl("Any TE", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_AnyTE_value <- mean(allte$five_prime_lgth[grepl("Any TE", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Copia_value <- mean(allte$three_prime_lgth[grepl("Copia", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Copia_value <- mean(allte$five_prime_lgth[grepl("Copia", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_DNA_value <- mean(allte$three_prime_lgth[grepl("DNA", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_DNA_value <- mean(allte$five_prime_lgth[grepl("DNA", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Gypsy_value <- mean(allte$three_prime_lgth[grepl("Gypsy", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Gypsy_value <- mean(allte$five_prime_lgth[grepl("Gypsy", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_LINE_value <- mean(allte$three_prime_lgth[grepl("LINE", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_LINE_value <- mean(allte$five_prime_lgth[grepl("LINE", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_LTR_value <- mean(allte$three_prime_lgth[grepl("LTR", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_LTR_value <- mean(allte$five_prime_lgth[grepl("LTR", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Mariner_value <- mean(allte$three_prime_lgth[grepl("Mariner", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Mariner_value <- mean(allte$five_prime_lgth[grepl("Mariner", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Pogo_value <- mean(allte$three_prime_lgth[grepl("Pogo", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Pogo_value <- mean(allte$five_prime_lgth[grepl("Pogo", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Tad_value <- mean(allte$three_prime_lgth[grepl("Tad", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Tad_value <- mean(allte$five_prime_lgth[grepl("Tad", allte$te_group) & grepl("Non CSEP", allte$sec_type)], na.rm = TRUE)

text <- print(paste(prefix, "of", count_non_csep, "Non CSEP", "Gene 3", mean_3_gene_value, "Gene 5", mean_5_gene_value, "Any TE 3", mean_3_AnyTE_value, "Any TE 5", mean_5_AnyTE_value, "Copia 3", mean_3_Copia_value, "Copia 5", mean_5_Copia_value, "DNA 3", mean_3_DNA_value, "DNA 5", mean_5_DNA_value, "Gypsy 3", mean_3_Gypsy_value, "Gypsy 5", mean_5_Gypsy_value, "LINE 3", mean_3_LINE_value, "LINE 5", mean_5_LINE_value, "LTR 3", mean_3_LTR_value, "LTR 5", mean_5_LTR_value, "Mariner 3", mean_3_Mariner_value, "Mariner 5", mean_5_Mariner_value, "Pogo 3", mean_3_Pogo_value, "Pogo 5", mean_5_Pogo_value, "Tad 3", mean_3_Tad_value, "Tad 5", mean_5_Tad_value))

mean_3_gene_value <- mean(allte$three_prime_lgth[grepl("Gene", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_gene_value <- mean(allte$five_prime_lgth[grepl("Gene", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_AnyTE_value <- mean(allte$three_prime_lgth[grepl("Any TE", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_AnyTE_value <- mean(allte$five_prime_lgth[grepl("Any TE", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Copia_value <- mean(allte$three_prime_lgth[grepl("Copia", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Copia_value <- mean(allte$five_prime_lgth[grepl("Copia", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_DNA_value <- mean(allte$three_prime_lgth[grepl("DNA", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_DNA_value <- mean(allte$five_prime_lgth[grepl("DNA", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Gypsy_value <- mean(allte$three_prime_lgth[grepl("Gypsy", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Gypsy_value <- mean(allte$five_prime_lgth[grepl("Gypsy", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_LINE_value <- mean(allte$three_prime_lgth[grepl("LINE", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_LINE_value <- mean(allte$five_prime_lgth[grepl("LINE", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_LTR_value <- mean(allte$three_prime_lgth[grepl("LTR", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_LTR_value <- mean(allte$five_prime_lgth[grepl("LTR", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Mariner_value <- mean(allte$three_prime_lgth[grepl("Mariner", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Mariner_value <- mean(allte$five_prime_lgth[grepl("Mariner", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Pogo_value <- mean(allte$three_prime_lgth[grepl("Pogo", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Pogo_value <- mean(allte$five_prime_lgth[grepl("Pogo", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Tad_value <- mean(allte$three_prime_lgth[grepl("Tad", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Tad_value <- mean(allte$five_prime_lgth[grepl("Tad", allte$te_group) & grepl("Short CSEP", allte$sec_type)], na.rm = TRUE)

text2 <- print(paste(prefix, "of", count_short_csep, "Short CSEP", "Gene 3", mean_3_gene_value, "Gene 5", mean_5_gene_value, "Any TE 3", mean_3_AnyTE_value, "Any TE 5", mean_5_AnyTE_value, "Copia 3", mean_3_Copia_value, "Copia 5", mean_5_Copia_value, "DNA 3", mean_3_DNA_value, "DNA 5", mean_5_DNA_value, "Gypsy 3", mean_3_Gypsy_value, "Gypsy 5", mean_5_Gypsy_value, "LINE 3", mean_3_LINE_value, "LINE 5", mean_5_LINE_value, "LTR 3", mean_3_LTR_value, "LTR 5", mean_5_LTR_value, "Mariner 3", mean_3_Mariner_value, "Mariner 5", mean_5_Mariner_value, "Pogo 3", mean_3_Pogo_value, "Pogo 5", mean_5_Pogo_value, "Tad 3", mean_3_Tad_value, "Tad 5", mean_5_Tad_value))

mean_3_gene_value <- mean(allte$three_prime_lgth[grepl("Gene", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_gene_value <- mean(allte$five_prime_lgth[grepl("Gene", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_AnyTE_value <- mean(allte$three_prime_lgth[grepl("Any TE", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_AnyTE_value <- mean(allte$five_prime_lgth[grepl("Any TE", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Copia_value <- mean(allte$three_prime_lgth[grepl("Copia", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Copia_value <- mean(allte$five_prime_lgth[grepl("Copia", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_DNA_value <- mean(allte$three_prime_lgth[grepl("DNA", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_DNA_value <- mean(allte$five_prime_lgth[grepl("DNA", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Gypsy_value <- mean(allte$three_prime_lgth[grepl("Gypsy", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Gypsy_value <- mean(allte$five_prime_lgth[grepl("Gypsy", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_LINE_value <- mean(allte$three_prime_lgth[grepl("LINE", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_LINE_value <- mean(allte$five_prime_lgth[grepl("LINE", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_LTR_value <- mean(allte$three_prime_lgth[grepl("LTR", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_LTR_value <- mean(allte$five_prime_lgth[grepl("LTR", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Mariner_value <- mean(allte$three_prime_lgth[grepl("Mariner", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Mariner_value <- mean(allte$five_prime_lgth[grepl("Mariner", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Pogo_value <- mean(allte$three_prime_lgth[grepl("Pogo", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Pogo_value <- mean(allte$five_prime_lgth[grepl("Pogo", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)

mean_3_Tad_value <- mean(allte$three_prime_lgth[grepl("Tad", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)
mean_5_Tad_value <- mean(allte$five_prime_lgth[grepl("Tad", allte$te_group) & grepl("Long CSEP", allte$sec_type)], na.rm = TRUE)

text3 <- print(paste(prefix, "of", count_long_csep, "Long CSEP", "Gene 3", mean_3_gene_value, "Gene 5", mean_5_gene_value, "Any TE 3", mean_3_AnyTE_value, "Any TE 5", mean_5_AnyTE_value, "Copia 3", mean_3_Copia_value, "Copia 5", mean_5_Copia_value, "DNA 3", mean_3_DNA_value, "DNA 5", mean_5_DNA_value, "Gypsy 3", mean_3_Gypsy_value, "Gypsy 5", mean_5_Gypsy_value, "LINE 3", mean_3_LINE_value, "LINE 5", mean_5_LINE_value, "LTR 3", mean_3_LTR_value, "LTR 5", mean_5_LTR_value, "Mariner 3", mean_3_Mariner_value, "Mariner 5", mean_5_Mariner_value, "Pogo 3", mean_3_Pogo_value, "Pogo 5", mean_5_Pogo_value, "Tad 3", mean_3_Tad_value, "Tad 5", mean_5_Tad_value))


cat(text, "\n", file = "TE_distance.txt", append = TRUE)
cat(text2, "\n", file = "TE_distance.txt", append = TRUE)
cat(text3, "\n", file = "TE_distance.txt", append = TRUE)

# Define custom colors
te_group_colors <- c("Gene" = "#eeeeee", "Any TE" = "#b6d7a8" , "LINE" = "#9fc5e8", "Tad" = "#9fc5e8", "LTR" = "#e06666", "Copia" = "#e06666", "Gypsy" = "#e06666", "DNA" = "#ffd966", "Mariner" = "#ffd966", "Pogo" = "#ffd966")

library(ggplot2)
library(hrbrthemes)
library(scales)
library(dplyr)

counts <- allte %>%
  group_by(te_group, sec_type) %>%
  summarise(n = sum(!is.na(three_prime_lgth)), 
            median_y = median(as.numeric(three_prime_lgth[as.numeric(three_prime_lgth) != 0]), na.rm = TRUE))

ggplot(allte, aes(x = te_group, y = three_prime_lgth)) +
    geom_point(alpha = 0.1, position = 'jitter') +
    geom_violin(aes(fill = te_group)) +
    geom_text(data = counts, aes(x = te_group, y = median_y, label = n), position = position_dodge(width = 0.9), angle = 90, vjust = 0.3, size = 3) +
    facet_wrap(~sec_type) +
    scale_fill_manual(values = te_group_colors, name = "TE Group") +
    scale_x_discrete(limits = te_group_order) +
    scale_y_log10(labels = scales::label_number(accuracy = 1)) +  
    theme_ipsum() +
    theme(
        axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),  
        axis.title.x = element_text(hjust = 0.5),  
        axis.title.y = element_text(hjust = 0.5),  
        plot.title = element_text(hjust = 0.5),  
        strip.text = element_text(hjust = 0.5),  
        plot.margin = margin(10, 10, 10, 10)  
    ) +
    ylab("3' intergenic distance (bp)") +
    xlab("Repetitive element type (bp)") 

counts <- allte %>%
  group_by(te_group, sec_type) %>%
  summarise(n = sum(!is.na(five_prime_lgth)), 
            median_y = median(as.numeric(five_prime_lgth[as.numeric(five_prime_lgth) != 0]), na.rm = TRUE))

ggplot(allte, aes(x = te_group, y = five_prime_lgth)) +
    geom_point(alpha = 0.1, position = 'jitter') +
    geom_violin(aes(fill = te_group)) +
    geom_text(data = counts, aes(x = te_group, y = median_y, label = n), position = position_dodge(width = 0.9), angle = 90, vjust = 0.3, size = 3) +
    facet_wrap(~sec_type) +
    scale_fill_manual(values = te_group_colors, name = "TE Group") +
    scale_x_discrete(limits = te_group_order) +
    scale_y_log10(labels = scales::label_number(accuracy = 1)) +  
    theme_ipsum() +
    theme(
        axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),  
        axis.title.x = element_text(hjust = 0.5),  
        axis.title.y = element_text(hjust = 0.5),  
        plot.title = element_text(hjust = 0.5),  
        strip.text = element_text(hjust = 0.5), 
        plot.margin = margin(10, 10, 10, 10)  
    ) +
    ylab("5' intergenic distance (bp)") +
    xlab("Repetitive element type (bp)") 




```

#### EarlGreyTE
```bash
head -n 2 /home/theaven/scratch/uncompressed/genomes/HEAVEN_apple2020.fna > temp_earlgreytest.fna

conda activate earlgrey
for Genome in $(ls /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900237765.1/fcs/Blumeriahordei_GCA_900237765.1_BghRACE1_v1_genomic_clean.fasta); do
  OutFile=$(echo $Genome | cut -d '/' -f7 | cut -c 1-3)_$(echo $Genome | cut -d '/' -f8 | cut -c 1-3)_$(echo $Genome | cut -d '/' -f9)
  OutDir=$(dirname $Genome)/earlgreyte/${OutFile}
  ProgDir=~/scratch/apps
  RMsearch=erysiphales
  mkdir -p $OutDir
  sbatch ${ProgDir}/earlgrey/run_earlgrey.sh $Genome $OutFile $OutDir $RMsearch
done
conda deactivate
#19269205-8
#19312435-8
#19312820-2
#19313867-71
#19315485-92 Golovinomyces + endophytic + parauncinula
#19317438-49 Erysiphe
#19317478-81 Fusca + xanthii
#19317484 Leveillula
#19320460-63 Erysiphe + xanthii + fusca
#19320467-19320469 Golovinomyces 
#19326488 magnicellulatus
#19425290-7 graminis
#19544807-12
#19573744-7 hordei
#19573750-55 graminis-secale Oidium

#19633989
/home/theaven/scratch/uncompressed/genomes/Golovinomyces/magnicellulatus/GCA_006912115.1/fcs/Golovinomycesmagnicellulatus_GCA_006912115.1_ASM691211v1_genomic_clean.fasta


```


19320460     EarlgreyTE       100G            3-09:50:49         32   07:52:52 OUT_OF_ME+    0:125                  32   theaven
19320461     EarlgreyTE       100G            5-22:40:55         32   18:25:22 OUT_OF_ME+    0:125                  32   theaven
19320463     EarlgreyTE       100G            9-09:58:29         32   20:14:47 OUT_OF_ME+    0:125                  32   theaven
19326488     EarlgreyTE        50G             16:31.940         32   00:06:29  COMPLETED      0:0                  32   theaven
19425296     EarlgreyTE        50G            6-03:05:42         32   09:56:54 OUT_OF_ME+    0:125                  32   theaven
19425297     EarlgreyTE        50G            6-08:56:48         32   12:09:28 OUT_OF_ME+    0:125                  32   theaven



```bash
cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/Psyllidae/assembly/genome/T_apicales/hifiasm_19.5/880m/29/3/3.0/0.75/break10x/purge_dups/sanger/MitoHifi/filtered/inspector/T_apicales_880m_29_3_3.0_0.75_break_TellSeqPurged_curated_nomito_filtered_corrected.fa download/.
cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/Psyllidae/assembly/genome/T_urticae/hifiasm_19.5/715m/12/2/3.0/0.5/filtered/purge_dups/purge_haplotigs/break10x/yahs/filtered/inspector/T_urticae_715m_12_2_3.0_0.5_filtered_HiFiPurged_HiFiPurged_curated_break_scaffolds_final_nomito_filtered_corrected.fa download/.
cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/Psyllidae/assembly/genome/T_anthrisci/hifiasm_19.5/820m/48/1/10.0/0.25/break10x/purge_dups/sanger/MitoHifi/filtered/inspector/T_anthrisci_820m_48_1_10.0_0.25_break_TellSeqPurged_curated_nomito_filtered_corrected.fa download/.

conda activate earlgrey
for Genome in $(ls /home/theaven/scratch/uncompressed/hogenhout/GCA_024506275.2_CRF-UY_Dcit_genomic.fna /home/theaven/scratch/uncompressed/hogenhout/GCA_000475195.1_Diaci_psyllid_genome_assembly_version_1.1_genomic.fna); do
  OutFile=$(basename $Genome | sed 's@.fna@@g' | cut -d '_' -f1,2)
  OutDir=$(dirname $Genome)/earlgreyte2/${OutFile}
  ProgDir=~/scratch/apps
  RMsearch=Sternorrhyncha
  mkdir -p $OutDir
  sbatch ${ProgDir}/earlgrey/run_earlgrey.sh $Genome $OutFile $OutDir $RMsearch
done
#19238763,5
#19306652-4
conda deactivate
#19546924-19546937

19546924
19546927
#19582121-2


```
#### FCS
```bash
for Genome in $(ls /home/theaven/scratch/uncompressed/genomes/Leveillula/taurrica/CADEPA01/leveillulataurrica_CADEPA01.fasta); do
Jobs=$(squeue -u theaven| grep 'fcs' | wc -l)
while [ $Jobs -gt 1 ]; do
sleep 120s
printf "."
Jobs=$(squeue -u theaven| grep 'fcs' | wc -l)
done
Species=$(echo $Genome | cut -d '/' -f7,8)
if [ "$Species" = "Amorphotheca/resinae" ]; then
TAXID=5101
elif [ "$Species" = "Arachnopeziza/araneosa" ]; then
  TAXID=2259763
elif [ "$Species" = "Ascocoryne/sarcoides" ]; then
  TAXID=139061
elif [ "$Species" = "Aspergillus/nidulans" ]; then
  TAXID=162425
elif [ "$Species" = "Blumeria/graminis" ]; then
  TAXID=34373
elif [ "$Species" = "Blumeria/graminis-secale" ]; then
  TAXID=34373
elif [ "$Species" = "Blumeria/hordei" ]; then
  TAXID=2867405
elif [ "$Species" = "Botrytis/cineria" ]; then
  TAXID=40559
elif [ "$Species" = "Chlorociboria/aeruginascens" ]; then
  TAXID=296797
elif [ "$Species" = "Colletotrichum/higginsianum" ]; then
  TAXID=80884
elif [ "$Species" = "Coprinus/cinereus" ]; then
  TAXID=5346
elif [ "$Species" = "Cryptococcus/neoformans" ]; then
  TAXID=5207
elif [ "$Species" = "Drepanopeziza/brunnea" ]; then
  TAXID=698440
elif [ "$Species" = "Erysiphe/alphitoides" ]; then
  TAXID=157594
elif [ "$Species" = "Erysiphe/necator" ]; then
  TAXID=52586
elif [ "$Species" = "Erysiphe/neolycopersici" ]; then
  TAXID=212602
elif [ "$Species" = "Erysiphe/pisi" ]; then
  TAXID=36044
elif [ "$Species" = "Erysiphe/pulchra" ]; then
  TAXID=225359
elif [ "$Species" = "Fusarium/graminearum" ]; then
  TAXID=5518
elif [ "$Species" = "Fusarium/oxysporum" ]; then
  TAXID=5507
elif [ "$Species" = "Glarea/lozoyensis" ]; then
  TAXID=101852
elif [ "$Species" = "Golovinomyces/cichoracearum" ]; then
  TAXID=62708
elif [ "$Species" = "Golovinomyces/magnicellulatus" ]; then
  TAXID=62714
elif [ "$Species" = "Golovinomyces/orontii" ]; then
  TAXID=62715
elif [ "$Species" = "Leveillula/taurrica" ]; then
  TAXID=62718
elif [ "$Species" = "Magnaporthe/oryzae" ]; then
  TAXID=318829
elif [ "$Species" = "Melampsora/laricis-populina" ]; then
  TAXID=203908
elif [ "$Species" = "Mollisia/scopiformis" ]; then
  TAXID=149040
elif [ "$Species" = "Neobulgaria/alba" ]; then
  TAXID=1461596
elif [ "$Species" = "Neurospora/crassa" ]; then
  TAXID=5141
elif [ "$Species" = "Oidiodendron/maius" ]; then
  TAXID=78148
elif [ "$Species" = "Oidium/heveae" ]; then
  TAXID=299130
elif [ "$Species" = "Parauncinula/polyspora" ]; then
  TAXID=2016243
elif [ "$Species" = "Phialocephala/subalpina" ]; then
  TAXID=576137
elif [ "$Species" = "Phyllactinia/moricola" ]; then
  TAXID=57460
elif [ "$Species" = "Pleochaeta/shiraiana" ]; then
  TAXID=57462
elif [ "$Species" = "Pleurotus/ostreatus" ]; then
  TAXID=5322
elif [ "$Species" = "Podosphaera/aphanis" ]; then
  TAXID=79252
elif [ "$Species" = "Podosphaera/cerasii" ]; then
  TAXID=2086344
elif [ "$Species" = "Podosphaera/fusca" ]; then
  TAXID=62727
elif [ "$Species" = "Podosphaera/leucotricha" ]; then
  TAXID=79249
elif [ "$Species" = "Podosphaera/xanthii" ]; then
  TAXID=135283
elif [ "$Species" = "Psilocybe/cubensis" ]; then
  TAXID=181762
elif [ "$Species" = "Puccinia/graminis" ]; then
  TAXID=5297
elif [ "$Species" = "Puccinia/striiformis" ]; then
  TAXID=27350
elif [ "$Species" = "Puccinia/triticina" ]; then
  TAXID=208348
elif [ "$Species" = "Pyricularia/oryzae" ]; then
  TAXID=318829
elif [ "$Species" = "Saccharomyces/cerevisiae" ]; then
  TAXID=4932
elif [ "$Species" = "Schizophyllum/commune" ]; then
  TAXID=5334
elif [ "$Species" = "Sclerotinia/sclerotiorum" ]; then
  TAXID=5180
elif [ "$Species" = "Tuber/melanosporum" ]; then
  TAXID=39416
elif [ "$Species" = "Ustilago/maydis" ]; then
  TAXID=5270
else
  TAXID=NA
fi
OutDir=$(dirname $Genome)/fcs
OutFile=$(basename $Genome | sed 's@.c.fna@@g'| sed 's@.fna@@g'| sed 's@.fasta@@g')
mkdir $OutDir
ProgDir=/home/theaven/scratch/apps
sbatch $ProgDir/fcs/run_fcs.sh $Genome $TAXID $OutDir $OutFile
#
done

screen -S predector
conda activate predector
for proteome in $(ls /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000151065.3/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153116/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153117/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153118/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153119/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153120/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Parauncinula/polyspora/Parp01/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/fusca/GCA_030378345.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_028751805.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000417025.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000417865.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000418435.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000441875.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_900519115.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_905067625.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_000401675.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900237765.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900239735.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900638725.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/alphitoides/CLCBIO/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798715.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798735.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798755.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798775.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798795.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_016906895.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/neolycopersici/GCA_003610855.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/pisi/GCA_000208805.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/pisi/GCA_000214055.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/pulchra/GCA_002918395.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611195.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611215.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611235.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Golovinomyces/magnicellulatus/GCA_006912115.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Golovinomyces/orontii/MGH1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Leveillula/taurrica/CADEPA01/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Phyllactinia/moricola/GCA_019455665.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Pleochaeta/shiraiana/GCA_019455505.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72020/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72021/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/SCOTT2020/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/cerasii/GCA_018398735.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/GCA_013170925.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2019/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2021/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGBp112020/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_010015925.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_014884795.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Oidium/heveae/GCA_003957845.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_024703715.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta); do
#  ls $proteome  
    OutDir=$(dirname $proteome)/predector/Prothint
    ProgDir=/home/theaven/scratch/apps/predector
#    ls $OutDir/results/clean_final_genes_renamed.pep/clean_final_genes_renamed.pep-ranked.tsv
if [ ! -f "$OutDir/results/clean_final_genes_renamed.pep/clean_final_genes_renamed.pep-ranked.tsv" ]; then
echo $proteome >> predectorpathlog.txt
sbatch $ProgDir/predector_singularity.sh $proteome 1.2.6 $OutDir  2>&1 >> predectorpathlog.txt
echo $proteome
else 
echo $OutDir
fi
#sleep 30
done 

for proteome in $(ls /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000151065.3/fcs/GCA_000151065.3_ASM15106v3_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153116/fcs/S_1459_contigs_min_500bp_clean.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153117/fcs/S_1201_contigs_min_500bp_clean.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153118/fcs/S_1203_contigs_min_500bp_clean.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153119/fcs/S_1391_contigs_min_500bp_clean.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153120/fcs/S_1400_contigs_min_500bp_clean.fasta /home/theaven/scratch/uncompressed/genomes/Colletotrichum/higginsianum/broad_KN1394/fcs/KN-1394_23MarchAllContigs_clean.fasta /home/theaven/scratch/uncompressed/genomes/Coprinus/cinereus/GCA_000182895.1/fcs/GCA_000182895.1_CC3_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Cryptococcus/neoformans/GCF_000091045.1/fcs/GCF_000091045.1_ASM9104v1_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_024703715.1/fcs/GCA_024703715.1_EnE101_chr_assembly_v3_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Fusarium/oxysporum/GCF_013085055.1/fcs/GCF_013085055.1_ASM1308505v1_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Magnaporthe/oryzae/GCF_000002495.2/fcs/GCF_000002495.2_MG8_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Parauncinula/polyspora/Parp01/fcs/Parpo1_AssemblyScaffolds_clean.fasta /home/theaven/scratch/uncompressed/genomes/Pleurotus/ostreatus/GCA_014466165.1/fcs/GCA_014466165.1_ASM1446616v1_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/fusca/GCA_030378345.1/fcs/GCA_030378345.1_ASM3037834v1_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_028751805.1/fcs/GCA_028751805.1_YZU_CsPM_1.2_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Psilocybe/cubensis/GCA_017499595.2/fcs/GCA_017499595.2_MGC_Penvy_1_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Puccinia/striiformis/GCA_021901695.1/fcs/GCA_021901695.1_Pst134E36_v1_pri_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Puccinia/triticina/GCA_000151525.2/fcs/GCA_000151525.2_P_triticina_1_1_V2_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Saccharomyces/cerevisiae/GCF_000146045.2/fcs/Scereviseae_GCF_000146045.2_R64_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Schizophyllum/commune/GCA_000143185.2/fcs/GCA_000143185.2_Schco3_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Tuber/melanosporum/GCF_000151645.1/fcs/GCF_000151645.1_ASM15164v1_genom_clean.fasta /home/theaven/scratch/uncompressed/genomes/Ustilago/maydis/GCA_000328475.2/fcs/GCA_000328475.2_Umaydis521_2.0_genom_clean.fasta | sed 's@fcs/@fcs/ab_initio_@g'); do
  proteome=$(dirname $genome)/gene_pred/braker/final-02042924/ab_initio_final_genes_renamed.pep.fasta
    Jobs=$(squeue -u theaven | grep 'predecto' | wc -l)
    while [ $Jobs -gt 9 ]; do
    sleep 300s
    printf "."
    Jobs=$(squeue -u theaven | grep 'predecto' | wc -l)
    done 
    OutDir=$(dirname $proteome)/predector/abinitio
    ProgDir=/home/theaven/scratch/apps/predector
sbatch $ProgDir/predector_singularity.sh $proteome 1.2.6 $OutDir  2>&1 >> predectorpathlog.txt
sleep 30
done 

#tar and move between clusters
list="/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000151065.3/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153116/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153117/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153118/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153119/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153120/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Parauncinula/polyspora/Parp01/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/fusca/GCA_030378345.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_028751805.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000417025.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000417865.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000418435.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000441875.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_900519115.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_905067625.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_000401675.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900237765.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900239735.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Blumeria/hordei/GCA_900638725.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/alphitoides/CLCBIO/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798715.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798735.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798755.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798775.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_000798795.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_016906895.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/neolycopersici/GCA_003610855.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/pisi/GCA_000208805.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/pisi/GCA_000214055.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/pulchra/GCA_002918395.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611195.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611215.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Golovinomyces/cichoracearum/GCA_003611235.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Golovinomyces/magnicellulatus/GCA_006912115.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Golovinomyces/orontii/MGH1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Leveillula/taurrica/CADEPA01/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Phyllactinia/moricola/GCA_019455665.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Pleochaeta/shiraiana/GCA_019455505.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72020/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72021/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/SCOTT2020/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/cerasii/GCA_018398735.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/GCA_013170925.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2019/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2021/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGBp112020/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_010015925.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_014884795.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Oidium/heveae/GCA_003957845.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta /home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_024703715.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta"
for File in $list; do 
InFile=$(echo $File | sed 's@/home@/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download2/home@g')
ls $InFile
OutDir=$(dirname $InFile)/interproscan/Prothint
ProgDir=~/git_repos/Wrappers/NBI
mkdir -p $OutDir
sbatch $ProgDir/run_interproscan.sh $InFile $OutDir
done #60036638-88

for folder in $(ls -d download2/home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/interproscan); do
out=$(echo $folder | sed 's@download2@@g')
mv $folder $out
done


#Annotate aphanis only genes:
InFile=aphanis_only.faa
OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/download2/INTERPRO
ProgDir=~/git_repos/Wrappers/NBI
sbatch $ProgDir/run_interproscan.sh $InFile $OutDir
#62170663
```
/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000151065.3/fcs/gene_pred/braker/final-02042924/

Shared by B.cinerea, M. oryzae, C. higginsianum, S. sclerotiorum and S. cerevisiae
```bash
for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta); do
seqkit rmdup $file > temp.fasta && mv temp.fasta $file
done

for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta); do
x=$(grep '>' $file | wc -l)
ID=$(echo $file | cut -d '/' -f7 | cut -c 1-3)_$(echo $file | cut -d '/' -f8 | cut -c 1-3)_$(echo $file | cut -d '/' -f9)
echo "$ID $x"
done

Amo_res_GCA_003019875.1 8871
Amo_res_GCA_018167515.1 9001
Ara_ara_GCA_003988855.1 13791
Asc_sar_GCA_000328965.1 10965
Asp_nid_GCA_000149205.2 10793
Blu_gra_GCA_000151065.3 9659
Blu_gra_GCA_000417025.1 9837
Blu_gra_GCA_000417865.1 10573
Blu_gra_GCA_000418435.1 9043
Blu_gra_GCA_000441875.1 10911
Blu_gra_GCA_900519115.1 9282
Blu_gra_GCA_905067625.1 8912
Blu_gra_SRR2153116 11831
Blu_gra_SRR2153117 11895
Blu_gra_SRR2153118 12044
Blu_gra_SRR2153119 11938
Blu_gra_SRR2153120 11610
Blu_hor_GCA_000401675.1 9760
Blu_hor_GCA_900237765.1 8569
Blu_hor_GCA_900239735.1 8507
Blu_hor_GCA_900638725.1 8316
Bot_cin_GCA_000143535.4 12046
Chl_aer_GCA_002276475.2 10500
Col_hig_broad_KN1394 15454
Col_hig_GCA_001672515.1 13839
Cop_cin_GCA_000182895.1 13654
Cry_neo_GCF_000091045.1 7475
Dre_bru_GCA_000298775.1 10008
Ery_alp_CLCBIO 52758
Ery_nec_GCA_000798715.1 9125
Ery_nec_GCA_000798735.1 8963
Ery_nec_GCA_000798755.1 8991
Ery_nec_GCA_000798775.1 9070
Ery_nec_GCA_000798795.1 9027
Ery_nec_GCA_016906895.1 9785
Ery_nec_GCA_024703715.1 8945
Ery_neo_GCA_003610855.1 9782
Ery_pis_GCA_000208805.1 14712
Ery_pis_GCA_000214055.1 11032
Ery_pul_GCA_002918395.1 14532
Fus_gra_GCA_000240135.3 12829
Fus_oxy_GCF_013085055.1 17818
Gla_loz_GCA_000409485.1 13423
Gol_cic_GCA_003611195.1 10947
Gol_cic_GCA_003611215.1 10790
Gol_cic_GCA_003611235.1 10746
Gol_mag_GCA_006912115.1 33442
Gol_oro_MGH1 16686
Lev_tau_CADEPA01 14978
Mag_ory_GCF_000002495.2 11245
Mel_lar_GCA_000204055.1 23912
Mol_sco_GCA_001500285.1 18404
Neo_alb_GCA_003988965.1 11189
Neu_cra_GCA_000182925.2 9449
Oid_mai_GCA_000827325.1 16737
Oid_hev_GCA_003957845.1 10034
Par_pol_Parp01 6879
Phi_sub_GCA_900073065.1 22146
Phy_mor_GCA_019455665.1 14886
Ple_shi_GCA_019455505.1 11647
Ple_ost_GCA_014466165.1 13018
Pod_aph_DRT72020 10287
Pod_aph_DRT72021 9894
Pod_aph_SCOTT2020 8819
Pod_cer_GCA_018398735.1 6560
Pod_fus_GCA_030378345.1 10982
Pod_leu_GCA_013170925.1 7954
Pod_leu_OGB2019 10752
Pod_leu_OGB2021 10004
Pod_leu_OGBp112020 9529
Pod_xan_GCA_010015925.1 5368
Pod_xan_GCA_014884795.1 9571
Pod_xan_GCA_028751805.1 10400
Psi_cub_GCA_017499595.2 14054
Puc_gra_GCA_000149925.1 16981
Puc_str_GCA_021901695.1 19169
Puc_tri_GCA_000151525.2 20207
Pyr_ory_GCA_000002495.2 11217
Sac_cer_GCF_000146045.2 5549
Sch_com_GCA_000143185.2 14390
Scl_scl_GCA_000146945.2 10978
Scl_scl_GCF_000146945.1 10971
Tub_mel_GCF_000151645.1 9818
Ust_may_GCA_000328475.2 6780


cd /home/theaven/scratch/uncompressed/mcag/db
makeblastdb -in /home/theaven/scratch/uncompressed/genomes/Botrytis/cineria/GCA_000143535.4/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta -input_type fasta -dbtype prot  -title Bot_cin  -parse_seqids -out Bot_cin
makeblastdb -in /home/theaven/scratch/uncompressed/genomes/Magnaporthe/oryzae/GCF_000002495.2/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta -input_type fasta -dbtype prot  -title Mag_ory  -parse_seqids -out Mag_ory
makeblastdb -in /home/theaven/scratch/uncompressed/genomes/Colletotrichum/higginsianum/GCA_001672515.1/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta -input_type fasta -dbtype prot  -title Col_hig  -parse_seqids -out Col_hig
makeblastdb -in /home/theaven/scratch/uncompressed/genomes/Sclerotinia/sclerotiorum/GCA_000146945.2/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta -input_type fasta -dbtype prot  -title Scl_scl  -parse_seqids -out Scl_scl
makeblastdb -in /home/theaven/scratch/uncompressed/genomes/Saccharomyces/cerevisiae/GCF_000146045.2/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta -input_type fasta -dbtype prot  -title Sac_cer  -parse_seqids -out Sac_cer

blastp -query /home/theaven/scratch/uncompressed/genomes/Saccharomyces/cerevisiae/GCF_000146045.2/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta -db Scl_scl -out ../Scl_scl_results -evalue 1e-5 -outfmt 6 -num_threads 1 -max_target_seqs 1
awk '{print $1}' ../Scl_scl_results | sort | uniq > hits.txt
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file hits.txt --input /home/theaven/scratch/uncompressed/genomes/Saccharomyces/cerevisiae/GCF_000146045.2/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta --output Sac_cer_Scl_scl.faa
blastp -query Sac_cer_Scl_scl.faa -db Col_hig -out ../Col_hig_results -evalue 1e-5 -outfmt 6 -num_threads 1 -max_target_seqs 1
awk '{print $1}' ../Col_hig_results | sort | uniq > hits.txt
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file hits.txt --input Sac_cer_Scl_scl.faa --output Sac_cer_Scl_scl_Col_hig.faa
blastp -query Sac_cer_Scl_scl_Col_hig.faa -db Mag_ory -out ../Mag_ory_results -evalue 1e-5 -outfmt 6 -num_threads 1 -max_target_seqs 1
awk '{print $1}' ../Mag_ory_results | sort | uniq > hits.txt
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file hits.txt --input Sac_cer_Scl_scl_Col_hig.faa --output Sac_cer_Scl_scl_Col_hig_Mag_ory.faa
blastp -query Sac_cer_Scl_scl_Col_hig_Mag_ory.faa -db Bot_cin -out ../Bot_cin_results -evalue 1e-5 -outfmt 6 -num_threads 1 -max_target_seqs 1
awk '{print $1}' ../Bot_cin_results | sort | uniq > hits.txt
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file hits.txt --input Sac_cer_Scl_scl_Col_hig_Mag_ory.faa --output Sac_cer_Scl_scl_Col_hig_Mag_ory_Bot_cin.faa
grep '>' Sac_cer_Scl_scl_Col_hig_Mag_ory_Bot_cin.faa | wc -l #4,048

blastp -query /home/theaven/scratch/uncompressed/genomes/Saccharomyces/cerevisiae/GCF_000146045.2/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta -db Scl_scl -out ../Scl_scl_results -evalue 1e-10 -outfmt 6 -num_threads 1 -max_target_seqs 1
awk '{print $1}' ../Scl_scl_results | sort | uniq > hits.txt
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file hits.txt --input /home/theaven/scratch/uncompressed/genomes/Saccharomyces/cerevisiae/GCF_000146045.2/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta --output Sac_cer_Scl_scl.faa
blastp -query Sac_cer_Scl_scl.faa -db Col_hig -out ../Col_hig_results -evalue 1e-10 -outfmt 6 -num_threads 1 -max_target_seqs 1
awk '{print $1}' ../Col_hig_results | sort | uniq > hits.txt
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file hits.txt --input Sac_cer_Scl_scl.faa --output Sac_cer_Scl_scl_Col_hig.faa
blastp -query Sac_cer_Scl_scl_Col_hig.faa -db Mag_ory -out ../Mag_ory_results -evalue 1e-10 -outfmt 6 -num_threads 1 -max_target_seqs 1
awk '{print $1}' ../Mag_ory_results | sort | uniq > hits.txt
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file hits.txt --input Sac_cer_Scl_scl_Col_hig.faa --output Sac_cer_Scl_scl_Col_hig_Mag_ory.faa
blastp -query Sac_cer_Scl_scl_Col_hig_Mag_ory.faa -db Bot_cin -out ../Bot_cin_results -evalue 1e-10 -outfmt 6 -num_threads 1 -max_target_seqs 1
awk '{print $1}' ../Bot_cin_results | sort | uniq > hits.txt
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file hits.txt --input Sac_cer_Scl_scl_Col_hig_Mag_ory.faa --output Sac_cer_Scl_scl_Col_hig_Mag_ory_Bot_cin2.faa
grep '>' Sac_cer_Scl_scl_Col_hig_Mag_ory_Bot_cin2.faa | wc -l #3,660

screen -S mcag
srun -p short  -c 1 --mem 50G --pty bash
mkdir -p test/out
cd /home/theaven/scratch/uncompressed/mcag/db/test
for proteome in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta); do
ID=$(echo $proteome | cut -d '/' -f7 | cut -c 1-3)_$(echo $proteome | cut -d '/' -f8 | cut -c 1-3)_$(echo $proteome | cut -d '/' -f9)
echo $ID
makeblastdb -in $proteome -input_type fasta -dbtype prot  -title $ID -parse_seqids -out $ID
blastp -query ../Sac_cer_Scl_scl_Col_hig_Mag_ory_Bot_cin2.faa -db $ID -out out/${ID}_results -evalue 1e-6 -outfmt 6 -num_threads 32 -max_target_seqs 1
done

cd out
grep '>' ../../Sac_cer_Scl_scl_Col_hig_Mag_ory_Bot_cin2.faa | sed 's@>@@g' > CAGs.txt
echo CAGs > mcags.txt
cat CAGs.txt >> mcags.txt
for proteome in *_results; do
    echo "$proteome" > temp.txt
    while IFS= read -r line; do
      echo $line
        # Check if the line exists in the current proteome file
        if grep -qF "$line" "$proteome"; then
            echo "1" >> temp.txt
        else
            echo "0" >> temp.txt
        fi
    done < "CAGs.txt"
    paste mcags.txt temp.txt > temp2.txt && mv temp2.txt mcags.txt
done

head -n 1 mcags.txt > MCAGs.tsv
awk -F'\t' 'BEGIN {OFS="\t"} {count=0; for (i=7; i<=22; i++) if ($i == "0") count++; for (i=30; i<=50; i++) if ($i == "0") count++; for (i=56; i<=74; i++) if ($i == "0") count++; if (count >= 3) print}' mcags.txt >> MCAGs.tsv
#572 are missing from at least 3 mildews
#927 are missing from at least 2 mildews
#1,622 are missing from at least 1 mildew

cd /home/theaven/scratch/uncompressed/mcag/db/test
makeblastdb -in /home/theaven/scratch/uncompressed/mcag/db/Sac_cer_Scl_scl_Col_hig_Mag_ory_Bot_cin2.faa -input_type fasta -dbtype prot  -title spanu -parse_seqids -out spanu
for file in $(ls /home/theaven/scratch/uncompressed/mcag/prot/*); do
name=$(basename $file | cut -d '.' -f1)
blastp -query $file -db spanu -out ../${name}_results -evalue 1e-6 -outfmt 6 -num_threads 1 
done

cat ../*results > temp.txt
awk -F'\t' '$3 > 90' temp.txt > temp2.txt
```
99 mcags
```bash
#Give species unique names to each predicted gene:
mkdir /home/theaven/scratch/uncompressed/mcag/db/99
cd /home/theaven/scratch/uncompressed/mcag/db/99
for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta); do
ID=$(echo $file | cut -d '/' -f7 | cut -c 1-3)_$(echo $file | cut -d '/' -f8 | cut -c 1-3)_$(echo $file | cut -d '/' -f9)
echo $ID
cp $file ./${ID}_$(basename $file)
sed -i "s/>/>${ID}_/g" ${ID}_$(basename $file)
done

for file in $(ls *final_genes_renamed.pep.fasta); do
seqkit rmdup $file > temp.fasta && mv temp.fasta $file
done

#make a blast database from the proteomes and query each putative MCAG against it:
mkdir db
cat *final_genes_renamed.pep.fasta > db/db.faa
cd db
makeblastdb -in db.faa -input_type fasta -dbtype prot  -title mildew+db  -parse_seqids -out mildew+db

for file in $(ls /home/theaven/scratch/uncompressed/mcag/prot/*.fsa); do
name=$(basename $file | cut -d '.' -f1)
blastp -query $file -db mildew+db -out ../${name}_results -evalue 1e-5 -outfmt 6 -num_threads 1
done

ls ../*_results | wc -l

#Collect results into one file:
echo Gene: > out99.tsv

for file2 in $(ls ../*_final_genes_renamed.pep.fasta); do
  name=$(basename $file2 | sed 's@_clean_final_genes_renamed.pep.fasta@@g')
  sed -i "\$s/\$/ $name/" out99.tsv
done

for file in $(ls ../*_results); do
gene=$(awk '{print $1; exit}' $file)
echo $gene >> out99.tsv
for file2 in $(ls ../*_final_genes_renamed.pep.fasta); do
  name=$(basename $file2 | sed 's@_clean_final_genes_renamed.pep.fasta@@g')
x=$(grep -m 1 $name $file | awk '{print $11}')
if [ -z "$x" ]; then
    y=missing
else
    y=$x
fi
sed -i "\$s/\$/ $y/" out99.tsv
done
done
```
Check to see if MCAGs that are present blast to distantly related species and are therefore likely contaminants rather than truely present MCAGs:
```bash
#Collect gne IDs for select de novo mcags:
mkdir /home/theaven/scratch/uncompressed/mcag/db/blast
extramcags=/home/theaven/scratch/uncompressed/mcags+.txt
for blastresult in /home/theaven/scratch/uncompressed/mcag/db/test/out/*_results; do
  assembly_id=$(basename "$blastresult" | sed 's@_results@@g')
  awk 'NR==FNR { patterns[$1]; next } $1 in patterns && !($1 in printed) { print; printed[$1] }' "$extramcags" "$blastresult" | awk '{print $2}' > temp_genenames.txt
  while read -r gene; do
    echo "${assembly_id}_${gene}" >> "/home/theaven/scratch/uncompressed/mcag/db/blast/${assembly_id}_proteins.txt"
  done < temp_genenames.txt
  rm temp_genenames.txt
done
#Collect gene IDs for 99 predefined MCAGS:
ls /home/theaven/scratch/uncompressed/mcag/db/99/*_final_genes_renamed.pep.fasta | rev | cut -d '/' -f1 |  rev | sed 's@_clean_final_genes_renamed.pep.fasta@@g' > assemblies.txt
for assembly_id in $(cat assemblies.txt); do
for protein in $(ls /home/theaven/scratch/uncompressed/mcag/db/99/*_protein_results); do
grep -m 1 "$assembly_id" $protein | awk '{print $2}' >> /home/theaven/scratch/uncompressed/mcag/db/blast/${assembly_id}_proteins.txt
done
done

#Get the corresponding protein sequences for the mcags
for file in $(ls /home/theaven/scratch/uncompressed/mcag/db/blast/*_proteins.txt); do
sort $file > temp-temp.txt && mv temp-temp.txt $file
done

for file in $(ls /home/theaven/scratch/uncompressed/mcag/db/blast/*_proteins.txt); do
  ID=$(basename $file | sed 's@_proteins.txt@@g')
  ls /home/theaven/scratch/uncompressed/mcag/db/99/${ID}_clean_final_genes_renamed.pep.fasta
  python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file $file --input /home/theaven/scratch/uncompressed/mcag/db/99/${ID}_clean_final_genes_renamed.pep.fasta --output /home/theaven/scratch/uncompressed/mcag/db/blast/${ID}_final_genes_renamed.pep.fasta
done

#Get search the mcag proteins against the uniprot database
for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast2/*_final_genes_renamed.pep.fasta); do
Database=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/databases/blast/uniprot_01102023/Uniprot_01102023_reference_proteomes.dmnd
OutDir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/MCAG/blast2
OutFile=$(basename $file | sed 's@_final_genes_renamed.pep.fasta@@g')
hits=5
ProgDir=~/git_repos/Wrappers/NBI
sbatch $ProgDir/run_diamond_blastp.sh $file $Database $OutDir $OutFile $hits
done
#1272157-240

#Collect the outputs into a single file for each assembly:
for assembly_id in $(cat assemblies.txt); do
echo -e "MCAG\tTop_hit\tblast_1\tblast_2\tblast_3\tblast_4\tblast_5\tID_1\tID_2\tID_3\tID_4\tID_5" > /home/theaven/scratch/uncompressed/mcag/db/blast/${assembly_id}_proteins_notes.txt
for protein in $(ls /home/theaven/scratch/uncompressed/mcag/db/99/*_protein_results); do
x=$(basename $protein | sed 's@_protein_results@@g'| sed 's@results/@@g') 
y=$(grep -m 1 "$assembly_id" $protein | awk '{print $2}')
echo -e "$x\t$y" >> /home/theaven/scratch/uncompressed/mcag/db/blast/${assembly_id}_proteins_notes.txt
done
done

extramcags=/home/theaven/scratch/uncompressed/mcags+.txt
mapfile -t patterns < "$extramcags"
for blastresult in /home/theaven/scratch/uncompressed/mcag/db/test/out/*_results; do
  assembly_id=$(basename "$blastresult" | sed 's@_results@@g')
  
  for pattern in "${patterns[@]}"; do
    y=$(awk -v pat="$pattern" '$1 == pat { print $2; exit }' "$blastresult")
    if [ -n "$y" ]; then
      echo -e "${pattern}\t${assembly_id}_${y}" >> "/home/theaven/scratch/uncompressed/mcag/db/blast/${assembly_id}_proteins_notes.txt"
    fi
  done
done

for file in $(ls /home/theaven/scratch/uncompressed/mcag/db/blast/*_proteins_notes.txt); do
awk 'BEGIN {FS=OFS="\t"} $2 == "" {$2="###"}1' $file > temp.txt && mv temp.txt $file
done

for file in /home/theaven/scratch/uncompressed/mcag/db/blast/*_proteins_notes.txt; do
    ID=$(basename "$file" | sed 's@_proteins_notes.txt@@g')
    while IFS=$'\t' read -r col1 col2 rest; do
        matches=$(grep "^$col2" "/home/theaven/scratch/uncompressed/mcag/db/blast/${ID}.vs.Uniprot_01102023_reference_proteomes.dmnd.diamond_blastp.out" | awk -v col2="$col2" '$1 == col2 {printf "%s\t", $5}')
        if [ -n "$matches" ]; then
            matches="${matches%?}"  # Remove the last character (trailing tab)
        fi
        echo -e "$col1\t$col2\t$rest\t$matches"
    done < "$file" > "${ID}merged_notes.txt"
    awk 'BEGIN {FS=OFS="\t"} {print $1, $2, $4, $5, $6, $7, $8, $9}' ${ID}merged_notes.txt > $file
    rm ${ID}merged_notes.txt
done

#Get the uniprot codes for lookup:
for file in /home/theaven/scratch/uncompressed/mcag/db/blast/*_proteins_notes.txt; do
awk -F'\t' '{split($3, a, "|"); split($4, b, "|"); split($5, c, "|"); split($6, d, "|"); split($7, e, "|"); print a[2] "\n" b[2] "\n" c[2] "\n" d[2] "\n" e[2]}' $file | sort | uniq > $(dirname $file)/$(basename $file | sed 's@_proteins_notes.txt@@g')_protcodes.txt
done

#Edit notes file to contain species info:
for notes in $(ls /home/theaven/scratch/uncompressed/mcag/db/blast/*_proteins_notes.txt); do
tsv=/home/theaven/scratch/uncompressed/mcag/db/blast/uniprot/$(basename "$notes" | sed 's@_proteins_notes.txt@_protcodes.tsv@g')
output_file="edited_file.txt"
rm "$output_file"
touch "$output_file"
while IFS= read -r line; do
    id=$(echo "$line" | awk -F'\t' '{split($3, arr, "|"); print arr[2]}')
    fifth_column=$(awk -v var="$id" -F'\t' '$1 == var {print $5}' $tsv | cut -d ' ' -f1,2)
    edited_line="$line\t$fifth_column"
    echo -e "$edited_line" >> "$output_file"
done < $notes
mv "$output_file" $notes
rm "$output_file"
touch "$output_file"
while IFS= read -r line; do
    id=$(echo "$line" | awk -F'\t' '{split($4, arr, "|"); print arr[2]}')
    fifth_column=$(awk -v var="$id" -F'\t' '$1 == var {print $5}' $tsv | cut -d ' ' -f1,2)
    edited_line="$line\t$fifth_column"
    echo -e "$edited_line" >> "$output_file"
done < $notes
mv "$output_file" $notes
rm "$output_file"
touch "$output_file"
while IFS= read -r line; do
    id=$(echo "$line" | awk -F'\t' '{split($5, arr, "|"); print arr[2]}')
    fifth_column=$(awk -v var="$id" -F'\t' '$1 == var {print $5}' $tsv | cut -d ' ' -f1,2)
    edited_line="$line\t$fifth_column"
    echo -e "$edited_line" >> "$output_file"
done < $notes
mv "$output_file" $notes
rm "$output_file"
touch "$output_file"
while IFS= read -r line; do
    id=$(echo "$line" | awk -F'\t' '{split($6, arr, "|"); print arr[2]}')
    fifth_column=$(awk -v var="$id" -F'\t' '$1 == var {print $5}' $tsv | cut -d ' ' -f1,2)
    edited_line="$line\t$fifth_column"
    echo -e "$edited_line" >> "$output_file"
done < $notes
mv "$output_file" $notes
rm "$output_file"
touch "$output_file"
while IFS= read -r line; do
    id=$(echo "$line" | awk -F'\t' '{split($7, arr, "|"); print arr[2]}')
    fifth_column=$(awk -v var="$id" -F'\t' '$1 == var {print $5}' $tsv | cut -d ' ' -f1,2)
    edited_line="$line\t$fifth_column"
    echo -e "$edited_line" >> "$output_file"
done < $notes
mv "$output_file" $notes
done
```
```bash
ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/*fcs_gx_report.txt
ls /home/theaven/scratch/uncompressed/mildews/*/gene_pred/braker/final_2/final_genes_renamed.gff3 > temp_search.txt
ls other/*/gene_pred/braker/final/final_genes_renamed.gff3

for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/*clean.fasta); do
gff=$(dirname $file | sed 's@/fcs@@g')/braker/final_genes_renamed.gff3
out_gff=$(dirname $file | sed 's@/fcs@@g')/braker/final_genes_renamed_filtered.gff3
for search in $(grep '>' $file | cut -d ' ' -f1 | sed 's@.@_@g' | sed 's@>@@g'); do
grep "$search" $gff >> $out_gff
done

Genome=
Gff=
OutFile=
singularity exec /home/theaven/scratch/apps/containers/agat_1.3.2--pl5321hdfd78af_0 agat_sp_extract_sequences.pl -g $Gff -f $Genome -t cds --output $OutFile --clean_final_stop --protein


head -n 1 /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/*clean.fasta
for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/*fcs_gx_report.txt); do
ID=$(echo $file | cut -d '/' -f9 | cut -d '.' -f1)
gff=$(grep "$ID" temp_search.txt)
OutDir=$(dirname $file | sed 's@/fcs@@g')/braker
if [ -n "$gff" ]; then
#echo $ID found:
#echo $gff
#mkdir $OutDir
#ln -s $gff ${OutDir}/.
sleep 1s
else
echo $ID not found
#mkdir $OutDir
echo $OutDir
fi
done


```
/home/theaven/scratch/uncompressed/genomes/Ustilago/maydis/GCA_000328475.2/fcs/GCA_000328475.2_Umaydis521_2.0_genom.fcs_gx_report.txt

/home/theaven/scratch/uncompressed/mildews/Scereviseae_GCF_000146045/gene_pred/braker/final_2/final_genes_renamed.pep.fasta



GCA_000151065 not found
/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis/GCA_000151065.3/braker #
SRR2153116 not found
/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153116/braker #
SRR2153117 not found
/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153117/braker #
SRR2153118 not found
/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153118/braker #
SRR2153119 not found
/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153119/braker #
SRR2153120 not found
/home/theaven/scratch/uncompressed/genomes/Blumeria/graminis-secale/SRR2153120/braker #
GCA_000143535 not found
/home/theaven/scratch/uncompressed/genomes/Botrytis/cineria/GCA_000143535.4/braker #
broad_KN1394 not found
/home/theaven/scratch/uncompressed/genomes/Colletotrichum/higginsianum/broad_KN1394/braker #
GCA_000182895 not found
/home/theaven/scratch/uncompressed/genomes/Coprinus/cinereus/GCA_000182895.1/braker #
GCF_000091045 not found
/home/theaven/scratch/uncompressed/genomes/Cryptococcus/neoformans/GCF_000091045.1/braker #
GCA_024703715 not found
/home/theaven/scratch/uncompressed/genomes/Erysiphe/necator/GCA_024703715.1/braker #
GCA_000240135 not found
/home/theaven/scratch/uncompressed/genomes/Fusarium/graminearum/GCA_000240135.3/braker #
GCF_013085055 not found
/home/theaven/scratch/uncompressed/genomes/Fusarium/oxysporum/GCF_013085055.1/braker #
GCF_000002495 not found
/home/theaven/scratch/uncompressed/genomes/Magnaporthe/oryzae/GCF_000002495.2/braker #
Parp01 not found
/home/theaven/scratch/uncompressed/genomes/Parauncinula/polyspora/Parp01/braker #
GCA_014466165 not found
/home/theaven/scratch/uncompressed/genomes/Pleurotus/ostreatus/GCA_014466165.1/braker #
GCA_030378345 not found
/home/theaven/scratch/uncompressed/genomes/Podosphaera/fusca/GCA_030378345.1/braker #
GCA_028751805 not found
/home/theaven/scratch/uncompressed/genomes/Podosphaera/xanthii/GCA_028751805.1/braker #
GCA_017499595 not found
/home/theaven/scratch/uncompressed/genomes/Psilocybe/cubensis/GCA_017499595.2/braker #
GCA_000149925 not found
/home/theaven/scratch/uncompressed/genomes/Puccinia/graminis/GCA_000149925.1/braker #
GCA_021901695 not found
/home/theaven/scratch/uncompressed/genomes/Puccinia/striiformis/GCA_021901695.1/braker #
GCA_000151525 not found
/home/theaven/scratch/uncompressed/genomes/Puccinia/triticina/GCA_000151525.2/braker #
GCA_000143185 not found
/home/theaven/scratch/uncompressed/genomes/Schizophyllum/commune/GCA_000143185.2/braker #
GCA_000146945 not found
/home/theaven/scratch/uncompressed/genomes/Sclerotinia/sclerotiorum/GCA_000146945.2/braker #
GCF_000146945 not found
/home/theaven/scratch/uncompressed/genomes/Sclerotinia/sclerotiorum/GCF_000146945.1/braker #
GCF_000151645 not found
/home/theaven/scratch/uncompressed/genomes/Tuber/melanosporum/GCF_000151645.1/braker #
GCA_000328475 not found
/home/theaven/scratch/uncompressed/genomes/Ustilago/maydis/GCA_000328475.2/braker #


Blast for aphanis only effectors across wider mildews:
```bash
for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/clean_final_genes_renamed.pep.fasta); do
output_dir=$(dirname $file)
ID=$(echo $file | cut -d '/' -f7 | cut -c 1-3)_$(echo $file | cut -d '/' -f8 | cut -c 1-3)_$(echo $file | cut -d '/' -f9)
echo $ID
sed -E "/^>/ s/>[[:space:]]*/&$ID /" $file | sed 's/ \([^\t]\)/_\1/' > ${output_dir}/${ID}_clean_final_genes.pep.fasta
done

mkdir db
for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  cat $file >> db/clean_mildew.faa
done

conda activate seqkit
seqkit rmdup db/clean_mildew.faa > temp.fasta && mv temp.fasta db/clean_mildew.faa
conda deactivate

conda activate blast+
cd /home/theaven/scratch/uncompressed/db
makeblastdb -in clean_mildew.faa -input_type fasta -dbtype prot  -title mildew+db  -parse_seqids -out mildew+db

while IFS=$'\t' read -r line; do
    awk -F'\t' '$31 == "1" && $27 == "." && $7 == "0" {print $1}' <<< "$line" | grep -v 'name' >> aphanis_only_secreted_effectors.txt
done < ~/projects/niab/theaven/results/P_aphanis-THeavenDRCT72020_1-aphanis-ranked4.tsv

while IFS=$'\t' read -r line; do
echo $line > hits.txt
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file hits.txt --input /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta --output effectors/${line}.faa
done < aphanis_only_secreted_effectors.txt

for file in $(ls effectors/*.faa); do
name=$(basename $file | cut -d '.' -f1)
blastp -query $file -db db/mildew+db -out effectors/${name}_results -evalue 1e-5 -outfmt 6 -num_threads 16 -max_target_seqs 99999
done

echo Gene: > effectors/out.tsv

for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file | cut -d '/' -f7 | cut -c 1-3)_$(echo $file | cut -d '/' -f8 | cut -c 1-3)_$(echo $file | cut -d '/' -f9)
sed -i "\$s/\$/ $ID/" effectors/out.tsv
done


for file in $(ls effectors/*_results); do
gene=$(basename $file | sed 's@_results@@g')
echo $gene
echo $gene >> effectors/out.tsv
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep -m 1 $ID $file | awk '{print $11}')
if [ -z "$x" ]; then
    y=missing
else
    y=$x
fi
sed -i "\$s/\$/ $y/" effectors/out.tsv
done
done

ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/*clean.fasta

for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/*clean.fasta); do
output_dir=$(dirname $file)
ID=$(echo $file | cut -d '/' -f7 | cut -c 1-3)_$(echo $file | cut -d '/' -f8 | cut -c 1-3)_$(echo $file | cut -d '/' -f9)
echo $ID
sed -E "/^>/ s/>[[:space:]]*/&$ID /" $file | sed 's/ \([^\t]\)/_\1/' | awk '{print $1}' | sed 's@_Oidium_NoIndex_L002_R1_R2_paired_trimmed@@g' | awk -F'_length' '{print $1}' > ${output_dir}/${ID}_clean_renamed.fasta
done

for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/*clean_renamed.fasta); do
  cat $file >> db/clean_mildew.fa
done

awk 'length($0) > 50 && /^>/ {print}' db/clean_mildew.fa

conda activate seqkit
seqkit rmdup db/clean_mildew.fa > temp.fasta && mv temp.fasta db/clean_mildew.fa
conda deactivate

srun -p short --mem-per-cpu 4G --cpus-per-task 8 --pty bash
conda activate blast+
cd /home/theaven/scratch/uncompressed/db
makeblastdb -in clean_mildew.fa -input_type fasta -dbtype nucl  -title mildew+db2  -parse_seqids -out mildew+db2

for file in $(ls effectors/*.faa); do
name=$(basename $file | cut -d '.' -f1)
tblastn -query $file -db db/mildew+db2 -out effectors/${name}_resultsx -evalue 1e-5 -outfmt 6 -num_threads 16 -max_target_seqs 99999
done

g6562.t1        Pod_aph_SCOTT2020_contig_55     65.000  80      10      2       1       63      10354   10118
g12955.t1       Pod_aph_DRT72020_contig_3643    100.000 248     0       0       48      295     3388    4131    2.33e-170       514


echo Gene: >> effectors/out7.tsv

for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file | cut -d '/' -f7 | cut -c 1-3)_$(echo $file | cut -d '/' -f8 | cut -c 1-3)_$(echo $file | cut -d '/' -f9)
sed -i "\$s/\$/ $ID/" effectors/out7.tsv
done

#E value of top hit:
for file in $(ls effectors/*_resultsx); do
gene=$(basename $file | sed 's@_resultsx@@g')
echo $gene
echo $gene >> effectors/out2.tsv
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep -m 1 $ID $file | awk '{print $11}')
if [ -z "$x" ]; then
    y=missing
else
    y=$x
fi
sed -i "\$s/\$/ $y/" effectors/out2.tsv
done
done

#E value of top hit, filter for % query length and % identity:
for file in $(ls effectors/*_resultsx); do
gene=$(basename $file | sed 's@_resultsx@@g')
echo $gene
echo $gene >> effectors/out6.tsv
gene_file=$(ls effectors/${gene}.t1.faa)
gene_length=$(grep -v '>' $gene_file | tr -d '\n' | wc -c)
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep -m 1 $ID $file | awk '$3 > 70' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.4' | awk '{print $11}')
if [ -z "$x" ]; then
    y=missing
else
    y=$x
fi
sed -i "\$s/\$/ $y/" effectors/out6.tsv
done
done

#No. of hits
for file in $(ls effectors/*_resultsx); do
gene=$(basename $file | sed 's@_resultsx@@g')
echo $gene
echo $gene >> effectors/out7.tsv
gene_file=$(ls effectors/${gene}.t1.faa)
gene_length=$(grep -v '>' $gene_file | tr -d '\n' | wc -c)
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 > 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.4' | wc -l)
sed -i "\$s/\$/ $x/" effectors/out7.tsv
done
done


for file in $(ls effectors/*_resultsx); do
  grep $ID $file | awk '$3 > 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.4' >> temp.out.txt
done



#Check for stop codons???
for file in $(ls effectors/*_resultsx); do
gene=$(basename $file | sed 's@_resultsx@@g')
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file >> effectors/species/${ID}2.tsv
#sed -i "s@${ID}_@@g" effectors/species/${ID}.tsv
#sed -i 's@_contig@contig@g' effectors/species/${ID}.tsv
done
done

for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
  out=$(dirname $file2)/aphanis_only2.bed
awk -F'\t' '{print $2"\t"$9"\t"$10"\t"$1}' effectors/species/${ID}2.tsv > $out
done

for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/aphanis_only2.bed); do
  genome=$(ls $(echo $file | cut -d '/' -f1,2,3,4,5,6,7,8,9,10)/*clean_renamed.fasta)
singularity exec ~/scratch/apps/containers/bedtools_2.31.1--hf5e1c6e_1 bedtools getfasta -fi $genome -bed $file > $(echo $file | sed 's@.bed@.fa@g')
done










for file in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/final_genes_renamed.gff3); do
  out=$(echo $file | sed 's@.gff3@.bed@g')
singularity exec ~/scratch/apps/containers/bedops_2.4.41--h4ac6f70_2 gff2bed < $file > $out
done



for file in $(ls effectors/*_resultsx); do
gene=$(basename $file | sed 's@_resultsx@@g')
echo $gene
echo $gene >> effectors/out7.tsv
gene_file=$(ls effectors/${gene}.t1.faa)
gene_length=$(grep -v '>' $gene_file | tr -d '\n' | wc -c)
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 > 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.4' | grep 'Pod_aph_DRT72020' >> temp.out.txt
grep $ID $file | awk '$3 > 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.4' | grep 'Pod_aph_DRT72021' >> temp2.out.txt
grep $ID $file | awk '$3 > 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.4' | grep 'Pod_aph_SCOTT2020' >> temp3.out.txt
sed -i "\$s/\$/ $x/" effectors/out7.tsv
done
done


makeblastdb -in data/assembly/genome/fragaria/ananassa/F_ana_Camarosa_6-28-17.c.fna -input_type fasta -dbtype nucl  -title fananasadb2  -parse_seqids -out fananasadb2
for file in $(ls effectors/*.t1.faa); do
name=$(basename $file | cut -d '.' -f1)
tblastn -query $file -db fananasadb2 -out ${name}_resultsx_fragan -evalue 1e-5 -outfmt 6 -num_threads 12 -max_target_seqs 99999
done


for file in $(ls *_resultsx_fragan); do
gene=$(basename $file | sed 's@_resultsx_fragan@@g')
echo $gene
gene_file=$(ls effectors/${gene}.t1.faa)
gene_length=$(grep -v '>' $gene_file | tr -d '\n' | wc -c)
echo $file | awk '$3 > 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.4'
done

makeblastdb -in data/assembly/genome/rubus/idaeus/AnitraCuratedED_HiC.c.fna -input_type fasta -dbtype nucl  -title ridaeusdb2  -parse_seqids -out ridaeusdb2
for file in $(ls effectors/*.t1.faa); do
name=$(basename $file | cut -d '.' -f1)
tblastn -query $file -db ridaeusdb2 -out ${name}_resultsx_ridaeus -evalue 1e-5 -outfmt 6 -num_threads 12 -max_target_seqs 99999
done

for file in $(ls *_resultsx_ridaeus); do
gene=$(basename $file | sed 's@_resultsx_ridaeus@@g')
echo $gene
gene_file=$(ls effectors/${gene}.t1.faa)
gene_length=$(grep -v '>' $gene_file | tr -d '\n' | wc -c)
echo $file | awk '$3 > 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.4'
done
```
```bash
grep 'g10232;\|g11054;\|g11278;\|g1209;\|g12302;\|g12450;\|g12453;\|g12628;\|g12667;\|g12955;\|g13367;\|g13490;\|g1355;\|g13885;\|g14348;\|g14731;\|g14832;\|g15923;\|g2113;\|g2919;\|g2928;\|g3129;\|g324;\|g422;\|g548;\|g5605;\|g5645;\|g5721;\|g6055;\|g6450;\|g6520;\|g6562;\|g7278;\|g757;\|g8019;\|g9359;\|g10232.t1\|g11054.t1\|g11278.t1\|g1209.t1\|g12302.t1\|g12450.t1\|g12453.t1\|g12628.t1\|g12667.t1\|g12955.t1\|g13367.t1\|g13490.t1\|g1355.t1\|g13885.t1\|g14348.t1\|g14731.t1\|g14832.t1\|g15923.t1\|g2113.t1\|g2919.t1\|g2928.t1\|g3129.t1\|g324.t1\|g422.t1\|g548.t1\|g5605.t1\|g5645.t1\|g5721.t1\|g6055.t1\|g6450.t1\|g6520.t1\|g6562.t1\|g7278.t1\|g757.t1\|g8019.t1\|g9359.t1' /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 > effectors/aphanis_only.gff
```
Aphanis_Gene: Exon_no.: Lengths:
g10232  1 1289
g11054  4 321 506 437 157
g11278  3 160 407 873
g1209 2 253 228
g12302  2 115 378
g12450  1 764
g12453  2 483 37
g12628  1 257
g12667* 2 142 141
g12955  2 141 745
g13367  4 157 407 509 321
g13490  1 500
g1355 1 491
g13885  1 647
g14348  1 899
g14731  2 439 123
g14832  1 786
g15923  1 611
g2113 2 479 44
g2919 1 230
g2928 1 605
g3129 1 446
g324  1 539
g422  3 138 226 668
g548  1 332
g5605 2 274 357
g5645 1 665
g5721 2 109 360
g6055 3 68 847 363
g6450 1 1232
g6520*  2 463 66
g6562 2 80 183
g7278 3 13 71 369
g757  1 386
g8019 2 152 386
g9359 1 389

```bash
#No. of hits
Output=effectors/out13.tsv
for file in $(ls effectors/*_resultsxyz); do
gene=$(basename $file | sed 's@_resultsxyz@@g')
echo $gene
echo $gene >> $Output

if [[ $gene == "g10232" || $gene == "g12450" || $gene == "g12628" || $gene == "g13490" || $gene == "g1355" || $gene == "g13885" || $gene == "g14348" || $gene == "g14832" || $gene == "g15923" || $gene == "g2919" || $gene == "g2928" || $gene == "g3129" || $gene == "g324" || $gene == "g548" || $gene == "g5645" || $gene == "g6450" || $gene == "g757" || $gene == "g9359" ]]; then
gene_file=$(ls effectors/${gene}.t1.faa)
gene_length=$(grep -v '>' $gene_file | tr -d '\n' | wc -c)
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.7' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g11054" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 118' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g11278" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 203' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g1209" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 59' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g12302" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 88' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g12453" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 112' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g12667" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 32' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g12955" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 173' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g13367" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 118' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g14731" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 102' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g2113" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 111' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g422" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 155' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g5605" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 83' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g5721" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 84' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g6055" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 197' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g6520" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 108' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g6562" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 42' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g7278" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 86' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g8019" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 90' | awk '$11 < 1e-23' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

fi

done

for file in $(ls effectors/*.faa); do
name=$(basename $file | cut -d '.' -f1)
tblastn -query $file -db db/mildew+db2 -out effectors/${name}_resultsxyz -evalue 1e-5 -outfmt "6 std qseq sseq" -num_threads 12 -max_target_seqs 99999
done

for file in $(ls effectors/*_out13.tsv); do
x=$(basename $file | sed 's@.tsv@.fasta@g')
mv $file effectors/$x
done

for file in $(ls effectors/*_resultsxyz); do
gene=$(basename $file | sed 's@_resultsxyz@@g')
Output=effectors/${gene}_out13.fasta

  if [[ $gene == "g10232" || $gene == "g12450" || $gene == "g12628" || $gene == "g13490" || $gene == "g1355" || $gene == "g13885" || $gene == "g14348" || $gene == "g14832" || $gene == "g15923" || $gene == "g2919" || $gene == "g2928" || $gene == "g3129" || $gene == "g324" || $gene == "g548" || $gene == "g5645" || $gene == "g6450" || $gene == "g757" || $gene == "g9359" ]]; then
    gene_file=$(ls effectors/${gene}.t1.faa)
    gene_length=$(grep -v '>' "$gene_file" | tr -d '\n' | wc -c)
    for file2 in /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta; do
      ID=$(echo "$file2" | cut -d '/' -f7 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f8 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f9)
      grep "$ID" "$file" | awk '$3 >= 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.7' | awk '$11 < 1e-23' |
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

  elif [[ $gene == "g11054" ]]; then
    for file2 in /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta; do
      ID=$(echo "$file2" | cut -d '/' -f7 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f8 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f9)
      grep "$ID" "$file" | awk '$3 >= 60' | awk '$4 > 118' | awk '$11 < 1e-23' |
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g11278" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 203' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g1209" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 59' | awk '$11 < 1e-23' |
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g12302" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 88' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g12453" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 112' | awk '$11 < 1e-23' |
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g12667" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 32' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g12955" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 173' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g13367" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 118' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g14731" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 102' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g2113" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 111' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g422" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 155' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g5605" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 83' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g5721" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 84' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g6055" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 197' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g6520" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 108' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g6562" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 42' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g7278" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 86' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g8019" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 90' | awk '$11 < 1e-23' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

fi

done



```
```bash
for file in $(ls effectors/*.faa); do
name=$(basename $file | cut -d '.' -f1)
tblastn -query $file -db db/mildew+db2 -out effectors/${name}_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length -num_threads 12 -max_target_seqs 99999
done

for file in $(ls slurm-19869203.out); do
tblastn -query effectors/g10232.t1.faa -db db/mildew+db2 -out effectors/g10232_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g11054.t1.faa -db db/mildew+db2 -out effectors/g11054_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 94 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g11278.t1.faa -db db/mildew+db2 -out effectors/g11278_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 93 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g1209.t1.faa -db db/mildew+db2 -out effectors/g1209_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 304 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g12302.t1.faa -db db/mildew+db2 -out effectors/g12302_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 73 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g12450.t1.faa -db db/mildew+db2 -out effectors/g12450_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g12453.t1.faa -db db/mildew+db2 -out effectors/g12453_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 59 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g12628.t1.faa -db db/mildew+db2 -out effectors/g12628_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g12667.t1.faa -db db/mildew+db2 -out effectors/g12667_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 55 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g12955.t1.faa -db db/mildew+db2 -out effectors/g12955_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 248 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g13367.t1.faa -db db/mildew+db2 -out effectors/g13367_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 100 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g13490.t1.faa -db db/mildew+db2 -out effectors/g13490_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g1355.t1.faa -db db/mildew+db2 -out effectors/g1355_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g13885.t1.faa -db db/mildew+db2 -out effectors/g13885_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g14348.t1.faa -db db/mildew+db2 -out effectors/g14348_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g14731.t1.faa -db db/mildew+db2 -out effectors/g14731_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 59 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g14832.t1.faa -db db/mildew+db2 -out effectors/g14832_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g15923.t1.faa -db db/mildew+db2 -out effectors/g15923_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g2113.t1.faa -db db/mildew+db2 -out effectors/g2113_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 48 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g2919.t1.faa -db db/mildew+db2 -out effectors/g2919_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g2928.t1.faa -db db/mildew+db2 -out effectors/g2928_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g3129.t1.faa -db db/mildew+db2 -out effectors/g3129_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g324.t1.faa -db db/mildew+db2 -out effectors/g324_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g422.t1.faa -db db/mildew+db2 -out effectors/g422_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 349 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g548.t1.faa -db db/mildew+db2 -out effectors/g548_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g5605.t1.faa -db db/mildew+db2 -out effectors/g5605_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 72 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g5645.t1.faa -db db/mildew+db2 -out effectors/g5645_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g5721.t1.faa -db db/mildew+db2 -out effectors/g5721_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 64 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g6055.t1.faa -db db/mildew+db2 -out effectors/g6055_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 67 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g6450.t1.faa -db db/mildew+db2 -out effectors/g6450_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g6520.t1.faa -db db/mildew+db2 -out effectors/g6520_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 73 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g6562.t1.faa -db db/mildew+db2 -out effectors/g6562_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 56 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g7278.t1.faa -db db/mildew+db2 -out effectors/g7278_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 56 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g757.t1.faa -db db/mildew+db2 -out effectors/g757_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g8019.t1.faa -db db/mildew+db2 -out effectors/g8019_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 129 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors/g9359.t1.faa -db db/mildew+db2 -out effectors/g9359_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
done


for file in $(ls effectors/*_resultsxyza); do
gene=$(basename $file | sed 's@_resultsxyza@@g')
Output=effectors/${gene}_out15.fasta

  if [[ $gene == "g10232" || $gene == "g12450" || $gene == "g12628" || $gene == "g13490" || $gene == "g1355" || $gene == "g13885" || $gene == "g14348" || $gene == "g14832" || $gene == "g15923" || $gene == "g2919" || $gene == "g2928" || $gene == "g3129" || $gene == "g324" || $gene == "g548" || $gene == "g5645" || $gene == "g6450" || $gene == "g757" || $gene == "g9359" ]]; then
    gene_file=$(ls effectors/${gene}.t1.faa)
    gene_length=$(grep -v '>' "$gene_file" | tr -d '\n' | wc -c)
    for file2 in /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta; do
      ID=$(echo "$file2" | cut -d '/' -f7 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f8 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f9)
      grep "$ID" "$file" | awk '$3 >= 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.7' | awk '$11 < 1e-20' |
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

  elif [[ $gene == "g11054" ]]; then
    for file2 in /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta; do
      ID=$(echo "$file2" | cut -d '/' -f7 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f8 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f9)
      grep "$ID" "$file" | awk '$3 >= 60' | awk '$4 > 118' | awk '$11 < 1e-20' |
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g11278" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 203' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g1209" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 59' | awk '$11 < 1e-20' |
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g12302" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 88' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g12453" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 112' | awk '$11 < 1e-20' |
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g12667" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 32' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g12955" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 173' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g13367" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 118' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g14731" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 102' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g2113" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 111' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g422" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 155' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g5605" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 83' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g5721" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 84' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g6055" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 197' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g6520" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 108' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g6562" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 42' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g7278" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 86' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

elif [[ $gene == "g8019" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
grep $ID $file | awk '$3 >= 60' | awk '$4 > 90' | awk '$11 < 1e-20' | 
      while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
      done
    done

fi

done


#No. of hits
Output=effectors/out15.tsv
for file in $(ls effectors/*_resultsxyza); do
gene=$(basename $file | sed 's@_resultsxyza@@g')
echo $gene
echo $gene >> $Output

if [[ $gene == "g10232" || $gene == "g12450" || $gene == "g12628" || $gene == "g13490" || $gene == "g1355" || $gene == "g13885" || $gene == "g14348" || $gene == "g14832" || $gene == "g15923" || $gene == "g2919" || $gene == "g2928" || $gene == "g3129" || $gene == "g324" || $gene == "g548" || $gene == "g5645" || $gene == "g6450" || $gene == "g757" || $gene == "g9359" ]]; then
gene_file=$(ls effectors/${gene}.t1.faa)
gene_length=$(grep -v '>' $gene_file | tr -d '\n' | wc -c)
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.7' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g11054" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 118' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g11278" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 203' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g1209" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 59' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g12302" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 88' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g12453" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 112' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g12667" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 32' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g12955" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 173' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g13367" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 118' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g14731" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 102' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g2113" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 111' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g422" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 155' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g5605" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 83' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g5721" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 84' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g6055" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 197' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g6520" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 108' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g6562" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 42' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g7278" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 86' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

elif [[ $gene == "g8019" ]]; then
for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
  ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
x=$(grep $ID $file | awk '$3 >= 60' | awk '$4 > 90' | awk '$11 < 1e-20' | wc -l)
sed -i "\$s/\$/ $x/" $Output
done

fi

done

Output="effectors/out25.tsv"
> $Output 
for file in effectors/*_resultsxyza; do
    gene=$(basename "$file" | sed 's@_resultsxyza@@g')
    echo $gene
    echo -n "$gene" >> $Output  
    while read -r line; do
        x=$(echo "$line" | awk '{print $2}')
        sed -i "\$s/\$/ $x/" $Output
    done < "$file"
    echo "" >> $Output 
done
```
blastp against good gene models
```bash
cat /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta | sed 's@>@>Pod_aph_DRT72020@g' >> good_preds.faa
cat /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta | sed 's@>@>Pod_aph_DRT72021@g' >> good_preds.faa
cat /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenSCOTT2020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta | sed 's@>@>Pod_aph_SCOTT2020@g' >> good_preds.faa
cat /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta | sed 's@>@>Pod_leu_OGBp112020@g' >> good_preds.faa
cat /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2019_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta | sed 's@>@>Pod_leu_OGB2019@g' >> good_preds.faa
cat /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenpOGB2021_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta | sed 's@>@>Pod_leu_OGB2021@g' >> good_preds.faa

makeblastdb -in good_preds.faa -dbtype prot -title gooddb2 -out db/gooddb2

for file in $(ls effectors/*.faa); do
name=$(basename $file | cut -d '.' -f1)
blastp -query $file -db db/gooddb2 -out effectors/${name}_resultsxyzab -evalue 1e-5 -outfmt "6 std qseq sseq" -num_threads 12 -max_target_seqs 99999
done

#No. of hits
Output=effectors/out17.tsv
for file in $(ls effectors/*_resultsxyzab); do
gene=$(basename $file | sed 's@_resultsxyzab@@g')
echo $gene
echo $gene >> $Output

  gene_file=$(ls effectors/${gene}.t1.faa)
  gene_length=$(grep -v '>' $gene_file | tr -d '\n' | wc -c)
  for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
    ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
    x=$(grep $ID $file | awk '$3 >= 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.7' | awk '$11 < 1e-20' | wc -l)
    sed -i "\$s/\$/ $x/" $Output
  done

done

/home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72020/fcs/gene_pred/braker/final-02042924/Pod_aph_DRT72020_clean_final_genes.pep.fasta
/home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/DRT72021/fcs/gene_pred/braker/final-02042924/Pod_aph_DRT72021_clean_final_genes.pep.fasta
/home/theaven/scratch/uncompressed/genomes/Podosphaera/aphanis/SCOTT2020/fcs/gene_pred/braker/final-02042924/Pod_aph_SCOTT2020_clean_final_genes.pep.fasta
/home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/GCA_013170925.1/fcs/gene_pred/braker/final-02042924/Pod_leu_GCA_013170925.1_clean_final_genes.pep.fasta
/home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2019/fcs/gene_pred/braker/final-02042924/Pod_leu_OGB2019_clean_final_genes.pep.fasta
/home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGB2021/fcs/gene_pred/braker/final-02042924/Pod_leu_OGB2021_clean_final_genes.pep.fasta
/home/theaven/scratch/uncompressed/genomes/Podosphaera/leucotricha/OGBp112020/fcs/gene_pred/braker/final-02042924/Pod_leu_OGBp112020_clean_final_genes.pep.fasta

```
```bash
ls ~/projects/niab/theaven/results/P_aphanis-THeavenDRCT72020_1-aphanis-ranked4.tsv
ls /home/theaven/scratch/uncompressed/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/NRI/P.aphanis_strawberry2020_interproscan.tsv

grep 'g10232;\|g11054;\|g11278;\|g1209;\|g12302;\|g12450;\|g12453;\|g12628;\|g12667;\|g12955;\|g13367;\|g13490;\|g1355;\|g13885;\|g14348;\|g14731;\|g14832;\|g15923;\|g2113;\|g2919;\|g2928;\|g3129;\|g324;\|g422;\|g548;\|g5605;\|g5645;\|g5721;\|g6055;\|g6450;\|g6520;\|g6562;\|g7278;\|g757;\|g8019;\|g9359;\|g10232.t1\|g11054.t1\|g11278.t1\|g1209.t1\|g12302.t1\|g12450.t1\|g12453.t1\|g12628.t1\|g12667.t1\|g12955.t1\|g13367.t1\|g13490.t1\|g1355.t1\|g13885.t1\|g14348.t1\|g14731.t1\|g14832.t1\|g15923.t1\|g2113.t1\|g2919.t1\|g2928.t1\|g3129.t1\|g324.t1\|g422.t1\|g548.t1\|g5605.t1\|g5645.t1\|g5721.t1\|g6055.t1\|g6450.t1\|g6520.t1\|g6562.t1\|g7278.t1\|g757.t1\|g8019.t1\|g9359.t1' /home/theaven/scratch/uncompressed/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/NRI/P.aphanis_strawberry2020_interproscan.tsv > /home/theaven/scratch/uncompressed/gene_pred/P_aphanis/THeavenDRCT72020_1/interproscan/NRI/aphanis_cseps.tsv
```
leucotricha only effectors
```bash
while IFS=$'\t' read -r line; do
    awk -F'\t' '$31 == "1" && $27 == "." && $7 == "0" {print $1}' <<< "$line" | grep -v 'name' >> leuco_only_secreted_effectors.txt
done < /home/theaven/projects/niab/theaven/results/P_leucotricha-THeavenp11_1-leucotricha-ranked4.tsv

/home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenSCOTT2020_1/predector_singularity3/results/final_genes_appended_renamed.pep/final_genes_appended_renamed.pep-ranked.tsv

while IFS=$'\t' read -r line; do
echo $line > hits.txt
python3 /home/theaven/scratch/apps/tools/seq_get.py --id_file hits.txt --input /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta --output effectors2/${line}.faa
done < leuco_only_secreted_effectors.txt

grep 'g4176;\|g4600;\|g4897;\|g5141;\|g5142;\|g5372;\|g5674;\|g5692;\|g5745;\|g5831;\|g6026;\|g6027;\|g6105;\|g6162;\|g6243;\|g6281;\|g6315;\|g6354;\|g6355;\|g6406;\|g6458;\|g6590;\|g6999;\|g7051;\|g7120;\|g7121;\|g7132;\|g7198;\|g7200;\|g7361;\|g7603;\|g7646;\|g7647;\|g7696;\|g7802;\|g7927;\|g7928;\|g7935;\|g7937;\|g8009;\|g8035;\|g8081;\|g8248;\|g8278;\|g8734;\|g8760;\|g8897;\|g8974;\|g9008;\|g9065;\|g911;\|g9132;\|g9487;\|g978;\|g981;\|g9883;\|g9979;\|g10095;\|g1010;\|g10145;\|g10372;\|g10489;\|g10497;\|g10500;\|g10675;\|g10692;\|g10783;\|g10784;\|g10794;\|g1106;\|g11286;\|g11369;\|g11409;\|g11416;\|g11565;\|g11652;\|g11660;\|g11719;\|g11727;\|g11778;\|g11806;\|g11807;\|g11808;\|g11809;\|g1186;\|g11906;\|g11998;\|g12135;\|g12284;\|g12296;\|g12452;\|g12489;\|g12500;\|g12653;\|g12716;\|g12776;\|g13051;\|g13093;\|g13170;\|g13217;\|g13219;\|g13226;\|g13566;\|g13811;\|g13892;\|g13921;\|g14015;\|g14026;\|g14153;\|g14154;\|g14161;\|g14208;\|g14239;\|g14266;\|g14430;\|g14456;\|g14463;\|g14471;\|g14546;\|g14551;\|g14690;\|g14900;\|g14908;\|g15093;\|g150;\|g1518;\|g15306;\|g15465;\|g15827;\|g16211;\|g16340;\|g16440;\|g16601;\|g16680;\|g172;\|g1765;\|g17771;\|g18158;\|g1899;\|g1901;\|g2067;\|g2071;\|g2085;\|g2280;\|g2297;\|g254;\|g255;\|g258;\|g259;\|g2761;\|g2902;\|g3072;\|g3170;\|g3172;\|g3204;\|g3237;\|g3319;\|g3921;\|g4016;\|g4176.t1\|g4600.t1\|g4897.t1\|g5141.t1\|g5142.t1\|g5372.t1\|g5674.t1\|g5692.t1\|g5745.t1\|g5831.t1\|g6026.t1\|g6027.t1\|g6105.t1\|g6162.t1\|g6243.t1\|g6281.t1\|g6315.t1\|g6354.t1\|g6355.t1\|g6406.t1\|g6458.t1\|g6590.t1\|g6999.t1\|g7051.t1\|g7120.t1\|g7121.t1\|g7132.t1\|g7198.t1\|g7200.t1\|g7361.t1\|g7603.t1\|g7646.t1\|g7647.t1\|g7696.t1\|g7802.t1\|g7927.t1\|g7928.t1\|g7935.t1\|g7937.t1\|g8009.t1\|g8035.t1\|g8081.t1\|g8248.t1\|g8278.t1\|g8734.t1\|g8760.t1\|g8897.t1\|g8974.t1\|g9008.t1\|g9065.t1\|g911.t1\|g9132.t1\|g9487.t1\|g978.t1\|g981.t1\|g9883.t1\|g9979.t1\|g10095.t1\|g1010.t1\|g10145.t1\|g10372.t1\|g10489.t1\|g10497.t1\|g10500.t1\|g10675.t1\|g10692.t1\|g10783.t1\|g10784.t1\|g10794.t1\|g1106.t1\|g11286.t1\|g11369.t1\|g11409.t1\|g11416.t1\|g11565.t1\|g11652.t1\|g11660.t1\|g11719.t1\|g11727.t1\|g11778.t1\|g11806.t1\|g11807.t1\|g11808.t1\|g11809.t1\|g1186.t1\|g11906.t1\|g11998.t1\|g12135.t1\|g12284.t1\|g12296.t1\|g12452.t1\|g12489.t1\|g12500.t1\|g12653.t1\|g12716.t1\|g12776.t1\|g13051.t1\|g13093.t1\|g13170.t1\|g13217.t1\|g13219.t1\|g13226.t1\|g13566.t1\|g13811.t1\|g13892.t1\|g13921.t1\|g14015.t1\|g14026.t1\|g14153.t1\|g14154.t1\|g14161.t1\|g14208.t1\|g14239.t1\|g14266.t1\|g14430.t1\|g14456.t1\|g14463.t1\|g14471.t1\|g14546.t1\|g14551.t1\|g14690.t1\|g14900.t1\|g14908.t1\|g15093.t1\|g150.t1\|g1518.t1\|g15306.t1\|g15465.t1\|g15827.t1\|g16211.t1\|g16340.t1\|g16440.t1\|g16601.t1\|g16680.t1\|g172.t1\|g1765.t1\|g17771.t1\|g18158.t1\|g1899.t1\|g1901.t1\|g2067.t1\|g2071.t1\|g2085.t1\|g2280.t1\|g2297.t1\|g254.t1\|g255.t1\|g258.t1\|g259.t1\|g2761.t1\|g2902.t1\|g3072.t1\|g3170.t1\|g3172.t1\|g3204.t1\|g3237.t1\|g3319.t1\|g3921.t1\|g4016.t1' /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.gff3 > effectors2/leuco_only.gff

#max intron length 1.1x the largest intron in the gene prediction or 40, whichever is larger
for file in $(ls slurm-19869203.out); do
tblastn -query effectors2/g10095.t1.faa -db db/mildew+db2 -out effectors2/g10095_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g1010.t1.faa -db db/mildew+db2 -out effectors2/g1010_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 49 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g10145.t1.faa -db db/mildew+db2 -out effectors2/g10145_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g10372.t1.faa -db db/mildew+db2 -out effectors2/g10372_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g10489.t1.faa -db db/mildew+db2 -out effectors2/g10489_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 81 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g10497.t1.faa -db db/mildew+db2 -out effectors2/g10497_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 73 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g10500.t1.faa -db db/mildew+db2 -out effectors2/g10500_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 132 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g10675.t1.faa -db db/mildew+db2 -out effectors2/g10675_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g10692.t1.faa -db db/mildew+db2 -out effectors2/g10692_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g10783.t1.faa -db db/mildew+db2 -out effectors2/g10783_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 104 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g10784.t1.faa -db db/mildew+db2 -out effectors2/g10784_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 95 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g10794.t1.faa -db db/mildew+db2 -out effectors2/g10794_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 65 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g1106.t1.faa -db db/mildew+db2 -out effectors2/g1106_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 76 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11286.t1.faa -db db/mildew+db2 -out effectors2/g11286_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 72 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11369.t1.faa -db db/mildew+db2 -out effectors2/g11369_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 72 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11409.t1.faa -db db/mildew+db2 -out effectors2/g11409_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11416.t1.faa -db db/mildew+db2 -out effectors2/g11416_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 91 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11565.t1.faa -db db/mildew+db2 -out effectors2/g11565_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11652.t1.faa -db db/mildew+db2 -out effectors2/g11652_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11660.t1.faa -db db/mildew+db2 -out effectors2/g11660_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 80 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11719.t1.faa -db db/mildew+db2 -out effectors2/g11719_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 85 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11727.t1.faa -db db/mildew+db2 -out effectors2/g11727_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 88 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11778.t1.faa -db db/mildew+db2 -out effectors2/g11778_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11806.t1.faa -db db/mildew+db2 -out effectors2/g11806_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 59 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11807.t1.faa -db db/mildew+db2 -out effectors2/g11807_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 59 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11808.t1.faa -db db/mildew+db2 -out effectors2/g11808_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 66 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11809.t1.faa -db db/mildew+db2 -out effectors2/g11809_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 65 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g1186.t1.faa -db db/mildew+db2 -out effectors2/g1186_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 54 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11906.t1.faa -db db/mildew+db2 -out effectors2/g11906_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 82 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g11998.t1.faa -db db/mildew+db2 -out effectors2/g11998_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g12135.t1.faa -db db/mildew+db2 -out effectors2/g12135_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 189 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g12284.t1.faa -db db/mildew+db2 -out effectors2/g12284_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 63 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g12296.t1.faa -db db/mildew+db2 -out effectors2/g12296_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 83 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g12452.t1.faa -db db/mildew+db2 -out effectors2/g12452_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g12489.t1.faa -db db/mildew+db2 -out effectors2/g12489_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g12500.t1.faa -db db/mildew+db2 -out effectors2/g12500_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 55 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g12653.t1.faa -db db/mildew+db2 -out effectors2/g12653_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 198 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g12716.t1.faa -db db/mildew+db2 -out effectors2/g12716_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 62 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g12776.t1.faa -db db/mildew+db2 -out effectors2/g12776_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 110 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g13051.t1.faa -db db/mildew+db2 -out effectors2/g13051_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 65 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g13093.t1.faa -db db/mildew+db2 -out effectors2/g13093_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g13170.t1.faa -db db/mildew+db2 -out effectors2/g13170_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 61 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g13217.t1.faa -db db/mildew+db2 -out effectors2/g13217_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 62 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g13219.t1.faa -db db/mildew+db2 -out effectors2/g13219_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 61 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g13226.t1.faa -db db/mildew+db2 -out effectors2/g13226_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g13566.t1.faa -db db/mildew+db2 -out effectors2/g13566_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 66 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g13811.t1.faa -db db/mildew+db2 -out effectors2/g13811_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 105 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g13892.t1.faa -db db/mildew+db2 -out effectors2/g13892_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g13921.t1.faa -db db/mildew+db2 -out effectors2/g13921_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 169 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14015.t1.faa -db db/mildew+db2 -out effectors2/g14015_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 106 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14026.t1.faa -db db/mildew+db2 -out effectors2/g14026_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 71 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14153.t1.faa -db db/mildew+db2 -out effectors2/g14153_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 104 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14154.t1.faa -db db/mildew+db2 -out effectors2/g14154_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 82 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14161.t1.faa -db db/mildew+db2 -out effectors2/g14161_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14208.t1.faa -db db/mildew+db2 -out effectors2/g14208_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 65 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14239.t1.faa -db db/mildew+db2 -out effectors2/g14239_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14266.t1.faa -db db/mildew+db2 -out effectors2/g14266_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 70 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14430.t1.faa -db db/mildew+db2 -out effectors2/g14430_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 66 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14456.t1.faa -db db/mildew+db2 -out effectors2/g14456_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 59 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14463.t1.faa -db db/mildew+db2 -out effectors2/g14463_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 70 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14471.t1.faa -db db/mildew+db2 -out effectors2/g14471_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 70 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14546.t1.faa -db db/mildew+db2 -out effectors2/g14546_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 74 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14551.t1.faa -db db/mildew+db2 -out effectors2/g14551_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 58 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14690.t1.faa -db db/mildew+db2 -out effectors2/g14690_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 70 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14900.t1.faa -db db/mildew+db2 -out effectors2/g14900_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 69 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g14908.t1.faa -db db/mildew+db2 -out effectors2/g14908_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 62 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g150.t1.faa -db db/mildew+db2 -out effectors2/g150_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g15093.t1.faa -db db/mildew+db2 -out effectors2/g15093_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g1518.t1.faa -db db/mildew+db2 -out effectors2/g1518_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g15306.t1.faa -db db/mildew+db2 -out effectors2/g15306_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 104 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g15465.t1.faa -db db/mildew+db2 -out effectors2/g15465_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 75 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g15827.t1.faa -db db/mildew+db2 -out effectors2/g15827_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g16211.t1.faa -db db/mildew+db2 -out effectors2/g16211_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 68 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g16340.t1.faa -db db/mildew+db2 -out effectors2/g16340_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g16440.t1.faa -db db/mildew+db2 -out effectors2/g16440_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 102 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g16601.t1.faa -db db/mildew+db2 -out effectors2/g16601_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 69 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g16680.t1.faa -db db/mildew+db2 -out effectors2/g16680_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g172.t1.faa -db db/mildew+db2 -out effectors2/g172_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g1765.t1.faa -db db/mildew+db2 -out effectors2/g1765_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 101 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g17771.t1.faa -db db/mildew+db2 -out effectors2/g17771_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g18158.t1.faa -db db/mildew+db2 -out effectors2/g18158_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g1899.t1.faa -db db/mildew+db2 -out effectors2/g1899_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g1901.t1.faa -db db/mildew+db2 -out effectors2/g1901_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 54 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g2067.t1.faa -db db/mildew+db2 -out effectors2/g2067_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 98 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g2071.t1.faa -db db/mildew+db2 -out effectors2/g2071_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g2085.t1.faa -db db/mildew+db2 -out effectors2/g2085_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 97 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g2280.t1.faa -db db/mildew+db2 -out effectors2/g2280_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 70 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g2297.t1.faa -db db/mildew+db2 -out effectors2/g2297_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 61 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g254.t1.faa -db db/mildew+db2 -out effectors2/g254_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 52 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g255.t1.faa -db db/mildew+db2 -out effectors2/g255_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 109 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g258.t1.faa -db db/mildew+db2 -out effectors2/g258_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 86 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g259.t1.faa -db db/mildew+db2 -out effectors2/g259_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 95 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g2761.t1.faa -db db/mildew+db2 -out effectors2/g2761_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g2902.t1.faa -db db/mildew+db2 -out effectors2/g2902_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g3072.t1.faa -db db/mildew+db2 -out effectors2/g3072_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 66 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g3170.t1.faa -db db/mildew+db2 -out effectors2/g3170_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 51 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g3172.t1.faa -db db/mildew+db2 -out effectors2/g3172_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 51 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g3204.t1.faa -db db/mildew+db2 -out effectors2/g3204_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 104 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g3237.t1.faa -db db/mildew+db2 -out effectors2/g3237_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 55 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g3319.t1.faa -db db/mildew+db2 -out effectors2/g3319_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 91 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g3921.t1.faa -db db/mildew+db2 -out effectors2/g3921_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 57 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g4016.t1.faa -db db/mildew+db2 -out effectors2/g4016_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g4176.t1.faa -db db/mildew+db2 -out effectors2/g4176_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 94 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g4600.t1.faa -db db/mildew+db2 -out effectors2/g4600_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 168 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g4897.t1.faa -db db/mildew+db2 -out effectors2/g4897_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 73 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g5141.t1.faa -db db/mildew+db2 -out effectors2/g5141_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 68 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g5142.t1.faa -db db/mildew+db2 -out effectors2/g5142_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 51 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g5372.t1.faa -db db/mildew+db2 -out effectors2/g5372_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 87 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g5674.t1.faa -db db/mildew+db2 -out effectors2/g5674_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 75 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g5692.t1.faa -db db/mildew+db2 -out effectors2/g5692_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g5745.t1.faa -db db/mildew+db2 -out effectors2/g5745_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 49 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g5831.t1.faa -db db/mildew+db2 -out effectors2/g5831_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 75 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g6026.t1.faa -db db/mildew+db2 -out effectors2/g6026_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 65 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g6027.t1.faa -db db/mildew+db2 -out effectors2/g6027_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 59 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g6105.t1.faa -db db/mildew+db2 -out effectors2/g6105_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 51 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g6162.t1.faa -db db/mildew+db2 -out effectors2/g6162_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 107 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g6243.t1.faa -db db/mildew+db2 -out effectors2/g6243_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 91 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g6281.t1.faa -db db/mildew+db2 -out effectors2/g6281_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 57 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g6315.t1.faa -db db/mildew+db2 -out effectors2/g6315_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 68 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g6354.t1.faa -db db/mildew+db2 -out effectors2/g6354_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 106 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g6355.t1.faa -db db/mildew+db2 -out effectors2/g6355_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 96 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g6406.t1.faa -db db/mildew+db2 -out effectors2/g6406_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g6458.t1.faa -db db/mildew+db2 -out effectors2/g6458_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g6590.t1.faa -db db/mildew+db2 -out effectors2/g6590_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 58 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g6999.t1.faa -db db/mildew+db2 -out effectors2/g6999_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 58 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7051.t1.faa -db db/mildew+db2 -out effectors2/g7051_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 87 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7120.t1.faa -db db/mildew+db2 -out effectors2/g7120_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 71 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7121.t1.faa -db db/mildew+db2 -out effectors2/g7121_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 57 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7132.t1.faa -db db/mildew+db2 -out effectors2/g7132_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7198.t1.faa -db db/mildew+db2 -out effectors2/g7198_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7200.t1.faa -db db/mildew+db2 -out effectors2/g7200_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 60 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7361.t1.faa -db db/mildew+db2 -out effectors2/g7361_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 103 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7603.t1.faa -db db/mildew+db2 -out effectors2/g7603_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 97 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7646.t1.faa -db db/mildew+db2 -out effectors2/g7646_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 63 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7647.t1.faa -db db/mildew+db2 -out effectors2/g7647_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 60 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7696.t1.faa -db db/mildew+db2 -out effectors2/g7696_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7802.t1.faa -db db/mildew+db2 -out effectors2/g7802_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 90 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7927.t1.faa -db db/mildew+db2 -out effectors2/g7927_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 116 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7928.t1.faa -db db/mildew+db2 -out effectors2/g7928_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 95 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7935.t1.faa -db db/mildew+db2 -out effectors2/g7935_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 70 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g7937.t1.faa -db db/mildew+db2 -out effectors2/g7937_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 70 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g8009.t1.faa -db db/mildew+db2 -out effectors2/g8009_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 76 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g8035.t1.faa -db db/mildew+db2 -out effectors2/g8035_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g8081.t1.faa -db db/mildew+db2 -out effectors2/g8081_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 57 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g8248.t1.faa -db db/mildew+db2 -out effectors2/g8248_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g8278.t1.faa -db db/mildew+db2 -out effectors2/g8278_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g8734.t1.faa -db db/mildew+db2 -out effectors2/g8734_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 91 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g8760.t1.faa -db db/mildew+db2 -out effectors2/g8760_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 91 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g8897.t1.faa -db db/mildew+db2 -out effectors2/g8897_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 62 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g8974.t1.faa -db db/mildew+db2 -out effectors2/g8974_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g9008.t1.faa -db db/mildew+db2 -out effectors2/g9008_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 69 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g9065.t1.faa -db db/mildew+db2 -out effectors2/g9065_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 73 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g911.t1.faa -db db/mildew+db2 -out effectors2/g911_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 75 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g9132.t1.faa -db db/mildew+db2 -out effectors2/g9132_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 82 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g9487.t1.faa -db db/mildew+db2 -out effectors2/g9487_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 53 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g978.t1.faa -db db/mildew+db2 -out effectors2/g978_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g981.t1.faa -db db/mildew+db2 -out effectors2/g981_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 95 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g9883.t1.faa -db db/mildew+db2 -out effectors2/g9883_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 98 -num_threads 12 -max_target_seqs 99999
tblastn -query effectors2/g9979.t1.faa -db db/mildew+db2 -out effectors2/g9979_resultsxyza -evalue 1e-5 -outfmt "6 std qseq sseq" -max_intron_length 40 -num_threads 12 -max_target_seqs 99999
done

tblastn -query effectors2/g8974.t1.faa -db db/mildew+db2 -out effectors2/g8974_resultsxyza_2 -evalue 1e-5 -outfmt "6 std qseq sseq" -num_threads 12 -max_target_seqs 99999
#this returns no hits, possibly because the gene is so short?

#length of hit 70% of lingest exon:
declare -A exon_lengths
exon_lengths["g1010"]=371
exon_lengths["g10497"]=221
exon_lengths["g10500"]=208
exon_lengths["g10783"]=242
exon_lengths["g10784"]=244
exon_lengths["g10794"]=233
exon_lengths["g11286"]=454
exon_lengths["g11369"]=485
exon_lengths["g11719"]=310
exon_lengths["g11807"]=223
exon_lengths["g11808"]=242
exon_lengths["g11809"]=217
exon_lengths["g1186"]=165
exon_lengths["g12284"]=214
exon_lengths["g12500"]=212
exon_lengths["g12653"]=445
exon_lengths["g12716"]=896
exon_lengths["g12776"]=202
exon_lengths["g13051"]=240
exon_lengths["g13170"]=206
exon_lengths["g13217"]=99
exon_lengths["g13219"]=212
exon_lengths["g13566"]=240
exon_lengths["g14026"]=210
exon_lengths["g14208"]=204
exon_lengths["g14266"]=292
exon_lengths["g14430"]=223
exon_lengths["g14463"]=196
exon_lengths["g14471"]=235
exon_lengths["g14690"]=558
exon_lengths["g14900"]=225
exon_lengths["g14908"]=227
exon_lengths["g15465"]=242
exon_lengths["g16211"]=661
exon_lengths["g16440"]=882
exon_lengths["g16601"]=135
exon_lengths["g1901"]=214
exon_lengths["g2280"]=79
exon_lengths["g2297"]=263
exon_lengths["g254"]=225
exon_lengths["g3072"]=248
exon_lengths["g3170"]=233
exon_lengths["g3172"]=269
exon_lengths["g3204"]=206
exon_lengths["g3237"]=208
exon_lengths["g3921"]=169
exon_lengths["g5142"]=217
exon_lengths["g5674"]=246
exon_lengths["g5745"]=231
exon_lengths["g5831"]=214
exon_lengths["g6026"]=227
exon_lengths["g6027"]=227
exon_lengths["g6105"]=408
exon_lengths["g6281"]=206
exon_lengths["g6590"]=212
exon_lengths["g6999"]=263
exon_lengths["g7051"]=214
exon_lengths["g7120"]=246
exon_lengths["g7121"]=294
exon_lengths["g7200"]=248
exon_lengths["g7646"]=248
exon_lengths["g7647"]=231
exon_lengths["g7935"]=244
exon_lengths["g7937"]=238
exon_lengths["g8081"]=217
exon_lengths["g8760"]=240
exon_lengths["g8897"]=128
exon_lengths["g9008"]=210
exon_lengths["g9065"]=395
exon_lengths["g911"]=235
exon_lengths["g9487"]=156
exon_lengths["g10489"]=231
exon_lengths["g1106"]=316
exon_lengths["g11660"]=245
exon_lengths["g11806"]=252
exon_lengths["g13921"]=210
exon_lengths["g14154"]=475
exon_lengths["g14456"]=114
exon_lengths["g14551"]=520
exon_lengths["g4897"]=235
exon_lengths["g6315"]=293
exon_lengths["g8009"]=156
exon_lengths["g8734"]=80
exon_lengths["g11416"]=270
exon_lengths["g11727"]=283
exon_lengths["g11906"]=266
exon_lengths["g12135"]=270
exon_lengths["g12296"]=347
exon_lengths["g13811"]=264
exon_lengths["g14153"]=258
exon_lengths["g14546"]=275
exon_lengths["g15306"]=266
exon_lengths["g1765"]=270
exon_lengths["g2067"]=264
exon_lengths["g2085"]=258
exon_lengths["g255"]=283
exon_lengths["g258"]=266
exon_lengths["g259"]=275
exon_lengths["g3319"]=258
exon_lengths["g4176"]=264
exon_lengths["g5141"]=144
exon_lengths["g5372"]=266
exon_lengths["g6162"]=277
exon_lengths["g6243"]=170
exon_lengths["g6354"]=291
exon_lengths["g6355"]=289
exon_lengths["g7361"]=270
exon_lengths["g7603"]=270
exon_lengths["g7802"]=273
exon_lengths["g7927"]=277
exon_lengths["g7928"]=277
exon_lengths["g9132"]=266
exon_lengths["g981"]=258
exon_lengths["g9883"]=270
exon_lengths["g14015"]=270
exon_lengths["g4600"]=124

#get fastas
for file in $(ls effectors2/*_resultsxyza); do
gene=$(basename $file | sed 's@_resultsxyza@@g')
Output=effectors2/${gene}_out5.fasta
echo $gene

if [[ $gene == "g10675" || $gene == "g10692"  || $gene == "g10095" || $gene == "g10145" || $gene == "g10372" || $gene == "g11409" || $gene == "g11565" || $gene == "g11652" || $gene == "g11778" || $gene == "g11998" || $gene == "g12452" || $gene == "g12489" || $gene == "g13093" || $gene == "g13226" || $gene == "g13892" || $gene == "g14161" || $gene == "g14239" || $gene == "g150" || $gene == "g15093" || $gene == "g1518" || $gene == "g15827" || $gene == "g16340" || $gene == "g16680" || $gene == "g172" || $gene == "g17771" || $gene == "g18158" || $gene == "g1899" || $gene == "g2071" || $gene == "g2761" || $gene == "g2902" || $gene == "g4016" || $gene == "g5692" || $gene == "g6406" || $gene == "g6458" || $gene == "g7132" || $gene == "g7198" || $gene == "g7696" || $gene == "g8035" || $gene == "g8248" || $gene == "g8278" || $gene == "g8974" || $gene == "g978" || $gene == "g9979" ]]; then
  gene_file=$(ls effectors2/${gene}.t1.faa)
  gene_length=$(grep -v '>' "$gene_file" | tr -d '\n' | wc -c)
  for file2 in /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta; do
    ID=$(echo "$file2" | cut -d '/' -f7 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f8 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f9)
    grep "$ID" "$file" | awk '$3 >= 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.7' | awk '$11 < 1e-20' |
    while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
    done
  done
else 
  exon_length=${exon_lengths[$gene]}
  for file2 in /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta; do
    ID=$(echo "$file2" | cut -d '/' -f7 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f8 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f9)
    grep "$ID" "$file" | awk '$3 >= 60' | awk -v exon_length="$exon_length" '$4 > exon_length / 3' | awk '$11 < 1e-20' |
    while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do
        echo ">${col2}_${col9}" >> "$Output"
        echo "$col14" >> "$Output"
    done
  done
fi
done

#No. of hits
Output=effectors2/out5.tsv
for file in $(ls effectors2/*_resultsxyza); do
gene=$(basename $file | sed 's@_resultsxyza@@g')
echo $gene
echo $gene >> $Output

if [[ $gene == "g10675" || $gene == "g10692"  || $gene == "g10095" || $gene == "g10145" || $gene == "g10372" || $gene == "g11409" || $gene == "g11565" || $gene == "g11652" || $gene == "g11778" || $gene == "g11998" || $gene == "g12452" || $gene == "g12489" || $gene == "g13093" || $gene == "g13226" || $gene == "g13892" || $gene == "g14161" || $gene == "g14239" || $gene == "g150" || $gene == "g15093" || $gene == "g1518" || $gene == "g15827" || $gene == "g16340" || $gene == "g16680" || $gene == "g172" || $gene == "g17771" || $gene == "g18158" || $gene == "g1899" || $gene == "g2071" || $gene == "g2761" || $gene == "g2902" || $gene == "g4016" || $gene == "g5692" || $gene == "g6406" || $gene == "g6458" || $gene == "g7132" || $gene == "g7198" || $gene == "g7696" || $gene == "g8035" || $gene == "g8248" || $gene == "g8278" || $gene == "g8974" || $gene == "g978" || $gene == "g9979" ]]; then
  gene_file=$(ls effectors2/${gene}.t1.faa)
  gene_length=$(grep -v '>' $gene_file | tr -d '\n' | wc -c)
  for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
    ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
    x=$(grep $ID $file | awk '$3 >= 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.7' | awk '$11 < 1e-20' | wc -l)
    sed -i "\$s/\$/ $x/" $Output
  done
else 
  exon_length=${exon_lengths[$gene]}
  for file2 in /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta; do
    ID=$(echo "$file2" | cut -d '/' -f7 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f8 | cut -c 1-3)_$(echo "$file2" | cut -d '/' -f9)
    x=$(grep "$ID" "$file" | awk '$3 >= 60' | awk -v exon_length="$exon_length" '$4 > exon_length / 3' | awk '$11 < 1e-20' | wc -l)
    sed -i "\$s/\$/ $x/" $Output
  done
fi
done


```
blastp against good gene models
```bash
for file in $(ls effectors2/*.faa); do
name=$(basename $file | cut -d '.' -f1)
blastp -query $file -db db/gooddb2 -out effectors2/${name}_resultsxyzab -evalue 1e-5 -outfmt "6 std qseq sseq" -num_threads 12 -max_target_seqs 99999
done

#No. of hits
Output=effectors2/out6.tsv
for file in $(ls effectors2/*_resultsxyzab); do
gene=$(basename $file | sed 's@_resultsxyzab@@g')
echo $gene
echo $gene >> $Output
  gene_file=$(ls effectors2/${gene}.t1.faa)
  gene_length=$(grep -v '>' $gene_file | tr -d '\n' | wc -c)
  for file2 in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
    ID=$(echo $file2 | cut -d '/' -f7 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f8 | cut -c 1-3)_$(echo $file2 | cut -d '/' -f9)
    x=$(grep $ID $file | awk '$3 >= 60' | awk -v gene_length="$gene_length" '$4 / gene_length > 0.7' | awk '$11 < 1e-20' | wc -l)
    sed -i "\$s/\$/ $x/" $Output
  done
done
```

```bash
ls /home/theaven/scratch/uncompressed/gene_pred/P_leucotricha/THeavenp11_1/interproscan/NRI/P.leucotricha_apple2020_interproscan.tsv

grep 'g4176;\|g4600;\|g4897;\|g5141;\|g5142;\|g5372;\|g5674;\|g5692;\|g5745;\|g5831;\|g6026;\|g6027;\|g6105;\|g6162;\|g6243;\|g6281;\|g6315;\|g6354;\|g6355;\|g6406;\|g6458;\|g6590;\|g6999;\|g7051;\|g7120;\|g7121;\|g7132;\|g7198;\|g7200;\|g7361;\|g7603;\|g7646;\|g7647;\|g7696;\|g7802;\|g7927;\|g7928;\|g7935;\|g7937;\|g8009;\|g8035;\|g8081;\|g8248;\|g8278;\|g8734;\|g8760;\|g8897;\|g8974;\|g9008;\|g9065;\|g911;\|g9132;\|g9487;\|g978;\|g981;\|g9883;\|g9979;\|g10095;\|g1010;\|g10145;\|g10372;\|g10489;\|g10497;\|g10500;\|g10675;\|g10692;\|g10783;\|g10784;\|g10794;\|g1106;\|g11286;\|g11369;\|g11409;\|g11416;\|g11565;\|g11652;\|g11660;\|g11719;\|g11727;\|g11778;\|g11806;\|g11807;\|g11808;\|g11809;\|g1186;\|g11906;\|g11998;\|g12135;\|g12284;\|g12296;\|g12452;\|g12489;\|g12500;\|g12653;\|g12716;\|g12776;\|g13051;\|g13093;\|g13170;\|g13217;\|g13219;\|g13226;\|g13566;\|g13811;\|g13892;\|g13921;\|g14015;\|g14026;\|g14153;\|g14154;\|g14161;\|g14208;\|g14239;\|g14266;\|g14430;\|g14456;\|g14463;\|g14471;\|g14546;\|g14551;\|g14690;\|g14900;\|g14908;\|g15093;\|g150;\|g1518;\|g15306;\|g15465;\|g15827;\|g16211;\|g16340;\|g16440;\|g16601;\|g16680;\|g172;\|g1765;\|g17771;\|g18158;\|g1899;\|g1901;\|g2067;\|g2071;\|g2085;\|g2280;\|g2297;\|g254;\|g255;\|g258;\|g259;\|g2761;\|g2902;\|g3072;\|g3170;\|g3172;\|g3204;\|g3237;\|g3319;\|g3921;\|g4016;\|g4176.t1\|g4600.t1\|g4897.t1\|g5141.t1\|g5142.t1\|g5372.t1\|g5674.t1\|g5692.t1\|g5745.t1\|g5831.t1\|g6026.t1\|g6027.t1\|g6105.t1\|g6162.t1\|g6243.t1\|g6281.t1\|g6315.t1\|g6354.t1\|g6355.t1\|g6406.t1\|g6458.t1\|g6590.t1\|g6999.t1\|g7051.t1\|g7120.t1\|g7121.t1\|g7132.t1\|g7198.t1\|g7200.t1\|g7361.t1\|g7603.t1\|g7646.t1\|g7647.t1\|g7696.t1\|g7802.t1\|g7927.t1\|g7928.t1\|g7935.t1\|g7937.t1\|g8009.t1\|g8035.t1\|g8081.t1\|g8248.t1\|g8278.t1\|g8734.t1\|g8760.t1\|g8897.t1\|g8974.t1\|g9008.t1\|g9065.t1\|g911.t1\|g9132.t1\|g9487.t1\|g978.t1\|g981.t1\|g9883.t1\|g9979.t1\|g10095.t1\|g1010.t1\|g10145.t1\|g10372.t1\|g10489.t1\|g10497.t1\|g10500.t1\|g10675.t1\|g10692.t1\|g10783.t1\|g10784.t1\|g10794.t1\|g1106.t1\|g11286.t1\|g11369.t1\|g11409.t1\|g11416.t1\|g11565.t1\|g11652.t1\|g11660.t1\|g11719.t1\|g11727.t1\|g11778.t1\|g11806.t1\|g11807.t1\|g11808.t1\|g11809.t1\|g1186.t1\|g11906.t1\|g11998.t1\|g12135.t1\|g12284.t1\|g12296.t1\|g12452.t1\|g12489.t1\|g12500.t1\|g12653.t1\|g12716.t1\|g12776.t1\|g13051.t1\|g13093.t1\|g13170.t1\|g13217.t1\|g13219.t1\|g13226.t1\|g13566.t1\|g13811.t1\|g13892.t1\|g13921.t1\|g14015.t1\|g14026.t1\|g14153.t1\|g14154.t1\|g14161.t1\|g14208.t1\|g14239.t1\|g14266.t1\|g14430.t1\|g14456.t1\|g14463.t1\|g14471.t1\|g14546.t1\|g14551.t1\|g14690.t1\|g14900.t1\|g14908.t1\|g15093.t1\|g150.t1\|g1518.t1\|g15306.t1\|g15465.t1\|g15827.t1\|g16211.t1\|g16340.t1\|g16440.t1\|g16601.t1\|g16680.t1\|g172.t1\|g1765.t1\|g17771.t1\|g18158.t1\|g1899.t1\|g1901.t1\|g2067.t1\|g2071.t1\|g2085.t1\|g2280.t1\|g2297.t1\|g254.t1\|g255.t1\|g258.t1\|g259.t1\|g2761.t1\|g2902.t1\|g3072.t1\|g3170.t1\|g3172.t1\|g3204.t1\|g3237.t1\|g3319.t1\|g3921.t1\|g4016.t1' /home/theaven/scratch/uncompressed/gene_pred/P_leucotricha/THeavenp11_1/interproscan/NRI/P.leucotricha_apple2020_interproscan.tsv > /home/theaven/scratch/uncompressed/gene_pred/P_leucotricha/THeavenp11_1/interproscan/NRI/leucotricha_cseps.tsv
```
#### orthovenn3
```bash
cp /home/theaven/projects/niab/theaven/gene_pred/P_aphanis/THeavenDRCT72020_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta ./P_aphanis_THeavenDRCT72020_1_protein.faa
cp /home/theaven/projects/niab/theaven/gene_pred/P_leucotricha/THeavenp11_1/codingquarry/rep_modeling/final/final_genes_appended_renamed.pep.fasta ./P_leucotricha_THeavenp11_1_protein.faa

for fasta in $(ls B_graminis_GCA_905067625.1_protein.faa B_hordei_GCA_900237765.1protein.faa E_necator_GCA_024703715.1protein.faa G_cichoracearum_GCA_003611235.1protein.faa P_aphanis_THeavenDRCT72020_1_protein.faa P_leucotricha_THeavenp11_1_protein.faa S_cerevisiae_GCF_000146045.2_protein.faa P_xanthii_GCA_010015925.1_protein.faa); do
python3 /home/theaven/scratch/apps/tools/longest_variant.py $fasta $(echo $fasta | sed 's@.faa@.longest.faa@g')
done


for fasta in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.fasta); do
python3 /home/theaven/scratch/apps/tools/longest_variant.py $fasta $(echo $fasta | sed 's@.fasta@.longest.faa@g')
done

for fasta in $(ls /home/theaven/scratch/uncompressed/genomes/*/*/*/fcs/gene_pred/braker/final-02042924/*clean_final_genes.pep.longest.faa); do
cp $fasta download4/.
done
```
#### Alphafold
```bash
cat effectors/*.faa > aphanis-unique-cseps.faa
cat effectors2/*.faa > leucotricha-unique-cseps.faa

/home/theaven/scratch/apps/tools/signalp-4.1/signalp -t euk -f short aphanis-unique-cseps.faa > aphanis-unique-cseps-signalp4.1.out
/home/theaven/scratch/apps/tools/signalp-4.1/signalp -t euk -f short leucotricha-unique-cseps.faa > leucotricha-unique-cseps-signalp4.1.out

#mot all proteins have signal peptide as predictd by signalp4.1, some are only predicted by signalp3, phobius or deepsig. Where there was dissagreement between different prediction methods signalp4.1 was considered most reliable, followed by singalp3NN, then signalp3HMM, then phobius, then deepsig - however inmost cases the different tools were in agreement with one another.
```
Aphanis_Gene: Signal predicted:
g10232  SignalP3NN:23
g11054  SignalP3NN:22,SignalP3HMM:22,SignalP4:22,SignalP5:22,DeepSig:22,Phobius:22,SignalP6:22
g11278  SignalP3NN:22,SignalP3HMM:22,SignalP4:22,SignalP5:22,DeepSig:22,Phobius:22,SignalP6:22
g1209 SignalP3NN:21
g12302  SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g12450  SignalP3NN:19,Phobius:19
g12453  Phobius:20
g12628  SignalP3NN:17,SignalP4:17,DeepSig:17
g12667* SignalP3HMM:19
g12955  Phobius:17
g13367  SignalP3NN:22,SignalP3HMM:22,SignalP4:22,SignalP5:22,DeepSig:22,Phobius:22,SignalP6:22
g13490  SignalP3NN:22
g1355 SignalP3NN:17,SignalP3HMM:17,SignalP4:17,Phobius:17
g13885  Phobius:23
g14348  Phobius:19,SignalP3NN:24,SignalP3HMM:24,SignalP4:24,SignalP5:24,DeepSig:24
g14731  SignalP3NN:14
g14832  SignalP3NN:19,Phobius:19
g15923  SignalP3NN:27,SignalP3HMM:27,Phobius:27
g2113 Phobius:18
g2919 Phobius:29
g2928 Phobius:16
g3129 SignalP3NN:21,DeepSig:21
g324  SignalP3NN:27
g422  SignalP3NN:30
g548  SignalP3NN:20
g5605 SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g5645 SignalP3HMM:16,Phobius:16
g5721 SignalP3NN:28,SignalP3HMM:28,SignalP4:28,SignalP5:28,Phobius:28,SignalP6:28
g6055 SignalP3NN:24,DeepSig:24,Phobius:24
g6450 SignalP3NN:28
g6520*  SignalP3NN:19
g6562 SignalP3HMM:18,SignalP5:18
g7278 SignalP3HMM:19,SignalP3NN:23
g757  SignalP4:10
g8019 SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:30
g9359 SignalP3HMM:31,Phobius:31
  
Leuco_Gene: 
g10095  SignalP3HMM:24
g1010 SignalP3HMM:18,Phobius:18
g10145  SignalP3NN:23,SignalP4:23,Phobius:23
g10372  SignalP3NN:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g10489  SignalP3NN:15,SignalP3HMM:15,Phobius:15,SignalP4:19,SignalP6:19,SignalP5:23,DeepSig:23
g10497  SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g10500  SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,SignalP6:21
g10675  SignalP3NN:23
g10692  SignalP3HMM:18,Phobius:18
g10783  SignalP3NN:18,SignalP3HMM:18,SignalP4:18,SignalP5:18,DeepSig:18,Phobius:18,SignalP6:18
g10784  SignalP3NN:18,SignalP3HMM:18,SignalP4:18,SignalP5:18,DeepSig:18,Phobius:18,SignalP6:18
g10794  SignalP3NN:33
g1106 SignalP3HMM:16,Phobius:19,SignalP3NN:26
g11286  SignalP3NN:19,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g11369  SignalP3NN:20,SignalP3HMM:20,SignalP5:20,Phobius:36
g11409  SignalP3NN:17,SignalP4:17,DeepSig:17,SignalP5:19,SignalP6:19,SignalP3HMM:21,Phobius:21
g11416  SignalP3NN:25,SignalP3HMM:25,SignalP4:25,SignalP5:25,DeepSig:25,Phobius:25,SignalP6:25
g11565  SignalP3NN:19,SignalP3HMM:19,SignalP4:19,DeepSig:19
g11652  SignalP3HMM:30
g11660  SignalP3NN:24,SignalP5:24,Phobius:24,SignalP3HMM:28,SignalP6:28
g11719  Phobius:34
g11727  DeepSig:22,SignalP3NN:23,SignalP3HMM:23,SignalP4:23,SignalP5:23,Phobius:23,SignalP6:23
g11778  SignalP3NN:16,SignalP3HMM:16,SignalP4:16,DeepSig:16,Phobius:16
g11806  SignalP4:19,DeepSig:19,SignalP3NN:23,SignalP5:23
g11807  SignalP3NN:17,Phobius:17,SignalP3HMM:21,SignalP5:21,DeepSig:21,SignalP6:24
g11808  SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g11809  SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g1186 SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g11906  SignalP3NN:22,SignalP3HMM:22,SignalP4:22,SignalP5:22,DeepSig:22,Phobius:22,SignalP6:22
g11998  SignalP3NN:16
g12135  SignalP3NN:24,SignalP3HMM:24,SignalP4:24,SignalP5:24,SignalP6:24,DeepSig:30,Phobius:30
g12284  SignalP3NN:24,SignalP3HMM:24,SignalP4:24,SignalP5:24,DeepSig:24,Phobius:24,SignalP6:24
g12296  SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g12452  SignalP3NN:20,SignalP3HMM:20,SignalP4:20,DeepSig:20,Phobius:20,SignalP5:22
g12489  Phobius:29
g12500  SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g12653  SignalP4:15,Phobius:15
g12716  SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g12776  SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g13051  SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:25
g13093  SignalP3HMM:16
g13170  SignalP3NN:16,SignalP3HMM:16,SignalP4:16,SignalP5:16,DeepSig:16,Phobius:16,SignalP6:16
g13217  SignalP3HMM:22
g13219  SignalP3NN:23,SignalP3HMM:23,SignalP4:23,SignalP5:23,DeepSig:23,Phobius:23,SignalP6:23
g13226  Phobius:21,SignalP6:22,SignalP3NN:24,SignalP4:24
g13566  SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g13811  SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g13892  Phobius:18
g13921  SignalP3NN:18,SignalP3HMM:18,SignalP5:18,Phobius:18,SignalP6:18
g14015  SignalP4:20,SignalP6:22,SignalP3NN:24,SignalP3HMM:24,SignalP5:24,DeepSig:24,Phobius:24
g14026  SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g14153  SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g14154  SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g14161  SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g14208  SignalP3NN:16,SignalP3HMM:16,SignalP4:16,SignalP5:16,DeepSig:16,Phobius:16,SignalP6:16
g14239  SignalP3NN:22
g14266  SignalP4:19,SignalP3NN:20,SignalP3HMM:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g14430  SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g14456  Phobius:21
g14463  SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g14471  SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g14546  SignalP3NN:24,SignalP3HMM:24,SignalP4:24,SignalP5:24,DeepSig:24,Phobius:24,SignalP6:24
g14551  SignalP3HMM:21,SignalP4:21,SignalP6:21,DeepSig:23,SignalP3NN:24,SignalP5:24
g14690  SignalP3NN:20,SignalP4:20,SignalP5:20,Phobius:20,SignalP6:20
g14900  SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:29
g14908  SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,SignalP6:21,Phobius:27
g150  Phobius:40
g15093  SignalP3NN:21,SignalP3HMM:21
g1518 SignalP4:11,Phobius:14,DeepSig:20,SignalP3NN:28
g15306  SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g15465  SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:24,SignalP6:24
g15827  Phobius:17
g16211  SignalP3HMM:21,Phobius:21,SignalP6:22,SignalP3NN:24,SignalP4:24
g16340  SignalP3NN:19,SignalP4:19,DeepSig:19,SignalP3HMM:21,SignalP5:21,Phobius:21
g16440  DeepSig:21
g16601  SignalP3HMM:21,Phobius:21
g16680  Phobius:45
g172  SignalP3NN:18,SignalP4:18
g1765 SignalP6:18,SignalP3NN:25,SignalP3HMM:25,SignalP4:25,SignalP5:25,DeepSig:25,Phobius:25
g17771  Phobius:34
g18158  SignalP3HMM:22,Phobius:22
g1899 Phobius:28
g1901 SignalP3NN:19,SignalP3HMM:19,SignalP5:19,DeepSig:19,SignalP6:19
g2067 Phobius:18,SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP6:19,SignalP5:21,DeepSig:21
g2071 Phobius:24
g2085 SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g2280 SignalP3HMM:20,Phobius:23
g2297 SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g254  SignalP3NN:22,SignalP4:22,SignalP5:22,DeepSig:22,SignalP6:22,SignalP3HMM:25,Phobius:25
g255  SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g258  SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g259  SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g2761 SignalP3NN:29,SignalP4:29,SignalP5:29,SignalP6:29
g2902 SignalP3NN:24,Phobius:27
g3072 SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,SignalP6:21,Phobius:26
g3170 SignalP3NN:22,SignalP3HMM:22,SignalP4:22,SignalP5:22,DeepSig:22,Phobius:22,SignalP6:22
g3172 SignalP3NN:22,SignalP3HMM:22,SignalP4:22,SignalP5:22,DeepSig:22,Phobius:22,SignalP6:22
g3204 SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g3237 SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g3319 SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g3921 SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g4016 SignalP3NN:18
g4176 SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g4600 SignalP3NN:15,SignalP3HMM:15,DeepSig:18,Phobius:18,SignalP5:24
g4897 SignalP3NN:23,SignalP3HMM:23,SignalP4:23,SignalP5:23,DeepSig:23,Phobius:23,SignalP6:23
g5141 SignalP3NN:24,SignalP3HMM:24,SignalP4:24,SignalP5:24,DeepSig:24,Phobius:24,SignalP6:24
g5142 SignalP3NN:23,SignalP3HMM:23,SignalP4:23,SignalP5:23,DeepSig:23,Phobius:23,SignalP6:23
g5372 SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g5674 SignalP3NN:23,SignalP3HMM:23,SignalP4:23,SignalP5:23,Phobius:23,SignalP6:23
g5692 SignalP3NN:22,SignalP3HMM:22,SignalP4:22
g5745 SignalP3NN:17,SignalP3HMM:17,SignalP4:17,SignalP5:17,DeepSig:17,SignalP6:17,Phobius:19
g5831 SignalP3NN:23,SignalP3HMM:23,SignalP4:23,SignalP5:23,DeepSig:23,Phobius:23,SignalP6:23
g6026 SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g6027 SignalP3NN:22,SignalP3HMM:22,SignalP4:22,SignalP5:22,DeepSig:22,Phobius:22,SignalP6:22
g6105 SignalP3NN:18,SignalP3HMM:18,SignalP4:18,SignalP5:18,DeepSig:18,Phobius:18,SignalP6:18
g6162 SignalP6:18,SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21
g6243 SignalP3NN:26,DeepSig:26
g6281 Phobius:13
g6315 SignalP3HMM:17,Phobius:17,DeepSig:18
g6354 SignalP3NN:20,SignalP4:20,DeepSig:20,Phobius:20,SignalP5:25,SignalP3HMM:27,SignalP6:27
g6355 SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g6406 SignalP3HMM:17
g6458 SignalP3NN:28
g6590 SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g6999 SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g7051 SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,SignalP6:20
g7120 SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g7121 SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g7132 DeepSig:25
g7198 SignalP3NN:18
g7200 SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g7361 SignalP3NN:23,SignalP3HMM:24,SignalP4:24,SignalP5:24,DeepSig:24,Phobius:24,SignalP6:24
g7603 SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g7646 SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g7647 Phobius:18,SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,SignalP6:20
g7696 SignalP3NN:23,SignalP4:23,DeepSig:23
g7802 SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g7927 SignalP3NN:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21,SignalP3HMM:23
g7928 SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g7935 SignalP3NN:20,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g7937 SignalP3NN:21,SignalP3HMM:21,SignalP4:21,SignalP5:21,DeepSig:21,Phobius:21,SignalP6:21
g8009 SignalP3NN:20,SignalP3HMM:20,SignalP4:20,DeepSig:20,SignalP5:22
g8035 SignalP3NN:17,SignalP3HMM:17,SignalP4:17,SignalP5:17,DeepSig:17,SignalP6:17,Phobius:19
g8081 SignalP3HMM:19,DeepSig:19,Phobius:19,SignalP3NN:21,SignalP4:21,SignalP5:21,SignalP6:21
g8248 SignalP4:21,SignalP5:21,DeepSig:21,SignalP6:21,SignalP3HMM:22,SignalP3NN:25,Phobius:25
g8278 SignalP3NN:17,SignalP4:17,SignalP5:17,DeepSig:17,SignalP6:17,SignalP3HMM:21,Phobius:21
g8734 Phobius:20
g8760 SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,Phobius:19,SignalP6:19
g8897 Phobius:27
g8974 SignalP3NN:14,SignalP3HMM:14,SignalP5:14,Phobius:14
g9008 SignalP3NN:18,SignalP3HMM:18,SignalP5:18,Phobius:18
g9065 SignalP3NN:27
g911  SignalP3NN:19,SignalP3HMM:19,SignalP4:19,SignalP5:19,DeepSig:19,SignalP6:19,Phobius:22
g9132 SignalP3NN:22,SignalP3HMM:22,SignalP4:22,SignalP5:22,Phobius:22
g9487 SignalP3HMM:19,Phobius:19
g978  SignalP3HMM:17,Phobius:17,SignalP3NN:18
g981  SignalP3NN:20,SignalP3HMM:20,SignalP4:20,SignalP5:20,DeepSig:20,Phobius:20,SignalP6:20
g9883 Phobius:21,SignalP3NN:23,SignalP3HMM:23,SignalP4:23,SignalP5:23,DeepSig:23
g9979 SignalP3NN:13,SignalP3HMM:13,SignalP4:13,SignalP5:13,Phobius:13
```txt
Aphanis_Gene: Signal predicted:
g10232  23
g11054  22
g11278  22
g1209 21
g12302  20
g12450  19
g12453  20
g12628  17
g12667 19
g12955  17
g13367  22
g13490  22
g1355 17
g13885  23
g14348  24
g14731  14
g14832  19
g15923  27
g2113 18
g2919 29
g2928 16
g3129 21
g324  27
g422  30
g548  20
g5605 20
g5645 16
g5721 28
g6055 24
g6450 28
g6520  19
g6562 18
g7278 23
g757  10
g8019 20
g9359 31
  
Leuco_Gene: 
g10095  24
g1010 18
g10145  23
g10372  20
g10489  19
g10497  19
g10500  21
g10675  23
g10692  18
g10783  18
g10784  18
g10794  33
g1106 26
g11286  20
g11369  20
g11409  17
g11416  25
g11565  19
g11652  30
g11660  24
g11719  34
g11727  23
g11778  16
g11806  23
g11807  17
g11808  19
g11809  19
g1186 19
g11906  22
g11998  16
g12135  24
g12284  24
g12296  21
g12452  20
g12489  29
g12500  19
g12653  15
g12716  19
g12776  21
g13051  20
g13093  16
g13170  16
g13217  22
g13219  23
g13226  24
g13566  21
g13811  21
g13892  18
g13921  18
g14015  20
g14026  20
g14153  19
g14154  19
g14161  20
g14208  16
g14239  22
g14266  19
g14430  19
g14456  21
g14463  21
g14471  21
g14546  24
g14551  21
g14690  20
g14900  19
g14908  21
g150  40
g15093  21
g1518 11
g15306  19
g15465  19
g15827  17
g16211  24
g16340  19
g16440  21
g16601  21
g16680  45
g172  18
g1765 25
g17771  34
g18158  22
g1899 28
g1901 19
g2067 19
g2071 24
g2085 21
g2280 20
g2297 20
g254  22
g255  20
g258  20
g259  20
g2761 29
g2902 24
g3072 21
g3170 22
g3172 22
g3204 21
g3237 19
g3319 19
g3921 19
g4016 18
g4176 20
g4600 15
g4897 23
g5141 24
g5142 23
g5372 21
g5674 23
g5692 22
g5745 17
g5831 23
g6026 20
g6027 22
g6105 18
g6162 21
g6243 26
g6281 13
g6315 17
g6354 20
g6355 20
g6406 17
g6458 28
g6590 19
g6999 19
g7051 20
g7120 20
g7121 20
g7132 25
g7198 18
g7200 19
g7361 24
g7603 21
g7646 21
g7647 20
g7696 23
g7802 20
g7927 21
g7928 21
g7935 21
g7937 21
g8009 20
g8035 17
g8081 21
g8248 21
g8278 17
g8734 20
g8760 19
g8897 27
g8974 14
g9008 18
g9065 27
g911  199
g9132 22
g9487 19
g978  18
g981  20
g9883 23
g9979 13

```
```bash
nano aphanis-unique-cseps-manual.out
nano leucotricha-unique-cseps-manual.out

cat effectors/*.faa > aphanis-unique-cseps.faa
cat effectors2/*.faa > leucotricha-unique-cseps.faa

mkdir aphanis-unique-cseps-cleaved
mkdir leucotricha-unique-cseps-cleaved
```
```python
from Bio import SeqIO

#signalp_file = "aphanis-unique-cseps-manual.out"
#input_fasta = "aphanis-unique-cseps.faa"
#output_fasta = "aphanis-unique-cseps-cleaved.faa"
signalp_file = "leucotricha-unique-cseps-manual.out"
input_fasta = "leucotricha-unique-cseps.faa"
output_fasta = "leucotricha-unique-cseps-cleaved.faa"

def load_signal_peptide_info(signalp_file):
    cleavage_sites = {}
    with open(signalp_file, 'r') as file:
        for line in file:
            parts = line.strip().split()
            seq_id = parts[0]
            cleavage_site = int(parts[1])
            cleavage_sites[seq_id] = cleavage_site
    return cleavage_sites

def remove_signal_peptide_fasta(input_fasta, output_fasta, cleavage_sites):
    with open(output_fasta, 'w') as output_handle:
        for record in SeqIO.parse(input_fasta, "fasta"):
            seq_id = record.id.split('.')[0]  # To match with IDs in cleavage_sites
            if seq_id in cleavage_sites:
                cleavage_site = cleavage_sites[seq_id]
                mature_sequence = record.seq[cleavage_site:]
                record.seq = mature_sequence
            SeqIO.write(record, output_handle, "fasta")

cleavage_sites = load_signal_peptide_info(signalp_file)
remove_signal_peptide_fasta(input_fasta, output_fasta, cleavage_sites)



from Bio import SeqIO
import os
def split_fasta(input_fasta, output_directory):
    if not os.path.exists(output_directory):
        os.makedirs(output_directory)
    for record in SeqIO.parse(input_fasta, "fasta"):
        output_file = os.path.join(output_directory, f"{record.id}.fasta")
        with open(output_file, 'w') as output_handle:
            SeqIO.write(record, output_handle, "fasta")
        print(f"Written {record.id} to {output_file}")

#input_fasta = "aphanis-unique-cseps-cleaved.faa"
#output_directory = "aphanis-unique-cseps-cleaved"
input_fasta = "leucotricha-unique-cseps-cleaved.faa"
output_directory = "leucotricha-unique-cseps-cleaved"

split_fasta(input_fasta, output_directory)
```
```bash
for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/aphanis-unique-cseps-cleaved/*fasta); do
echo $(basename $file)
grep -v '>' $file | wc -c
done

for protein in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/aphanis-unique-cseps-cleaved/*.fasta); do
sed -i 's/X*$//' $protein
OutDir=$(dirname $protein)/$(basename $protein | sed 's@.t1.fasta@@g')
mkdir $OutDir
sbatch ~/git_repos/Wrappers/NBI/alphafold.sh $protein $OutDir
done
#3555477-3555523 - gpu node with 8cpu, multiple jobs are running on each node

for protein in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/leucotricha-unique-cseps-cleaved/*.fasta); do
sed -i 's/X*$//' $protein
OutDir=$(dirname $protein)/$(basename $protein | sed 's@.t1.fasta@@g')
mkdir $OutDir
sbatch ~/git_repos/Wrappers/NBI/alphafold.sh $protein $OutDir
done
#3556341-3556499 - gpu node with 8cpu, multiple jobs are running on each node

mkdir temp_AF2  
for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/*-unique-cseps-cleaved/*/*/ranked_0.pdb); do
ID=$(echo $file | cut -d '/' -f8 | cut -d '-' -f1 )_$(echo $file | cut -d '/' -f9)_$(basename $file)
cp $file temp_AF2/$ID
done

#Download .pdb files from seong and krasileva paper:
cd /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Seong+Krasileva
for file in $(ls *.tar.gz); do
tar -xvzf $file
done
mkdir all
cp *PDBs/*.pdb all/.
cd ..


for file in /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Seong+Krasileva/all/*.pdb
do
    ln -s "$file" temp_AF2/.
done

source package cda29b6a-320e-4d73-83c6-240ed7a6201e
pdb_dir=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/temp_AF2
cpu=1  
Prefix=cluster-0.9
foldseek easy-cluster --threads $cpu -s 7.5 --max-seqs 2000 --min-seq-id 0.6 -c 0.9 $pdb_dir $Prefix tmp
Prefix=cluster-0.8
foldseek easy-cluster --threads $cpu  -s 7.5 --max-seqs 2000 --min-seq-id 0.6 -c 0.8 $pdb_dir $Prefix tmp
Prefix=cluster-0.7
foldseek easy-cluster --threads $cpu  -s 7.5 --max-seqs 2000 --min-seq-id 0.6 -c 0.7 $pdb_dir $Prefix tmp
Prefix=cluster-0.6
foldseek easy-cluster --threads $cpu  -s 7.5 --max-seqs 2000 --min-seq-id 0.6 -c 0.6 $pdb_dir $Prefix tmp

Prefix=cluster-0.9-5
foldseek easy-cluster --threads $cpu -s 7.5 --max-seqs 2000 --min-seq-id 0.5 -c 0.9 $pdb_dir $Prefix tmp
Prefix=cluster-0.8-5
foldseek easy-cluster --threads $cpu  -s 7.5 --max-seqs 2000 --min-seq-id 0.5 -c 0.8 $pdb_dir $Prefix tmp
Prefix=cluster-0.7-5
foldseek easy-cluster --threads $cpu  -s 7.5 --max-seqs 2000 --min-seq-id 0.5 -c 0.7 $pdb_dir $Prefix tmp
Prefix=cluster-0.6-5
foldseek easy-cluster --threads $cpu  -s 7.5 --max-seqs 2000 --min-seq-id 0.5 -c 0.6 $pdb_dir $Prefix tmp

Prefix=cluster-0.9-4
foldseek easy-cluster --threads $cpu -s 7.5 --max-seqs 2000 --min-seq-id 0.4 -c 0.9 $pdb_dir $Prefix tmp
Prefix=cluster-0.8-4
foldseek easy-cluster --threads $cpu  -s 7.5 --max-seqs 2000 --min-seq-id 0.4 -c 0.8 $pdb_dir $Prefix tmp
Prefix=cluster-0.7-4
foldseek easy-cluster --threads $cpu  -s 7.5 --max-seqs 2000 --min-seq-id 0.4 -c 0.7 $pdb_dir $Prefix tmp
Prefix=cluster-0.6-4
foldseek easy-cluster --threads $cpu  -s 7.5 --max-seqs 2000 --min-seq-id 0.4 -c 0.6 $pdb_dir $Prefix tmp

#make a foldseek database from the Seong and Krasileva pdbs
source package cda29b6a-320e-4d73-83c6-240ed7a6201e
foldseek createdb /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Seong+Krasileva/all /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Seong+Krasileva/S+Kdb

#The cost to run with the afdb database is ~£2 per protein, therefore run only for the custom database and submit through the web server - time consuming :(
for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/*-unique-cseps-cleaved/*/*/ranked_0.pdb | grep -v 'leucotricha-unique-cseps-cleaved/g9979/g9979.t1'); do
InFile=$file
OutDir=$(dirname $file)/foldseek
mkdir $OutDir
#Database=/nbi/Reference-Data/Foldseek/afdb
#OutFile=$(echo $file | cut -d '/' -f8 | cut -d '-' -f1 )_$(echo $file | cut -d '/' -f9)_$(basename $file | sed 's@.pdb@@g')-$(basename $Database)-foldseek-output.txt
#sbatch ~/git_repos/Wrappers/NBI/foldseek.sh $InFile $Database $OutDir $OutFile
#Database=/nbi/Reference-Data/Foldseek/afdb_proteome
#OutFile=$(echo $file | cut -d '/' -f8 | cut -d '-' -f1 )_$(echo $file | cut -d '/' -f9)_$(basename $file | sed 's@.pdb@@g')-$(basename $Database)-foldseek-output.txt
#sbatch ~/git_repos/Wrappers/NBI/foldseek.sh $InFile $Database $OutDir $OutFile
#Database=/nbi/Reference-Data/Foldseek/afdb_swissprot
#OutFile=$(echo $file | cut -d '/' -f8 | cut -d '-' -f1 )_$(echo $file | cut -d '/' -f9)_$(basename $file | sed 's@.pdb@@g')-$(basename $Database)-foldseek-output.txt
#sbatch ~/git_repos/Wrappers/NBI/foldseek.sh $InFile $Database $OutDir $OutFile
#Database=/nbi/Reference-Data/Foldseek/afdb_uniprot50
#OutFile=$(echo $file | cut -d '/' -f8 | cut -d '-' -f1 )_$(echo $file | cut -d '/' -f9)_$(basename $file | sed 's@.pdb@@g')-$(basename $Database)-foldseek-output.txt
#sbatch ~/git_repos/Wrappers/NBI/foldseek.sh $InFile $Database $OutDir $OutFile
#Database=/nbi/Reference-Data/Foldseek/cath50
#OutFile=$(echo $file | cut -d '/' -f8 | cut -d '-' -f1 )_$(echo $file | cut -d '/' -f9)_$(basename $file | sed 's@.pdb@@g')-$(basename $Database)-foldseek-output.txt
#sbatch ~/git_repos/Wrappers/NBI/foldseek.sh $InFile $Database $OutDir $OutFile
#Database=/nbi/Reference-Data/Foldseek/esmatlas30
#OutFile=$(echo $file | cut -d '/' -f8 | cut -d '-' -f1 )_$(echo $file | cut -d '/' -f9)_$(basename $file | sed 's@.pdb@@g')-$(basename $Database)-foldseek-output.txt
#sbatch ~/git_repos/Wrappers/NBI/foldseek.sh $InFile $Database $OutDir $OutFile
#Database=/nbi/Reference-Data/Foldseek/pdb
#OutFile=$(echo $file | cut -d '/' -f8 | cut -d '-' -f1 )_$(echo $file | cut -d '/' -f9)_$(basename $file | sed 's@.pdb@@g')-$(basename $Database)-foldseek-output.txt
#sbatch ~/git_repos/Wrappers/NBI/foldseek.sh $InFile $Database $OutDir $OutFile
Database=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Seong+Krasileva/S+Kdb
OutFile=$(echo $file | cut -d '/' -f8 | cut -d '-' -f1 )_$(echo $file | cut -d '/' -f9)_$(basename $file | sed 's@.pdb@@g')-$(basename $Database)-foldseek-output.txt
sbatch ~/git_repos/Wrappers/NBI/foldseek.sh $InFile $Database $OutDir $OutFile
done
#3751068-3751075
#3780842-3782679
#3782680-3782872

for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/*-unique-cseps-cleaved/*/*/ranked_0.pdb); do
result=/jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/temp_AF2/foldseek_web_server/mmseqs_results_$(echo $file | cut -d '/' -f8 | cut -d '-' -f1 )_$(echo $file | cut -d '/' -f9)_ranked_0.gz
mkdir $(dirname $file)/foldseek_web_server
mv $result $(dirname $file)/foldseek_web_server/$(basename $result | sed 's@.gz@.tar.gz@g')
ls $(dirname $file)/foldseek_web_server/$(basename $result)
cd $(dirname $file)/foldseek_web_server/
tar -xvzf $(basename $result | sed 's@.gz@.tar.gz@g')
done

for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/*-unique-cseps-cleaved/*/*/foldseek_web_server/*.m8); do
db=$(basename $file | cut -d '_' -f2 | cut -d '.' -f1)
awk -v db="$db" 'BEGIN{FS=OFS="\t"} {print $0, db}' $file > temp.tsv && mv temp.tsv $file
done

for dir in $(ls -d /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/*-unique-cseps-cleaved/*/*/foldseek_web_server); do
cat $dir/*.m8 > $dir/all_db.tsv
sort -k11,11nr -k12,12g $dir/all_db.tsv > temp.tsv && mv temp.tsv $dir/all_db.tsv
done

ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/*-unique-cseps-cleaved/*/*/foldseek_web_server/all_db.tsv
```

