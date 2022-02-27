# Load the dataset
install.packages("readr")
library(readr)
input <- read_csv(file.choose())
names(input)[1] <- "US State"

mydata <- input[ , (2:5)]

summary(mydata)

# Normalize the data
normalized_data <- scale(mydata[, 1:4]) # Excluding states

summary(normalized_data)

# Distance matrix
d_crime <- dist(normalized_data, method = "euclidean") 

fit <- hclust(d, method = "complete")

# Display dendrogram
plot(fit) 
plot(fit, hang = -1)

groups_crime <- cutree(fit, k = 3) # Cut tree into 20 clusters

rect.hclust(fit, k = 3 , border = "red")

membership <- as.matrix(groups)

final <- data.frame(membership, mydata)

aggregate(mydata[, 1:11], by = list(final$membership), FUN = mean)

library(readr)
write_csv(final, "hclustoutput.csv")

getwd()