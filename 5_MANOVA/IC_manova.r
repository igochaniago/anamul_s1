#Library untuk data excel
library(readxl)

#Membaca file data excel
data <- read_excel("5_MANOVA/IC_Data MANOVA.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)

#Menentukan variabel
dependent_var <- cbind(data$y1, data$y2, data$y3, data$y4)
sowing_date <- (data$sowing_date)
variety <- (data$variety)

#Membuat model dalam R
model <- manova(dependent_var ~ factor(sowing_date) + factor(variety) + factor(sowing_date*variety), data = data)

#Uji Two-Way MANOVA (5a)
#Pillai's Trace
print("Uji Pillai's Trace")
summary (model, test="Pillai", intercept = TRUE)
#Wilk's Lambda
print("Uji Wilk's Lambda")
summary (model, test="Wilks", intercept = TRUE)
#Hotelling-Lawley's Trace
print("Uji Hotelling-Lawley's Trace")
summary (model, test="Hotelling-Lawley", intercept = TRUE)
#Roy's Largest Root
print("Uji Roy's Largest Root")
summary (model, test="Roy", intercept = TRUE)

#Uji F-test (5b)
y1 <- (data$y1)
y2 <- (data$y2)
y3 <- (data$y3)
y4 <- (data$y4)
#F-test untuk y1 dengan y2
var.test (y1,y2)
#F-test untuk y1 dengan y3
var.test (y1,y3)
#F-test untuk y1 dengan y4
var.test (y1,y4)
#F-test untuk y2 dengan y3
var.test (y2,y3)
#F-test untuk y2 dengan y4
var.test (y2,y4)
#F-test untuk y3 dengan y4
var.test (y3,y4)

#Uji ANOVA (lanjutan 5b)
summary.aov(model)

#uji untuk test of significance (5c)
y34 <- cbind(data$y3, data$y4)
y1 <- (data$y1)
y2 <- (data$y2)
modelx <- manova(y34 ~ y1 + y2 + y1*y2, data = data)
#Pillai's Trace
print("Uji Pillai's Trace")
summary (modelx, test="Pillai", intercept = TRUE)
#Wilk's Lambda
print("Uji Wilk's Lambda")
summary (modelx, test="Wilks", intercept = TRUE)
#Hotelling-Lawley's Trace
print("Uji Hotelling-Lawley's Trace")
summary (modelx, test="Hotelling-Lawley", intercept = TRUE)
#Roy's Largest Root
print("Uji Roy's Largest Root")
summary (modelx, test="Roy", intercept = TRUE)

#uji untuk test of significance each variable (5d)
y1234 <- cbind(data$y1, data$y2, data$y3, data$y4)
y1 <- (data$y1)
y2 <- (data$y2)
y3 <- (data$y3)
y4 <- (data$y4)
modely <- manova(y1234 ~ y1 + y2 + y3 + y4 + y1*y2*y3*y4, data = data)
summary.aov(modely)
