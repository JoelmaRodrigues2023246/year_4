# 1. Feature Ranking (Boston Housing Dataset)

# Loading necessary packages
suppressWarnings(
     suppressMessages(if (!require(FSelector, quietly=TRUE)) install.packages("FSelector"))
)
library(FSelector)

# Load the Boston Housing dataset
path <- "F:/CCT/CCT/Data Exploration & Preparation/Git_Control/Data_ExplorationAndPreparation/Tutorial_6/datasets/BostonHousing.csv"  # Change this to your dataset path
Dataset <- read.csv(path, sep = ",", dec = ".", row.names = 1)
Dataset <- Dataset[-4]  # Remove the 4th column if not needed
str(Dataset)  # Check the structure of the data
head(Dataset)  # Display the first few rows

# Feature Ranking using Pearson correlation
Scores <- linear.correlation(medv ~ ., Dataset)
print(Scores)

# Selecting the top 5 features
Subset <- cutoff.k(Scores, 5)
print(as.data.frame(Subset))

# Selecting 40% of the best features
Subset2 <- cutoff.k.percent(Scores, 0.4)
print(as.data.frame(Subset2))

# Feature ranking using Information Gain
Scores2 <- information.gain(medv ~ ., Dataset)
Subset3 <- cutoff.k(Scores2, 5)
print(as.data.frame(Subset3))


# 2. Embedded Methods (Iris Dataset)

# Install and load wskm package
install.packages("wskm")
library(wskm)

# Set a random seed for reproducibility
set.seed(2)

# Apply ewkm clustering to the Iris dataset (excluding Species column)
model <- ewkm(iris[1:4], 3, lambda=2, maxiter=1000)
print(model)

# Load the cluster package to visualize the results
suppressWarnings(
     suppressMessages(if (!require(cluster, quietly=TRUE)) install.packages("cluster"))
)
library(cluster)

# Create a cluster plot
clusplot(iris[1:4], model$cluster, color=TRUE, shade=TRUE, labels=2, lines=1, 
         main='Cluster Analysis for Iris using ewkm package')

# --------------------------------------------

# 3. Wrapper Methods (Synthetic Dataset)

# Loading the required packages
install.packages("clustvarsel")
install.packages("mclust")
library(clustvarsel)
library(mclust)

# Reading a synthetic dataset (change the path to your dataset location)
path <- "F:/CCT/CCT/Data Exploration & Preparation/Git_Control/Data_ExplorationAndPreparation/Tutorial_6/datasets/syntheticdata.csv"
Dataset <- read.csv(path, sep=",", dec=".", row.names=1)
head(Dataset)

# Applying the clustvarsel method
out <- clustvarsel(Dataset, G = 1:5)
print(out$subset)

# Fitting the clustering model using the selected features
Subset1 <- Dataset[,out$subset]
mod <- Mclust(Subset1, G = 1:5)
summary(mod)

# Plotting the clustering results
plot(mod, what = "classification")

# Loading Data
path <- "F:/CCT/CCT/Data Exploration & Preparation/Git_Control/Data_ExplorationAndPreparation/Tutorial_6/datasets/BostonHousing.csv"
Dataset <- read.csv(path, sep = ",", dec = ".", row.names = 1)
Dataset <- Dataset[-4]
head(Dataset, 3)

# Installing required packages
install.packages("caret")
install.packages("corrplot")
library(caret)
library(corrplot)

# Calculate correlation matrix
correlationMatrix <- cor(Dataset)

# Find attributes that are highly correlated
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.75)
highlyCorrelated

# Display highly correlated attributes
names(Dataset[,highlyCorrelated])

# Removing redundant features
Dataset2 <- Dataset[,-highlyCorrelated]

# Comparing correlation graphs
par(mfrow = c(1, 2))
corrplot(correlationMatrix, order = "hclust")
corrplot(cor(Dataset2), order = "hclust")

# ----------------------------

# 4. Filter Methods (Boston Housing Dataset)

# Loading Data
path <- "F:/CCT/CCT/Data Exploration & Preparation/Git_Control/Data_ExplorationAndPreparation/Tutorial_6/datasets/BostonHousing.csv"
Dataset <- read.csv(path, sep = ",", dec = ".", row.names = 1)
Dataset <- Dataset[-4]
head(Dataset, 3)

# Installing required packages
install.packages("caret")
install.packages("corrplot")
library(caret)
library(corrplot)

# Calculate correlation matrix
correlationMatrix <- cor(Dataset)

# Find attributes that are highly correlated
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.75)
highlyCorrelated

# Display highly correlated attributes
names(Dataset[,highlyCorrelated])

# Removing redundant features
Dataset2 <- Dataset[,-highlyCorrelated]

# Comparing correlation graphs
par(mfrow = c(1, 2))
corrplot(correlationMatrix, order = "hclust")
corrplot(cor(Dataset2), order = "hclust")

