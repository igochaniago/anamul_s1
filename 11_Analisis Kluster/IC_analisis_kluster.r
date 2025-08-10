#Library untuk data excel
library(readxl)

#Library untuk clustering
library(cluster)
library(factoextra)

#Membaca file data excel
data <- read_excel("E:/IGO Programming Project/Github Repo/11_Analisis Kluster/IC_Data Analisis Cluster.xlsx")
#data <- read_excel("11_Analisis Kluster/IC_Data Analisis Cluster.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)

#Normalisasi data (karena satuan yang berbeda)
normdata <- scale(data[2:6])
head(normdata)

#Scree Plot (menentukan jumlah kluster)
fviz_nbclust(normdata, kmeans, method = "wss") #metode elbow
fviz_nbclust(normdata, kmeans, method = "silhouette") #metode silhouette

#K-means dengan cluster = 2
final2 <- kmeans(normdata,2,nstart=25)
final2
fviz_cluster(final2, data = normdata)