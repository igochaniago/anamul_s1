Analisis Missing Value
================

**Analisis missing value** adalah proses untuk mengidentifikasi dan
memahami data yang hilang atau tidak terisi dalam suatu kumpulan data,
termasuk jumlah, pola, dan kemungkinan penyebabnya. Tujuannya adalah
menentukan cara penanganan yang tepat agar hasil analisis tidak bias.

## Persoalan

Soal:

Lakukan analisis missing value pada data yang disediakan (Refer to
IC_Data Missing.xlsx)

Terdapat 94 data dengan 4 variabel.

## Metode Yang Digunakan

Metode yang akan digunakan untuk mengetahui adanya missing data dan
melakukan pengisian pada data yang missing adalah:

a\. Metode Mean Imputation

adalah teknik mengisi data yang hilang dengan menggunakan nilai
rata-rata dari variabel tersebut.

b\. Metode kNN Imputation

adalah teknik mengisi data yang hilang dengan memanfaatkan algoritma
untuk mengklasifikasikan titik data berdasarkan bagaimana data
tetangganya diklasifikasikan. “k” dalam algoritma kNN perlu dipilih
dengan tepat karena penting untuk akurasi pengisian data yang lebih
baik. Secara umum, digunakan cara (k = sqrt(N)); di mana N merupakan
jumlah sampel dalam dataset.

## Coding

### Library dan Read Data

``` r
#Library untuk read dan write data excel
library(readxl) 
library(writexl)

#library untuk melakukan imputation
library(VIM)
```

    ## Loading required package: colorspace

    ## Loading required package: grid

    ## VIM is ready to use.

    ## Suggestions and bug-reports can be submitted at: https://github.com/statistikat/VIM/issues

    ## 
    ## Attaching package: 'VIM'

    ## The following object is masked from 'package:datasets':
    ## 
    ##     sleep

``` r
#Membaca file data excel "missing data"
data <- read_excel("2_Analisis Missing Value/IC_Data Missing.xlsx") 

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)
```

    ## # A tibble: 6 × 4
    ##   Assignment Tutorial Midterm TakeHome
    ##        <dbl>    <dbl>   <dbl>    <dbl>
    ## 1       57.1     34.1    64.4     51.5
    ## 2       83.7     NA      30       63.2
    ## 3       81.2     NA      49.4    106. 
    ## 4       91.3     NA      95      107. 
    ## 5       95       NA      93.1     97.8
    ## 6       95.0    103.     56.2     99.1

Dari sini terlihat bahwa data sudah bisa terbaca dengan baik, dimana
terdapat 4 variabel dengan 94 baris data.

### Mencari Data Missing

``` r
#Mencari missing data dalam file excel "missing data"
is.na(data)
```

    ##       Assignment Tutorial Midterm TakeHome
    ##  [1,]      FALSE    FALSE   FALSE    FALSE
    ##  [2,]      FALSE     TRUE   FALSE    FALSE
    ##  [3,]      FALSE     TRUE   FALSE    FALSE
    ##  [4,]      FALSE     TRUE   FALSE    FALSE
    ##  [5,]      FALSE     TRUE   FALSE    FALSE
    ##  [6,]      FALSE    FALSE   FALSE    FALSE
    ##  [7,]      FALSE    FALSE   FALSE     TRUE
    ##  [8,]      FALSE    FALSE   FALSE    FALSE
    ##  [9,]      FALSE    FALSE   FALSE    FALSE
    ## [10,]      FALSE    FALSE   FALSE    FALSE
    ## [11,]      FALSE    FALSE   FALSE    FALSE
    ## [12,]      FALSE    FALSE   FALSE     TRUE
    ## [13,]      FALSE    FALSE   FALSE     TRUE
    ## [14,]      FALSE    FALSE   FALSE    FALSE
    ## [15,]      FALSE    FALSE   FALSE    FALSE
    ## [16,]      FALSE    FALSE   FALSE    FALSE
    ## [17,]      FALSE    FALSE   FALSE    FALSE
    ## [18,]      FALSE    FALSE   FALSE    FALSE
    ## [19,]      FALSE    FALSE   FALSE    FALSE
    ## [20,]      FALSE    FALSE   FALSE    FALSE
    ## [21,]      FALSE    FALSE   FALSE    FALSE
    ## [22,]      FALSE    FALSE   FALSE    FALSE
    ## [23,]      FALSE    FALSE   FALSE    FALSE
    ## [24,]      FALSE    FALSE   FALSE    FALSE
    ## [25,]      FALSE    FALSE   FALSE    FALSE
    ## [26,]      FALSE    FALSE   FALSE    FALSE
    ## [27,]      FALSE    FALSE   FALSE    FALSE
    ## [28,]      FALSE     TRUE   FALSE    FALSE
    ## [29,]      FALSE    FALSE   FALSE    FALSE
    ## [30,]      FALSE    FALSE   FALSE    FALSE
    ## [31,]      FALSE    FALSE   FALSE    FALSE
    ## [32,]      FALSE    FALSE   FALSE    FALSE
    ## [33,]       TRUE    FALSE   FALSE     TRUE
    ## [34,]       TRUE    FALSE   FALSE    FALSE
    ## [35,]      FALSE    FALSE   FALSE    FALSE
    ## [36,]      FALSE    FALSE   FALSE    FALSE
    ## [37,]      FALSE    FALSE   FALSE    FALSE
    ## [38,]      FALSE    FALSE   FALSE    FALSE
    ## [39,]      FALSE    FALSE   FALSE    FALSE
    ## [40,]      FALSE    FALSE   FALSE    FALSE
    ## [41,]      FALSE    FALSE   FALSE    FALSE
    ## [42,]      FALSE     TRUE   FALSE    FALSE
    ## [43,]      FALSE    FALSE   FALSE    FALSE
    ## [44,]      FALSE    FALSE   FALSE    FALSE
    ## [45,]      FALSE    FALSE    TRUE    FALSE
    ## [46,]      FALSE    FALSE   FALSE    FALSE
    ## [47,]      FALSE    FALSE   FALSE    FALSE
    ## [48,]      FALSE    FALSE   FALSE    FALSE
    ## [49,]      FALSE    FALSE   FALSE    FALSE
    ## [50,]      FALSE    FALSE   FALSE    FALSE
    ## [51,]      FALSE    FALSE   FALSE    FALSE
    ## [52,]      FALSE    FALSE   FALSE    FALSE
    ## [53,]      FALSE    FALSE   FALSE    FALSE
    ## [54,]      FALSE    FALSE   FALSE    FALSE
    ## [55,]      FALSE    FALSE   FALSE    FALSE
    ## [56,]      FALSE    FALSE   FALSE    FALSE
    ## [57,]      FALSE    FALSE   FALSE    FALSE
    ## [58,]      FALSE    FALSE   FALSE    FALSE
    ## [59,]      FALSE    FALSE   FALSE    FALSE
    ## [60,]      FALSE    FALSE   FALSE    FALSE
    ## [61,]      FALSE    FALSE   FALSE    FALSE
    ## [62,]       TRUE    FALSE   FALSE    FALSE
    ## [63,]      FALSE    FALSE   FALSE    FALSE
    ## [64,]      FALSE    FALSE   FALSE    FALSE
    ## [65,]      FALSE    FALSE   FALSE    FALSE
    ## [66,]      FALSE    FALSE   FALSE    FALSE
    ## [67,]      FALSE    FALSE   FALSE    FALSE
    ## [68,]      FALSE    FALSE   FALSE    FALSE
    ## [69,]      FALSE    FALSE   FALSE    FALSE
    ## [70,]      FALSE    FALSE   FALSE    FALSE
    ## [71,]      FALSE     TRUE   FALSE    FALSE
    ## [72,]      FALSE    FALSE   FALSE    FALSE
    ## [73,]      FALSE    FALSE   FALSE    FALSE
    ## [74,]      FALSE    FALSE   FALSE    FALSE
    ## [75,]      FALSE    FALSE   FALSE    FALSE
    ## [76,]      FALSE    FALSE   FALSE    FALSE
    ## [77,]      FALSE    FALSE   FALSE    FALSE
    ## [78,]      FALSE    FALSE   FALSE    FALSE
    ## [79,]      FALSE    FALSE   FALSE    FALSE
    ## [80,]      FALSE    FALSE   FALSE    FALSE
    ## [81,]      FALSE    FALSE   FALSE    FALSE
    ## [82,]       TRUE    FALSE   FALSE    FALSE
    ## [83,]      FALSE    FALSE   FALSE    FALSE
    ## [84,]      FALSE    FALSE   FALSE    FALSE
    ## [85,]      FALSE    FALSE   FALSE    FALSE
    ## [86,]      FALSE     TRUE   FALSE    FALSE
    ## [87,]      FALSE    FALSE   FALSE    FALSE
    ## [88,]      FALSE    FALSE   FALSE    FALSE
    ## [89,]      FALSE    FALSE   FALSE    FALSE
    ## [90,]      FALSE     TRUE   FALSE    FALSE
    ## [91,]      FALSE    FALSE   FALSE    FALSE
    ## [92,]      FALSE    FALSE   FALSE    FALSE
    ## [93,]      FALSE    FALSE   FALSE     TRUE
    ## [94,]      FALSE    FALSE   FALSE    FALSE

``` r
#Jumlah dari missing data menurut kolom
colSums(is.na(data))
```

    ## Assignment   Tutorial    Midterm   TakeHome 
    ##          4          9          1          5

Berdasarkan hasil pencarian, terdapat:

a\. 4 data missing di variabel “Assignment”

b\. 9 data missing di variabel “Tutorial”

c\. 1 data missing di variabel “Midterm”

d\. 5 data missing di variabel “TakeHome”

Kita akan lanjutkan dengan mengisi data yang missing tersebut dengan
metode yang telah disebutkan sebelumnya.

### Metode Mean Imputation

``` r
#Mengganti data yang hilang (missing data) dengan metode Mean Imputation
data$Assignment = ifelse(is.na(data$Assignment),ave(data$Assignment, FUN = function(x)mean(x, na.rm = TRUE)), data$Assignment)
data$Tutorial = ifelse(is.na(data$Tutorial),ave(data$Tutorial, FUN = function(x)mean(x, na.rm = TRUE)), data$Tutorial)
data$Midterm = ifelse(is.na(data$Midterm),ave(data$Midterm, FUN = function(x)mean(x, na.rm = TRUE)), data$Midterm)
data$TakeHome = ifelse(is.na(data$TakeHome),ave(data$TakeHome,FUN = function(x)mean(x, na.rm = TRUE)), data$TakeHome)

#Export data hasil mean imputation dari R ke Excel
write_xlsx(data, "2_Analisis Missing Value/IC_Data Missing_AfterMeanImp.xlsx") 

#Cek apakah masih ada missing data dalam file excel terbaru
is.na(data)
```

    ##       Assignment Tutorial Midterm TakeHome
    ##  [1,]      FALSE    FALSE   FALSE    FALSE
    ##  [2,]      FALSE    FALSE   FALSE    FALSE
    ##  [3,]      FALSE    FALSE   FALSE    FALSE
    ##  [4,]      FALSE    FALSE   FALSE    FALSE
    ##  [5,]      FALSE    FALSE   FALSE    FALSE
    ##  [6,]      FALSE    FALSE   FALSE    FALSE
    ##  [7,]      FALSE    FALSE   FALSE    FALSE
    ##  [8,]      FALSE    FALSE   FALSE    FALSE
    ##  [9,]      FALSE    FALSE   FALSE    FALSE
    ## [10,]      FALSE    FALSE   FALSE    FALSE
    ## [11,]      FALSE    FALSE   FALSE    FALSE
    ## [12,]      FALSE    FALSE   FALSE    FALSE
    ## [13,]      FALSE    FALSE   FALSE    FALSE
    ## [14,]      FALSE    FALSE   FALSE    FALSE
    ## [15,]      FALSE    FALSE   FALSE    FALSE
    ## [16,]      FALSE    FALSE   FALSE    FALSE
    ## [17,]      FALSE    FALSE   FALSE    FALSE
    ## [18,]      FALSE    FALSE   FALSE    FALSE
    ## [19,]      FALSE    FALSE   FALSE    FALSE
    ## [20,]      FALSE    FALSE   FALSE    FALSE
    ## [21,]      FALSE    FALSE   FALSE    FALSE
    ## [22,]      FALSE    FALSE   FALSE    FALSE
    ## [23,]      FALSE    FALSE   FALSE    FALSE
    ## [24,]      FALSE    FALSE   FALSE    FALSE
    ## [25,]      FALSE    FALSE   FALSE    FALSE
    ## [26,]      FALSE    FALSE   FALSE    FALSE
    ## [27,]      FALSE    FALSE   FALSE    FALSE
    ## [28,]      FALSE    FALSE   FALSE    FALSE
    ## [29,]      FALSE    FALSE   FALSE    FALSE
    ## [30,]      FALSE    FALSE   FALSE    FALSE
    ## [31,]      FALSE    FALSE   FALSE    FALSE
    ## [32,]      FALSE    FALSE   FALSE    FALSE
    ## [33,]      FALSE    FALSE   FALSE    FALSE
    ## [34,]      FALSE    FALSE   FALSE    FALSE
    ## [35,]      FALSE    FALSE   FALSE    FALSE
    ## [36,]      FALSE    FALSE   FALSE    FALSE
    ## [37,]      FALSE    FALSE   FALSE    FALSE
    ## [38,]      FALSE    FALSE   FALSE    FALSE
    ## [39,]      FALSE    FALSE   FALSE    FALSE
    ## [40,]      FALSE    FALSE   FALSE    FALSE
    ## [41,]      FALSE    FALSE   FALSE    FALSE
    ## [42,]      FALSE    FALSE   FALSE    FALSE
    ## [43,]      FALSE    FALSE   FALSE    FALSE
    ## [44,]      FALSE    FALSE   FALSE    FALSE
    ## [45,]      FALSE    FALSE   FALSE    FALSE
    ## [46,]      FALSE    FALSE   FALSE    FALSE
    ## [47,]      FALSE    FALSE   FALSE    FALSE
    ## [48,]      FALSE    FALSE   FALSE    FALSE
    ## [49,]      FALSE    FALSE   FALSE    FALSE
    ## [50,]      FALSE    FALSE   FALSE    FALSE
    ## [51,]      FALSE    FALSE   FALSE    FALSE
    ## [52,]      FALSE    FALSE   FALSE    FALSE
    ## [53,]      FALSE    FALSE   FALSE    FALSE
    ## [54,]      FALSE    FALSE   FALSE    FALSE
    ## [55,]      FALSE    FALSE   FALSE    FALSE
    ## [56,]      FALSE    FALSE   FALSE    FALSE
    ## [57,]      FALSE    FALSE   FALSE    FALSE
    ## [58,]      FALSE    FALSE   FALSE    FALSE
    ## [59,]      FALSE    FALSE   FALSE    FALSE
    ## [60,]      FALSE    FALSE   FALSE    FALSE
    ## [61,]      FALSE    FALSE   FALSE    FALSE
    ## [62,]      FALSE    FALSE   FALSE    FALSE
    ## [63,]      FALSE    FALSE   FALSE    FALSE
    ## [64,]      FALSE    FALSE   FALSE    FALSE
    ## [65,]      FALSE    FALSE   FALSE    FALSE
    ## [66,]      FALSE    FALSE   FALSE    FALSE
    ## [67,]      FALSE    FALSE   FALSE    FALSE
    ## [68,]      FALSE    FALSE   FALSE    FALSE
    ## [69,]      FALSE    FALSE   FALSE    FALSE
    ## [70,]      FALSE    FALSE   FALSE    FALSE
    ## [71,]      FALSE    FALSE   FALSE    FALSE
    ## [72,]      FALSE    FALSE   FALSE    FALSE
    ## [73,]      FALSE    FALSE   FALSE    FALSE
    ## [74,]      FALSE    FALSE   FALSE    FALSE
    ## [75,]      FALSE    FALSE   FALSE    FALSE
    ## [76,]      FALSE    FALSE   FALSE    FALSE
    ## [77,]      FALSE    FALSE   FALSE    FALSE
    ## [78,]      FALSE    FALSE   FALSE    FALSE
    ## [79,]      FALSE    FALSE   FALSE    FALSE
    ## [80,]      FALSE    FALSE   FALSE    FALSE
    ## [81,]      FALSE    FALSE   FALSE    FALSE
    ## [82,]      FALSE    FALSE   FALSE    FALSE
    ## [83,]      FALSE    FALSE   FALSE    FALSE
    ## [84,]      FALSE    FALSE   FALSE    FALSE
    ## [85,]      FALSE    FALSE   FALSE    FALSE
    ## [86,]      FALSE    FALSE   FALSE    FALSE
    ## [87,]      FALSE    FALSE   FALSE    FALSE
    ## [88,]      FALSE    FALSE   FALSE    FALSE
    ## [89,]      FALSE    FALSE   FALSE    FALSE
    ## [90,]      FALSE    FALSE   FALSE    FALSE
    ## [91,]      FALSE    FALSE   FALSE    FALSE
    ## [92,]      FALSE    FALSE   FALSE    FALSE
    ## [93,]      FALSE    FALSE   FALSE    FALSE
    ## [94,]      FALSE    FALSE   FALSE    FALSE

``` r
colSums(is.na(data))
```

    ## Assignment   Tutorial    Midterm   TakeHome 
    ##          0          0          0          0

Setelah berhasil, kita dapat melihat pada file yang telah dibuat dari
program yaitu **IC_Data Missing_AfterMeanImp.xlsx.** Pada file tersebut,
data yang semula missing sudah terisi semua nilainya dengan menggunakan
metode Mean Imputation.

### Metode kNN Imputation

Sebelumnya, karena dataset sebelumnya telah terisi, kita melakukan
pemanggilan ulang dataset dengan mendefinisikan variabel “data2” sebagai
dataset yang digunakan.

``` r
#Membaca file data excel "missing data"
data2 <- read_excel("2_Analisis Missing Value/IC_Data Missing.xlsx") 

#Mengecek file excel sudah dapat terbaca
View(data2)
head(data2)
```

    ## # A tibble: 6 × 4
    ##   Assignment Tutorial Midterm TakeHome
    ##        <dbl>    <dbl>   <dbl>    <dbl>
    ## 1       57.1     34.1    64.4     51.5
    ## 2       83.7     NA      30       63.2
    ## 3       81.2     NA      49.4    106. 
    ## 4       91.3     NA      95      107. 
    ## 5       95       NA      93.1     97.8
    ## 6       95.0    103.     56.2     99.1

``` r
#Mencari missing data dalam file excel "missing data"
is.na(data2)
```

    ##       Assignment Tutorial Midterm TakeHome
    ##  [1,]      FALSE    FALSE   FALSE    FALSE
    ##  [2,]      FALSE     TRUE   FALSE    FALSE
    ##  [3,]      FALSE     TRUE   FALSE    FALSE
    ##  [4,]      FALSE     TRUE   FALSE    FALSE
    ##  [5,]      FALSE     TRUE   FALSE    FALSE
    ##  [6,]      FALSE    FALSE   FALSE    FALSE
    ##  [7,]      FALSE    FALSE   FALSE     TRUE
    ##  [8,]      FALSE    FALSE   FALSE    FALSE
    ##  [9,]      FALSE    FALSE   FALSE    FALSE
    ## [10,]      FALSE    FALSE   FALSE    FALSE
    ## [11,]      FALSE    FALSE   FALSE    FALSE
    ## [12,]      FALSE    FALSE   FALSE     TRUE
    ## [13,]      FALSE    FALSE   FALSE     TRUE
    ## [14,]      FALSE    FALSE   FALSE    FALSE
    ## [15,]      FALSE    FALSE   FALSE    FALSE
    ## [16,]      FALSE    FALSE   FALSE    FALSE
    ## [17,]      FALSE    FALSE   FALSE    FALSE
    ## [18,]      FALSE    FALSE   FALSE    FALSE
    ## [19,]      FALSE    FALSE   FALSE    FALSE
    ## [20,]      FALSE    FALSE   FALSE    FALSE
    ## [21,]      FALSE    FALSE   FALSE    FALSE
    ## [22,]      FALSE    FALSE   FALSE    FALSE
    ## [23,]      FALSE    FALSE   FALSE    FALSE
    ## [24,]      FALSE    FALSE   FALSE    FALSE
    ## [25,]      FALSE    FALSE   FALSE    FALSE
    ## [26,]      FALSE    FALSE   FALSE    FALSE
    ## [27,]      FALSE    FALSE   FALSE    FALSE
    ## [28,]      FALSE     TRUE   FALSE    FALSE
    ## [29,]      FALSE    FALSE   FALSE    FALSE
    ## [30,]      FALSE    FALSE   FALSE    FALSE
    ## [31,]      FALSE    FALSE   FALSE    FALSE
    ## [32,]      FALSE    FALSE   FALSE    FALSE
    ## [33,]       TRUE    FALSE   FALSE     TRUE
    ## [34,]       TRUE    FALSE   FALSE    FALSE
    ## [35,]      FALSE    FALSE   FALSE    FALSE
    ## [36,]      FALSE    FALSE   FALSE    FALSE
    ## [37,]      FALSE    FALSE   FALSE    FALSE
    ## [38,]      FALSE    FALSE   FALSE    FALSE
    ## [39,]      FALSE    FALSE   FALSE    FALSE
    ## [40,]      FALSE    FALSE   FALSE    FALSE
    ## [41,]      FALSE    FALSE   FALSE    FALSE
    ## [42,]      FALSE     TRUE   FALSE    FALSE
    ## [43,]      FALSE    FALSE   FALSE    FALSE
    ## [44,]      FALSE    FALSE   FALSE    FALSE
    ## [45,]      FALSE    FALSE    TRUE    FALSE
    ## [46,]      FALSE    FALSE   FALSE    FALSE
    ## [47,]      FALSE    FALSE   FALSE    FALSE
    ## [48,]      FALSE    FALSE   FALSE    FALSE
    ## [49,]      FALSE    FALSE   FALSE    FALSE
    ## [50,]      FALSE    FALSE   FALSE    FALSE
    ## [51,]      FALSE    FALSE   FALSE    FALSE
    ## [52,]      FALSE    FALSE   FALSE    FALSE
    ## [53,]      FALSE    FALSE   FALSE    FALSE
    ## [54,]      FALSE    FALSE   FALSE    FALSE
    ## [55,]      FALSE    FALSE   FALSE    FALSE
    ## [56,]      FALSE    FALSE   FALSE    FALSE
    ## [57,]      FALSE    FALSE   FALSE    FALSE
    ## [58,]      FALSE    FALSE   FALSE    FALSE
    ## [59,]      FALSE    FALSE   FALSE    FALSE
    ## [60,]      FALSE    FALSE   FALSE    FALSE
    ## [61,]      FALSE    FALSE   FALSE    FALSE
    ## [62,]       TRUE    FALSE   FALSE    FALSE
    ## [63,]      FALSE    FALSE   FALSE    FALSE
    ## [64,]      FALSE    FALSE   FALSE    FALSE
    ## [65,]      FALSE    FALSE   FALSE    FALSE
    ## [66,]      FALSE    FALSE   FALSE    FALSE
    ## [67,]      FALSE    FALSE   FALSE    FALSE
    ## [68,]      FALSE    FALSE   FALSE    FALSE
    ## [69,]      FALSE    FALSE   FALSE    FALSE
    ## [70,]      FALSE    FALSE   FALSE    FALSE
    ## [71,]      FALSE     TRUE   FALSE    FALSE
    ## [72,]      FALSE    FALSE   FALSE    FALSE
    ## [73,]      FALSE    FALSE   FALSE    FALSE
    ## [74,]      FALSE    FALSE   FALSE    FALSE
    ## [75,]      FALSE    FALSE   FALSE    FALSE
    ## [76,]      FALSE    FALSE   FALSE    FALSE
    ## [77,]      FALSE    FALSE   FALSE    FALSE
    ## [78,]      FALSE    FALSE   FALSE    FALSE
    ## [79,]      FALSE    FALSE   FALSE    FALSE
    ## [80,]      FALSE    FALSE   FALSE    FALSE
    ## [81,]      FALSE    FALSE   FALSE    FALSE
    ## [82,]       TRUE    FALSE   FALSE    FALSE
    ## [83,]      FALSE    FALSE   FALSE    FALSE
    ## [84,]      FALSE    FALSE   FALSE    FALSE
    ## [85,]      FALSE    FALSE   FALSE    FALSE
    ## [86,]      FALSE     TRUE   FALSE    FALSE
    ## [87,]      FALSE    FALSE   FALSE    FALSE
    ## [88,]      FALSE    FALSE   FALSE    FALSE
    ## [89,]      FALSE    FALSE   FALSE    FALSE
    ## [90,]      FALSE     TRUE   FALSE    FALSE
    ## [91,]      FALSE    FALSE   FALSE    FALSE
    ## [92,]      FALSE    FALSE   FALSE    FALSE
    ## [93,]      FALSE    FALSE   FALSE     TRUE
    ## [94,]      FALSE    FALSE   FALSE    FALSE

``` r
#Jumlah dari missing data menurut kolom
colSums(is.na(data2))
```

    ## Assignment   Tutorial    Midterm   TakeHome 
    ##          4          9          1          5

\*Hasilnya akan sama dengan bagian “Mencari Data Missing”.

Selanjutnya, kita jalankan coding untuk melakukan metode kNN imputation

``` r
#Mengganti data yang hilang (missing data) dengan metode kNN Imputation
hasildata2 <- kNN(data2, k = 9)

#Export data hasil kNN Imputation dari R ke Excel
write_xlsx(data, "2_Analisis Missing Value/IC_Data Missing_AfterkNNImp.xlsx") 

#Cek apakah masih ada missing data dalam file excel terbaru
is.na(hasildata2)
```

    ##       Assignment Tutorial Midterm TakeHome Assignment_imp Tutorial_imp
    ##  [1,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ##  [2,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ##  [3,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ##  [4,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ##  [5,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ##  [6,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ##  [7,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ##  [8,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ##  [9,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [10,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [11,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [12,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [13,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [14,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [15,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [16,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [17,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [18,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [19,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [20,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [21,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [22,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [23,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [24,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [25,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [26,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [27,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [28,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [29,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [30,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [31,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [32,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [33,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [34,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [35,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [36,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [37,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [38,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [39,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [40,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [41,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [42,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [43,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [44,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [45,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [46,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [47,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [48,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [49,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [50,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [51,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [52,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [53,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [54,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [55,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [56,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [57,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [58,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [59,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [60,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [61,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [62,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [63,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [64,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [65,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [66,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [67,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [68,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [69,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [70,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [71,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [72,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [73,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [74,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [75,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [76,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [77,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [78,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [79,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [80,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [81,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [82,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [83,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [84,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [85,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [86,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [87,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [88,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [89,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [90,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [91,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [92,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [93,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ## [94,]      FALSE    FALSE   FALSE    FALSE          FALSE        FALSE
    ##       Midterm_imp TakeHome_imp
    ##  [1,]       FALSE        FALSE
    ##  [2,]       FALSE        FALSE
    ##  [3,]       FALSE        FALSE
    ##  [4,]       FALSE        FALSE
    ##  [5,]       FALSE        FALSE
    ##  [6,]       FALSE        FALSE
    ##  [7,]       FALSE        FALSE
    ##  [8,]       FALSE        FALSE
    ##  [9,]       FALSE        FALSE
    ## [10,]       FALSE        FALSE
    ## [11,]       FALSE        FALSE
    ## [12,]       FALSE        FALSE
    ## [13,]       FALSE        FALSE
    ## [14,]       FALSE        FALSE
    ## [15,]       FALSE        FALSE
    ## [16,]       FALSE        FALSE
    ## [17,]       FALSE        FALSE
    ## [18,]       FALSE        FALSE
    ## [19,]       FALSE        FALSE
    ## [20,]       FALSE        FALSE
    ## [21,]       FALSE        FALSE
    ## [22,]       FALSE        FALSE
    ## [23,]       FALSE        FALSE
    ## [24,]       FALSE        FALSE
    ## [25,]       FALSE        FALSE
    ## [26,]       FALSE        FALSE
    ## [27,]       FALSE        FALSE
    ## [28,]       FALSE        FALSE
    ## [29,]       FALSE        FALSE
    ## [30,]       FALSE        FALSE
    ## [31,]       FALSE        FALSE
    ## [32,]       FALSE        FALSE
    ## [33,]       FALSE        FALSE
    ## [34,]       FALSE        FALSE
    ## [35,]       FALSE        FALSE
    ## [36,]       FALSE        FALSE
    ## [37,]       FALSE        FALSE
    ## [38,]       FALSE        FALSE
    ## [39,]       FALSE        FALSE
    ## [40,]       FALSE        FALSE
    ## [41,]       FALSE        FALSE
    ## [42,]       FALSE        FALSE
    ## [43,]       FALSE        FALSE
    ## [44,]       FALSE        FALSE
    ## [45,]       FALSE        FALSE
    ## [46,]       FALSE        FALSE
    ## [47,]       FALSE        FALSE
    ## [48,]       FALSE        FALSE
    ## [49,]       FALSE        FALSE
    ## [50,]       FALSE        FALSE
    ## [51,]       FALSE        FALSE
    ## [52,]       FALSE        FALSE
    ## [53,]       FALSE        FALSE
    ## [54,]       FALSE        FALSE
    ## [55,]       FALSE        FALSE
    ## [56,]       FALSE        FALSE
    ## [57,]       FALSE        FALSE
    ## [58,]       FALSE        FALSE
    ## [59,]       FALSE        FALSE
    ## [60,]       FALSE        FALSE
    ## [61,]       FALSE        FALSE
    ## [62,]       FALSE        FALSE
    ## [63,]       FALSE        FALSE
    ## [64,]       FALSE        FALSE
    ## [65,]       FALSE        FALSE
    ## [66,]       FALSE        FALSE
    ## [67,]       FALSE        FALSE
    ## [68,]       FALSE        FALSE
    ## [69,]       FALSE        FALSE
    ## [70,]       FALSE        FALSE
    ## [71,]       FALSE        FALSE
    ## [72,]       FALSE        FALSE
    ## [73,]       FALSE        FALSE
    ## [74,]       FALSE        FALSE
    ## [75,]       FALSE        FALSE
    ## [76,]       FALSE        FALSE
    ## [77,]       FALSE        FALSE
    ## [78,]       FALSE        FALSE
    ## [79,]       FALSE        FALSE
    ## [80,]       FALSE        FALSE
    ## [81,]       FALSE        FALSE
    ## [82,]       FALSE        FALSE
    ## [83,]       FALSE        FALSE
    ## [84,]       FALSE        FALSE
    ## [85,]       FALSE        FALSE
    ## [86,]       FALSE        FALSE
    ## [87,]       FALSE        FALSE
    ## [88,]       FALSE        FALSE
    ## [89,]       FALSE        FALSE
    ## [90,]       FALSE        FALSE
    ## [91,]       FALSE        FALSE
    ## [92,]       FALSE        FALSE
    ## [93,]       FALSE        FALSE
    ## [94,]       FALSE        FALSE

``` r
colSums(is.na(hasildata2))
```

    ##     Assignment       Tutorial        Midterm       TakeHome Assignment_imp 
    ##              0              0              0              0              0 
    ##   Tutorial_imp    Midterm_imp   TakeHome_imp 
    ##              0              0              0

Setelah berhasil, kita dapat melihat pada file yang telah dibuat dari
program yaitu **IC_Data Missing_AfterkNNImp.xlsx.** Pada file tersebut,
data yang semula missing sudah terisi semua nilainya dengan menggunakan
metode kNN Imputation.

## 

