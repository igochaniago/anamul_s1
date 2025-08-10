#Library untuk data excel
library(readxl)

#Library untuk SEM
library(semPlot)
library(lavaan)

#Membaca file data excel
data <- read_excel("10_SEM/IC_Data SEM.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)

#Struktur SEM
model <- 'harga =~ x1+x2+x3
pelayanan =~ x4+x5+x6
kepuasan_pelanggan =~ x7+x8+x9
kesetiaan_pelanggan =~ x10+x11+x12
kepuasan_pelanggan ~ harga+pelayanan
kesetiaan_pelanggan ~ kepuasan_pelanggan
'

#Model Fit
fitsem <- sem(model, data = data)
fitcfa <- cfa(model, data = data)
summary (fitsem, standardized=TRUE)
summary (fitcfa, standardized=TRUE)

#Bentuk Model
semPaths(fitcfa, what = "std")
semPaths(fitsem, what = "std")

#Uji goodness of fit model structural
fitmeasures(fitsem,c("chisq","gfi","agfi","ifi","tli","cfi","nfi","rmsea"))
