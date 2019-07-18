#Uses a file containing US tax brackets to calculate the federal income tax for a single individual
#when given an adjusted gross income (agi) as the single argument

#Read in tax bracket csv file
tax_bracket <- read.csv("US_taxbracket_2019.csv", sep=",", header=TRUE)

#Define function
single_tax <- function(agi) {
  
  #Creating generic marginal tax amounts vector
  amtowed_single <- vector(mode="integer",length=7)   #Create empty vector of 0s 
  amtowed_single[6] <- (tax_bracket$Single[7] - tax_bracket$Single[6]) * tax_bracket$Tax.Rate[6]
  amtowed_single[5] <- (tax_bracket$Single[6] - tax_bracket$Single[5]) * tax_bracket$Tax.Rate[5]
  amtowed_single[4] <- (tax_bracket$Single[5] - tax_bracket$Single[4]) * tax_bracket$Tax.Rate[4]
  amtowed_single[3] <- (tax_bracket$Single[4] - tax_bracket$Single[3]) * tax_bracket$Tax.Rate[3]
  amtowed_single[2] <- (tax_bracket$Single[3] - tax_bracket$Single[2]) * tax_bracket$Tax.Rate[2]
  amtowed_single[1] <- (tax_bracket$Single[2] - tax_bracket$Single[1]) * tax_bracket$Tax.Rate[1]
  
  #Calculating actual tax amount owed using agi value
  if (agi > tax_bracket$Single[7]) {
    amtowed_single[7] <- (agi - tax_bracket$Single[7]) * tax_bracket$Tax.Rate[7] 
    sum(amtowed_single)
  } else if (agi > tax_bracket$Single[6]) {
    amtowed_single[6] <- (agi - tax_bracket$Single[6]) * tax_bracket$Tax.Rate[6]
    sum(amtowed_single)
  } else if (agi > tax_bracket$Single[5]) {
    amtowed_single[6] <- 0
    amtowed_single[5] <- (agi - tax_bracket$Single[5]) * tax_bracket$Tax.Rate[5]
    sum(amtowed_single)
  } else if (agi > tax_bracket$Single[4]) {
    amtowed_single[6] <- 0
    amtowed_single[5] <- 0
    amtowed_single[4] <- (agi - tax_bracket$Single[4]) * tax_bracket$Tax.Rate[4]
    sum(amtowed_single)
  } else if (agi > tax_bracket$Single[3]) {
    amtowed_single[6] <- 0
    amtowed_single[5] <- 0
    amtowed_single[4] <- 0
    amtowed_single[3] <- (agi - tax_bracket$Single[3]) * tax_bracket$Tax.Rate[3]
    sum(amtowed_single)
  } else if (agi > tax_bracket$Single[2]) {
    amtowed_single[6] <- 0
    amtowed_single[5] <- 0
    amtowed_single[4] <- 0
    amtowed_single[3] <- 0
    amtowed_single[2] <- (agi - tax_bracket$Single[2]) * tax_bracket$Tax.Rate[2]
    sum(amtowed_single)
  } else {
    amtowed_single[6] <- 0
    amtowed_single[5] <- 0
    amtowed_single[4] <- 0
    amtowed_single[3] <- 0
    amtowed_single[2] <- 0
    amtowed_single[1] <- (agi - tax_bracket$Single[1]) * tax_bracket$Tax.Rate[1]
    sum(amtowed_single)
  }
}