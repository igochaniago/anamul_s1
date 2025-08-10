Analisis Regresi Logistik
================

**Analisis regresi logistik** adalah metode statistik yang digunakan
untuk memodelkan hubungan antara satu variabel dependen berbentuk
kategori (terutama biner) dengan satu atau lebih variabel independen,
dengan tujuan memprediksi probabilitas terjadinya suatu kategori
tertentu.

## Persoalan

Soal:

Lakukan analisis regresi logistik dengan data yang tersedia (Refer to
IC_Data Regresi Logistik.xlsx)

Terdapat 100 data dengan 3 variabel.

a\. Persamaan regresi logistik

b\. Variabel bebas mana yang signifikan

c\. Seberapa sesuai model yang dihasilkan

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
#Library untuk Hosmer-Lemeshow Test
library(vcdExtra)
```

    ## Loading required package: vcd

    ## Loading required package: grid

    ## Loading required package: gnm

``` r
#Membaca file data excel
data <- read_excel("8_Regresi Logistik/IC_Data Regresi Logistik.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)
```

    ## # A tibble: 6 × 4
    ##      No     y   x_1   x_2
    ##   <dbl> <dbl> <dbl> <dbl>
    ## 1     1     1  24.1     5
    ## 2     2     0  11.2     7
    ## 3     3     1  21.1     9
    ## 4     4     1  26.5     8
    ## 5     5     0   5.9    12
    ## 6     6     1  26.2     7

Dari sini terlihat bahwa data sudah terbaca dengan baik, di mana
terdapat 3 variabel (“y”, “x_1”, “x_2”) dengan 100 baris data.

### Mendefinisikan Variabel dan Membuat Model

``` r
#Menentukan variabel
x1 <-(data$x_1)
x2 <- (data$x_2) 
dependent_var <- (data$y)

#Membuat model
model <- glm(dependent_var ~ x1 + x2, family=binomial(link='logit'), data = data)
```

Berikut ini kita definisikan variabelnya dan membuat model regresinya.

### Jawaban Soal A: Persamaan Regresi

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
    ## Determinant |X'X|:         0.9470         0
    ## Farrar Chi-Square:         5.3077         1
    ## Red Indicator:             0.2302         0
    ## Sum of Lambda Inverse:     2.1119         0
    ## Theil's Method:           -0.4460         0
    ## Condition Number:         10.3609         0
    ## 
    ## 1 --> COLLINEARITY is detected by the test 
    ## 0 --> COLLINEARITY is not detected by the test

Berdasarkan hasil di atas, hanya ditemukan multikolinearitas pada metode
Farrar Chi-Square. Dapat kita anggap bahwa multikolinearitas tidak ada
dalam dataset yang diuji

##### Uji Autokorelasi

``` r
#Autocorrelation Test -> Durbin-Watson's Test
lmtest::dwtest(model)
```

    ## 
    ##  Durbin-Watson test
    ## 
    ## data:  model
    ## DW = 1.8252, p-value = 0.1908
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
    ## BP = 0.83703, df = 2, p-value = 0.658

Berdasarkan hasil di atas, BP test menunjukkan p-value \>0.05, sehingga
dataset dianggap bebas dari heteroskedastisitas.

##### Kesimpulan Hasil Uji Asumsi Klasik

Sehingga dapat ditarik kesimpulan untuk uji asumsi klasik bahwa dataset
dapat dianalisis menggunakan analisis regresi.

#### Melakukan Regresi Logistik

``` r
#Regresi Logistik
summary(model)
```

    ## 
    ## Call:
    ## glm(formula = dependent_var ~ x1 + x2, family = binomial(link = "logit"), 
    ##     data = data)
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -1.97319    1.45608  -1.355 0.175374    
    ## x1           0.41965    0.08786   4.776 1.79e-06 ***
    ## x2          -0.49556    0.14243  -3.479 0.000502 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 138.589  on 99  degrees of freedom
    ## Residual deviance:  61.897  on 97  degrees of freedom
    ## AIC: 67.897
    ## 
    ## Number of Fisher Scoring iterations: 6

Ditemukanlah persamaan regresinya sebagai berikut:

$$
p = \frac{\exp\!\big(-1.97319 + 0.41965\,x_1 - 0.49556\,x_2\big)}
{1 + \exp\!\big(-1.97319 + 0.41965\,x_1 - 0.49556\,x_2\big)}
$$

### Jawaban Soal B: Signifikansi Variabel Bebas

Variabel bebas (independen) yang signifikan adalah x1 dan x2. Dengan
kata lain, seluruh variabel bebas adalah signifikan mempengaruhi model
regresi logistik. Hal ini dikarenakan nilai p-value \<0.05.

### Jawaban Soal C: Kesesuaian Model

``` r
#Mengecek kesesuaian model dengan Hosmer-Lemeshow Test
HLtest(model)
```

    ## Hosmer and Lemeshow Goodness-of-Fit Test 
    ## 
    ## Call:
    ## glm(formula = dependent_var ~ x1 + x2, family = binomial(link = "logit"), 
    ##     data = data)
    ##  ChiSquare df   P_value
    ##   9.698589  8 0.2868215

Kesesuaian model diuji dengan Hosmer-Lemeshow’s (HL) Test. Hasil HL Test
menunjukkan nilai sebesar 9.698589 dengan p-value \>0.05. Sehingga dapat
dinyatakan bahwa model mampu memprediksi nilai observasinya atau dapat
dianggap bahwa **model dapat diterima dan sesuai dengan data
observasinya**.

