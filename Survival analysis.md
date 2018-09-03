# Survival analysis in R- Plot survival curves to analyse the survival time of breast cancer patients
## load the packages
> library(GGally)
> library(ggplot2)
> library(survival)
## read file
>all_data <- read.csv (file='D:/model_evaluation/all_data.csv')
## Choose variables to predict the survival time
> sc.stage<-survfit(Surv(Survival_years,Event = = 0)~V9,
data= all_data)
## Plot survival curve
> ggsurv(ethnicity)
Repeat the steps for all the important variables.
