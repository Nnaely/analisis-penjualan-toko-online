# Analisis Penjualan Marketplace Indonesia dengan Excel

Proyek portofolio ini mengolah 20.848 pesanan dari dataset publik e-commerce Indonesia periode Desember 2023–November 2025. Tujuannya adalah menyiapkan data dan analisis yang dapat ditelusuri sebelum membuat dashboard. Hasil saat ini berupa workbook Excel dengan tabel analisis, data per pesanan, definisi metrik, pemetaan nilai, dan pemeriksaan kualitas. Dashboard menunggu referensi desain dari pemilik portofolio.

Mulai dari [workbook Excel](Portofolio_Penjualan_Ecommerce_Indonesia.xlsx). Baca [metodologi](docs/METODOLOGI.md), [temuan dan rekomendasi](docs/TEMUAN_DAN_REKOMENDASI.md), lalu [catatan untuk dashboard](docs/CATATAN_DASHBOARD.md) untuk memahami penggunaan dan pengembangannya.

## Konteks dan sumber

Sumber yang dipakai adalah versi **CLEAN** pada [repositori penerbit BakiTacos](https://github.com/BakiTacos/Indonesia-Ecommerce-Sales-Shipping-Data-2023-2025/tree/89a5eebb99d90ac13c511f2f7317b0767d1e862f), pada commit `89a5eebb99d90ac13c511f2f7317b0767d1e862f`. Identitas Shopee diinferensikan dari nilai pembayaran seperti SPayLater dan Saldo ShopeePay. Penerbit tidak menyebut merek platform secara eksplisit. Karena itu, proyek ini merupakan studi dataset pihak ketiga dalam konteks ekosistem Shopee, bukan analisis resmi perusahaan atau gambaran seluruh pasar Shopee Indonesia. Asal toko dan keaslian transaksi tidak diverifikasi secara independen; data juga tidak dinyatakan sintetis oleh penerbit.

Versi GitHub yang diunduh menyertakan lisensi CC0 1.0. Metadata [Kaggle](https://www.kaggle.com/datasets/bakitacos/indonesia-e-commerce-sales-and-shipping-20232025) menampilkan CC BY-SA 4.0. Paket mempertahankan atribusi, identitas versi GitHub, dan salinan lisensinya agar asal berkas jelas. Jangan menyamakan status lisensi kedua distribusi tanpa memeriksa versinya.

## Pertanyaan bisnis

1. Bagaimana jumlah pesanan dan pembayaran pesanan selesai berubah per bulan?
2. Apakah perubahan pembayaran berasal dari jumlah pesanan selesai atau nilai rata-rata pembayaran?
3. Provinsi dan kelompok keranjang mana yang menyumbang pembayaran terbesar?
4. Bagaimana tingkat pembatalan berbeda menurut metode pembayaran dan kelompok kurir?
5. Alasan pembatalan apa yang paling sering tercatat dan layak ditinjau lebih lanjut?
6. Masalah kualitas apa yang membatasi kesimpulan dan rancangan dashboard berikutnya?

## Isi workbook

| Sheet | Kegunaan |
| --- | --- |
| Analisis | Tabel metrik, tren bulanan, serta perbandingan dimensi bisnis tanpa dashboard. |
| Pesanan | Data kerja pada tingkat satu baris per pesanan dan kolom perhitungan Excel. |
| Referensi | Identitas sumber dan pemetaan nilai yang digunakan dalam persiapan data. |
| Kualitas | Rekonsiliasi dan temuan kualitas, termasuk batasan interpretasinya. |
| Kamus_Data | Arti kolom, tipe, satuan, asal, dan aturan pemakaian. |
| Dokumentasi | Metode, cara menggunakan dan memperbarui proyek, serta batasan. |

Buka Analisis untuk membaca hasil, lalu telusuri angka ke Pesanan. Gunakan filter tabel untuk memeriksa kelompok tertentu. Gunakan Kualitas untuk membedakan hasil yang lolos rekonsiliasi dari anomali sumber yang tetap dipertahankan. Definisi lengkap perhitungan berada di Kamus_Data dan dokumen metodologi.

Filter pada tabel Pesanan mengubah baris yang terlihat; formula SUMIFS pada Analisis tetap menghitung rentang dan kriteria yang tertulis. Ini belum merupakan dashboard dengan filter yang saling terhubung.

## Berkas pendukung dan cara kerja

Paket menyertakan `data/all_months_clean.xlsx` sebagai salinan CLEAN penerbit, `data/orders_source.csv` sebagai ekspor sumber, dan `data/orders_prepared.csv` sebagai hasil persiapan proyek. `data/source_manifest_clean.json` mencatat asal dan checksum berkas sumber. Lisensi distribusi GitHub tersimpan di `LICENSE_DATA.txt`.

Persiapan data dan normalisasi dilakukan dengan Python. Workbook ditulis menggunakan artifact-tool; perhitungan analisis memakai rumus Excel. Pada sheet Pesanan, kolom A:Z adalah data kerja yang sudah disiapkan, sedangkan AA:AH berisi formula. Ini adalah proyek analisis dengan hasil Excel, bukan klaim bahwa seluruh pembersihan dikerjakan secara native di aplikasi Excel.

`scripts/impor_source.pq` merupakan contoh impor sumber melalui Power Query. Skrip tersebut belum menjadi koneksi aktif dalam workbook dan tidak menjalankan seluruh persiapan proyek. Mengubah pemetaan pada Referensi tidak otomatis mengubah data A:Z; pemetaan harus diterapkan ulang dalam tahap persiapan. Detail pembaruan dan batas rentang tersedia dalam metodologi.

## Metrik yang harus dibaca dengan tepat

Metrik nominal utama adalah **pembayaran pesanan selesai**: jumlah `Total Pembayaran` hanya untuk status asli Selesai. Nilai ini dapat mencakup ongkos kirim dan penyesuaian sumber. Nilai tersebut tidak dilabeli pendapatan bersih penjual, GMV, laba, atau arus kas yang telah diterima penjual. Rata-rata pembayaran per pesanan selesai dihitung dengan populasi yang sama.

Tingkat pembatalan menggunakan seluruh pesanan sebagai penyebut. Kelompok **Belum final** ditampilkan terpisah karena hasil akhirnya belum diketahui pada snapshot sumber; kelompok ini mencakup pesanan dalam pengiriman atau masa pengajuan retur. Perbandingan tahunan harus memakai bulan yang sama; tahun 2023 hanya tersedia Desember dan tahun 2025 hanya sampai November.

## Cara menceritakan proyek dalam portofolio

Audit input menemukan 17.768 pesanan selesai, 2.830 batal, dan 250 masih dalam proses atau masa pengajuan retur. Pembayaran pesanan selesai berjumlah Rp1.045.550.734, dengan rata-rata sekitar Rp58.845 per pesanan selesai. Tingkat pembatalan seluruh pesanan adalah 13,57%. Jawa Barat menyumbang 26,34% pembayaran pesanan selesai. Angka ini menggambarkan sampel toko pada dataset, bukan pangsa pasar provinsi.

Seluruh 250 pesanan yang belum final berada pada November 2025. Penurunan pembayaran selesai pada bulan tersebut perlu dibaca bersama status terbuka ini, bukan langsung dianggap penurunan permintaan. Untuk contoh perbandingan lebih setara, pembayaran selesai Januari–Oktober 2025 naik sekitar 1,70% terhadap Januari–Oktober 2024.

“Saya membangun proyek Excel dari dataset publik pesanan marketplace Indonesia. Saya memisahkan transaksi selesai, batal, dan belum final, mempertahankan tanggal yang hilang, lalu menyusun analisis bulanan serta segmentasi pembayaran dan wilayah. Saya juga mendefinisikan batas metrik agar pembayaran pembeli tidak salah disebut pendapatan bersih.”

Tunjukkan satu angka hasil analisis, rumus pendukung, dan rekonsiliasinya ketika presentasi. Sajikan rekomendasi sebagai usulan pemeriksaan atau eksperimen; perbedaan antarkelompok belum membuktikan sebab akibat. Tambahkan identitas pemilik portofolio, ringkasan temuan yang sudah dipahami, dan tangkapan layar analisis setelah meninjau workbook sendiri.

## Tahap berikutnya

Setelah desain tersedia, dashboard dapat menggunakan tabel Pesanan dan definisi metrik yang sama. Tentukan tata letak, pilihan periode, filter, warna, dan kebutuhan interaksi sebelum menambahkan visual. Untuk pembaruan data, baca metodologi terlebih dahulu: workbook ini tidak mengklaim koneksi langsung ke marketplace, query tersambung, atau pembaruan otomatis.
