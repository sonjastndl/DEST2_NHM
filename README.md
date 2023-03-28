# Analysis of Inversion Specific Markers in the DESTv2 dataset.

The included scripts were applied to the *PoolSNP* and *SNAPE* VCF files of the DESTv2 project, the filtered markers correspond with *inversion_markers_v6.txt*.
Average fequencies of these inversion specific marker SNPs were determined for each SNP calling method.
The Following Analyses were performed:

### Method Correlation
Correlation of average frequencies for both methods were investigated for correlation.

![Preliminary results:](results/SNAPEvsPoolSNP.png) 

### Latitudinal Clines Across Continents 
For inverions *In(3R)Payne*, *In(2L)t*, *In(2R)Ns*, *In(3R)C*, *In(3R)K*, *In(3R)Mo* and  *In(3L)P* several analysis of relationship between latitude and inversion frequencies were performed. 

![Preliminary results. Example In(3R)Payne:](results/Continents_lat_3RPayne.png) 


### Consistency Across Years
Investigations were performed on North American sampels and European samples, to get insight into consistency of allele frequencies across years.  

![Preliminary results. Example Europe:](results/Year_Europe_lat.png)

## Pipeline Steps

Individual scripts to perform these analyses can be found in the scripts directory, the whole pipeline is documentated in the [main.sh](shell/main.sh) file.

1) Convert VCF to SYNC
2) Get count at inversion specific marker SNPs
3) Calculate average frequencies for marker SNPs
4) Plot marker frequencies for each Inversion occuring in the data set
5) Plot Correlation of Inversion Markers of PoolSNP & SNAPE

### Additional scrips that can be used to extend analysis based on coverage

- Get the average coverage of a marker for each population [SubsampleSyncCov](scripts/SubsampleSyncCov.py)
- Get the coverage of each marker [CovPerMarker](scripts/CovPerMarker.py)
