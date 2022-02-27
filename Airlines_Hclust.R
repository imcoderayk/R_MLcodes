# Load the dataset
install.packages("readxl")
library(readxl)
input <- read_excel(file.choose())
mydata <- input[ , (2:12)]

summary(mydata)

# Normalize the data
normalized_data <- scale(mydata[, 1:11]) # Excluding the university name

summary(normalized_data)

# Distance matrix
d <- dist(normalized_data, method = "euclidean") 

fit <- hclust(d, method = "complete")

# Display dendrogram
plot(fit) 
plot(fit, hang = -1)

groups <- cutree(fit, k = 6) # Cut tree into 20 clusters

rect.hclust(fit, k =6 , border = "red")

membership <- as.matrix(groups)

final <- data.frame(membership, mydata)

aggregate(mydata[, 1:11], by = list(final$membership), FUN = mean)

library(readr)
write_csv(final, "hclustoutput.csv")

getwd()