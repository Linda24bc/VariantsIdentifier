Variants Identifier
================
Automaitically Identification of Hb variants
## Installation

Install from GitHub:

``` 

```

## Steps to get the results
### package
library(dplyr)
library(tidyverse)
### step 1. Input the database including the diagnostic ions of Hb varints and use MS1 data to narrow down the database - subset the database
HbDatabase <-  read_csv("Hb Variants_ref.csv")
ref <- SubDatabase(HbDatabase, Mshift= -29.97, error_Da = 0.4)

### step 2. deconvolve MS2 results (m/z vs Intensity)

exp <- read.csv("expt mass_cHbSS.csv")

### step 3. search the experimental results in the subset database - Variant Identifier(can define the ppm_error)

ID.results <- Variants.Identifier(ref, exp, ppm_error_start=-2, ppm_error_end=5)

### step 4. output the results in .csv

write.csv(ID.results, "ID_cHbSS.csv", row.names = FALSE)

