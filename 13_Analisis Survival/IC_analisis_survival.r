#Library untuk data excel
library(readxl)

#Library untuk analisis survival
library(survival)
library(survminer)

#Membaca file data excel
data <- read_excel("13_Analisis Survival/IC_Data Analisis Survival.xlsx")

#Mengecek file excel sudah dapat terbaca
head(data)

#Model dari Proportional Hazard (Multivariate)
res.cox <- coxph(Surv(usia, status) ~ gender + stadium + berat_badan + gejala, data = data)
summary(res.cox)

#Plot Cox-PH multivariate
ggsurvplot(survfit(res.cox), data = data, palette = "#2E9FDF", ggtheme = theme_minimal())
