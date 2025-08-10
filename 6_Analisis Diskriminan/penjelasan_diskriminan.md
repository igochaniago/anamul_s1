Analisis Diskriminan
================

**Analisis diskriminan** adalah metode statistik yang digunakan untuk
mengelompokkan atau memprediksi suatu data ke dalam kategori tertentu
berdasarkan kombinasi variabel-variabel prediktor. Tujuannya adalah
menemukan fungsi atau model yang dapat membedakan kelompok-kelompok
tersebut secara optimal.

## Persoalan

Soal:

Lakukan analisis diskriminan pada data yang disediakan (Refer to IC_Data
Diskriminan.xlsx)

Terdapat 73 data dengan 6 variabel (“Y1”, “Y2”, “Y3”, “Y4”, “Y5”, dan
“Y6”) dengan 1 faktor.

a\. Cari fungsi diskriminan koefisien

b\. Cari koefisien terstandardized

c\. Hitung t-test masing-masing variabel

d\. Bandingkan poin (b) dan (c) untuk melihat kontribusi tiap variabel
ke pemisahan grup

## Coding

### Library dan Read Data

``` r
#Library untuk data excel
library(readxl)

#Library untuk analisis diskriminan
library(MASS)

#Membaca file data excel
data <- read_excel("6_Analisis Diskriminan/IC_Data Diskriminan.xlsx")

#Mengecek file excel sudah dapat terbaca
View(data)
head(data)
```

    ## # A tibble: 6 × 7
    ##      y1    y2    y3    y4    y5    y6 comparator 
    ##   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <chr>      
    ## 1    22     6    52  83.5  10.9   176 noncarriers
    ## 2    32     8    20  77    11     200 noncarriers
    ## 3    36     7    28  86.5  13.2   171 noncarriers
    ## 4    22    11    30 104    22.6   230 noncarriers
    ## 5    23     1    40  83    15.2   205 noncarriers
    ## 6    30     5    24  78.8   9.6   151 noncarriers

Dari sini terlihat bahwa data sudah terbaca dengan baik, di mana
terdapat 6 variabel (“y1-y6”) dengan 73 baris data dan ada 1 faktor
(“comparator”).

### Membuat Model Diskriminan

``` r
#Membuat model dalam R
model <- lda(comparator ~ y1 + y2 + y3 + y4 + y5 +y6, data = data)
groupmean<-(model$prior%*%model$means)
constant<-(groupmean%*%model$scaling)
```

\*Bagian ini memang tidak terdapat output, tetapi code tetap harus
dijalankan

### Jawaban Soal A: Fungsi Diskriminan

``` r
#Fungsi diskriminan (before standardized)
constant
```

    ##            LD1
    ## [1,] -7.643877

``` r
model$scaling
```

    ##             LD1
    ## y1 -0.065651640
    ## y2  0.023395534
    ## y3 -0.002227237
    ## y4 -0.040177323
    ## y5 -0.003343986
    ## y6 -0.009952229

Dengan menggunakan pembulatan angka, ditemukan persamaan diskriminan
(sebelum terstandardized), sebagai berikut:

**D = -7.64 - 0.066\*y1 + 0.234\*y2 + 0.002\*y3 - 0.040\*y4 -
0.003\*y5 - 0.009\*y6**

### Jawaban Soal B: Koefisien Terstandardized

``` r
#Simpangan baku setiap variabel
sd_var <- apply(data[, paste0("y",1:6)], 2, sd)

#Koefisien yang terstandardized
std_coef <- model$scaling *sd_var
std_coef
```

    ##            LD1
    ## y1 -0.52205124
    ## y2  0.06629363
    ## y3 -0.27431087
    ## y4 -0.54875625
    ## y5 -0.05344360
    ## y6 -0.67942914

Dengan menggunakan pembulatan angka, ditemukan persamaan diskriminan
(terstandardized), sebagai berikut:

**D = -0.522\*y1 + 0.066\*y2 - 0.274\*y3 - 0.549\*y4 - 0.053\*y5 -
0.679\*y6**

Dapat terlihat juga bahwa setelah di-standardize, maka nilai intercept
atau constant sudah tidak ada.

### Jawaban Soal C: T-Test

``` r
#Uji t-test
t_results <- lapply(data[, paste0("y", 1:6)], function(x) {
  t.test(x ~ data$comparator)
})

#Ringkasan hasil t-test
t_summary <- data.frame(
  Variable = paste0("y", 1:6),
  t_value = sapply(t_results, function(res) res$statistic),
  p_value = sapply(t_results, function(res) res$p.value)
)
t_summary
```

    ##      Variable    t_value      p_value
    ## y1.t       y1  4.4343249 6.266292e-05
    ## y2.t       y2 -0.5874024 5.589066e-01
    ## y3.t       y3  4.0719519 2.621962e-04
    ## y4.t       y4  5.2827926 1.343648e-06
    ## y5.t       y5  3.7877702 5.558296e-04
    ## y6.t       y6  6.2248346 8.600158e-08

Di atas merupakan hasil dari t-test nya yang nantinya akan digunakan di
poin (c) untuk comparison.

### Jawaban Soal D: Perbandingan

``` r
#Perbandingan poin (b) dan (c) -> dijadikan tabel
comparison <- data.frame(
  Variable = paste0("y", 1:6),
  Std_Coefficient = as.vector(std_coef),
  t_value = t_summary$t_value,
  p_value = t_summary$p_value
)
comparison
```

    ##   Variable Std_Coefficient    t_value      p_value
    ## 1       y1     -0.52205124  4.4343249 6.266292e-05
    ## 2       y2      0.06629363 -0.5874024 5.589066e-01
    ## 3       y3     -0.27431087  4.0719519 2.621962e-04
    ## 4       y4     -0.54875625  5.2827926 1.343648e-06
    ## 5       y5     -0.05344360  3.7877702 5.558296e-04
    ## 6       y6     -0.67942914  6.2248346 8.600158e-08

Kolom “Std_Coefficient” dari poin (b) menunjukkan kontribusi relatif
setiap variabel dalam membedakan kelompok (carrier vs noncarrier). Tanda
(+/-) menunjukkan arah hubungan dan bukan besarannya.

- Tanda (+): Skor diskriminan naik jika variabel naik

- Tanda (-): Skor diskriminan turun jika variabel naik

Kemudian, kolom “t-test” dari poin (c) adalah untuk membandingkan rerata
antar kelompok untuk tiap variabel (univariate).

- t-value besar -\> Perbedaan rerata antar kelompok lebih signifikan

- p-value \<0.05 -\> perbedaan dianggap signifikan secara statistik

Sehingga dapat disimpulkan sebagai berikut:

- y1 -\> Koefisien besar dan signifikan -\> Kontribusi cukup kuat

- y2 -\> Koefisien kecil dan tidak signifikan -\> Kontribusi kecil dan
  dapat dihilangkan dari model

- y3 -\> Koefisien medium (di tengah antara variabel lain) tetapi
  signifikan -\> Kontribusi medium

- y4 -\> Koefisien besar dan signifikan -\> Kontribusi cukup kuat

- y5 -\> Koefisien paling kecil tetapi signifikan -\> Kontribusi kecil

- y6 -\> Koefisien besar dan signifikan -\> Kontribusi cukup kuat

