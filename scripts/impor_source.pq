// Opsional: buat Blank Query di Excel > Data > Get Data > Advanced Editor.
// Ganti SourcePath dengan lokasi orders_source.csv yang telah diekstrak.
// Query ini mengimpor 19 kolom sumber; bukan koneksi aktif di workbook.
let
    SourcePath = "C:\PORTOFOLIO\data\orders_source.csv",
    Source = Csv.Document(File.Contents(SourcePath), [Delimiter=",", Columns=19, Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Typed = Table.TransformColumnTypes(Headers, {
        {"order_id", type text}, {"total_qty", Int64.Type},
        {"total_weight_gr", Int64.Type}, {"total_returned_qty", Int64.Type},
        {"Total Diskon", Int64.Type}, {"product_categories", type text},
        {"num_product_categories", Int64.Type}, {"Status Pesanan", type text},
        {"Alasan Pembatalan", type text}, {"Opsi Pengiriman", type text},
        {"Metode Pembayaran", type text}, {"Kota/Kabupaten", type text},
        {"Provinsi", type text}, {"Ongkos Kirim Dibayar oleh Pembeli", Int64.Type},
        {"Estimasi Potongan Biaya Pengiriman", Int64.Type},
        {"Total Pembayaran", Int64.Type}, {"Perkiraan Ongkos Kirim", Int64.Type},
        {"source_file", type text}
    }, "en-US"),
    OrderTime = Table.TransformColumns(Typed, {
        {"Waktu Pesanan Dibuat", each if _ = null or _ = "" then null else DateTime.FromText(_, [Culture="en-US"]), type nullable datetime}
    })
in
    OrderTime
