#Script for combining dataframes of tax data generated from earlier scripts for comparison purposes

library(tidyverse)

theme_set(theme_gray()+ theme(axis.line = element_line(size=0.5),panel.background = element_rect(fill=NA,size=rel(20)), panel.grid.minor = element_line(colour = NA), axis.text = element_text(size=16), axis.title = element_text(size=18)))

#Read dataframes from csv files
tax_2017 <- read.csv("tax_data_2017.csv", sep=",", header=TRUE) %>% mutate(Year = "2017")
tax_2019 <- read.csv("tax_data_2019.csv", sep=",", header=TRUE) %>% mutate(Year = "2019")
tax_data <- rbind(tax_2017, tax_2019)

p <- ggplot(tax_data, aes(x=bonus, color=Year))
p + geom_density() + scale_y_continuous(name="Count", labels = NULL)
p2 <- ggplot(tax_data, aes(x=Year, y=bonus))
p2 + geom_boxplot()
p2 + geom_violin()
