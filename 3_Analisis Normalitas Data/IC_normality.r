#Library untuk data excel
library(readxl)

#Library untuk normality test
library(MVN)

#Membaca file data excel "normality data" -> sesuaikan dengan file masing2
data <- read_excel("3_Analisis Normalitas Data/IC_Data Uji Normal.xlsx")

#Mengecek file excel sudah dapat terbaca
head(data)
summary(data)

#Menguji normalitas data dengan metode "Histogram"
univariate_diagnostic_plot(data, type="histogram", title=NULL, interactive=FALSE)

#Menguji normalitas data dengan metode "Lilliefors' Test" -> Univariate
test_univariate_normality(data, test="Lillie")

#Menguji normalitas data dengan metode "Shapiro-Wilk's Test" -> Univariate
test_univariate_normality(data, test="SW")

#Menguji normalitas data dengan metode "Anderson-Darling's Test" -> Univariate
test_univariate_normality(data, test="AD")

#Menguji normalitas data dengan metode "Mardia's Test" -> Multivariate
mardia(data)

#Menguji normalitas data dengan metode "Henze-Zirkler's Test" -> Multivariate
hz(data)

#Menguji normalitas data dengan metode "Royston's Test" -> Multivariate
royston(data)

#Menguji normalitas data dengan metode "Doornik-Hansen's Test" -> Multivariate
doornik_hansen(data)

#Menguji normalitas data dengan metode "Energy Test" -> Multivariate
energy(data)