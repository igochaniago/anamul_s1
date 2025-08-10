#Library untuk data excel
library(readxl)

#Library untuk analisis diskriminan
library(MASS)

#Membaca file data excel
data <- read_excel("6_Analisis Diskriminan/IC_Data Diskriminan.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)

#Membuat model dalam R
model <- lda(comparator ~ y1 + y2 + y3 + y4 + y5 +y6, data = data)
groupmean<-(model$prior%*%model$means)
constant<-(groupmean%*%model$scaling)

#Fungsi diskriminan (before standardized)
constant
model$scaling

#Simpangan baku setiap variabel
sd_var <- apply(data[, paste0("y",1:6)], 2, sd)

#Koefisien yang terstandardized
std_coef <- model$scaling *sd_var
std_coef

#Uji t-test
t_results <- lapply(data[, paste0("y", 1:6)], function(x) {
  t.test(x ~ data$comparator)
})

#Ringkasan hasil t-test
t_summary <- data.frame(
  Variable = paste0("y", 1:6),
  t_value = sapply(t_results, function(res) res$statistic),
  p_value = sapply(t_results, function(res) res$p.value)
)
t_summary


#Perbandingan poin (b) dan (c) -> dijadikan tabel
comparison <- data.frame(
  Variable = paste0("y", 1:6),
  Std_Coefficient = as.vector(std_coef),
  t_value = t_summary$t_value,
  p_value = t_summary$p_value
)
comparison
