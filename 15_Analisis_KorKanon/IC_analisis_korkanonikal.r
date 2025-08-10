#Library untuk data excel
library(readxl)

#Library untuk analisis korelasi kanonikal
library(ggplot2)
library(GGally)
library(CCA)
library(CCP)

#Membaca file data excel
data <- read_excel("15_Analisis_KorKanon/IC_Data Analisis Korkanonikal.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)

#Mengelompokkan data untuk diolah
psych <- data[,1:3] #data variabel psikologi
acad <- data[,4:7] #data variabel akademik

#Model Korelasi Kanonikal
cc1 <- cc(psych, acad)
cc1$cor

#Test untuk dimensi kanonikal (Canonical Dimension)
rho <- cc1$cor

#Definisi n obs, n var pada set psikologi, dan n var pada set akademik
n <- 200 #jumlah observasi ada 200 data sesuai di excel
p <- length(psych)
q <- length(acad)

#Menghitung p-value menggunakan F-approx. pada bbrp uji statistik (untuk signifikansi dimensi)
p.asym(rho, n, p, q, tstat = "Wilks")
p.asym(rho, n, p, q, tstat = "Hotelling")
p.asym(rho, n, p, q, tstat = "Pillai")
p.asym(rho, n, p, q, tstat = "Roy")

#Koefisien Kanonikal var Psikologi terstandardisasi
std1 <- diag(sqrt(diag(cov(psych))))
std1 %*% cc1$xcoef

#Koefisien Kanonikal var Akademik terstandardisasi
std2 <- diag(sqrt(diag(cov(acad))))
std2 %*% cc1$ycoef
