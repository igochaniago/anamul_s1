#Library untuk data excel
library(readxl)

#Library untuk analisis outlier -> using MVN
library(MVN)

#Membaca file data excel
data1 <- read_excel("1_Analisis Outlier/IC_Data Outlier.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data1)
head(data1)

#Mencari data yang termasuk outlier dengan metode boxplot
boxplot.stats(data1$X1)$out
boxplot.stats(data1$X2)$out
boxplot.stats(data1$X3)$out
boxplot.stats(data1$X4)$out
boxplot.stats(data1$X5)$out

#Mencari pada baris ke-? data outlier berada pada X1
out <- boxplot.stats(data1$X1)$out
out_ind <- which(data1$X1 %in% c(out))
out_ind

#Mencari pada baris ke-? data outlier berada pada X2
out <- boxplot.stats(data1$X2)$out
out_ind <- which(data1$X2 %in% c(out))
out_ind

#Mencari pada baris ke-? data outlier berada pada X3
out <- boxplot.stats(data1$X3)$out
out_ind <- which(data1$X3 %in% c(out))
out_ind

#Mencari pada baris ke-? data outlier berada pada X4
out <- boxplot.stats(data1$X4)$out
out_ind <- which(data1$X4 %in% c(out))
out_ind

#Mencari pada baris ke-? data outlier berada pada X5
out <- boxplot.stats(data1$X5)$out
out_ind <- which(data1$X5 %in% c(out))
out_ind

#Menampilkan boxplot
boxplot(data1)

#Mendeteksi outlier menggunakan quantile method <- Mahalanobis distance
outlier_quant <- mv_outlier(data=data1, method = "quan")
outlier_quant$outlier
outlier_quant$qq_outlier_plot

#Mendeteksi outlier menggunakan quantile method <- Adjusted Mahalanobis distance
outlier_adj <- mv_outlier(data=data1, method = "adj")
outlier_adj$outlier
outlier_adj$qq_outlier_plot


