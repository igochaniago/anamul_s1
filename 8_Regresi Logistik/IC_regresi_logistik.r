#Library untuk data excel
library(readxl)

#Library untuk multicollinearity test
library(mctest)
#Library untuk autocorrelation test dan heteroscedasticity test
library(lmtest)
#Library untuk Hosmer-Lemeshow Test
library(vcdExtra)

#Membaca file data excel
data <- read_excel("E:/IGO Programming Project/Github Repo/8_Regresi Logistik/IC_Data Regresi Logistik.xlsx")
#data <- read_excel("8_Regresi Logistik/IC_Data Regresi Logistik.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)

#Menentukan variabel
x1 <-(data$x_1)
x2 <- (data$x_2) 
dependent_var <- (data$y)

#Membuat model
model <- glm(dependent_var ~ x1 + x2, family=binomial(link='logit'), data = data)

#Multicollinearity Test
omcdiag(model)
#Autocorrelation Test -> Durbin-Watson's Test
lmtest::dwtest(model)
#Heteroscedasticity Test -> Breusch-Pagan's Test
lmtest::bptest(model)

#Regresi Logistik
summary(model)

#Mengecek kesesuaian model dengan Hosmer-Lemeshow Test
HLtest(model)