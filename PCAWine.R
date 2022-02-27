library(readr)
input <- read.csv(file.choose())
mydata <- input[ ,(2:14)]

attach(mydata)

pcaObj <- princomp(mydata, cor = TRUE, scores = TRUE, covmat = NULL)

str(pcaObj)

summary(pcaObj)

?loadings
loadings(pcaObj)

plot(pcaObj) # graph showingh importance of principal components 

biplot(pcaObj)

plot(cumsum(pcaObj$sdev * pcaObj$sdev) * 100 / (sum(pcaObj$sdev * pcaObj$sdev)), type = "b")

pcaObj$scores
pcaObj$scores[, 1:3]

# Top 3 pca scores 
final <- cbind(input[, 1], pcaObj$scores[, 1:3])
View(final)

finalh <- final

# Distance matrix
d <- dist(finalh, method = "euclidean") 

fit <- hclust(d, method = "complete")

# Display dendrogram
plot(fit) 
plot(fit, hang = -1)

groups <- cutree(fit, k = 4) # Cut tree into 3 clusters

rect.hclust(fit, k =4 , border = "red")

membership <- as.matrix(groups)

mydatah<-mydata

finalhc <- data.frame(membership, mydatah)

aggregate(mydatah[, 1:13], by = list(finalhc$membership), FUN = mean)

finalk <- final

twss <- NULL
for (i in 2:8) {
  twss <- c(twss, kmeans(finalk, centers = i)$tot.withinss)
}
twss

# Look for an "elbow" in the scree plot
plot(2:8, twss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")
title(sub = "K-Means Clustering Scree-Plot")


# 3 Cluster Solution
fit <- kmeans(finalk, 3) 
str(fit)

fit$cluster
finalkm <- data.frame(fit$cluster, mydata) # Append cluster membership

aggregate(mydata[, 1:13], by = list(fit$cluster), FUN = mean)
