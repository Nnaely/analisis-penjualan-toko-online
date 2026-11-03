# Catatan untuk pengembangan dashboard

Dashboard belum dibuat. Dokumen ini menyiapkan definisi dan kebutuhan data agar desain yang dipilih nanti dapat diterapkan tanpa mengubah arti metrik. Warna, tata letak, jenis grafik, dan interaksi visual menunggu referensi desain pemilik portofolio.

## Sumber dan kandidat metrik

Gunakan tabel Pesanan dengan grain satu baris per `order_id`. Kandidat metrik adalah jumlah pesanan, jumlah selesai, pembayaran pesanan selesai, rata-rata pembayaran selesai, tingkat pembatalan, unit pesanan selesai, dan jumlah pesanan belum final. Nominal pembayaran harus diberi satuan IDR dan disebut pembayaran pembeli, bukan pendapatan bersih.

Dimensi yang tersedia meliputi `bulan_laporan`, `status_kelompok`, `provinsi_bersih`, `metode_kelompok`, `kurir`, `kategori_analisis`, dan `alasan_kelompok`. Label asli tetap dapat dipakai untuk menelusuri kelompok. Kolom AA:AH menyediakan perhitungan pendukung. Pemetaan A:Z tersimpan sebagai nilai; perubahan referensi harus diterapkan kembali melalui tahap persiapan data.

## Aturan periode dan filter

Gunakan bulan laporan dari berkas sumber untuk cakupan bulanan yang lengkap. Sebanyak 1.980 tanggal pesanan kosong tetap tidak memiliki hari yang diketahui; fitur harian harus menampilkan pengecualian tersebut. Perbandingan tahunan wajib memakai rentang bulan yang sama. Seluruh 250 pesanan belum final berada pada November 2025 sehingga status terbuka perlu terlihat dalam pembacaan periode itu.

Untuk tingkat pembatalan, penyebutnya seluruh pesanan pada konteks filter yang sama. Filter status Batal tidak boleh secara tidak sengaja menjadikan tingkat pembatalan 100%. Kelompok Multi-kategori bersifat eksklusif: jangan mengulang nilai satu keranjang ke setiap kategori. Filter tabel pada workbook saat ini belum mengendalikan seluruh ringkasan Analisis.

## Pemeriksaan sebelum dashboard dirilis

1. Cocokkan jumlah dan pembayaran tanpa filter terhadap Analisis dan Kualitas.
2. Uji kelompok tanpa pesanan selesai, termasuk Mitra Shopee: rata-rata pembayaran harus tidak tersedia, bukan kesalahan pembagian.
3. Uji kelompok Pembayaran dibebaskan yang memiliki pesanan selesai dengan pembayaran nol; nol merupakan nilai valid.
4. Periksa November 2025, dua bulan bertanggal kosong, Multi-kategori, dan kurir Tidak tercantum.
5. Hitung rasio dari total pembilang dan penyebut, bukan rata-rata persentase kelompok.
6. Pastikan tambahan periode memperluas tabel dan semua rentang formula; jalankan ulang rekonsiliasi setelah perubahan.
