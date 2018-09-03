## Welcome to GitHub Pages

# Model Evaluation using 6 different Machine Learning Algorithms in R, for Breast Cancer dataset

## 1. Random Forest
### Load the package
>library (randomForest)
#### Read file_
>all_data <- read.csv (file='D:/model_evaluation/all_data.csv')
### Run randomForest
>all_data.rf <- randomForest (V24 ~. , data=all_data, ntree=500, mtry=5, keep.forest=FALSE, importance=TRUE)
### Print result of randomForest (OOB error and confusion matrix)
>print (all_data.rf)

## 2. Decision Tree
### Load the packages
>library (caret)
>library (rpart)
### Split data into testing and training
>intrain <- createDataPartition (y = all_data $V24, p= 0.7, list = FALSE)
>training <- all_data [intrain,]
>testing <- all_data [-intrain,]
### Train the model
>trctrl <- trainControl (method = "repeatedcv", number = 10, repeats = 3)
>dtree_fit <- train (V24 ~. , data = training, method = "rpart", parms = list (split = "information"), trControl=trctrl, tuneLength = 10)
### Prediction using testing data
>predict (dtree_fit, newdata = testing)
>test_pred <- predict (dtree_fit, newdata = testing)
### print result of randomForest (Accuracy and confusion matrix)
>confusionMatrix (test_pred, testing$V24)

## 3. Support Vector Machine (SVM)
### Load the packages
>library(caret)
### Assign the categorical variable as a factor in both training and testing sets (use training and testing sets from Decision Tree)
>training[["V24"]] = factor(training[["V24"]])
>testing[["V24"]] = factor(testing[["V24"]])
### Train the svm model
>trctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
>set.seed(3233)
>svm_Linear <- train(V24 ~., data = training, method = "svmLinear",trControl=trctrl, preProcess = c("center", "scale"),
tuneLength = 10)
>svm_Linear
### Test set prediction
>test_pred <- predict(svm_Linear, newdata = testing)
>test_pred
### Compute accuracy using confusion matrix
>confusionMatrix(test_pred, testing$V24)

## 4. Logistic Regression
### Training the dataset with lm
>lmMod <- lm(V24 ~ ., data=training) #build the model
distPred <- predict(lmMod, testing) #predict survival
>summary (lmMod)
### Test set prediction 
>actuals_preds <- data.frame(cbind(actuals=testing$V24,
predicteds=distPred)) #make actuals_predicteds dataframe
>correlation_accuracy <- cor(actuals_preds)
>head(actuals_preds)

## 5. Neural Networks
### Load packages
>library(caret)
>library(neuralnet)
### Fit neural network
>set.seed(2)
> NN = neuralnet(V24 ~ V1+V2+V3+V4+V5+V6+V7+V8+V9+V10+V11+V12+V13+V14+V15+V16+V17+V18+V19+V20+V21+V22+V23, training, hidden = 3 , linear.output = T)
### Prediction using neural network
>predict_testNN = compute(NN, testing[,c(1:23)])
>predict_testNN = (predict_testNN$net.result * (max(all_data$V24) - >min(all_data$V24))) + min(all_data$V24)
>plot(testing$V24, predict_testNN, col='blue', pch=16, ylab = "predicted rating NN", xlab = "real rating")
>abline(0,1)
### Calculate Root Mean Square Error (RMSE)
>RMSE.NN = (sum((testing$V24 - predict_testNN)^2) / nrow(testing)) ^ 0.5

## 6. Extreme Gradient Boosting
### Load packages
>library(xgboost)
>library(caret)
### Train with xgboost
>folds = createFolds(training$V24, k=10)
cv = lapply (folds, function(x){
training_fold= training[-x,]
testing_fold= testing[x,]
classifier = xgboost(data=as.matrix(training[-24]), label=training$V24, nrounds=10 )
y_pred = predict(classifier, newdata=as.matrix(testing_fold[24]))
y_pred =(y_pred >= 0.5)
cm = table(testing_fold[,24], y_pred)
accuracy = (cm[1,1] + cm[2,2]) / (cm[1,1] + cm[2,2] + cm[1,2] + cm[2,1])
return (accuracy)
})
accuracy = mean(as.numeric(cv))
