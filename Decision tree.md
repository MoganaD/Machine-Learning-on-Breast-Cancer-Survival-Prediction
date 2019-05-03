# Decision Tree - Build decision trees to analyse important prognostic factors influencing breast cancer survival prediction
## load the packages
>library (rpart)
>library (rpart.plot)
>library (party)
## read file
>all_data <- read.csv (file='D:/model_evaluation/all_data.csv')
## compute decision tree (select variables)
>tree1 <- ctree (V24 ~ V9+V22+V23, data = all_data) #Stage, total lymph nodes, positive Lymph nodes
## Plot the decision tree
>plot (tree1)
## Repeat the steps with different clusters of data and variables
change more 

change testing