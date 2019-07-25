#Uses a file containing US tax brackets to calculate the federal income and FICA tax for two married individuals
#Annual total gross income (gi) for both indviduals is given as the first argument.
##By default the standard deduction for 2 individuals in 2017 ($12,700) is set as the deduction

#Read in tax bracket csv file
tax_bracket <- read.csv("US_taxbracket_2017.csv", sep=",", header=TRUE)

#Define function
joint_tax2017 <- function(gi, deduct = 12700) {
  
  #Calculating adjusted gross indcome (agi)
  agi <- gi - deduct
  
  #Creating generic marginal tax amounts vector
  amtowed_joint <- vector(mode="integer",length=7)   #Create empty vector of 0s 
  amtowed_joint[6] <- (tax_bracket$Married[7] - tax_bracket$Married[6]) * tax_bracket$Tax.Rate[6]
  amtowed_joint[5] <- (tax_bracket$Married[6] - tax_bracket$Married[5]) * tax_bracket$Tax.Rate[5]
  amtowed_joint[4] <- (tax_bracket$Married[5] - tax_bracket$Married[4]) * tax_bracket$Tax.Rate[4]
  amtowed_joint[3] <- (tax_bracket$Married[4] - tax_bracket$Married[3]) * tax_bracket$Tax.Rate[3]
  amtowed_joint[2] <- (tax_bracket$Married[3] - tax_bracket$Married[2]) * tax_bracket$Tax.Rate[2]
  amtowed_joint[1] <- (tax_bracket$Married[2] - tax_bracket$Married[1]) * tax_bracket$Tax.Rate[1]
  
  #Calculating actual income and FICA tax amount owed using agi value
  if (agi > tax_bracket$Married[7]) {
    amtowed_joint[7] <- (agi - tax_bracket$Married[7]) * tax_bracket$Tax.Rate[7] 
    incometax <- sum(amtowed_joint)
  } else if (agi > tax_bracket$Married[6]) {
    amtowed_joint[6] <- (agi - tax_bracket$Married[6]) * tax_bracket$Tax.Rate[6]
    incometax <- sum(amtowed_joint)
  } else if (agi > tax_bracket$Married[5]) {
    amtowed_joint[6] <- 0
    amtowed_joint[5] <- (agi - tax_bracket$Married[5]) * tax_bracket$Tax.Rate[5]
    incometax <- sum(amtowed_joint)
  } else if (agi > tax_bracket$Married[4]) {
    amtowed_joint[6] <- 0
    amtowed_joint[5] <- 0
    amtowed_joint[4] <- (agi - tax_bracket$Married[4]) * tax_bracket$Tax.Rate[4]
    incometax <- sum(amtowed_joint)
  } else if (agi > tax_bracket$Married[3]) {
    amtowed_joint[6] <- 0
    amtowed_joint[5] <- 0
    amtowed_joint[4] <- 0
    amtowed_joint[3] <- (agi - tax_bracket$Married[3]) * tax_bracket$Tax.Rate[3]
    incometax <- sum(amtowed_joint)
  } else if (agi > tax_bracket$Married[2]) {
    amtowed_joint[6] <- 0
    amtowed_joint[5] <- 0
    amtowed_joint[4] <- 0
    amtowed_joint[3] <- 0
    amtowed_joint[2] <- (agi - tax_bracket$Married[2]) * tax_bracket$Tax.Rate[2]
    incometax <- sum(amtowed_joint)
  } else {
    amtowed_joint[6] <- 0
    amtowed_joint[5] <- 0
    amtowed_joint[4] <- 0
    amtowed_joint[3] <- 0
    amtowed_joint[2] <- 0
    amtowed_joint[1] <- (agi - tax_bracket$Married[1]) * tax_bracket$Tax.Rate[1]
    incometax <- sum(amtowed_joint)
  }
  
  #Calculate FICA tax amounts
  if (gi > tax_bracket$Social_Sec_Max[1]) {
    FICAtax <- (tax_bracket$Social_Sec_Max[1] * 0.062) + (gi * 0.0145)
  } else {
    FICAtax <- (gi * 0.062) + (gi * 0.0145)
  }
  
  #Calculate Medicare Surtax
  if (gi > tax_bracket$Medicare_Sur_Joint[1]) {
    medsurtax <- 0.009 * (gi - tax_bracket$Medicare_Sur_Joint[1])
  } else {
    medsurtax <- 0
  }
  
  #Sum all tax owed
  sum(incometax, FICAtax, medsurtax)
}