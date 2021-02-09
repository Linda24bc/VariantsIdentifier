SubDatabase <- function(HbDatabase, Mshift= -29.97, error_Da=0.4){
  s1 <- Mshift - error_Da
  e1 <- Mshift + error_Da
  subHbBeta1 <- filter(HbDatabase, Delta.mass <=e & Delta.mass >= s)
  return(subHbBeta1)
}
