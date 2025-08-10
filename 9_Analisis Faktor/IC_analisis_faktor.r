#Library untuk data excel
library(readxl)

#Library untuk KMO
library(psych)

#Membaca file data excel
data <- read_excel("9_Analisis Faktor/IC_Data Analisis Faktor.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)

#Menentukan variabel
expect <-(data$Expect)
entertain <- (data$Entertain) 
comm <- (data$Comm)
expert <- (data$Expert)
motivate <- (data$Motivate)
caring <- (data$Caring)
charisma <- (data$Charisma)
passion <- (data$Passion)
friendly <- (data$Friendly)
model <- cbind(expect, entertain, comm, expert, motivate, caring, charisma, passion, friendly)

#Uji KMO dan Bartlett
KMO(model)
cortest.bartlett(model)

#Perbaikan model (Dilakukan apabila KMO menunjukkan nilai <0,6 dan/atau pvalue Bartlett Test >0,05)
modelfix <- cbind(entertain, comm, expert, motivate, caring, charisma, passion)
#Uji KMO dan Bartlett ulang
KMO(modelfix)
cortest.bartlett(modelfix)

#Principal Factor Analysis dengan m=2 common factors
principal.m2 <- principal(modelfix, nfactors = 2, rotate = "varimax", scores = TRUE)
principal.m2
fa.diagram(principal.m2)

#Principal Factor Analysis dengan m=3 common factors
principal.m3 <- principal(modelfix, nfactors = 3, rotate = "varimax", scores = TRUE)
principal.m3
fa.diagram(principal.m3)