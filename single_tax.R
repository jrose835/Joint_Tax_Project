#Uses a file containing US tax brackets to calculate the federal income and FICA tax for a single married individual filing taxes separately
#Annual gross income (gi) for ONE INDIVIDUAL is given as the first argument. 
#By default the standard deduction for 1 individual in 2019 ($12,200) is set as the deduction in the second argument, but can be changed. 


#Read in tax bracket csv file
tax_bracket <- read.csv("US_taxbracket_2019.csv", sep=",", header=TRUE)

#Define function
single_tax <- function(gi, deduct = 12200) {
  
  #Calculating adjusted gross indcome (agi)
  agi <- gi - deduct
  
  #Creating generic marginal income tax amounts vector
  amtowed_single <- vector(mode="integer",length=7)   #Create empty vector of 0s 
  amtowed_single[6] <- (tax_bracket$Single[7] - tax_bracket$Single[6]) * tax_bracket$Tax.Rate[6]
  amtowed_single[5] <- (tax_bracket$Single[6] - tax_bracket$Single[5]) * tax_bracket$Tax.Rate[5]
  amtowed_single[4] <- (tax_bracket$Single[5] - tax_bracket$Single[4]) * tax_bracket$Tax.Rate[4]
  amtowed_single[3] <- (tax_bracket$Single[4] - tax_bracket$Single[3]) * tax_bracket$Tax.Rate[3]
  amtowed_single[2] <- (tax_bracket$Single[3] - tax_bracket$Single[2]) * tax_bracket$Tax.Rate[2]
  amtowed_single[1] <- (tax_bracket$Single[2] - tax_bracket$Single[1]) * tax_bracket$Tax.Rate[1]
  
  #Calculating actual income tax amount owed using agi value
  if (agi > tax_bracket$Single[7]) {
    amtowed_single[7] <- (agi - tax_bracket$Single[7]) * tax_bracket$Tax.Rate[7] 
    incometax <- sum(amtowed_single)
  } else if (agi > tax_bracket$Single[6]) {
    amtowed_single[6] <- (agi - tax_bracket$Single[6]) * tax_bracket$Tax.Rate[6]
    incometax <- sum(amtowed_single)
  } else if (agi > tax_bracket$Single[5]) {
    amtowed_single[6] <- 0
    amtowed_single[5] <- (agi - tax_bracket$Single[5]) * tax_bracket$Tax.Rate[5]
    incometax <- sum(amtowed_single)
  } else if (agi > tax_bracket$Single[4]) {
    amtowed_single[6] <- 0
    amtowed_single[5] <- 0
    amtowed_single[4] <- (agi - tax_bracket$Single[4]) * tax_bracket$Tax.Rate[4]
    incometax <- sum(amtowed_single)
  } else if (agi > tax_bracket$Single[3]) {
    amtowed_single[6] <- 0
    amtowed_single[5] <- 0
    amtowed_single[4] <- 0
    amtowed_single[3] <- (agi - tax_bracket$Single[3]) * tax_bracket$Tax.Rate[3]
    incometax <- sum(amtowed_single)
  } else if (agi > tax_bracket$Single[2]) {
    amtowed_single[6] <- 0
    amtowed_single[5] <- 0
    amtowed_single[4] <- 0
    amtowed_single[3] <- 0
    amtowed_single[2] <- (agi - tax_bracket$Single[2]) * tax_bracket$Tax.Rate[2]
    incometax <- sum(amtowed_single)
  } else {
    amtowed_single[6] <- 0
    amtowed_single[5] <- 0
    amtowed_single[4] <- 0
    amtowed_single[3] <- 0
    amtowed_single[2] <- 0
    amtowed_single[1] <- (agi - tax_bracket$Single[1]) * tax_bracket$Tax.Rate[1]
    incometax <- sum(amtowed_single)
  }
  
  #Calculate FICA tax amounts
  if (gi > tax_bracket$Social_Sec_Max[1]) {
    FICAtax <- (tax_bracket$Social_Sec_Max[1] * 0.062) + (gi * 0.0145)
  } else {
    FICAtax <- (gi * 0.062) + (gi * 0.0145)
  }
  
  #Calculate Medicare Surtax
  if (gi > tax_bracket$Medicare_Sur_Sep[1]) {
    medsurtax <- 0.009 * (gi - tax_bracket$Medicare_Sur_Sep[1])
  } else {
    medsurtax <- 0
  }
  
  #Sum all tax owed
  sum(incometax, FICAtax, medsurtax)
}