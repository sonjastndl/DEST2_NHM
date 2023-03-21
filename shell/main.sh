#Inversion Analysis

## convert VCF to SYNC
##PoolSNP
gunzip -c /media/DEST2_NHM/data/dest.all.PoolSNP.001.50.25Feb2023.norep.vcf.gz |
    parallel \
        --jobs 80 \
        --pipe \
        -k \
        --cat python3 /media/DEST2_NHM/scripts/VCF2sync.py \
        --input {} |
    gzip >/media/DEST2_NHM/output/dest.all.PoolSNP.001.50.25Feb2023.norep.gz

#SNAPE 
gunzip -c /media/DEST2_NHM/data/dest.PoolSeq.SNAPE.NA.NA.25Feb2023.norep.vcf.gz |
    parallel \
        --jobs 80 \
        --pipe \
        -k \
        --cat python3 /media/DEST2_NHM/scripts/VCF2sync.py \
        --input {} |
    gzip >/media/DEST2_NHM/output/dest.PoolSeq.SNAPE.NA.NA.25Feb2023.norep.gz


## get count at inversion specific marker SNPs
gunzip -c /media/DEST2_NHM/output/dest.all.PoolSNP.001.50.25Feb2023.norep.gz |
    parallel \
        --pipe \
        --jobs 20 \
        -k \
        --cat python3 /media/DEST2_NHM/scripts/overlap_in_SNPs.py \
        --source /media/DEST2_NHM/scripts/inversion_markers_v6.txt_pos \
        --target {} \
        >output/PoolSNP_inversion_markers.sync

###check if variable call works
NAMES=$(gunzip -c /media/DEST2_NHM/data/dest.all.PoolSNP.001.50.25Feb2023.norep.vcf.gz | head -50 | awk '/^#C/' | cut -f10- | tr '\t' ',')

## calculate average frequencies for marker SNPs
python3 /media/DEST2_NHM/scripts/inversion-freqs.py \
    /media/DEST2_NHM/scripts/inversion_markers_v6.txt \
    /media/DEST2_NHM/output/PoolSNP_inversion_markers.sync \
    $NAMES \
    >/media/DEST2_NHM/results/PoolSNP_nhm_inversion.af


#Plot with R for each Inversion
inversions=("In.2L.t" "In.2R.Ns" "In.3L.P" "In.3R.C" "In.3R.K" "In.3R.Mo" "In.3R.Payne")

for i in ${inversions[@]}; do
    inv=$(expr $i)
    #echo $inv
    Rscript /media/DEST2_NHM/scripts/LatContInv.R /media/DEST2_NHM/results/PoolSNP_nhm_inversion.af /media/DEST2_NHM/data/dest_v2.samps_25Feb2023.csv ${inv}
done

#Rscript /media/DEST2_NHM/scripts/LatContInv.R /media/DEST2_NHM/results/PoolSNP_nhm_inversion.af /media/DEST2_NHM/data/dest_v2.samps_25Feb2023.csv In.2L.t

