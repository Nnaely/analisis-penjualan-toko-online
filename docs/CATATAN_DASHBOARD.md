# Catatan penggunaan dashboard

Sheet Dashboard memakai susunan tiga kolom dengan latar hijau `#15616D`, panel grafik dan kartu angka krem `#FFECD1`, serta teks hitam `#000000`. Empat metrik utama dan lima grafik Excel native menyajikan hasil untuk tahun yang dipilih. Tabel Analisis tetap tersedia untuk menelusuri perhitungan lebih rinci.

## Pilihan tahun dan cakupan

Ubah dropdown **AF4** pada Dashboard ke **2023, 2024, atau 2025**; pilihan awal adalah **2025**. Metrik, peringkat teratas, dan narasi menggunakan tahun yang sama. Tahun 2023 hanya mencakup Desember, 2024 mencakup Januari–Desember, dan 2025 mencakup Januari–November. Tidak ada filter harian. Bulan di luar cakupan sumber tidak berarti toko mencatat penjualan nol.

Periode mengikuti `bulan_laporan`, yang berasal dari nama berkas sumber dan tersimpan di kolom C sheet Pesanan. Sebanyak 1.980 waktu pesanan kosong tetap kosong; hari dan jam tidak diimputasi. Seluruh 250 pesanan Belum final berada pada November 2025, sehingga perubahan pembayaran selesai pada bulan itu perlu dibaca bersama status terbukanya.

## Metrik dan grafik

Empat metrik adalah **total pesanan**, **pembayaran pesanan selesai**, **AOV pembayaran selesai**, dan **tingkat pembatalan**. AOV membagi pembayaran pesanan selesai dengan jumlah pesanan selesai. Tingkat pembatalan membagi pesanan Batal dengan seluruh pesanan pada tahun terpilih. Nilai pembayaran dapat mencakup ongkir dan penyesuaian sumber; nilai ini tidak digunakan sebagai pendapatan bersih.

| Grafik | Ukuran yang ditampilkan |
| --- | --- |
| Donat status | Jumlah pesanan Selesai, Batal, dan Belum final. |
| Batang lima provinsi teratas | Pembayaran pesanan selesai per provinsi. |
| Kolom bulanan | Pembayaran pesanan selesai per bulan. |
| Garis pembatalan bulanan | Pesanan Batal dibagi seluruh pesanan setiap bulan. |
| Batang enam alasan pembatalan teratas | Jumlah pesanan Batal menurut kelompok alasan. |

Peringkat provinsi dan alasan pembatalan dihitung ulang untuk tahun terpilih. Grafik membaca formula pendukung pada Dashboard mulai baris 59. Formula tersebut memakai ringkasan bulanan Analisis dan data Pesanan. Filter atau sort pada tabel Pesanan tidak menggantikan pilihan tahun AF4 dan tidak otomatis memfilter seluruh ringkasan.

## Pemeriksaan dan pembaruan

Dashboard telah diuji di Microsoft Excel untuk pilihan tahun 2023, 2024, dan 2025. Jumlah pesanan, pembayaran, rata-rata, tingkat pembatalan, peringkat wilayah, dan alasan pembatalan cocok dengan kontrol sumber independen. Pengujian perubahan pembayaran, status, dan peringkat wilayah memperbarui hasil terkait. Grafik bulanan hanya memuat bulan yang tersedia pada sumber: 1, 12, dan 11 titik menurut tahun. Nilai pengujian dipulihkan; workbook utama tetap pada pilihan awal 2025.

Saat data diperbarui, periksa rentang formula yang dibatasi, daftar provinsi dan kelompok alasan, serta semua area pendukung mulai baris 59. Hitung rasio dari jumlah pembilang dan penyebut yang sesuai; jangan merata-ratakan persentase bulanan. Pemetaan A:Z tetap merupakan hasil persiapan, sehingga perubahan Referensi harus diterapkan ulang pada data kerja.
