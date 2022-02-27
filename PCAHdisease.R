# Load the dataset
library(readr)
input <- read_csv(file.choose())
mydata <- input[ , (1:14)]

summary(mydata)

# Normalize the data
normalized_data <- scale(mydata[, 1:14]) 

summary(normalized_data)

# Distance matrix
d <- dist(normalized_data, method = "euclidean") 

fit <- hclust(d, method = "complete")

# Display dendrogram
plot(fit) 
plot(fit, hang = -1)

groups <- cutree(fit, k = 5) # Cut tree into 20 clusters

rect.hclust(fit, k =5 , border = "red")

membership <- as.matrix(groups)

final <- data.frame(membership, mydata)

aggregate(mydata[, 1:14], by = list(final$membership), FUN = mean)

data <- mydata
attach(data)

?princomp
pcaObj <- princomp(data, cor = TRUE, scores = TRUE, covmat = NULL)

str(pcaObj)
summary(pcaObj)

loadings(pcaObj)

plot(pcaObj) # graph showing importance of principal components 

biplot(pcaObj)

plot(cumsum(pcaObj$sdev * pcaObj$sdev) * 100 / (sum(pcaObj$sdev * pcaObj$sdev)), type = "b")

pcaObj$scores
pcaObj$scores[, 1:10]

# Top 3 pca scores 
final <- cbind(input[, 1], pcaObj$scores[, 1:10])
View(final)

# Scatter diagram
plot(final$Comp.1, final$Comp.2)


d1 <- dist(final, method = "euclidean") 

fit <- hclust(d1, method = "complete")

# Display dendrogram
plot(fit) 
plot(fit, hang = -1)

groups <- cutree(fit, k = 5) # Cut tree into 20 clusters

rect.hclust(fit, k =5 , border = "red")

membership <- as.matrix(groups)

final <- data.frame(membership, mydata)

aggregate(mydata[, 1:14], by = list(final$membership), FUN = mean)
