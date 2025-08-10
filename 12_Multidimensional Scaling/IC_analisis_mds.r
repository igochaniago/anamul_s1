#Library untuk data excel
library(readxl)

#Library untuk MDS
library(magrittr)
library(dplyr)
library(ggpubr)
library(MASS)

#Membaca file data excel
data <- read_excel("12_Multidimensional Scaling/IC_Data MDS.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)

#Subset data -> Untuk mengambil data x1-x6 tanpa kolom responden
DataNumeric = subset(data, select=c(2,3,4,5,6,7))
head(DataNumeric)

#Matrix dari data
DataNumericMatrix = as.matrix(DataNumeric)
print(DataNumericMatrix)
print(cor(DataNumeric))

#Buat dendogram
plot(hclust(as.dist(1-cor(DataNumeric))))

#Chart
rownames(data, do.NULL = TRUE,prefix = "1" )
Datax <- data[,-1]
Datax <- as.matrix(data)

#Mencari solusi MDS 
#Kruskal's non-metric multidimensional scalling
# Komputasi MDS
mds <- data %>%
  dist() %>%          
  cmdscale() %>%
  as_tibble()
colnames(mds) <- c("Dim.1", "Dim.2")
# Plot MDS
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(data),
          size = 1,
          repel = TRUE)

# K-means clustering agar terlihat kluster akhir
clust <- kmeans(mds, 3)$cluster %>%
  as.factor()
mds <- mds %>%
  mutate(groups = clust)
# Plot and color by groups
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(data),
          color = "groups",
          palette = "jco",
          size = 1, 
          ellipse = TRUE,
          ellipse.type = "convex",
          repel = TRUE)
