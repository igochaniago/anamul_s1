MANOVA
================

**MANOVA (*Multivariate Analysis of Variance*)** adalah metode statistik
untuk membandingkan rata-rata lebih dari dua kelompok pada lebih dari
satu variabel terikat secara bersamaan. Tujuannya adalah mengetahui
apakah terdapat perbedaan signifikan antar kelompok dengan
mempertimbangkan hubungan antar variabel terikat tersebut.

## Persoalan

Soal:

Lakukan MANOVA pada data yang disediakan (Refer to IC_Data MANOVA.xlsx)

Terdapat 60 data dengan 4 variabel (“Y1”, “Y2”, “Y3”, “Y4”) dan 2 faktor
(“sowing_date” dan “variety”).

a\. Test for main effect and interaction menggunakan semua MANOVA
statistic

b\. Jika tes pada poin (a) ada yang menolak H0, lakukan ANOVA F-test
pada keempat variabel

c\. Tes signifikansi “Y3” dan “Y4” yang di-adjusted untuk “Y1” dan “Y2”
pada main effect dan interaction

d\. Tes signifikansi masing-masing variabel adjusted untuk tiga variabel
lainnya pada main effect dan interaction

## Coding

### Library dan Read Data

``` r
#Library untuk data excel
library(readxl)

#Membaca file data excel
data <- read_excel("E:/IGO Programming Project/Github Repo/5_MANOVA/IC_Data MANOVA.xlsx")
#data <- read_excel("5_MANOVA/IC_Data MANOVA.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)
```

    ## # A tibble: 6 × 6
    ##   sowing_date variety    y1    y2    y3    y4
    ##         <dbl>   <dbl> <dbl> <dbl> <dbl> <dbl>
    ## 1           1       1  59.3   4.5  38.4   295
    ## 2           1       1  60.3   4.5  38.6   302
    ## 3           1       1  60.9   5.3  37.2   318
    ## 4           1       1  60.6   5.8  38.1   345
    ## 5           1       1  60.4   6    38.8   325
    ## 6           1       2  59.3   6.7  37.9   275

### Menentukan Jenis Variabel dan Membuat Model

``` r
#Menentukan variabel
dependent_var <- cbind(data$y1, data$y2, data$y3, data$y4)
sowing_date <- (data$sowing_date)
variety <- (data$variety)

#Membuat model dalam R
model <- manova(dependent_var ~ factor(sowing_date) + factor(variety) + factor(sowing_date*variety), data = data)
```

\*Bagian ini memang tidak terdapat output, tetapi code tetap harus
dijalankan.

### Jawaban Soal A: Test Main Effect and Interaction

``` r
#Uji Two-Way MANOVA (5a)
#Pillai's Trace
print("Uji Pillai's Trace")
```

    ## [1] "Uji Pillai's Trace"

``` r
summary (model, test="Pillai", intercept = TRUE)
```

    ##                               Df  Pillai approx F num Df den Df    Pr(>F)    
    ## (Intercept)                    1 0.99993   171407      4     46 < 2.2e-16 ***
    ## factor(sowing_date)            3 2.31687       41     12    144 < 2.2e-16 ***
    ## factor(variety)                2 1.01978       12      8     94 7.669e-12 ***
    ## factor(sowing_date * variety)  5 0.92046        3     20    196 6.770e-05 ***
    ## Residuals                     49                                             
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
#Wilk's Lambda
print("Uji Wilk's Lambda")
```

    ## [1] "Uji Wilk's Lambda"

``` r
summary (model, test="Wilks", intercept = TRUE)
```

    ##                               Df    Wilks approx F num Df den Df    Pr(>F)    
    ## (Intercept)                    1 0.000067   171407      4  46.00 < 2.2e-16 ***
    ## factor(sowing_date)            3 0.001134      122     12 122.00 < 2.2e-16 ***
    ## factor(variety)                2 0.132304       20      8  92.00 < 2.2e-16 ***
    ## factor(sowing_date * variety)  5 0.312333        3     20 153.51 2.131e-05 ***
    ## Residuals                     49                                              
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
#Hotelling-Lawley's Trace
print("Uji Hotelling-Lawley's Trace")
```

    ## [1] "Uji Hotelling-Lawley's Trace"

``` r
summary (model, test="Hotelling-Lawley", intercept = TRUE)
```

    ##                               Df Hotelling-Lawley approx F num Df den Df
    ## (Intercept)                    1          14905.0   171407      4     46
    ## factor(sowing_date)            3             92.7      345     12    134
    ## factor(variety)                2              5.4       30      8     90
    ## factor(sowing_date * variety)  5              1.5        3     20    178
    ## Residuals                     49                                        
    ##                                  Pr(>F)    
    ## (Intercept)                   < 2.2e-16 ***
    ## factor(sowing_date)           < 2.2e-16 ***
    ## factor(variety)               < 2.2e-16 ***
    ## factor(sowing_date * variety) 5.693e-06 ***
    ## Residuals                                  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
#Roy's Largest Root
print("Uji Roy's Largest Root")
```

    ## [1] "Uji Roy's Largest Root"

``` r
summary (model, test="Roy", intercept = TRUE)
```

    ##                               Df     Roy approx F num Df den Df    Pr(>F)    
    ## (Intercept)                    1 14905.0   171407      4     46 < 2.2e-16 ***
    ## factor(sowing_date)            3    88.0     1056      4     48 < 2.2e-16 ***
    ## factor(variety)                2     5.2       61      4     47 < 2.2e-16 ***
    ## factor(sowing_date * variety)  5     1.0       10      5     49 1.156e-06 ***
    ## Residuals                     49                                             
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Berdasarkan keempat uji MANOVA yang dilakukan, dapat dinyatakan bahwa
variabel “Y1”, “Y2”, “Y3”, dan “Y4” secara simultan berpengaruh
signifikan (dikarenakan nilai sig. \<0.05) terhadap faktor
“sowing_date”, “variety”, dan interaksi “sowing_date\*variety”.

### Jawaban Soal B: ANOVA F-test

``` r
#Uji F-test (5b)
y1 <- (data$y1)
y2 <- (data$y2)
y3 <- (data$y3)
y4 <- (data$y4)
#F-test untuk y1 dengan y2
var.test (y1,y2)
```

    ## 
    ##  F test to compare two variances
    ## 
    ## data:  y1 and y2
    ## F = 4.1114, num df = 59, denom df = 59, p-value = 1.943e-07
    ## alternative hypothesis: true ratio of variances is not equal to 1
    ## 95 percent confidence interval:
    ##  2.455864 6.883094
    ## sample estimates:
    ## ratio of variances 
    ##            4.11144

``` r
#F-test untuk y1 dengan y3
var.test (y1,y3)
```

    ## 
    ##  F test to compare two variances
    ## 
    ## data:  y1 and y3
    ## F = 1.1544, num df = 59, denom df = 59, p-value = 0.583
    ## alternative hypothesis: true ratio of variances is not equal to 1
    ## 95 percent confidence interval:
    ##  0.6895757 1.9326862
    ## sample estimates:
    ## ratio of variances 
    ##           1.154441

``` r
#F-test untuk y1 dengan y4
var.test (y1,y4)
```

    ## 
    ##  F test to compare two variances
    ## 
    ## data:  y1 and y4
    ## F = 0.017631, num df = 59, denom df = 59, p-value < 2.2e-16
    ## alternative hypothesis: true ratio of variances is not equal to 1
    ## 95 percent confidence interval:
    ##  0.01053150 0.02951682
    ## sample estimates:
    ## ratio of variances 
    ##         0.01763112

``` r
#F-test untuk y2 dengan y3
var.test (y2,y3)
```

    ## 
    ##  F test to compare two variances
    ## 
    ## data:  y2 and y3
    ## F = 0.28079, num df = 59, denom df = 59, p-value = 2.499e-06
    ## alternative hypothesis: true ratio of variances is not equal to 1
    ## 95 percent confidence interval:
    ##  0.1677212 0.4700752
    ## sample estimates:
    ## ratio of variances 
    ##          0.2807874

``` r
#F-test untuk y2 dengan y4
var.test (y2,y4)
```

    ## 
    ##  F test to compare two variances
    ## 
    ## data:  y2 and y4
    ## F = 0.0042883, num df = 59, denom df = 59, p-value < 2.2e-16
    ## alternative hypothesis: true ratio of variances is not equal to 1
    ## 95 percent confidence interval:
    ##  0.002561511 0.007179192
    ## sample estimates:
    ## ratio of variances 
    ##        0.004288307

``` r
#F-test untuk y3 dengan y4
var.test (y3,y4)
```

    ## 
    ##  F test to compare two variances
    ## 
    ## data:  y3 and y4
    ## F = 0.015272, num df = 59, denom df = 59, p-value < 2.2e-16
    ## alternative hypothesis: true ratio of variances is not equal to 1
    ## 95 percent confidence interval:
    ##  0.009122597 0.025568066
    ## sample estimates:
    ## ratio of variances 
    ##         0.01527243

``` r
#Uji ANOVA (lanjutan 5c)
summary.aov(model)
```

    ##  Response 1 :
    ##                               Df Sum Sq Mean Sq  F value    Pr(>F)    
    ## factor(sowing_date)            3 728.79 242.930 492.2084 < 2.2e-16 ***
    ## factor(variety)                2 124.52  62.261 126.1484 < 2.2e-16 ***
    ## factor(sowing_date * variety)  5  18.01   3.601   7.2968  3.55e-05 ***
    ## Residuals                     49  24.18   0.494                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response 2 :
    ##                               Df  Sum Sq Mean Sq  F value    Pr(>F)    
    ## factor(sowing_date)            3 195.865  65.288 246.7634 < 2.2e-16 ***
    ## factor(variety)                2   4.866   2.433   9.1964 0.0004062 ***
    ## factor(sowing_date * variety)  5   4.112   0.822   3.1083 0.0162700 *  
    ## Residuals                     49  12.964   0.265                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response 3 :
    ##                               Df Sum Sq Mean Sq  F value    Pr(>F)    
    ## factor(sowing_date)            3 747.78 249.259 743.9958 < 2.2e-16 ***
    ## factor(variety)                2   8.40   4.201  12.5398 4.001e-05 ***
    ## factor(sowing_date * variety)  5   3.11   0.621   1.8546    0.1196    
    ## Residuals                     49  16.42   0.335                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response 4 :
    ##                               Df Sum Sq Mean Sq F value    Pr(>F)    
    ## factor(sowing_date)            3  33469 11156.5 65.7554 < 2.2e-16 ***
    ## factor(variety)                2   8188  4094.1 24.1305 5.074e-08 ***
    ## factor(sowing_date * variety)  5    820   163.9  0.9663    0.4476    
    ## Residuals                     49   8314   169.7                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

| Uji F-test   | Nilai F   | p-value   | Signifikan? |
|--------------|-----------|-----------|-------------|
| y1 dengan y2 | 4.1114    | 1.943e-07 | YA          |
| y1 dengan y3 | 1.1544    | 0.583     | TIDAK       |
| y1 dengan y4 | 0.017631  | \<2.2e-16 | YA          |
| y2 dengan y3 | 0.28079   | 2.499e-06 | YA          |
| y2 dengan y4 | 0.0042883 | \<2.2e-16 | YA          |
| y3 dengan y4 | 0.015272  | \<2.2e-16 | YA          |

Hasil yang “signifikan” mengindikasikan dua variabel diambil dari
populasi berdistribusi normal dengan variabilitas yang sama.

Sedangkan, hasil yang “tidak signifikan” mengindikasikan dua variabel
tidak diambil dari populasi yang berdistribusi normal dan juga memiliki
variabilitas populasi yang berbeda.

### Jawaban Soal C: Test of Significance

Melakukan tes y3 dan y4 terhadap y1 dan y2 dengan menggunakan uji
Two-Way MANOVA

``` r
#uji untuk test of significance (5c)
y34 <- cbind(data$y3, data$y4)
y1 <- (data$y1)
y2 <- (data$y2)
modelx <- manova(y34 ~ y1 + y2 + y1*y2, data = data)
#Pillai's Trace
print("Uji Pillai's Trace")
```

    ## [1] "Uji Pillai's Trace"

``` r
summary (modelx, test="Pillai", intercept = TRUE)
```

    ##             Df  Pillai approx F num Df den Df    Pr(>F)    
    ## (Intercept)  1 0.99965    77937      2     55 < 2.2e-16 ***
    ## y1           1 0.90009      248      2     55 < 2.2e-16 ***
    ## y2           1 0.57169       37      2     55 7.469e-11 ***
    ## y1:y2        1 0.22999        8      2     55 0.0007564 ***
    ## Residuals   56                                             
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
#Wilk's Lambda
print("Uji Wilk's Lambda")
```

    ## [1] "Uji Wilk's Lambda"

``` r
summary (modelx, test="Wilks", intercept = TRUE)
```

    ##             Df   Wilks approx F num Df den Df    Pr(>F)    
    ## (Intercept)  1 0.00035    77937      2     55 < 2.2e-16 ***
    ## y1           1 0.09991      248      2     55 < 2.2e-16 ***
    ## y2           1 0.42831       37      2     55 7.469e-11 ***
    ## y1:y2        1 0.77001        8      2     55 0.0007564 ***
    ## Residuals   56                                             
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
#Hotelling-Lawley's Trace
print("Uji Hotelling-Lawley's Trace")
```

    ## [1] "Uji Hotelling-Lawley's Trace"

``` r
summary (modelx, test="Hotelling-Lawley", intercept = TRUE)
```

    ##             Df Hotelling-Lawley approx F num Df den Df    Pr(>F)    
    ## (Intercept)  1          2834.08    77937      2     55 < 2.2e-16 ***
    ## y1           1             9.01      248      2     55 < 2.2e-16 ***
    ## y2           1             1.33       37      2     55 7.469e-11 ***
    ## y1:y2        1             0.30        8      2     55 0.0007564 ***
    ## Residuals   56                                                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
#Roy's Largest Root
print("Uji Roy's Largest Root")
```

    ## [1] "Uji Roy's Largest Root"

``` r
summary (modelx, test="Roy", intercept = TRUE)
```

    ##             Df     Roy approx F num Df den Df    Pr(>F)    
    ## (Intercept)  1 2834.08    77937      2     55 < 2.2e-16 ***
    ## y1           1    9.01      248      2     55 < 2.2e-16 ***
    ## y2           1    1.33       37      2     55 7.469e-11 ***
    ## y1:y2        1    0.30        8      2     55 0.0007564 ***
    ## Residuals   56                                             
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Berdasarkan keempat uji Two-Way MANOVA, variabel “Y1” dan “Y2” secara
simultan berpengaruh terhadap variabel “Y3” dan “Y4” secara simultan
pula.

### Jawaban Soal D: Test of Significance Per Variable - Adjusted to Other Variable

Dengan menggunakan uji Common Way ANOVA

``` r
#uji untuk test of significance each variable (5d)
y1234 <- cbind(data$y1, data$y2, data$y3, data$y4)
y1 <- (data$y1)
y2 <- (data$y2)
y3 <- (data$y3)
y4 <- (data$y4)
modely <- manova(y1234 ~ y1 + y2 + y3 + y4 + y1*y2*y3*y4, data = data)
summary.aov(modely)
```

    ##  Response 1 :
    ##             Df Sum Sq Mean Sq    F value Pr(>F)    
    ## y1           1  895.5   895.5 4.8475e+32 <2e-16 ***
    ## y2           1    0.0     0.0 2.0852e+00 0.1558    
    ## y3           1    0.0     0.0 7.5020e-01 0.3911    
    ## y4           1    0.0     0.0 5.7640e-01 0.4518    
    ## y1:y2        1    0.0     0.0 1.0000e-04 0.9914    
    ## y1:y3        1    0.0     0.0 1.6000e-03 0.9679    
    ## y2:y3        1    0.0     0.0 4.1800e-01 0.5213    
    ## y1:y4        1    0.0     0.0 9.0200e-02 0.7653    
    ## y2:y4        1    0.0     0.0 3.7090e-01 0.5457    
    ## y3:y4        1    0.0     0.0 2.8300e-01 0.5974    
    ## y1:y2:y3     1    0.0     0.0 1.0154e+00 0.3191    
    ## y1:y2:y4     1    0.0     0.0 1.8216e+00 0.1840    
    ## y1:y3:y4     1    0.0     0.0 4.1140e-01 0.5246    
    ## y2:y3:y4     1    0.0     0.0 1.5800e-01 0.6929    
    ## y1:y2:y3:y4  1    0.0     0.0 8.7000e-03 0.9261    
    ## Residuals   44    0.0     0.0                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response 2 :
    ##             Df Sum Sq Mean Sq    F value  Pr(>F)    
    ## y1           1 156.70  156.70 6.2147e+32 < 2e-16 ***
    ## y2           1  61.11   61.11 2.4237e+32 < 2e-16 ***
    ## y3           1   0.00    0.00 1.4796e+00 0.23032    
    ## y4           1   0.00    0.00 7.1410e-01 0.40265    
    ## y1:y2        1   0.00    0.00 2.1350e-01 0.64635    
    ## y1:y3        1   0.00    0.00 3.0300e-01 0.58480    
    ## y2:y3        1   0.00    0.00 2.4332e+00 0.12596    
    ## y1:y4        1   0.00    0.00 3.5700e-02 0.85104    
    ## y2:y4        1   0.00    0.00 5.6700e-02 0.81297    
    ## y3:y4        1   0.00    0.00 3.0455e+00 0.08794 .  
    ## y1:y2:y3     1   0.00    0.00 2.7980e+00 0.10148    
    ## y1:y2:y4     1   0.00    0.00 3.5970e-01 0.55172    
    ## y1:y3:y4     1   0.00    0.00 5.4580e-01 0.46398    
    ## y2:y3:y4     1   0.00    0.00 5.2268e+00 0.02711 *  
    ## y1:y2:y3:y4  1   0.00    0.00 4.9553e+00 0.03118 *  
    ## Residuals   44   0.00    0.00                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response 3 :
    ##             Df Sum Sq Mean Sq    F value    Pr(>F)    
    ## y1           1 587.06  587.06 3.3504e+33 < 2.2e-16 ***
    ## y2           1  95.56   95.56 5.4534e+32 < 2.2e-16 ***
    ## y3           1  93.08   93.08 5.3123e+32 < 2.2e-16 ***
    ## y4           1   0.00    0.00 9.2983e+00  0.003875 ** 
    ## y1:y2        1   0.00    0.00 0.0000e+00  0.997813    
    ## y1:y3        1   0.00    0.00 1.9946e+00  0.164894    
    ## y2:y3        1   0.00    0.00 6.1700e-02  0.805011    
    ## y1:y4        1   0.00    0.00 4.2460e+00  0.045286 *  
    ## y2:y4        1   0.00    0.00 9.3000e-03  0.923751    
    ## y3:y4        1   0.00    0.00 3.3590e-01  0.565185    
    ## y1:y2:y3     1   0.00    0.00 2.1890e-01  0.642166    
    ## y1:y2:y4     1   0.00    0.00 2.2728e+00  0.138809    
    ## y1:y3:y4     1   0.00    0.00 6.3250e-01  0.430714    
    ## y2:y3:y4     1   0.00    0.00 4.3450e-01  0.513216    
    ## y1:y2:y3:y4  1   0.00    0.00 7.0450e-01  0.405803    
    ## Residuals   44   0.00    0.00                         
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ##  Response 4 :
    ##             Df  Sum Sq Mean Sq    F value Pr(>F)    
    ## y1           1 12749.0 12749.0 1.1868e+34 <2e-16 ***
    ## y2           1  5716.4  5716.4 5.3216e+33 <2e-16 ***
    ## y3           1  8787.4  8787.4 8.1805e+33 <2e-16 ***
    ## y4           1 23538.1 23538.1 2.1912e+34 <2e-16 ***
    ## y1:y2        1     0.0     0.0 1.2570e+00 0.2683    
    ## y1:y3        1     0.0     0.0 9.0630e-01 0.3463    
    ## y2:y3        1     0.0     0.0 7.1520e-01 0.4023    
    ## y1:y4        1     0.0     0.0 2.6938e+00 0.1079    
    ## y2:y4        1     0.0     0.0 4.5200e-02 0.8326    
    ## y3:y4        1     0.0     0.0 5.6910e-01 0.4546    
    ## y1:y2:y3     1     0.0     0.0 3.9810e-01 0.5313    
    ## y1:y2:y4     1     0.0     0.0 3.2100e-02 0.8586    
    ## y1:y3:y4     1     0.0     0.0 7.8890e-01 0.3793    
    ## y2:y3:y4     1     0.0     0.0 1.0000e-04 0.9932    
    ## y1:y2:y3:y4  1     0.0     0.0 7.8090e-01 0.3817    
    ## Residuals   44     0.0     0.0                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Berdasarkan hasil di atas, interpretasi hasilnya adalah sebagai berikut:

A. Variabel “Y1”

- Variabel y2, y3, dan y4 masing-masing tidak berpengaruh terhadap
  variabel y1

- Interaksi y2, y3, dan y4 secara simultan tidak berpengaruh terhadap
  variabel y1

B. Variabel “Y2”

- Variabel y1 berpengaruh terhadap variabel y2

- Variabel y3 dan y4 masing-masing tidak berpengaruh terhadap variabel
  y2

- Interaksi y1, y3, dan y4 secara simultan tidak berpengaruh terhadap
  variabel y2

C. Variabel “Y3”

- Variabel y1 dan y2 masing-masing berpengaruh terhadap variabel y3

- Variabel y4 tidak berpengaruh terhadap variabel y3

- Interaksi y1, y2, dan y4 secara simultan tidak berpengaruh terhadap
  variabel y3

D. Variabel”Y4”

- Variabel y1, y2, dan y3 masing-masing berpengaruh terhadap variabel y4

- Interaksi y1, y2, dan y3 secara simultan tidak berpengaruh terhadap
  variabel y4
