#The goal of this project is to create a heatmap of tax filings for two individuals with varying gross income levels
#It provides heatmaps for both single filing and married filing status as well as the "marriage bonus"
#Jrose 23May19

#Load Packages
library(ComplexHeatmap)
library(circlize)

#Creating variables for range of incomes
indv1_low <- 15000
indv1_high <- 200000
indv2_low <- 15000
indv2_high <- 200000
increment <- 5000

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
        name = "Bonus $",
        col= c("Red", "yellow", "greenyellow", "green", "cyan", "blue")
        )

#png(file="htmp_bonus.png")
draw(htmp_bonus)
#dev.off()

#Just playing around...
#htmp_bonus2 <- Heatmap(bonus_penalty,
#        cluster_columns=FALSE,
#        column_title = "Marriage Tax Bonus: Joint Filing vs Single Filing",
#        cluster_rows=FALSE,
#        name = "Bonus $",
#        col= c("Red", "yellow", "greenyellow", "green", "cyan", "blue"),
#        cell_fun = function(j, i, x, y, width, height, fill) {
#          if(small_mat[i, j] == 0)
#            grid.text(sprintf("%.1f", small_mat[i, j]), x, y, gp = gpar(fontsize = 10))
#        }
#)