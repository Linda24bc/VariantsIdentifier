Variants Identifier
================
Automaitically Identification of Hb variants
## Installation

Install from GitHub:

``` 

```
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
library(dplyr)
library(tidyverse)
library(knitr)
```

## Introduction
+ Identify the Hb variants by comparing the experimental data in the database
+ Original database contains the theoretical diagnostic ions of Hb variants been tested by mass spectrometry so far 

### Prerequisite 1: Install packages
+ library(dplyr)
+ library(tidyverse)
+ library(knitr)

### Prerequisite 2:load SubDatabase and Variant.Identifier function
The R apckage is avaiable in Github. See the link below.

[Variant Identifier](https://github.com/Linda24bc/VariantsIdentifier)

SubDatabase(HbDatabase, Mshift= -29.97, error_Da= 0.4)  
Variants.Identifier <- function(ref, exp, ppm_error_start=-2, ppm_error_end=5)
```{r,p0, echo=FALSE}
SubDatabase <- function(HbDatabase, Mshift= -29.97, error_Da=0.4){
  s1 <- Mshift - error_Da
  e1 <- Mshift + error_Da
  subHbBeta1 <- filter(HbDatabase, Delta.mass <=e1 & Delta.mass >= s1)
  return(subHbBeta1)
}
```

```{r,p00, echo=FALSE}
Variants.Identifier <- function(ref, exp, ppm_error_start=-2, ppm_error_end=5){
 exp <- dplyr::mutate(exp,
                   Exp_rel_abundance = Exp_Intensity/max(exp$Exp_Intensity)*100)
  name.ref <- as.character(ref$Name)
  exp$Name <- numeric(length(exp$Exp_Mass))
for (i in 1:length(exp$Exp_Mass)){
  for (j in 1:length(ref$Ref_Mass)){
    ppm_error = (exp$Exp_Mass[i] - ref$Ref_Mass[j])/ref$Ref_Mass[j] * (10^6)
    if (ppm_error <= ppm_error_end & ppm_error > ppm_error_start)
      exp$Name[i]<- name.ref[j]
  }
}
join <- full_join(exp, ref) 
join$ppm_error=(join$Exp_Mass - join$Ref_Mass)/join$Ref_Mass * (10^6)
join1 <- filter(join, Exp_rel_abundance > 2 & !is.na(Ref_Mass) & !is.na(Exp_Mass))
sort <- join1[with(join1, order(Variant, Ion.type, Exp_Mass, Ref_Mass)),]
re <- sort[,c(4,1,3,5,6,7,8,9,10,11,12)]
}
```

### Step 1. Input the database including the diagnostic ions of Hb varints and use MS1 data to narrow down the database - subset the database

1.1 Input the original database

```{r,p1, echo=TRUE}
HbDatabase <-  read_csv("Hb Variants_OriginalDatabase.csv")
HbDatabase
class(HbDatabase)
```

1.2 Use the MS1 data to narrow down the database, if the mass shift is about -0.98 Da, then the Mshift is -1 Da and the error tolerence is 0.4 Da. Thoese two values are changable and depend on the accuracy of deconvolution.

```{r,p2, echo=TRUE}
ref <- SubDatabase(HbDatabase, Mshift= -1, error_Da = 0.4)
ref
```

### Step 2. Input the deconvolve MS2 results 
The list should contain two columns,  Exp_m/z vs Exp_Intensity)

```{r,p3, echo=TRUE}
exp <- read.csv("expt mass_AE.csv")
head(exp)
```

### Step 3. Search the experimental results in the subset database with Variant Identifier
Run the function Variants.Identifier, the ppm_error range is changable and depends on the accuracy of the MS2 data. View the result list and get the identification.

```{r,p4, echo=TRUE}
ID.results <- Variants.Identifier(ref, exp, ppm_error_start=-2, ppm_error_end=5)
ID.results
```

### Step 4. Output the results in .csv

```{r,p5, echo=TRUE}
write.csv(ID.results, "ID_HbAE_1.csv", row.names = FALSE)
```
