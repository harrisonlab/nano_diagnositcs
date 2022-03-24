# Powdery mildew comparative genomics pipeline

Documentation of analysis and commands used for comparative genomics work as part of Nano Diagnostics PhD.

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
```
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
for assembly in $(ls data/assembly/genome/*/*/*.fna); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=viridiplantae_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2462675-2462728, 2487763-8, 2488333-2488367
conda deactivate
exit
echo finished

conda activate BUSCO
for assembly in $(ls data/assembly/genome/*/*/*.fna); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=ascomycota_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2463015-2463068,2488280-2488332
conda deactivate
exit
echo finished

conda activate BUSCO
for assembly in $(ls data/assembly/genome/*/*/*.fna); do
  echo $assembly
  ProgDir=~/scratch/apps/busco
  BuscoDB=leotiomycetes_odb10
  OutDir=$(dirname $assembly|sed 's@data/assembly/genome@gene_pred@g')/$(echo $assembly|rev|cut -f1 -d '/' --output-delimiter '-'|rev|sed 's@.fna@@g'|sed 's@_genomic@@g'|sed 's@.mod@@g')/BUSCO
  echo $OutDir
  echo $BuscoDB
  sbatch $ProgDir/sub_busco.sh $assembly $BuscoDB $OutDir
done
#2463069-2463122, 2487770-2487809
conda deactivate
exit
echo finished
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
for file in $(ls gene_pred/Podosphaera/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Erysiphe/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Blumeria/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Golovinomyces/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Oidium/*/*c/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
grep -v "^#" $file | awk '$2=="Complete" {print $1}' >> analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt;
done
for file in $(ls gene_pred/Saccharomyces/*/*4/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/full_table.tsv); do
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
```
BUSCOs that were only present in less than 3 genomes were filtered out:

```bash
#Mildew BUSCOs:
sort analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids.txt |uniq -c > analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids_with_counts.txt
awk '$NF > 2 {print $1}' analysis/phylogeny/busco/mildew_leotiomycetes_complete_busco_ids_with_counts.txt > analysis/phylogeny/busco/mildew_leotiomycetes_final_busco_ids.txt

#Host BUSCOs:
sort analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids.txt |uniq -c > analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids_with_counts.txt
awk '$NF > 2 {print $1}' analysis/phylogeny/busco/host_viridiplantae_complete_busco_ids_with_counts.txt > analysis/phylogeny/busco/host_viridiplantae_final_busco_ids.txt
```
Genes (both nucleotides and amino acids) were copied to a different directory. - Note that the gene names for each BUSCO output are only indetified by BUSCO id with either faa or fna extenstions. If you try to copy them directly to a single directory, you will likely overwrite all the files and end up with only the last set of files. Therefore each BUSCO gene for each genome was assigned a unique name and then all were merged together, writing them to a single busco id file. Ssequence nameS (fasta header) were edited so to include organism identifiers.

NOTE:.fna files containing nucleotide information will not be created by busco unless --augustus parameter is used (has not been here).
```bash
#For pathogen; Blumeria Erysiphe Podosphaera Golovinomyces Oidium and Saccharomyces outgroup 

mkdir -p analysis/phylogeny/busco/mildew_leotiomycetes_busco_aa
mkdir -p analysis/phylogeny/busco/mildew_leotiomycetes_busco_nt

for dir in $(ls -d gene_pred/Saccharomyces/*/*4/BUSCO/leotiomycetes_odb10/*/run_leotiomycetes_odb10/busco_sequences/single_copy_busco_sequences); do
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

for dir in $(ls -d gene_pred/triticum/*/*/BUSCO/viridiplantae_odb10/*/run_viridiplantae_odb10/busco_sequences/single_copy_busco_sequences); do
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
```



Arabidopsis/     Erysiphe/        malus/           P_leucotricha/   secale/          vitus/
Blumeria/        fragaria/        nicotiana/       Podosphaera/     solanum/
busco_summaries/ Golovinomyces/   Oidium/          prunus/          Sporidiobolus/
cucumis/         hevea/           P_aphanis/       rubus/           Sporobolomyces/
cucurbita/       hordeum/         pisum/           Saccharomyces/   triticum/

