# Menelusuri dan melatih ulang analisis di Excel

Workbook utama sudah berisi data dan rumus. Panduan ini membantu memahami alurnya. Persiapan data pada proyek ini dikerjakan dengan Python; analisis serta rekonsiliasi disimpan sebagai rumus Excel. Workbook tidak memiliki koneksi Power Query aktif atau PivotTable tersimpan.

## 1. Tinjau sumber

Buka `data/all_months_clean.xlsx` untuk melihat 19 kolom yang diterbitkan. Alternatifnya, impor `data/orders_source.csv` melalui Data → From Text/CSV dengan encoding UTF-8 dan pemisah koma. Tetapkan `order_id` sebagai Text, kuantitas serta nominal sebagai Whole Number, dan waktu pesanan sebagai Date/Time. Nilai tanggal yang kosong harus tetap null.

Skrip `scripts/impor_source.pq` dapat ditempelkan pada Advanced Editor sebuah Blank Query setelah Anda mengganti `SourcePath`. Skrip tersebut hanya menyiapkan impor sumber. Eksekusinya di Power Query belum diuji dalam aplikasi Excel.

## 2. Tinjau persiapan data

Bandingkan sumber dengan `data/orders_prepared.csv` dan kolom A:Z pada sheet Pesanan. Gunakan enam tabel pemetaan pada Referensi: MapBulan, MapStatus, MapBayar, MapProvinsi, MapKurir dan MapBatal. Bila mencoba ulang dengan Power Query, gunakan Merge Queries dengan pencocokan tepat pada kolom asli. Pastikan setiap nilai sumber memiliki satu pasangan; hentikan pembaruan dan lengkapi peta jika muncul nilai baru.

Bulan laporan diambil dari `source_file` melalui MapBulan. Nilai awal bulan hanya kunci pengelompokan bulanan; waktu pesanan yang kosong tidak diisi. Untuk kategori, gunakan aturan `jumlah_kategori > 1` menjadi `Multi-kategori`, selebihnya gunakan kategori asli. Status selain Selesai atau Batal masuk Belum final pada versi ini. Tinjau status baru sebelum menerapkan aturan pada data baru.

## 3. Telusuri rumus

Pada Pesanan, header berada di baris 6 dan data mulai baris 7. Contoh rumus pada baris 7:

```excel
AA7 = IF(E7="Selesai",1,0)
AB7 = IF(AA7=1,Y7,0)
AC7 = IF(AA7=1,R7,0)
AD7 = IF(ISNUMBER(B7),0,1)
AE7 = IF(S7>R7,1,0)
AF7 = IF(W7>X7,1,0)
AG7 = IF(B7="","Tidak tersedia",IF(DATE(YEAR(B7),MONTH(B7),1)=C7,"Sesuai","Berbeda"))
AH7 = IF(S7>0,1,0)
```

Pemisah argumen pada Excel lokal mungkin berupa titik koma. Rumus dalam berkas XLSX disimpan dengan format Excel yang berlaku lintas bahasa.

Analisis menjumlahkan AB untuk pembayaran selesai, AA untuk pesanan selesai dan AC untuk unit selesai. Contoh tren bulanan memakai `SUMIFS` dan `COUNTIFS` dengan bulan pada kolom C Pesanan. Persentase dihitung dari komponen totalnya; jangan menjumlahkan persentase atau merata-ratakan rerata kelompok tanpa bobot.

## 4. Latihan perubahan pada salinan

1. Simpan salinan workbook.
2. Pada baris 7 Pesanan, tambahkan Rp1.000 ke pembayaran_idr (Y7). Pembayaran selesai pada Analisis harus naik Rp1.000 karena pesanan ini berstatus Selesai.
3. Kembalikan nilai awal. Ubah status_kelompok (E7) menjadi Batal. Pesanan selesai turun satu dan pesanan batal naik satu; nominal pesanan tersebut keluar dari pembayaran selesai.
4. Tutup salinan latihan tanpa menyimpan, atau pulihkan semua nilai awal.

Kontrol Kualitas akan menandai perbedaan dari sumber selama latihan; itu perilaku yang diharapkan. Mengubah status tidak otomatis mengubah status_asli atau alasan karena kolom tersebut menyimpan data sumber/persiapan.

## 5. Jika jumlah data bertambah

Rentang rumus saat ini dibatasi sampai baris 20854. Menambahkan baris ke TblPesanan saja belum cukup untuk memastikan semua agregasi ikut meluas. Perluas rentang formula yang relevan, pastikan formula AA:AH terisi sampai baris akhir baru, tambahkan nilai dimensi/periode baru pada tabel analisis, hitung ulang kontrol independen, dan ulangi rekonsiliasi. Untuk dataset baru, proses persiapan dan pembentukan ulang workbook lebih aman dilakukan sebagai versi baru yang terdokumentasi.

Dashboard, grafik dan slicer baru dibuat setelah referensi desain ditentukan.
