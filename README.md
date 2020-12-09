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
### Input the database which contains the diagnostic product ions of Hb variants
ref <- read.csv("Hb Variants_ref_lacolized_1.csv")
### Input the possible diagnostic ion list for each AA
exp <- read.csv("expt mass_AC.csv")
### Run the function and get the results
ID.results <- Variants.Identifier(ref, exp)

