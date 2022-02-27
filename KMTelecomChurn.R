# Load the dataset
install.packages("readxl")
library(readxl)
input <- read_excel(file.choose(),1)

#input <- read_excel("E:\\360DigiTMG\\Assignment Solutions\\Telco_customer_churn.xlsx")


mydata <- input[ ,c(2:24,30)]

summary(mydata)

mydata[sapply(mydata, is.character)] <- lapply(mydata[sapply(mydata, is.character)],as.factor)

str(mydata)

install.packages("cluster")
library(cluster)



# Normalize the data
gower_data <- daisy(mydata, metric="gower") 

#gower_matrix <- as.matrix(gower_data)

summary(gower_data)

twss <- NULL

for (i in 2:8) {
  twss <- c(twss, kmeans(gower_data, centers = i)$tot.withinss)
}
twss

aggregate(mydata[, 1:24], by = list(final$membership), FUN = mean)

library(readr)
write_csv(final, "hclustoutput.csv")

getwd()