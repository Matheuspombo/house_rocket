install.packages("randomForest")
library (randomForest)
library(tidyverse)
library(dplyr)


houserocket <- read.csv("kc_house_data.csv")

str (houserocket)

preco.rf <- randomForest(price ~ ., data = houserocket, mtry = 3,
                         importance = TRUE, na.action = na.omit)
print(preco.rf)

plot(preco.rf)
