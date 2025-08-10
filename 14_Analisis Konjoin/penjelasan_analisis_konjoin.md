Analisis Konjoin
================

**Analisis konjoin** adalah metode statistik yang digunakan untuk
memahami bagaimana orang membuat keputusan atau memilih suatu
produk/jasa dengan mengevaluasi kombinasi atribut-atributnya, sehingga
dapat diketahui atribut mana yang paling memengaruhi preferensi atau
pilihan mereka.

## Persoalan

Soal:

Lakukan analisis konjoin dengan data yang tersedia (Refer to IC_Data
Analisis Konjoin.xlsx)

Terdapat 15 data responden dengan ID Profil yang berbeda. Kemudian,
terdapat 4 atribut yang dijadikan pertimbangan yaitu flavor, packaging,
light, dan organic.

- “Flavor” memiliki 5 kategori

- “Packaging” memiliki 3 kategori

- “Light” memiliki 2 kategori

- “Organic” memilki 2 kategori

## Coding

### Library dan Pengelompokan Data

``` r
#Library untuk data excel
library(readxl)

#Library untuk analisis konjoin
library(conjoint)

#Membaca file data excel
path <- "E:/IGO Programming Project/Github Repo/14_Analisis Konjoin/IC_Data Analisis Konjoin.xlsx"
#path <- "14_Analisis Konjoin/IC_Data Analisis Konjoin.xlsx"

#Kelompok data
profile <- read_excel(path, sheet = "Sheet1", range = "A1:D11")
dfprofile <- data.frame(profile)
survey_data <- read_excel(path, sheet = "Sheet1", range = "E1:N16")
dfsurvey_data <- data.frame(survey_data)
level <- read_excel(path, sheet = "Sheet1", range = "O1:O13")
dflevel <- data.frame(level)
survey_datapref <- read_excel(path, sheet = "Sheet1", range = "P1:P151")
dfsurvey_datapref <- data.frame(survey_datapref)
```

\*Bagian ini memang tidak terlihat outputnya, tapi penting untuk
dijalankan karena mendefinisikan program dan code flow.

### Pemodelan dan Hasil Analisis Konjoin

``` r
#Model dari Conjoint Analysis
Conjoint(y=dfsurvey_datapref, x=dfprofile, z=dflevel)
```

    ## 
    ## Call:
    ## lm(formula = frml)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -5,3972 -2,3111 -0,1972  2,6028  5,2583 
    ## 
    ## Coefficients:
    ##                      Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)           5,56167    0,24713  22,505   <2e-16 ***
    ## factor(x$flavor)1    -0,15611    0,52258  -0,299    0,766    
    ## factor(x$flavor)2     0,34944    0,52258   0,669    0,505    
    ## factor(x$flavor)3     0,31611    0,52258   0,605    0,546    
    ## factor(x$flavor)4    -0,62278    0,52258  -1,192    0,235    
    ## factor(x$packaging)1 -0,18889    0,43573  -0,433    0,665    
    ## factor(x$packaging)2  0,10000    0,35577   0,281    0,779    
    ## factor(x$light)1     -0,35833    0,26683  -1,343    0,181    
    ## factor(x$organic)1    0,06111    0,25157   0,243    0,808    
    ## ---
    ## Signif. codes:  0 '***' 0,001 '**' 0,01 '*' 0,05 '.' 0,1 ' ' 1
    ## 
    ## Residual standard error: 2,923 on 141 degrees of freedom
    ## Multiple R-squared:  0,02653,    Adjusted R-squared:  -0,02871 
    ## F-statistic: 0,4802 on 8 and 141 DF,  p-value: 0,8686

    ## [1] "Part worths (utilities) of levels (model parameters for whole sample):"
    ##             levnms    utls
    ## 1        intercept  5,5617
    ## 2        Raspberry -0,1561
    ## 3            Mango  0,3494
    ## 4       Strawberry  0,3161
    ## 5          Vanilla -0,6228
    ## 6        Chocolate  0,1133
    ## 7             Cone -0,1889
    ## 8  Homemade waffle     0,1
    ## 9             Pint  0,0889
    ## 10      No low fat -0,3583
    ## 11         Low fat  0,3583
    ## 12     Not organic  0,0611
    ## 13         Organic -0,0611
    ## [1] "Average importance of factors (attributes):"
    ## [1] 45,20 25,44 19,33 10,03
    ## [1] Sum of average importance:  100
    ## [1] "Chart of average factors importance"

Hasil uji average importance factor adalah sebagai berikut:

| Atribut   | Score |
|-----------|-------|
| Flavor    | 45.20 |
| Packaging | 25.44 |
| Light     | 19.33 |
| Organic   | 10.03 |

Berdasarkan hasil tersebut, diketahui bahwa atribut “Flavor” merupakan
atribut yang dianggap paling penting oleh customer

\-

Hasil Utility Score untuk masing-masing atribut adalah sebagai berikut:

- Atribut “Flavor”

| Flavor     | Score   |
|------------|---------|
| Raspberry  | -0.1561 |
| Mango      | 0.3494  |
| Strawberry | 0.3161  |
| Vanilla    | -0.6228 |
| Chocolate  | 0.1133  |

Hasil tersebut menunjukkan bahwa customer lebih menyukai flavor “Mango”

- Atribut “Packaging”

| Packaging       | Score   |
|-----------------|---------|
| Cone            | -0.1889 |
| Homemade Waffle | 0.1     |
| Pint            | 0.0889  |

Hasil tersebut menunjukkan bahwa customer lebih menyukai packaging
“Homemade Waffle”

- Atribut “Light”

| Light      | Score   |
|------------|---------|
| No Low Fat | -0.3583 |
| Low Fat    | 0.3583  |

Hasil tersebut menunjukkan bahwa customer lebih menyukai “Low Fat”

- Atribut “Organic”

| Organic    | Score   |
|------------|---------|
| No Organic | 0.0611  |
| Organic    | -0.0611 |

Hasil tersebut menunjukkan bahwa customer lebih menyukai “No Organic”

## Kesimpulan

Berdasarkan hasil analisis konjoin, dapat ditarik kesimpulan bahwa
customer menganggap atribut “Flavor” sebagai atribut yang paling
penting. Kemudian, didapatkan juga kombinasi yang mungkin paling disukai
oleh customer yaitu:

- Flavor: Raspberry

- Packaging: Homemade Waffle

- Light: Low Fat

- Organic: No Organic
