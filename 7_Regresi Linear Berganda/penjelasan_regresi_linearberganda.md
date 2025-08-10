Analisis Regresi Linear Berganda
================

**Analisis regresi linear berganda** adalah metode statistik yang
digunakan untuk mempelajari hubungan antara satu variabel terikat dengan
dua atau lebih variabel bebas dalam bentuk persamaan linear, dengan
tujuan memprediksi nilai variabel terikat serta mengukur besarnya
pengaruh setiap variabel bebas.

## Persoalan

Soal:

Lakukan analisis regresi linear berganda (Refer to IC_Data Regresi
Linear Berganda.xlsx)

Terdapat 25 data dengan 4 variabel.

a\. Apa itu variabel dependen dan independen

b\. Apa itu persamaan regresi

c\. Jika mean outside temperature di Januari adalah 30 derajat, dan
terdapat 5 inch insulation in attic, dan umur furnace 10 tahun.
Berapakah heating cost-nya?

d\. Berapa koefisien regresi dari mean outside temperature? Apa
hubungannya dengan heating cost?

e\. Jika kita menaikkan temperature sebesar 1 derajat dan variabel
lainnya konstan, apa yang akan terjadi ke heating cost?

f\. Jika mean temperature di Boston adalah 25 derajat dan di
Philadelphia 35 derajat, serta variabel lainnya tetap. Apa yang akan
terjadi ke heating cost?

g\. Berapa koefisien regresi untuk attic insulation? Apa hubungannya
dengan heating cost?

h\. Berapa koefisien regresi untuk umur furnace? Apa hubungannya dengan
heating cost?

## Coding

### Library dan Read Data

``` r
#Library untuk data excel
library(readxl)

#Library untuk multicollinearity test
library(mctest)
#Library untuk autocorrelation test dan heteroscedasticity test
library(lmtest)
```

    ## Loading required package: zoo

    ## 
    ## Attaching package: 'zoo'

    ## The following objects are masked from 'package:base':
    ## 
    ##     as.Date, as.Date.numeric

``` r
#Membaca file data excel
data <- read_excel("E:/IGO Programming Project/Github Repo/7_Regresi Linear Berganda/IC_Data Regresi Linear Berganda.xlsx")
#data <- read_excel ("7_Regresi Linear Berganda/IC_Data Regresi Linear Berganda.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)
```

    ## # A tibble: 6 × 5
    ##    home heating_cost meanoutsidetemp attic_insulation age_furnace
    ##   <dbl>        <dbl>           <dbl>            <dbl>       <dbl>
    ## 1     1          250              35                3           6
    ## 2     2          360              29                4          10
    ## 3     3          165              36                7           3
    ## 4     4           43              60                6           9
    ## 5     5           92              65                5           6
    ## 6     6          200              30                5           5

Dari sini terlihat bahwa data sudah terbaca dengan baik, di mana
terdapat 4 variabel (“heating_cost”, “meanoutsidetemp”,
“attic_insulation”, “age_furnace”) dengan 25 baris data.

### Mendefinisikan Variabel dan Membuat Model

``` r
#Menentukan variabel
meanoutsidetemp <-(data$meanoutsidetemp)
attic <- (data$attic_insulation) 
age <- (data$age_furnace)
dependent_var <- (data$heating_cost)

#Membuat model
model <- lm(dependent_var ~ meanoutsidetemp + attic + age, data = data) 
```

Berikut ini kita definisikan variabelnya dan membuat model regresinya

### Jawaban Soal A: Definisi Variabel Dependen dan Independen

**Variabel dependen** adalah variabel yang nilainya dipengaruhi atau
dijelaskan oleh variabel lain dalam analisis. Dalam hal ini,
“heating_cost” merupakan variabel dependen.

Sedangkan variabel independen adalah variabel yang memengaruhi atau
digunakan untuk menjelaskan variabel dependen. Dalam hal ini,
“meanoutsidetemp”, “attic_insulation”, dan “age_furnace” merupakan
variabel independen.

### Jawaban Soal B: Persamaan Regresi

Persamaan regresi adalah rumus matematika yang menggambarkan hubungan
antara variabel dependen dan satu atau lebih variabel independen,
digunakan untuk memprediksi nilai variabel dependen berdasarkan nilai
variabel independen.

#### Uji Asumsi Klasik

Sebelum dilakukan regresi, dataset perlu diuji terlebih dahulu dengan 3
uji asumsi klasik, yaitu: Uji multikolinearitas, uji autokorelasi, dan
uji heteroskedastisitas. Pengujiannya sebagai berikut:

##### Uji Multikolinearitas

``` r
#Multicollinearity Test 
omcdiag(model)
```

    ## 
    ## Call:
    ## omcdiag(mod = model)
    ## 
    ## 
    ## Overall Multicollinearity Diagnostics
    ## 
    ##                        MC Results detection
    ## Determinant |X'X|:         0.7776         0
    ## Farrar Chi-Square:         5.5772         0
    ## Red Indicator:             0.2720         0
    ## Sum of Lambda Inverse:     3.5729         0
    ## Theil's Method:           -1.1269         0
    ## Condition Number:         11.7106         0
    ## 
    ## 1 --> COLLINEARITY is detected by the test 
    ## 0 --> COLLINEARITY is not detected by the test

Berdasarkan hasil di atas, tidak ditemukan multikolinearitas pada
keseluruhan metode.

##### Uji Autokorelasi

``` r
#Autocorrelation Test -> Durbin-Watson's Test
lmtest::dwtest(model)
```

    ## 
    ##  Durbin-Watson test
    ## 
    ## data:  model
    ## DW = 2.1655, p-value = 0.6861
    ## alternative hypothesis: true autocorrelation is greater than 0

Berdasarkan hasil di atas, DW test menunjukkan p-value \>0.05, sehingga
dataset dianggap bebas dari autokorelasi.

##### Uji Heteroskedastisitas

``` r
#Heteroscedasticity Test -> Breusch-Pagan's Test
lmtest::bptest(model)
```

    ## 
    ##  studentized Breusch-Pagan test
    ## 
    ## data:  model
    ## BP = 3.0099, df = 3, p-value = 0.3901

Berdasarkan hasil di atas, BP test menunjukkan p-value \>0.05, sehingga
dataset dianggap bebas dari heteroskedastisitas.

##### Kesimpulan Hasil Uji Asumsi Klasik

Sehingga dapat ditarik kesimpulan untuk uji asumsi klasik bahwa dataset
dapat dianalisis menggunakan analisis regresi.

#### Melakukan Regresi Linear Berganda

``` r
#Lakukan Regresi Linear Berganda
summary(model)
```

    ## 
    ## Call:
    ## lm(formula = dependent_var ~ meanoutsidetemp + attic + age, data = data)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -83.605 -25.413  -5.044  23.768  91.564 
    ## 
    ## Coefficients:
    ##                 Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)     439.4448    50.5031   8.701 2.09e-08 ***
    ## meanoutsidetemp  -4.4854     0.6658  -6.737 1.15e-06 ***
    ## attic           -13.6399     3.7327  -3.654  0.00148 ** 
    ## age               2.6400     3.5627   0.741  0.46689    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 48.25 on 21 degrees of freedom
    ## Multiple R-squared:  0.7865, Adjusted R-squared:  0.7561 
    ## F-statistic: 25.79 on 3 and 21 DF,  p-value: 3.081e-07

Ditemukanlah persamaan regresinya sebagai berikut:

heating_cost = 439.4448 + (-4.4854) \* meanoutsidetemp + (-13.6399) \*
attic_insulation + 2.64 \* age_furnace

Akan tetapi, model di atas perlu diperbaiki karena terdapat variabel
yang tidak signifikan. Variabel x3 atau age_furnace memiliki nilai
Pr(\>\|t\|) \>0.05 sehingga tidak signifikan. Variabel yang tidak
signifikan sebaiknya dibuang agar hasil regresi menjadi lebih bagus dan
akurat.

``` r
#Perbaiki model (karena terdapat variabel insignifikan -> x3 (age_furnace))
modelfix <- lm(dependent_var ~ meanoutsidetemp + attic, data = data)

#Regresi Linear Berganda (ulang)
summary(modelfix)
```

    ## 
    ## Call:
    ## lm(formula = dependent_var ~ meanoutsidetemp + attic, data = data)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -89.929 -31.610  -2.837  22.000  92.270 
    ## 
    ## Coefficients:
    ##                 Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)     466.7270    34.2132  13.642 3.26e-12 ***
    ## meanoutsidetemp  -4.7176     0.5814  -8.115 4.66e-08 ***
    ## attic           -13.7530     3.6911  -3.726  0.00117 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 47.75 on 22 degrees of freedom
    ## Multiple R-squared:  0.781,  Adjusted R-squared:  0.7611 
    ## F-statistic: 39.22 on 2 and 22 DF,  p-value: 5.567e-08

Sehingga didapatkan persamaan regresi sebagai berikut:

**heating_cost = 466.7270 - 4.7176 \* meanoutsidetemp - 13.7530 \*
attic_insulation**

### Jawaban Soal C: Studi Kasus

Diketahui:

- Mean outside temperature = 30 derajat

- Attic insulation = 5 inch

- Age of furnace = 10 tahun

Ditanya:

- Heating cost?

Jawab:

- heating_cost = 466.7270 - 4.7176 \* meanoutsidetemp - 13.7530 \*
  attic_insulation

- heating_cost = 466.720 - 4.7176 \* 30 - 13.7530 \* 5

- heating_cost = 256.4340

- heating_cost ~= 257

Jadi, heating cost dalam kondisi sebagaimana diketahui adalah sebesar
257 dollar.

### Jawaban Soal D: Koefisien Regresi Mean Outside Temperature

Koefisien regresi untuk mean outside temperature adalah sebesar -4.7176.
Hubungan yang dimiliki dengan heating cost adalah berbanding terbalik.
Hal ini berarti bahwa meningkatnya mean outside temperature akan
menyebabkan penurunan nilai heating cost, dan sebaliknya, penurunan
nilai mean outside temperature akan menyebabkan kenaikan heating cost.

### Jawaban Soal E: Kenaikan Mean Outside Temperature

Jika nilai mean outside temperature naik sebesar 1 derajat, dengan
catatan variabel lainnya tidak berubah, maka nilai heating cost akan
berkurang sebesar 4.7176 dollar.

### Jawaban Soal F: Perbedaan di Boston dan Philadelphia

Jika temperature di Boston (25 derajat) dan di Philadelphia (35 derajat)
dengan variabel lainnya dianggap tetap, **maka heating cost di kota
Philadelphia lebih murah 47.18 dollar daripada di kota Boston**. Hal ini
dapat dilihat di poin (e) bahwa semakin tinggi temperature maka semakin
kecil heating cost.

### Jawaban Soal G: Koefisien Regresi Attic Insulation

Koefisien regresi untuk attic insulation adalah sebesar -13.7530.
Hubungan yang dimiliki dengan heating cost adalah berbanding terbalik.
Hal ini berarti bahwa meningkatnya attic insulation akan menyebabkan
penurunan nilai heating cost, dan sebaliknya, penurunan nilai attic
insulation akan menyebabkan kenaikan heating cost.

### Jawaban Soal H: Koefisien Regresi Age of Furnace

Koefisien regresi untuk age of furnace adalah sebesar 2.64. Hubungan
yang dimiliki dengan heating cost adalah berbanding lurus. Hal ini
berarti bahwa meningkatnya age of furnace akan menyebabkan kenaikan
nilai heating cost, dan sebaliknya, penurunan nilai age of furnace akan
menyebabkan penurunan heating cost.

Akan tetapi, variabel ini terbukti tidak signifikan mempengaruhi heating
cost sehingga variabel age of furnace sebaiknya dieliminasi dari
persamaan regresi. Peningkatan adjusted R-square setelah eliminasi juga
memperkuat alasan variabel ini perlu dieliminasi karena terbukti
mengurangi explanatory power dan mengurangi value.
