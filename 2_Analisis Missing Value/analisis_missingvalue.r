#Library untuk read dan write data excel
library(readxl) 
library(writexl)

#library untuk melakukan imputation
library(VIM)

#Membaca file data excel "missing data"
data <- read_excel("2_Analisis Missing Value/IC_Data Missing.xlsx") 

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)

#Mencari missing data dalam file excel "missing data"
is.na(data)

#Jumlah dari missing data menurut kolom
colSums(is.na(data))

#=======MEAN IMPUTATION==========
#Mengganti data yang hilang (missing data) dengan metode Mean Imputation
data$Assignment = ifelse(is.na(data$Assignment),ave(data$Assignment, FUN = function(x)mean(x, na.rm = TRUE)), data$Assignment)
data$Tutorial = ifelse(is.na(data$Tutorial),ave(data$Tutorial, FUN = function(x)mean(x, na.rm = TRUE)), data$Tutorial)
data$Midterm = ifelse(is.na(data$Midterm),ave(data$Midterm, FUN = function(x)mean(x, na.rm = TRUE)), data$Midterm)
data$TakeHome = ifelse(is.na(data$TakeHome),ave(data$TakeHome,FUN = function(x)mean(x, na.rm = TRUE)), data$TakeHome)

#Export data hasil mean imputation dari R ke Excel
write_xlsx(data, "E:/IGO Programming Project/Github Repo/2_Analisis Missing Value/IC_Data Missing_AfterMeanImp.xlsx")
#write_xlsx(data, "2_Analisis Missing Value/IC_Data Missing_AfterMeanImp.xlsx") 

#Cek apakah masih ada missing data dalam file excel terbaru
is.na(data)
colSums(is.na(data))

#=======kNN IMPUTATION==========
#Membaca file data excel "missing data"
data2 <- read_excel("2_Analisis Missing Value/IC_Data Missing.xlsx") 

#Mengecek file excel sudah dapat terbaca
View(data2)
head(data2)

#Mencari missing data dalam file excel "missing data"
is.na(data2)

#Jumlah dari missing data menurut kolom
colSums(is.na(data2))

#Mengganti data yang hilang (missing data) dengan metode kNN Imputation
hasildata2 <- kNN(data2, k = 9)

#Export data hasil kNN Imputation dari R ke Excel
write_xlsx(data, "2_Analisis Missing Value/IC_Data Missing_AfterkNNImp.xlsx")

#Cek apakah masih ada missing data dalam file excel terbaru
is.na(hasildata2)

colSums(is.na(hasildata2))
