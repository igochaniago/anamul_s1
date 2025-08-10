Analisis Korelasi Kanonikal
================

**Analisis korelasi kanonikal** adalah metode statistik yang digunakan
untuk mengukur dan menganalisis hubungan antara dua set variabel
sekaligus, dengan tujuan menemukan pasangan kombinasi variabel dari
masing-masing set yang memiliki korelasi tertinggi.

## Persoalan

Soal:

Lakukan analisis korelasi kanonikal dengan data yang tersedia (Refer to
IC_Data Analisis Korkanonikal.xlsx)

Terdapat 200 data dengan 7 variabel yang terbagi menjadi 3 variabel
psikologis (“locus_of_control”, “self_concept”, dan “motivation”) serta
4 variabel akademik (“read”, “write”, “math”, ” science”)

## Coding

### Library dan Read Data

``` r
#Library untuk data excel
library(readxl)

#Library untuk analisis korelasi kanonikal
library(ggplot2)
library(GGally)
library(CCA)
```

    ## Loading required package: fda

    ## Loading required package: splines

    ## Loading required package: fds

    ## Loading required package: rainbow

    ## Loading required package: MASS

    ## Loading required package: pcaPP

    ## Loading required package: RCurl

    ## Loading required package: deSolve

    ## 
    ## Attaching package: 'fda'

    ## The following object is masked from 'package:graphics':
    ## 
    ##     matplot

    ## The following object is masked from 'package:datasets':
    ## 
    ##     gait

    ## Loading required package: fields

    ## Loading required package: spam

    ## Spam version 2.11-1 (2025-01-20) is loaded.
    ## Type 'help( Spam)' or 'demo( spam)' for a short introduction 
    ## and overview of this package.
    ## Help for individual functions is also obtained by adding the
    ## suffix '.spam' to the function name, e.g. 'help( chol.spam)'.

    ## 
    ## Attaching package: 'spam'

    ## The following objects are masked from 'package:base':
    ## 
    ##     backsolve, forwardsolve

    ## Loading required package: viridisLite

    ## 
    ## Try help(fields) to get started.

``` r
library(CCP)

#Membaca file data excel
data <- read_excel("E:/IGO Programming Project/Github Repo/15_Analisis_KorKanon/IC_Data Analisis Korkanonikal.xlsx")
#data <- read_excel("15_Analisis_KorKanon/IC_Data Analisis Korkanonikal.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)
```

    ## # A tibble: 6 × 7
    ##   locus_of_control self_concept motivation  read write  math science
    ##              <dbl>        <dbl>      <dbl> <dbl> <dbl> <dbl>   <dbl>
    ## 1            -0.84        -0.24       1     54.8  64.5  44.5    52.6
    ## 2            -0.38        -0.47       0.67  62.7  43.7  44.7    52.6
    ## 3             0.89         0.59       0.67  60.6  56.7  70.5    58  
    ## 4             0.71         0.28       0.67  62.7  56.7  54.7    58  
    ## 5            -0.64         0.03       1     41.6  46.3  38.4    36.3
    ## 6             1.11         0.9        0.33  62.7  64.5  61.4    58

Dari sini terlihat bahwa data sudah bisa terbaca dengan baik, di mana
terdapat 7 variabel yang terbagi atas set variabel psikologis dan set
variabel akademik.

### Pengelompokan Variabel

``` r
#Mengelompokkan data untuk diolah
psych <- data[,1:3] #data variabel psikologi
acad <- data[,4:7] #data variabel akademik
```

\*Bagian ini memang tidak tampak outputnya, tetapi penting untuk
dijalankan karena berfungsi untuk mengelompokkan variabel sesuai dengan
soal.

### Pemodelan Korelasi Kanonikal

``` r
#Model Korelasi Kanonikal
cc1 <- cc(psych, acad)
cc1$cor
```

    ## [1] 0.5063894 0.1337951 0.0836476

Berikut ini adalah besaran dari korelasi kanonikal pada setiap dimensi.

### Uji Dimensi Kanonikal

Uji dimensi kanonikal dapat dilakukan dengan beberapa tes dengan
menggunakan F-approximation, seperti:

- Wilk’s Lambda

- Hotelling-Lawley Trace

- Pillai-Bartlett Trace

- Roy’s Largest Root

``` r
#Test untuk dimensi kanonikal (Canonical Dimension)
rho <- cc1$cor

#Definisi n obs, n var pada set psikologi, dan n var pada set akademik
n <- 200 #jumlah observasi ada 200 data sesuai di excel
p <- length(psych)
q <- length(acad)

#Menghitung p-value menggunakan F-approx. pada bbrp uji statistik (untuk signifikansi dimensi)
p.asym(rho, n, p, q, tstat = "Wilks")
```

    ## Wilks' Lambda, using F-approximation (Rao's F):
    ##               stat    approx df1      df2      p.value
    ## 1 to 3:  0.7251495 5.4989910  12 510.9215 7.355462e-09
    ## 2 to 3:  0.9752272 0.8161836   6 388.0000 5.578064e-01
    ## 3 to 3:  0.9930031 0.6870068   2 195.0000 5.042931e-01

``` r
p.asym(rho, n, p, q, tstat = "Hotelling")
```

    ##  Hotelling-Lawley Trace, using F-approximation:
    ##                 stat    approx df1 df2      p.value
    ## 1 to 3:  0.370137318 5.9119155  12 575 9.491448e-10
    ## 2 to 3:  0.025273656 0.8157775   6 581 5.578791e-01
    ## 3 to 3:  0.007046223 0.6893555   2 587 5.023053e-01

``` r
p.asym(rho, n, p, q, tstat = "Pillai")
```

    ##  Pillai-Bartlett Trace, using F-approximation:
    ##                 stat    approx df1 df2      p.value
    ## 1 to 3:  0.281328265 5.0446520  12 585 5.016834e-08
    ## 2 to 3:  0.024898063 0.8243278   6 591 5.512704e-01
    ## 3 to 3:  0.006996922 0.6978212   2 597 4.980739e-01

``` r
p.asym(rho, n, p, q, tstat = "Roy")
```

    ##  Roy's Largest Root, using F-approximation:
    ##               stat  approx df1 df2      p.value
    ## 1 to 1:  0.2564302 16.8121   4 195 7.393863e-12
    ## 
    ##  F statistic for Roy's Greatest Root is an upper bound.

Untuk kali ini, saya akan menggunakan salah satu hasil uji yaitu Wilk’s
Lambda dan dirangkum hasilnya pada tabel di bawah ini.

| Dimensi | Korelasi Kanonikal | F         | df1 | df2      | p-value      |
|---------|--------------------|-----------|-----|----------|--------------|
| 1       | 0.5063894          | 5.4989910 | 12  | 510.9215 | 7.355462e-19 |
| 2       | 0.1337951          | 0.8161836 | 6   | 388      | 5.578064e-01 |
| 3       | 0.0836476          | 0.6870068 | 2   | 195      | 5.042931e-01 |

Berdasarkan hasil pengujian, semua dimensi kanonikal signifikan secara
statistik dengan p-value di bawah 0.05 (p\<0.05)

- Dimensi 1 memilki korelasi kanonikal sebesar 0.506 di antara dua set
  variabel

- Dimensi 2 memiliki korelasi kanonikal sebesar 0.134 di antara dua set
  variabel

- Dimensi 3 memiliki korelasi kanonikal sebesar 0.084 di antara dua set
  variabel

### Koefisien Kanonikal Ter-standardized

``` r
#Koefisien Kanonikal var Psikologi terstandardisasi
std1 <- diag(sqrt(diag(cov(psych))))
std1 %*% cc1$xcoef
```

    ##             [,1]       [,2]       [,3]
    ## [1,] -0.87107012  0.3040358  0.4905086
    ## [2,]  0.06579691  0.7708877 -0.6922601
    ## [3,] -0.34489437 -0.7824057 -0.6117105

``` r
#Koefisien Kanonikal var Akademik terstandardisasi
std2 <- diag(sqrt(diag(cov(acad))))
std2 %*% cc1$ycoef
```

    ##               [,1]       [,2]       [,3]
    ## [1,] -0.5818839521 -0.4323353  1.1142788
    ## [2,] -0.4719402552 -0.9516265 -0.7873489
    ## [3,] -0.0892259595  1.2664100 -0.7690374
    ## [4,]  0.0001372622  0.2764341  0.3539019

Untuk mempermudah interpretasi, akan ditampilkan hasilnya pada tabel di
bawah ini.

|                    | Dimensi 1 | Dimensi 2 | Dimensi 3 |
|--------------------|:---------:|:---------:|:---------:|
| Variabel Psikologi |   =====   |   =====   |   =====   |
| locus_of_control   |  -0.871   |   0.304   |   0.491   |
| self_concept       |   0.066   |   0.771   |  -0.692   |
| motivation         |  -0.345   |  -0.782   |  -0.612   |
| Variabel Akademik  |   =====   |   =====   |   =====   |
| read               |  -0.582   |  -0.432   |   1.114   |
| write              |  -0.472   |  -0.952   |  -0.787   |
| math               |  -0.089   |   1.266   |  -0.769   |
| science            |  0.0001   |   0.276   |   0.354   |

## Kesimpulan

Berdasarkan hasil analisis korelasi kanonikal yang telah dilakukan,
dapat ditarik kesimpulaan sebagai berikut:

A. Pada Variabel Psikologi

- Dimensi 1 didominasi oleh pengaruh variabel “locus_of_control”
  (-0.871)

- Dimensi 2 didominasi oleh pengaruh variabel “motivation” (-0.782)

- Dimensi 3 didominasi oleh pengaruh “self_concept” (-0.692)

B. Pada Variabel Akademik

- Dimensi 1 didominasi oleh pengaruh “read” (-0.582)

- Dimensi 2 didominasi oleh pengaruh “math” (1.266)

- Dimensi 3 didominasi oleh pengaruh “read” (1.114)
