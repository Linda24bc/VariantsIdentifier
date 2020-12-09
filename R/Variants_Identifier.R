Variants.Identifier <- function(ref, exp){
  exp <- mutate(exp,
                Exp_rel_abundance = Exp_Intensity/max(exp$Exp_Intensity)*100)
  name.ref <- as.character(ref$Name)
  for (i in 1:length(exp$Exp_Mass)){
    for (j in 1:length(ref$Ref_Mass)){
      ppm_error = (exp$Exp_Mass[i] - ref$Ref_Mass[j])/ref$Ref_Mass[j] * (10^6)
      if (ppm_error <= 10 & ppm_error > -2)
        exp$Name[i] <- name.ref[j]
    }
  }
  join <- full_join(exp, ref)
  join$ppm_error=(join$Exp_Mass - join$Ref_Mass)/join$Ref_Mass * (10^6)
  join1 <- filter(join, Exp_rel_abundance > 2 & !is.na(Ref_Mass) & !is.na(Exp_Mass))
  sort <- join1[with(join1, order(Ion.type, Exp_Mass, Ref_Mass)),]
}
