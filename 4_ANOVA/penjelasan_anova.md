ANOVA
================

**ANOVA (*Analysis of Variance*)** adalah metode statistik untuk
membandingkan rata-rata lebih dari dua kelompok sekaligus, guna
menentukan apakah terdapat perbedaan yang signifikan di antara
kelompok-kelompok tersebut. Tujuannya adalah mengetahui apakah variasi
nilai yang terjadi disebabkan oleh perbedaan antar kelompok atau hanya
oleh variasi acak.

## Persoalan

Soal:

Lakukan ANOVA pada data yang disediakan (Refer to IC_Data ANOVA.xlsx)

Terdapat 6 data dengan 4 varaibel. 2 variabel (“560CM” dan “720CM”)
dianggap sebagai variabel dependen dan 2 variabel lainnya (“Species” dan
“Nutrient”) dianggap sebagai variabel independen.

a\. Tes two-way MANOVA untuk efek variabel “Species” dan “Nutrient”
dengan alpha = 0.05.

b\. Tes two-way ANOVA untuk variabel “560CM” dan “720CM” secara
terpisah. Apakah hasilnya konsisten dengan hasil MANOVA yang dilakukan
pada poin (a)? Jika tidak, jelaskan perbedaannya.

## Coding

### Library dan Read Data

``` r
#Library untuk data excel
library(readxl)

#Membaca file data excel
data <- read_excel("E:/IGO Programming Project/Github Repo/4_ANOVA/IC_Data ANOVA.xlsx")
#data <- read_excel("4_ANOVA/IC_Data ANOVA.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)
```

    ## # A tibble: 6 × 4
    ##   `560CM` `720CM` Species Nutrient
    ##     <dbl>   <dbl>   <dbl> <chr>   
    ## 1   10.4     25.9       1 +       
    ## 2   13.3     38.6       2 +       
    ## 3    7.78    25.2       3 +       
    ## 4   10.4     24.2       1 -       
    ## 5   17.8     41.4       2 -       
    ## 6   10.4     29.2       3 -

### Menentukan Jenis Variabel

``` r
#Menentukan variabel
dependent_var <- cbind(data$"560CM", data$"720CM")
species <- (data$Species)
nutrient <- (data$Nutrient)

#Membuat model ANOVA-MANOVA dalam R
modelx <- manova(dependent_var ~ species + nutrient + species*nutrient, data = data)
```

\*Bagian ini memang tidak terdapat output, tetapi code tetap harus
dijalankan.

### Jawaban Soal A: Two-Way MANOVA

``` r
#Uji Two-Way MANOVA
#Pillai's Trace
print("Uji Pillai's Trace")
```

    ## [1] "Uji Pillai's Trace"

``` r
summary (modelx, test="Pillai", intercept = TRUE)
```

    ##                  Df  Pillai approx F num Df den Df Pr(>F)
    ## (Intercept)       1 0.96480  13.7057      2      1 0.1876
    ## species           1 0.70318   1.1845      2      1 0.5448
    ## nutrient          1 0.67296   1.0289      2      1 0.5719
    ## species:nutrient  1 0.03323   0.0172      2      1 0.9832
    ## Residuals         2

``` r
print("==========================")
```

    ## [1] "=========================="

``` r
#Wilk's Lambda
print("Uji Wilk's Lambda")
```

    ## [1] "Uji Wilk's Lambda"

``` r
summary (modelx, test="Wilks", intercept = TRUE)
```

    ##                  Df   Wilks approx F num Df den Df Pr(>F)
    ## (Intercept)       1 0.03520  13.7057      2      1 0.1876
    ## species           1 0.29682   1.1845      2      1 0.5448
    ## nutrient          1 0.32704   1.0289      2      1 0.5719
    ## species:nutrient  1 0.96677   0.0172      2      1 0.9832
    ## Residuals         2

``` r
print("==========================")
```

    ## [1] "=========================="

``` r
#Hotelling-Lawley's Trace
print("Uji Hotelling-Lawley's Trace")
```

    ## [1] "Uji Hotelling-Lawley's Trace"

``` r
summary (modelx, test="Hotelling-Lawley", intercept = TRUE)
```

    ##                  Df Hotelling-Lawley approx F num Df den Df Pr(>F)
    ## (Intercept)       1          27.4114  13.7057      2      1 0.1876
    ## species           1           2.3690   1.1845      2      1 0.5448
    ## nutrient          1           2.0578   1.0289      2      1 0.5719
    ## species:nutrient  1           0.0344   0.0172      2      1 0.9832
    ## Residuals         2

``` r
print("==========================")
```

    ## [1] "=========================="

``` r
#Roy's Largest Root
print("Uji Roy's Largest Root")
```

    ## [1] "Uji Roy's Largest Root"

``` r
summary (modelx, test="Roy", intercept = TRUE)
```

    ##                  Df     Roy approx F num Df den Df Pr(>F)
    ## (Intercept)       1 27.4114  13.7057      2      1 0.1876
    ## species           1  2.3690   1.1845      2      1 0.5448
    ## nutrient          1  2.0578   1.0289      2      1 0.5719
    ## species:nutrient  1  0.0344   0.0172      2      1 0.9832
    ## Residuals         2

``` r
print("==========================")
```

    ## [1] "=========================="

Berdasarkan uji MANOVA yang dilakukan, seluruh variabel dependen
(“560CM” dan “720CM”) secara simultan tidak berpengaruh signifikan
(dikarenakan nilai sig. \>0.05) terhadap variabel “Species”, “Nutrient”,
dan interaksi “Species\*Nutrient”.

### Jawaban Soal B: Two-Way ANOVA

``` r
#Uji Two-Way ANOVA
summary.aov(modelx)
```

    ##  Response 1 :
    ##                  Df Sum Sq Mean Sq F value Pr(>F)
    ## species           1  1.651  1.6512  0.0683 0.8182
    ## nutrient          1  8.497  8.4966  0.3517 0.6133
    ## species:nutrient  1  1.651  1.6512  0.0683 0.8182
    ## Residuals         2 48.323 24.1615               
    ## 
    ##  Response 2 :
    ##                  Df  Sum Sq Mean Sq F value Pr(>F)
    ## species           1   4.347   4.347  0.0336 0.8715
    ## nutrient          1   4.489   4.489  0.0347 0.8694
    ## species:nutrient  1   8.208   8.208  0.0634 0.8247
    ## Residuals         2 258.782 129.391

Berdasarkan uji ANOVA yang dilakukan, variabel “560CM” (Response 1) dan
“720CM” (Response 2) secara keseluruhan tidak berpengaruh signifikan
(dikarenakan nilai sig. \>0.05) terhadap variabel “Species”, “Nutrient”,
dan interaksi “Species\*Nutrient”.

## Kesimpulan

Berdasarkan hasil pengolahan data ANOVA-MANOVA yang telah dilakukan,
dapat disimpulkan bahwa tidak terdapat perbedaan hasil antara uji ANOVA
dan MANOVA. Hasil pada uji MANOVA dan ANOVA konsisten menyatakan bahwa
variabel “560CM” dan “720CM” tidak berpengaruh secara signifikan
terhadap variabel “Species”, “Nutrient”, serta terhadap interaksi
“Species\*Nutrient”.
