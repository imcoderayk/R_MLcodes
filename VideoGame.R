library(recommenderlab)
library(reshape2)

####### Example: Data generated in class #####
videogames <-read.csv(file.choose(),header=TRUE)
str(videogames)
head(videogames)

dim(videogames)

## covert to matrix format


vg_matrix<-as.matrix(acast(videogames,userId~game,value.var ="rating",fun.aggregate = mean))

dim(vg_matrix)

## recommendarlab realRatingMatrix format
R <- as(vg_matrix, "realRatingMatrix")

rec2 = Recommender(R, method="IBCF") ## Item-based collaborative filtering
rec3 = Recommender(R, method="SVD")
rec4 = Recommender(R, method="POPULAR")
rec5 = Recommender(binarize(R,minRating=2), method="UBCF") ## binarize all 2+ rating to 1

## create n recommendations for a user
uid = 1
videogame <- subset(videogames, videogames$userId==uid)
print("You have rated:")
videogame
print("recommendations for you:")
prediction <- predict(rec2, R[uid], n=1) ## you may change the model here
as(prediction, "list")
prediction <- predict(rec2, R[uid], n=3) ## you may change the model here
as(prediction, "list")
prediction <- predict(rec3, R[uid], n=2) ## you may change the model here
as(prediction, "list")
prediction <- predict(rec4, R[uid], n=3) ## you may change the model here
as(prediction, "list")
prediction <- predict(rec5, R[uid], n=4) ## you may change the model here
as(prediction, "list")







