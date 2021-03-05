Variants Identifier
================
Automaitically Identification of Hb variants
## Installation

Install from GitHub:

``` 

```

## Introduction
+ Identify the Hb variants by comparing the experimental data in the database
+ Original database contains the theoretical diagnostic ions of Hb variants been tested by mass spectrometry so far 

### Prerequisite 1: Install packages
+ library(dplyr)
+ library(tidyverse)
+ library(knitr)

### Prerequisite 2:load SubDatabase and Variant.Identifier function
The R apckage is avaiable in Github. Example data are avaiable in Input folder and expected output data are in Output data.

### Step 1. Input the database including the diagnostic ions of Hb varints and use MS1 data to narrow down the database - subset the database

1.1 Input the original database

HbDatabase <-  read_csv("Hb Variants_OriginalDatabase.csv")

1.2 Use the MS1 data to narrow down the database, if the mass shift is about -0.93 Da, then the Mshift is -0.93 Da and the error tolerence is 0.06 Da. Thoese two values are changable and depend on the accuracy of deconvolution.

ref <- SubDatabase(HbDatabase, Mshift= -0.93, error_Da = 0.06)

### Step 2. Input the deconvolve MS2 results 
The list should contain two columns,  Exp_m/z vs Exp_Intensity)

exp <- read-_csv("expt mass_AE.csv")

### Step 3. Search the experimental results in the subset database with Variant Identifier
Run the function Variants.Identifier, the ppm_error range is changable and depends on the accuracy of the MS2 data. View the result list and get the identification.

ID.results <- Variants.Identifier(ref, exp, ppm_error_start=-2, ppm_error_end=5)

### Step 4. Output the results in .csv

write.csv(ID.results, "ID_HbAE_1.csv", row.names = FALSE)
