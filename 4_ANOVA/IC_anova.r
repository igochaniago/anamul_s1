#Library untuk data excel
library(readxl)

#Membaca file data excel
data <- read_excel("E:/IGO Programming Project/Github Repo/4_ANOVA/IC_Data ANOVA.xlsx")
#data <- read_excel("4_ANOVA/IC_Data ANOVA.xlsx")

#Mengecek file excel sudah dapat terbaca
head(data)
summary(data)

#Menentukan variabel
dependent_var <- cbind(data$"560CM", data$"720CM")
species <- (data$Species)
nutrient <- (data$Nutrient)

#Membuat model dalam R
modelx <- manova(dependent_var ~ species + nutrient + species*nutrient, data = data)

#Uji Two-Way MANOVA
#Pillai's Trace
summary (modelx, test="Pillai", intercept = TRUE)
#Wilk's Lambda
summary (modelx, test="Wilks", intercept = TRUE)
#Hotelling-Lawley's Trace
summary (modelx, test="Hotelling-Lawley", intercept = TRUE)
#Roy's Largest Root
summary (modelx, test="Roy", intercept = TRUE)

#Uji Two-Way ANOVA
summary.aov(modelx)