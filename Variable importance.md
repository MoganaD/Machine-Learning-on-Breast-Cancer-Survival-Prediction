# Variable importance using Random Forest in R- To determine important prognostic factors affecting breast cancer survival rate
## 1. Random Forest – VSURF
### load the packages
>library (randomForest)
>library (VSURF)
### read file
>all_data <- read.csv (file='D:/model_evaluation/all_data.csv')
### run VSURF
>bc.vsurf <- VSURF(bc[,1:23], bc[,24], mtry=5)
### Plot Variable Importance plot
>vsurf1 <- plot(bc.vsurf, step="thres", imp.sd=FALSE,var.names=TRUE)
## Repeat the steps in (1) for the clusters of Data
## 2. Random Forest – randomForestExplainer
### load the packages
>library(randomForest)
>library(randomForestExplainer)
### run Random Forest
>all_data.rf <- randomForest (V24 ~. , data=all_data, ntree=500, mtry=5, keep.forest=FALSE, importance=TRUE)
### Plot the variable importance with minimal depth distribution
>min_depth_frame <- min_depth_distribution(all_data.rf)
>save(min_depth_frame, file = "min_depth_frame.rda")
>load("min_depth_frame.rda")
>head(min_depth_frame, n = 10)
>plot_min_depth_distribution(min_depth_frame)
### Plot multi-way importance plot
>importance_frame <- measure_importance(all_data.rf)
>save(importance_frame, file = "importance_frame.rda")
>load("importance_frame.rda")
>importance_frame
>(vars <- important_variables(importance_frame, k = 5, measures = c("mean_min_depth", "no_of_trees")))
>plot_multi_way_importance(importance_frame, size_measure = "no_of_nodes")
Repeat the steps in (2) for the clusters of Data
## 3. Variable importance using Random Forest
### load the packages
>library(randomForest)
>library(randomForestExplainer)
### run Random Forest
>all_data.rf <- randomForest (V24 ~. , data=all_data, ntree=500, mtry=5, keep.forest=FALSE, importance=TRUE)
### Plot variable importance
>varImpPlot(all_data.rf)
Repeat the steps in (3) for the clusters of Data
