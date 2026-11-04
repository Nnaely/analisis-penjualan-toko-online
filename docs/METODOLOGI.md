# Metodologi dan catatan analisis

## Tingkat data dan cakupan

Unit analisis adalah satu pesanan, bukan satu item produk. Input utama adalah [berkas CLEAN gabungan pada commit sumber](https://github.com/BakiTacos/Indonesia-Ecommerce-Sales-Shipping-Data-2023-2025/blob/89a5eebb99d90ac13c511f2f7317b0767d1e862f/CLEAN/all_months_clean.xlsx). Berkas ini telah dibersihkan dan diagregasi oleh penerbit. Kontribusi proyek adalah profiling lanjutan, normalisasi untuk pelaporan, pembuatan rumus Excel, analisis, rekonsiliasi, dan dokumentasi; proyek tidak mengklaim mengumpulkan transaksi langsung dari marketplace.

Persiapan dan normalisasi menggunakan Python; penulisan workbook menggunakan artifact-tool. Rumus dalam workbook menghitung metrik dan analisis menggunakan sintaks Excel. Salinan sumber dan hasil persiapan tersedia sebagai CSV agar perubahan bisa dibandingkan. Workbook final bernama `Portofolio_Penjualan_Ecommerce_Indonesia.xlsx`.

Sebagian RAW_PUBLIC mengandung kolom identitas pribadi sehingga berkas tersebut tidak disertakan dalam paket distribusi. Analisis memakai versi CLEAN yang berisi ID pesanan anonim dan lokasi tingkat kota/provinsi. ID anonim pada versi RAW_PUBLIC dan CLEAN tidak diasumsikan cocok karena proses penomoran penerbit dapat berbeda. Jangan menggabungkan kedua versi hanya berdasarkan kesamaan `order_id`.

## Persiapan data

1. Simpan salinan input CLEAN dan catat sumber serta versi; pertahankan nilai sumber agar transformasi dapat ditelusuri.
2. Periksa jumlah baris, keunikan ID, nilai kosong, tipe numerik, variasi kategori, dan periode berkas.
3. Ubah waktu pesanan yang tersedia menjadi tanggal/jam Excel. Tanggal kosong tetap kosong. Audit menemukan 1.980 nilai waktu pesanan kosong: 1.214 pada Desember 2024 dan 766 pada Juli 2025. Tidak ditemukan tanggal nonkosong yang gagal diparsing atau berbeda bulan dari berkas. Tanggal kosong tidak diisi dengan tanggal buatan.
4. Bentuk **bulan laporan dari `source_file` untuk seluruh pesanan**. Bulan ini menandai berkas pelaporan, bukan tanggal kejadian yang direkonstruksi. Bandingkan bulan waktu pesanan yang tersedia dengan bulan berkas sebagai pemeriksaan terpisah.
5. Kelompokkan status menjadi Selesai, Batal, dan Belum final sambil mempertahankan status asli. Status penerimaan dengan masa pengajuan retur aktif masuk Belum final.
6. Normalisasi label provinsi serta kelompok pembayaran dan kurir melalui aturan yang terlihat. Nama kurir yang tidak tercantum pada opsi pengiriman tidak ditebak.
7. Untuk analisis pembayaran menurut kategori, masukkan keranjang dengan lebih dari satu kategori ke kelompok **Multi-kategori**. Jangan membagi atau mengulang seluruh pembayaran ke masing-masing kategori tanpa nilai penjualan item.
8. Pertahankan anomali numerik dan tandai untuk ditinjau. Jangan menghapus pesanan hanya agar pemeriksaan menghasilkan nol masalah.

## Definisi perhitungan

| Metrik | Aturan |
| --- | --- |
| Pesanan | Jumlah ID pesanan pada populasi yang dianalisis. |
| Pesanan selesai | Jumlah pesanan dengan status asli Selesai. |
| Pembayaran pesanan selesai | Jumlah Total Pembayaran untuk pesanan selesai, dalam IDR. |
| Rata-rata pembayaran selesai | Pembayaran pesanan selesai dibagi jumlah pesanan selesai; tidak tersedia jika penyebut nol. |
| Tingkat pembatalan | Jumlah pesanan Batal dibagi seluruh pesanan pada kelompok/periode yang sama. |
| Unit pesanan selesai | Total kuantitas pada pesanan selesai; bukan unit bersih setelah pengembalian. |
| Pertumbuhan bulanan | Pembayaran selesai bulan berjalan dibagi bulan sebelumnya, lalu dikurangi satu. |

Rasio dihitung dari total pembilang dan penyebut yang sesuai, bukan rata-rata sederhana atas persentase kelompok. Nilai retur tidak dikurangkan dari pembayaran karena nilai pengembalian dana tidak tersedia. Biaya layanan, biaya iklan, harga pokok, dan pencairan penjual juga tidak lengkap; profitabilitas tidak dihitung.

## Kolom kerja dan formula

Baris header Pesanan berada pada baris 6; data berada pada baris 7–20.854. Kolom A:Z memuat data hasil persiapan yang tersimpan sebagai nilai. Kolom AA:AH menghitung `flag_selesai`, `pembayaran_selesai_idr`, `unit_selesai`, `flag_tanggal_kosong`, `flag_retur_lebih_qty`, `flag_subsidi_lebih_est`, `cek_bulan`, dan `flag_pesanan_retur`.

Formula analisis memakai rentang terbatas dari baris 7 sampai 20.854. Mengubah nilai input yang dirujuk formula akan menghitung ulang hasil terkait. Namun, perubahan label pemetaan pada Referensi tidak menjalankan ulang persiapan A:Z. Terapkan kembali pemetaan pada data sumber, lalu ganti hasil persiapannya dalam salinan workbook. Urutan baris juga perlu dijaga bila menempelkan kolom terpisah: cocokkan menggunakan `order_id`, bukan posisi baris yang kebetulan sama.

## Dashboard dan konteks tahun

Workbook memiliki tujuh sheet: Dashboard, Analisis, Pesanan, Referensi, Kualitas, Kamus_Data, dan Dokumentasi. Sheet Dashboard menggunakan susunan tiga kolom dan palet `#001524`, `#15616D`, serta `#FFECD1`. Satu dropdown pada **Dashboard!AF4** menetapkan tahun aktif: 2023, 2024, atau 2025, dengan nilai awal 2025. Tidak ada filter harian.

Empat metrik utama menghitung total pesanan, pembayaran pesanan selesai, rata-rata pembayaran selesai (AOV), serta tingkat pembatalan pada tahun aktif. Lima grafik Excel native menampilkan komposisi status sebagai donat, pembayaran lima provinsi teratas sebagai batang, pembayaran selesai bulanan sebagai kolom, tingkat pembatalan bulanan sebagai garis, serta enam kelompok alasan pembatalan teratas sebagai batang. Peringkat dan narasi mengikuti tahun yang dipilih.

Area formula pendukung berada pada Dashboard mulai **baris 59**. Perhitungan membaca ringkasan bulanan pada Analisis dan data per pesanan pada Pesanan, menggunakan `bulan_laporan` di kolom C sebagai periode. Angka selesai, batal, dan belum final tetap terpisah. AOV memakai jumlah pesanan selesai sebagai penyebut, sedangkan tingkat pembatalan memakai seluruh pesanan pada konteks tahun atau bulan yang sama.

Tahun 2023 hanya memuat Desember dan 2025 hanya Januari–November; 2024 memuat seluruh tahun. Perbandingan tahunan harus memakai rentang bulan yang sama. Bulan di luar cakupan tidak membuktikan tidak adanya aktivitas toko. Pilihan tahun pada Dashboard berdiri sendiri dari filter tampilan tabel Pesanan. Aturan penggunaan dan pemeriksaan dashboard dijelaskan pada [catatan dashboard](CATATAN_DASHBOARD.md).

## Pemeriksaan dan pembaruan

Pemeriksaan meliputi rekonsiliasi baris dan nominal sumber, partisi status, jumlah tiap dimensi, tanggal kosong, ketidaksesuaian bulan, kuantitas retur melebihi kuantitas, serta subsidi ongkir melebihi estimasi. Anomali subsidi merupakan tanda tinjau, bukan bukti salah transaksi. Hasil verifikasi aktual mengikuti sheet Kualitas dan catatan pengujian yang menyertai rilis.

Audit input tidak menemukan ID pesanan ganda, baris duplikat penuh, kuantitas nol, angka negatif, atau kuantitas retur melebihi kuantitas. Terdapat 17 pesanan dengan subsidi ongkir melebihi estimasi ongkir. Seluruh 1.504 keranjang dengan banyak kategori dipertahankan; nilai pembayaran tidak digandakan.

Untuk menambah periode: gunakan berkas dengan grain dan definisi yang sama, periksa keunikan ID lintas periode, perbarui referensi bulan dan pemetaan, lalu bangun ulang tabel kerja. Perluas rentang formula dan tabel analisis bila jumlah baris berubah. Hitung ulang workbook dan cocokkan total terhadap sumber sebelum menyimpan versi baru. Tombol Refresh All tidak dianggap cukup bila tidak ada koneksi yang sengaja dibuat dan diuji.

Contoh `scripts/impor_source.pq` dapat diimpor secara manual melalui Power Query dengan menyesuaikan path lokal. Contoh ini hanya membaca sumber, bukan pipeline normalisasi lengkap, dan belum terpasang sebagai koneksi aktif. Paket akhir tidak menyertakan program penulis workbook. Rilis ini merupakan snapshot analisis dengan sumber, data hasil persiapan, pemetaan, dan aturan yang terdokumentasi.

Verifikasi workbook sebelum penambahan Dashboard mencakup penghitungan dengan artifact-tool, pembacaan hasil utama, pemeriksaan ekspor, dan tinjauan visual seluruh sheet yang saat itu tersedia. Salinan berkas juga berhasil dibuka dan dihitung ulang melalui Microsoft Excel 16.0. Pengujian kenaikan pembayaran Rp1.000, perubahan status Selesai menjadi Batal, serta pengosongan tanggal memperbarui hasil terkait dengan benar. Nilai latihan dipulihkan dan salinan ditutup tanpa menyimpan perubahan; berkas utama tetap utuh. Detail pengujian sebelumnya tersedia pada VERIFIKASI.json.

Dashboard telah lolos pengujian native Microsoft Excel untuk pilihan tahun 2023, 2024, dan 2025. Empat metrik utama, status, peringkat provinsi dan alasan pembatalan, serta seri grafik cocok dengan kontrol sumber independen. Uji perubahan pembayaran dan status diteruskan ke hasil; penambahan pembayaran pada provinsi di luar lima besar mengubah urutan teratas. Pilihan tahun kosong atau tidak valid menampilkan permintaan memilih tahun. Sumber pengujian dipulihkan dan salinan ditutup tanpa menyimpan perubahan. Isi, formula, format, dan 18 tabel pada enam sheet awal diperiksa terhadap versi sebelumnya; hanya teks terkait penambahan dashboard yang diperbarui. Setelah memperbarui data, hitung ulang workbook dan periksa kembali sheet Kualitas serta seluruh tampilan Dashboard.

Dataset tidak memiliki identitas pelanggan yang dapat dipakai untuk analisis pembelian ulang, retensi, atau kohor. Kategori berasal dari pemetaan penerbit, bukan taksonomi resmi marketplace. Cakupan sampel dan status yang masih terbuka membatasi generalisasi. Temuan deskriptif dapat menjadi hipotesis untuk peninjauan operasional, bukan klaim kausal atau ukuran kinerja seluruh platform.
