# What Happened to the Marriage Penalty?
##Joint vs Single Tax Filing Visualization Before and After the Tax Cuts and Jobs Act

### Summary

I recently got married! I'm also trying to brush off some of my knowledge of the R programming language. Naturally the first thing I thought to do was try and visualize how my new marital status would affect my tax return! I know! It's true! Married life can be **SO** exciting!

But...I found something interesting. What I didn't know was that **the 2017 Tax Cut act dramatically changed the effects of marriage on _some people's_ taxes.** See below for details!

Anyways this project performs a simulation of two married individuals (**without children and neither of which is self employed**) in the USA pooling their annual earnings over a range of potential incomes and either filing their taxes separately or jointly. I created two R scripts titled single_tax.R and joint_tax.R which takes the gross income as an argument, as well as the deductions you are claiming, and then uses the current (or 2017) US tax brackets (found in .csv file) to calculate federal income, social security, and medicare tax for either single or joint filings respectively. The simulation and visualization occurs in the Tax_data or Tax_data2017 files.

The Tax_data.R files are where I perform the simulation and visualize the results in heatmaps of pooled income on both total tax amounts paid and the bonus (or penalty) of filing jointly.

This was just a fun first individual project to get me into using R, but happy to hear any suggestions for improvement!

### Results

First I plotted the total taxes owed for filings in 2019. These graphs are pretty straight forward, but show you the gradual increase of income/payroll taxes as total earnings increases for both single and joint tax filing.

![2019 Total Tax Owed](https://raw.githubusercontent.com/jrose835/Joint_Tax_Project/master/Total_Tax_Owed_2019.png)

Getting a little more interesting, I then calculated the "marriage bonus" by subtracting the taxes owed when joint filing from those with the same total income but two separate tax filings to generate the heatmap below:

##### Here's 2019's results
![2019 Marriage Bonus Heatmap](https://raw.githubusercontent.com/jrose835/Joint_Tax_Project/master/htmp_bonus_2019.png)

As you can see the bonus is highest when incomes are asymmetrical (i.e. one earner has significantly higher salary than the other). The bonus ranged from $0 all the way up to ~ $26,000 a year for those higher earners with spouses who make a lot less.  

But what about this marriage penalty thing I've heard about? Technically it is possible for joint filers to owe more but it doesn't seem to be happening much here.

Let's compare the same heatmap using the 2017 tax brackets (before the tax cut act of that year took effect):

##### Bonus/Penalty in 2017

![2017 Marriage Bonus Heatmap](https://raw.githubusercontent.com/jrose835/Joint_Tax_Project/master/htmp_bonus_2017.png)

Wow! There's a bit more red here! It would seem there **was** a bit of a penalty for those married couples each making more than $175K respectively that filed taxes jointly.

Here's another way of looking at the differences by plotting the simulation by total joint income and percent contribution of one of the two individual earners for both of the two years.

| ##### 2017 | ##### 2019 |
| ----- | ----- |
| ![2017 Contribution Plot](https://raw.githubusercontent.com/jrose835/Joint_Tax_Project/master/ContributionPlot_2017.png) | ![2019 Contribution Plot](https://raw.githubusercontent.com/jrose835/Joint_Tax_Project/master/ContributionPlot_2019.png) |

### Description of Files
* US_taxbracket_2019.csv -- A simple table with the 2019 US tax brackets
* single_tax.R -- R script for calculing single tax filing giving adjusted gross income
* joint_tax.R -- Same as single but for joint filing
* Tax_data3.R -- current version of simulation and visualization code
