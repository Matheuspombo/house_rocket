install.packages("randomForest")
install.packages("h2o")
install.packages("ranger")
install.packages("caret")
install.packages("rsample")


library(tidyverse)
library(dplyr)
library(rsample)      # data splitting 
library(randomForest) # basic implementation
library(ranger)       # a faster implementation of randomForest
library(caret)        # an aggregator package for performing many machine learning models
library(h2o)          # an extremely fast java-based platform

#criar base de dados
houserocket <- read.csv("kc_house_data.csv")

#visualizar tipos de vari?veis
str (houserocket)

#Criar modelo de ML
set.seed(123)
houserocket_split <- initial_split(houserocket, prop = .7)
#Treino
treno <- training(houserocket_split)
#Teste
teste <- testing(houserocket_split)


preco.rf <- randomForest(price ~ ., data = houserocket, mtry = 3,
                         importance = TRUE, na.action = na.omit)

#Criar coluna de predicao com base nas observacoes adjacentes
predi <- predict(preco.rf, newdata = teste)

teste1 <- mutate(teste, predicao=predi)
teste1 <- teste1[,c(1,2, 3,22,4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
                    15, 16, 17, 18, 19, 20, 21)]

ggplot(data=teste1, aes(x=grade, y=price, group=1)) +
  geom_line()+
  geom_point()



view(predi)  

#View na base de dados com a coluna de predicao

#Visualizar 
print(preco.rf)

plot(preco.rf)
