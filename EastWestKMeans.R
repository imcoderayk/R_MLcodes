install.packages("readxl")
library(readxl)
input <- read_excel(file.choose())
mydata <- input[, (2:12)]

# Normalize the data
normalized_data <- scale(mydata[, 1:11])

# Elbow curve to decide the k value
twss <- NULL
for (i in 2:8) {
  twss <- c(twss, kmeans(normalized_data, centers = i)$tot.withinss)
}
twss

# Look for an "elbow" in the scree plot
plot(2:8, twss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")
title(sub = "K-Means Clustering Scree-Plot")


# 3 Cluster Solution
fit <- kmeans(normalized_data, 3) 
str(fit)
#betweenss   : num 12977
#tot.withinss: num 31001

# 6 Cluster Solution
fit <- kmeans(normalized_data, 6) 
str(fit)
#betweenss : num 18303
#Hence k=3 is the solution 

fit <- kmeans(normalized_data, 3) 
str(fit)

fit$cluster
final <- data.frame(fit$cluster, mydata) # Append cluster membership

aggregate(mydata[, 1:1], by = list(fit$cluster), FUN = mean)
