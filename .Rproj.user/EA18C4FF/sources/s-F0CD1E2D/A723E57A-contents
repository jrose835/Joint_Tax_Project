#The goal of this project is to create a heatmap of tax filings for two individuals with varying gross income levels
#It provides heatmaps for both single filing and married filing status as well as the "marriage bonus"
#Jrose 23May19

#Clear workspace
rm(list=ls())

#Load Packages
library(ComplexHeatmap)
library(circlize)
library(tidyverse)

#Creating variables for range of incomes
indv1_low <- 15000
indv1_high <- 200000
indv2_low <- 15000
indv2_high <- 200000
increment <- 10000

#Create vectors of individual gross income possibilities
indv1 <- seq(from=indv1_low, to=indv1_high, by=increment)
indv2 <- seq(from=indv2_low, to=indv2_high, by=increment)

#Adjusted gross income calculation (assumes standard deduction of $12,000 per individual)
std_deduct <- 12000
agi_indv1 <- indv1 - std_deduct
agi_indv2 <- indv2 - std_deduct

#Source functions single_tax.R and joint_tax.R for amount owed in single filing and married joint filings
source("single_tax.R")
source("joint_tax.R")

#Apply joint_tax function to create a matrix of joint tax amount totals
joint_tax_totals <- sapply(1:length(agi_indv2), function(n) 
  c(sapply((agi_indv1 + agi_indv2[n]), joint_tax))
  )
colnames(joint_tax_totals) <- sprintf("%sK", seq(from=(indv1_low/1000), to=(indv1_high/1000), by=(increment/1000)))
rownames(joint_tax_totals) <- sprintf("%sK", seq(from=(indv2_low/1000), to=(indv2_high/1000), by=(increment/1000)))

#Apply single_tax function to create matrix of single tax amount totals
single_tax_totals <- sapply(1:length(agi_indv2), function(n) 
  c(sapply(agi_indv1, single_tax) + sapply(agi_indv2[n], single_tax))
  )
colnames(single_tax_totals) <- sprintf("%sK", seq(from=(indv1_low/1000), to=(indv1_high/1000), by=(increment/1000)))
rownames(single_tax_totals) <- sprintf("%sK", seq(from=(indv2_low/1000), to=(indv2_high/1000), by=(increment/1000)))

#heatmaps of total federal tax

htmp_single <- Heatmap(single_tax_totals, 
        column_title = "Total Tax--Single Filing",
        cluster_columns=FALSE,
        cluster_rows=FALSE,
        name = "Tax Owed"
        )

htmp_joint <- Heatmap(joint_tax_totals, 
        column_title = "Total Tax--Joint Filing",
        cluster_columns=FALSE,
        cluster_rows=FALSE,
        name = "Tax Owed"
        )
#png(file="htmp_sing.png")
draw(htmp_single)
#dev.off()

#png(file="htmp_joint.png")
draw(htmp_joint)
#dev.off()

#Calculate 'marriage bonus/penalty' amounts & plot heatmap
bonus_penalty <- single_tax_totals - joint_tax_totals

htmp_bonus <- Heatmap(bonus_penalty,
        cluster_columns=FALSE,
        column_title = "Marriage Tax Bonus: Joint Filing vs Single Filing",
        cluster_rows=FALSE,
       # row_names_gp = gpar(col = 
        #                      c(
         #                       rep(
          #                        c("black", rep("white", 3)), (length(indv1)/4)      #Whites out labels bewtween 1 and 5
           #                     )
            #                  )
             #               ),
        #column_names_gp = gpar(col = 
         #                      c(
          #                       rep(
           #                        c("black", rep("white", 3)), (length(indv1)/4)      #Whites out labels bewtween 1 and 5
            #                     )
             #                  )
                              #),  
        name = "Bonus $",
        col= c("Red", "yellow", "greenyellow", "green", "cyan", "blue")
        )

#png(file="htmp_bonus.png")
draw(htmp_bonus)
#dev.off()

##Part two of Project: Tidy up data, and plot by percentage total earnings

#Create a corresponding maxtrix of joint total income
M_total_income <- sapply(1:length(indv2), function(n)
  c(indv1 + indv2[n])
)

rownames(M_total_income) <- indv1 
colnames(M_total_income) <- indv2

#Create a corresponding matrix of percentage contribution to joint total income for individual 1
M_indv1_contrib <- sapply(1:length(indv1), function(n)
  c(indv1 / (indv1 + indv2[n]))
)
rownames(M_indv1_contrib) <- indv1 
colnames(M_indv1_contrib) <- indv2

#Redo bonus_penalty column and row names as original values
bonus_penalty2 <- bonus_penalty
rownames(bonus_penalty2) <- indv1
colnames(bonus_penalty2) <- indv2

#Define empty vectors for data frame construction
primary <- vector()
second <- vector()
total_income <- vector()
indv1_contrib <- vector()
bonus <- vector()

#Create vectors for each cell in matrices
for (i in seq_along(bonus_penalty2)) {
  k <- arrayInd(i, dim(bonus_penalty2))
  primary <- c(primary, rownames(bonus_penalty2)[k[,1]])
  second <- c(second, colnames(bonus_penalty2)[k[,2]])
  total_income <- c(total_income, M_total_income[primary[i],second[i]])
  indv1_contrib <- c(indv1_contrib, M_indv1_contrib[primary[i],second[i]])
  bonus <- c(bonus, bonus_penalty2[primary[i],second[i]])
}

#Change primary and secondary earner vectors to numeric
primary <- as.numeric(primary)
second <- as.numeric(second)

#Create dataframe, filter for one-sided (contribution <= 50%), arrange by percent contribution
income_data <- data.frame(primary,second,total_income,indv1_contrib, bonus) %>% 
  filter(indv1_contrib <= 0.5) %>%
  arrange(desc(total_income))

#Rounding off contribution percentage
income_data$indv1_contrib <- round((income_data$indv1_contrib*100), digits=0)

#Create new matrix for heatmap
bonus_percent <- select(income_data, total_income, indv1_contrib, bonus) %>% 
  spread(key="total_income", value="bonus")

rownames(bonus_percent) <- bonus_percent$indv1_contrib

#Convert to matrix, remove first column
bonus_percent_map <- t(as.matrix(select(bonus_percent, -indv1_contrib)))

#Create heatmap
htmp_bonus_percent <- Heatmap(bonus_percent_map,
                      cluster_columns=FALSE,
                      column_title = "Marriage Tax Bonus: Joint Filing vs Single Filing",
                      cluster_rows=FALSE,
                      name = "Tax Bonus Amount",
                      heatmap_legend_param = list(
                        legend_height = unit(4, "cm")
                        ),
                      col= c("Red", "yellow", "greenyellow", "green", "cyan", "blue")
)
draw(htmp_bonus_percent)


