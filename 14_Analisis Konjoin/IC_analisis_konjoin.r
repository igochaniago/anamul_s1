#Library untuk data excel
library(readxl)

#Library untuk analisis konjoin
library(conjoint)

#Membaca file data excel
path <- "14_Analisis Konjoin/IC_Data Analisis Konjoin.xlsx"

#Kelompok data
profile <- read_excel(path, sheet = "Sheet1", range = "A1:D11")
dfprofile <- data.frame(profile)
survey_data <- read_excel(path, sheet = "Sheet1", range = "E1:N16")
dfsurvey_data <- data.frame(survey_data)
level <- read_excel(path, sheet = "Sheet1", range = "O1:O13")
dflevel <- data.frame(level)
survey_datapref <- read_excel(path, sheet = "Sheet1", range = "P1:P151")
dfsurvey_datapref <- data.frame(survey_datapref)

#Model dari Conjoint Analysis
Conjoint(y=dfsurvey_datapref, x=dfprofile, z=dflevel)