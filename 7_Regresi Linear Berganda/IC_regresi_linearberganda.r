#Library untuk data excel
library(readxl)

#Library untuk multicollinearity test
library(mctest)
#Library untuk autocorrelation test dan heteroscedasticity test
library(lmtest)

#Membaca file data excel
data <- read_excel ("7_Regresi Linear Berganda/IC_Data Regresi Linear Berganda.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)

#Menentukan variabel
meanoutsidetemp <-(data$meanoutsidetemp)
attic <- (data$attic_insulation) 
age <- (data$age_furnace)
dependent_var <- (data$heating_cost)

#Membuat model
model <- lm(dependent_var ~ meanoutsidetemp + attic + age, data = data) 

#Multicollinearity Test 
omcdiag(model)
#Autocorrelation Test -> Durbin-Watson's Test
lmtest::dwtest(model)
#Heteroscedasticity Test -> Breusch-Pagan's Test
lmtest::bptest(model)

#Lakukan Regresi Linear Berganda
summary(model)

#Perbaiki model (karena terdapat variabel insignifikan -> x3 (age))
modelfix <- lm(dependent_var ~ meanoutsidetemp + attic, data = data)

#Regresi Linear Berganda (ulang)
summary(modelfix)