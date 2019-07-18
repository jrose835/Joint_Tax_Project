#Uses a file containing US tax brackets to calculate the federal income tax for two married individuals
#when given an adjusted gross income (agi) as the single argument

#Read in tax bracket csv file
tax_bracket <- read.csv("US_taxbracket_2019.csv", sep=",", header=TRUE)

#Define function
joint_tax <- function(agi) {
  
  #Creating generic marginal tax amounts vector
  amtowed_joint <- vector(mode="integer",length=7)   #Create empty vector of 0s 
  amtowed_joint[6] <- (tax_bracket$Married[7] - tax_bracket$Married[6]) * tax_bracket$Tax.Rate[6]
  amtowed_joint[5] <- (tax_bracket$Married[6] - tax_bracket$Married[5]) * tax_bracket$Tax.Rate[5]
  amtowed_joint[4] <- (tax_bracket$Married[5] - tax_bracket$Married[4]) * tax_bracket$Tax.Rate[4]
  amtowed_joint[3] <- (tax_bracket$Married[4] - tax_bracket$Married[3]) * tax_bracket$Tax.Rate[3]
  amtowed_joint[2] <- (tax_bracket$Married[3] - tax_bracket$Married[2]) * tax_bracket$Tax.Rate[2]
  amtowed_joint[1] <- (tax_bracket$Married[2] - tax_bracket$Married[1]) * tax_bracket$Tax.Rate[1]
  
  #Calculating actual tax amount owed using agi value
  if (agi > tax_bracket$Married[7]) {
    amtowed_joint[7] <- (agi - tax_bracket$Married[7]) * tax_bracket$Tax.Rate[7] 
    sum(amtowed_joint)
  } else if (agi > tax_bracket$Married[6]) {
    amtowed_joint[6] <- (agi - tax_bracket$Married[6]) * tax_bracket$Tax.Rate[6]
    sum(amtowed_joint)
  } else if (agi > tax_bracket$Married[5]) {
    amtowed_joint[6] <- 0
    amtowed_joint[5] <- (agi - tax_bracket$Married[5]) * tax_bracket$Tax.Rate[5]
    sum(amtowed_joint)
  } else if (agi > tax_bracket$Married[4]) {
    amtowed_joint[6] <- 0
    amtowed_joint[5] <- 0
    amtowed_joint[4] <- (agi - tax_bracket$Married[4]) * tax_bracket$Tax.Rate[4]
    sum(amtowed_joint)
  } else if (agi > tax_bracket$Married[3]) {
    amtowed_joint[6] <- 0
    amtowed_joint[5] <- 0
    amtowed_joint[4] <- 0
    amtowed_joint[3] <- (agi - tax_bracket$Married[3]) * tax_bracket$Tax.Rate[3]
    sum(amtowed_joint)
  } else if (agi > tax_bracket$Married[2]) {
    amtowed_joint[6] <- 0
    amtowed_joint[5] <- 0
    amtowed_joint[4] <- 0
    amtowed_joint[3] <- 0
    amtowed_joint[2] <- (agi - tax_bracket$Married[2]) * tax_bracket$Tax.Rate[2]
    sum(amtowed_joint)
  } else {
    amtowed_joint[6] <- 0
    amtowed_joint[5] <- 0
    amtowed_joint[4] <- 0
    amtowed_joint[3] <- 0
    amtowed_joint[2] <- 0
    amtowed_joint[1] <- (agi - tax_bracket$Married[1]) * tax_bracket$Tax.Rate[1]
    sum(amtowed_joint)
  }
}