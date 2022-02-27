library(recommenderlab)
library(reshape2)

####### Example: Data generated in class #####
movies <-read.csv(file.choose())
str(movies)
head(movies)

dim(movies)
colnames(movies)
## covert to matrix format


movies_matrix<-as.matrix(acast(movies,ï..UserId~Reviews,value.var="Reviews",fun.aggregate = mean))

dim(movies_matrix)

## recommendarlab realRatingMatrix format
R <- as(movies_matrix, "realRatingMatrix")

rec1 = Recommender(R, method="UBCF") ## User-based collaborative filtering


rec5 = Recommender(binarize(R,minRating=2), method="UBCF") ## binarize all 2+ rating to 1

## create n recommendations for a user
uid = 1123
movie <- subset(movies, movies$ï..UserId==uid)
print("You have rated:")
movie
print("recommendations for you:")
prediction <- predict(rec1, R[uid], n=1) ## you may change the model here
as(prediction, "list")
prediction <- predict(rec5, R[uid], n=3) ## you may change the model here
as(prediction, "list")







