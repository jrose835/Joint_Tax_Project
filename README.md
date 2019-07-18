# Joint vs Single Tax Filing Visualization

### Summary

I recently got married! I'm also trying to brush off some of my knowledge of the R programming language. Naturally the first thing I thought to do was try and visualize how my new marital status would affect my tax return! I know! It's true! Married life can be **SO** exciting!

Anyways this project performs a simulation of two individuals in the USA pooling their annual earnings over a range of potential incomes and either filing their taxes separately or jointly. I created two small R scripts titled single_tax.R and joint_tax.R which takes the adjusted gross income as an argument and uses the current US tax brackets (found in US_taxbracket_2019.csv) to calculate federal income tax for either single or joint filings respectively.

The Tax_data.R files are where I perform the simulation and visualize the results in heatmaps of pooled income on both total tax amounts paid and the bonus (or penalty) of filing jointly.

This was just a fun first project to get me back into using R after a long while of dormancy, but happy to hear any suggestions for improvement!

### Results

Check back soon!

### Description of Files
* US_taxbracket_2019.csv -- A simple table with the 2019 US tax brackets
* single_tax.R -- R script for calculing single tax filing giving adjusted gross income
* joint_tax.R -- Same as single but for joint filing
* Tax_data3.R -- current version of simulation and visualization code
