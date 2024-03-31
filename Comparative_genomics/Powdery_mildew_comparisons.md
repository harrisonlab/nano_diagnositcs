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
srun -p long  -c 8 --mem 50G --pty bash
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

cd /home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa
buscos=/home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_final_buscos_ids.txt
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

  AlignDir=/home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa
  cd $AlignDir
  ProgDir=/home/theaven/scratch/apps/phylogeny
  sbatch $ProgDir/sub_mafft_alignment.sh $AlignDir
#2569980, 2859968, 3113182
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

for gene in $(ls /home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa/*_aligned.fasta); do
  ID=$(basename $gene |sed 's@_aa_aligned.fasta@@g')
  echo $ID
  mkdir /home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa/$ID
  cp $gene /home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa/$ID
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
for Alignment in $(ls /home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa/*/*_aligned.fasta); do
  Output=$(echo $Alignment | sed 's@aligned.fasta@aligned_host.fasta@g')
grep -A1 '>ARABIDOPSISTHALIANA\|>CAPSICUMANNUUM\|>CUCUMISSATIVUS\|>CUCURBITAPEPO\|>FRAGARIA\|>HEVEABRASILIENS\|>HORDEUMVULGARE\|>MALUSDOMESTICA\|>MORUSALBA\|>NICOTIANATABACUM\|>PISUMSATIVUM\|>PRUNUSAVIUM\|>QUERCUSROBUR\|>RUBUS\|>SACCHAROMYCESCEREVISIAE\|>SECALECEREALE\|>SOLANUMLYCOPERSICUM\|>VITUSVINIFERA\|>TRITICUMAESTIVUM' $Alignment > $Output
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

  for Alignment in $(ls /home/theaven/scratch/analysis/phylogeny/busco/host_viridiplantae_busco_aa/*/*_aligned.fasta); do
    OutDir=$(dirname $Alignment)
    TrimmedName=$(basename $Alignment .fasta)"_trimmed.fasta"
    echo $Alignment
    echo $OutDir
    echo $TrimmedName
    trimal -in $Alignment -out $OutDir/$TrimmedName -keepheader -automated1
  done
conda deactivate

99at147548
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

for Alignment in $(ls analysis/phylogeny/busco/host_viridiplantae_busco_aa/*/*_trimmed.fasta); do
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
for Alignment in $(ls analysis/phylogeny/busco/host_viridiplantae_busco_aa/*/*_trimmed_edit.fasta); do
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
for assembly in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/Parauncinula/*/*/*a); do
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

#Extract complete busco IDs, keep those present in at least 3 genomes:
for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/BUSCO/fungi_odb10/run_fungi_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids.txt;
done

sort /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids.txt |uniq -c > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids_with_counts.txt
grep -v " 2 " /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids_with_counts.txt | grep -v " 1 " > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids.txt
awk '{print $2}' /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids.txt > /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/complete_busco_ids_3.txt

mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt

for file in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/Genomes/*/*/*/BUSCO/fungi_odb10/run_fungi_odb10/busco_sequences/single_copy_busco_sequences.tar.gz); do
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

for gene in $(ls /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/*_aligned.fasta); do
  ID=$(basename $gene |sed 's@_nt_aligned.fasta@@g')
  echo $ID
  mkdir /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/$ID
  cp $gene /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/nano_diagnostics/analysis/phylogeny/busco_nt/$ID
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

#Run RAxML
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
for Assembly in $(ls temp_genomes/*/*/GCA_000146945.2/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa temp_genomes/*/*/GCF_000151645.1/repeatmasking/combined/*_contigs_softmasked_repeatmasker_TPSI_appended.fa); do
  ID=$(echo $Assembly | cut -d '/' -f2 | cut -c 1-3)_$(echo $Assembly | cut -d '/' -f3 | cut -c 1-3)_$(echo $Assembly | cut -d '/' -f4)
  echo $ID
  OutDir=mildews/${ID}/gene_pred/braker-2
  GeneModelName=${ID}_genemodels
  Hintfile=mildews/${ID}/gene_pred/prothint/prothint_augustus.gff
  ProgDir=/home/theaven/scratch/apps/braker
  if [[ ! -f ${OutDir}/braker.gff3 ]]; then
  if [[ -f ${Hintfile} ]]; then
    echo "running for $ID"
  sbatch $ProgDir/braker_fungi_noRNA.sh $Assembly $OutDir $GeneModelName $Hintfile
  else 
  echo "inputs missing for $ID"
  fi
  else
  echo "already run for $ID"
  fi 
done #19242548-19242574
#19317486-7
conda deactivate

for job in $(squeue -u theaven | awk '{print $1}'); do
file=slurm-${job}.out
echo $job
grep -A 1 'OutDir:' $file
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
  cat ${ID}_busco_blast.tsv >> temp.tsv && mv temp.tsv ${ID}_busco_blast.tsv
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
  cat ${ID}_csep_blast.tsv >> temp.tsv && mv temp.tsv ${ID}_csep_blast.tsv
done

conda deactivate
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
  geom_hex(binwidth=c(0.05, 0.05)) +
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
  geom_hex(binwidth = c(0.05, 0.05), fill = "grey") +
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
  geom_hex(binwidth = c(0.05, 0.05), fill = "grey") +
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
  geom_hex(binwidth = c(0.05, 0.05), fill = "grey") +
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
  geom_hex(binwidth = c(0.05, 0.05), fill = "grey") +
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
  geom_hex(binwidth = c(0.05, 0.05), fill = "grey") +
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

search <- read.table("p112020_good.txt", header = FALSE)
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

df_all <- read.xlsx(OBG2021_output.xlsx)
# 5-prime IG
df_filtered <- df_all[!is.na(df_all$five_prime_2), ]


mean_other <- mean(subset(df_filtered$five_prime_2, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime_2, na.rm = TRUE)
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
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Five prime intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff)

# 3-prime IG
df_filtered <- df_all[!is.na(df_all$three_prime_2), ]


mean_other <- mean(subset(df_filtered$three_prime_2, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime_2, na.rm = TRUE)
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
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Three prime intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff)

# Total IG

df_filtered2 <- df_all[!is.na(df_all$five_prime_2), ]
df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime_2), ]

df_filtered$total_IG = df_filtered$five_prime_2 + df_filtered$three_prime_2

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

ggsave("p112020_CSEPs_total_IG_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("p112020_CSEPs_5_IG_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("p112020_CSEPs_3_IG_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")

print(paste("p112020 CSEPs total intergenic distance:", total_sig))
print(paste("p112020 CSEPs 5' intergenic distance:", sig_5))
print(paste("p112020 CSEPs 3' intergenic distance:", sig_3))

#Larger values means that treatment has greater intergenic distance than average
```
DRCT72020 BUSCOs total intergenic distance: 9999
DRCT72020 BUSCOs 5' intergenic distance: 9858
DRCT72020 BUSCOs 3' intergenic distance: 9999
DRCT72021 BUSCOs total intergenic distance: 9994
DRCT72021 BUSCOs 5' intergenic distance: 4191
DRCT72021 BUSCOs 3' intergenic distance: 9999
SCOTT2020 BUSCOs total intergenic distance: 9996
SCOTT2020 BUSCOs 5' intergenic distance: 8594
SCOTT2020 BUSCOs 3' intergenic distance: 9999
OGB2019 BUSCOs total intergenic distance: 9999
OGB2019 BUSCOs 5' intergenic distance: 9999
OGB2019 BUSCOs 3' intergenic distance: 9999
p112020 BUSCOs total intergenic distance: 9999
p112020 BUSCOs 5' intergenic distance: 9999
p112020 BUSCOs 3' intergenic distance: 9999
OGB2021 BUSCOs total intergenic distance: 9999
OGB2021 BUSCOs 5' intergenic distance: 9999
OGB2021 BUSCOs 3' intergenic distance: 9999

DRCT72020 CSEPs total intergenic distance: 7949
DRCT72020 CSEPs 5' intergenic distance: 9865
DRCT72020 CSEPs 3' intergenic distance: 825
DRCT72021 CSEPs total intergenic distance: 9920
DRCT72021 CSEPs 5' intergenic distance: 9900
DRCT72021 CSEPs 3' intergenic distance: 9103
SCOTT2020 CSEPs total intergenic distance: 9353
SCOTT2020 CSEPs 5' intergenic distance: 9680
SCOTT2020 CSEPs 3' intergenic distance: 6623
OGB2019 CSEPs total intergenic distance: 9999
OGB2019 CSEPs 5' intergenic distance: 9991
OGB2019 CSEPs 3' intergenic distance: 9993
p112020 CSEPs total intergenic distance: 9999
p112020 CSEPs 5' intergenic distance: 9996
p112020 CSEPs 3' intergenic distance: 9990
OGB2021 CSEPs total intergenic distance: 9998
OGB2021 CSEPs 5' intergenic distance: 9992
OGB2021 CSEPs 3' intergenic distance: 9946

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
python2.7 ../apps/tools/find_intergenic_te_distances.py --Gff $Gff --ID DNA/TcMar_Pogo >> $OutFile
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
python2.7 ../apps/tools/find_intergenic_te_distances.py --Gff $Gff --ID DNA/TcMar_Mariner >> $OutFile
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
```

#### EarlGreyTE
```bash
head -n 2 /home/theaven/scratch/uncompressed/genomes/HEAVEN_apple2020.fna > temp_earlgreytest.fna

conda activate earlgrey
for Genome in $(ls /home/theaven/scratch/uncompressed/genomes/Leveillula/*/*/fcs/*_clean.fasta); do
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

#19315485-92
#19317438-49
#19317478-81
#19317484
```
```bash
cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/Psyllidae/assembly/genome/T_apicales/hifiasm_19.5/880m/29/3/3.0/0.75/break10x/purge_dups/sanger/MitoHifi/filtered/inspector/T_apicales_880m_29_3_3.0_0.75_break_TellSeqPurged_curated_nomito_filtered_corrected.fa download/.
cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/Psyllidae/assembly/genome/T_urticae/hifiasm_19.5/715m/12/2/3.0/0.5/filtered/purge_dups/purge_haplotigs/break10x/yahs/filtered/inspector/T_urticae_715m_12_2_3.0_0.5_filtered_HiFiPurged_HiFiPurged_curated_break_scaffolds_final_nomito_filtered_corrected.fa download/.
cp /jic/scratch/groups/Saskia-Hogenhout/tom_heaven/Psyllidae/assembly/genome/T_anthrisci/hifiasm_19.5/820m/48/1/10.0/0.25/break10x/purge_dups/sanger/MitoHifi/filtered/inspector/T_anthrisci_820m_48_1_10.0_0.25_break_TellSeqPurged_curated_nomito_filtered_corrected.fa download/.

conda activate earlgrey
for Genome in $(ls /home/theaven/scratch/uncompressed/hogenhout/T*.fa); do
  OutFile=$(basename $Genome | sed 's@.fa@@g' | cut -d '_' -f1,2)
  OutDir=$(dirname $Genome)/earlgreyte2/${OutFile}
  ProgDir=~/scratch/apps
  RMsearch=Sternorrhyncha
  mkdir -p $OutDir
  sbatch ${ProgDir}/earlgrey/run_earlgrey.sh $Genome $OutFile $OutDir $RMsearch
done
#19238763,5
#19306652-4
conda deactivate
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
```
Shared by B.cinerea, M. oryzae, C. higginsianum, S. sclerotiorum and S. cerevisiae
```bash

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
