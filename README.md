# MyPortfolio Mobile

Aplikasi mobile portofolio pribadi yang dibuat dengan Flutter sebagai bagian dari mata kuliah Pemrograman Berbasis Platform (CSGE602022). Halaman utama menampilkan identitas pemilik dan tiga aksi portofolio.

## Menjalankan aplikasi

Pastikan Flutter SDK sudah terpasang, lalu jalankan perintah berikut dari root proyek:

```sh
flutter pub get
flutter run
```

Untuk memeriksa kualitas kode:

```sh
flutter analyze
```

### Tugas 7

1. **Apa yang dimaksud dengan widget tree dan bagaimana hubungan parent-child bekerja?**

   Widget tree adalah susunan widget bertingkat yang mendeskripsikan antarmuka Flutter. Widget parent membungkus dan mengatur satu atau beberapa child. Parent dapat memberi batas ukuran, posisi, gaya, atau perilaku kepada child. Contohnya, `Scaffold` menjadi parent untuk `AppBar` dan `body`, sedangkan `Padding` membungkus konten agar memiliki jarak dari tepi layar. Susunan ini dibangun kembali oleh Flutter saat perlu memperbarui tampilan.

2. **Widget apa saja yang digunakan dan apa fungsinya?**

   `MaterialApp` menyediakan kerangka aplikasi Material, tema, dan halaman awal. `Scaffold` menyediakan struktur halaman, termasuk app bar dan body. `AppBar` menampilkan judul halaman. `ListView` membuat konten halaman dapat digulir. `Row` menyusun kartu profil secara horizontal dan `Expanded` membagi ruang yang tersedia. `InfoCard` adalah widget khusus untuk menampilkan satu informasi profil dengan `Card`, `Padding`, `Column`, `Text`, dan `FittedBox`. `SizedBox` memberi jarak antarkomponen. `GridView.count` menyusun menu dalam kisi dan `NeverScrollableScrollPhysics` menyerahkan gulir kepada `ListView`. `ItemCard` adalah widget khusus yang membungkus aksi dengan `Material` dan `InkWell`; `Icon` dan `Text` menampilkan isi tombol. Saat tombol dipilih, `ScaffoldMessenger` menampilkan `SnackBar`.

3. **Apa fungsi `MaterialApp` dan mengapa biasanya menjadi root widget?**

   `MaterialApp` menyiapkan fitur tingkat aplikasi yang mengikuti Material Design, seperti tema, navigasi, lokalisasi, dan konfigurasi halaman. Widget ini biasanya menjadi root agar seluruh halaman di bawahnya dapat memakai konfigurasi dan layanan tersebut secara konsisten. Dalam proyek ini, `MyApp` mengembalikan `MaterialApp` dan menetapkan `MyHomePage` sebagai halaman awal.

4. **Apa perbedaan `StatelessWidget` dan `StatefulWidget`, dan kapan memilihnya?**

   `StatelessWidget` tidak menyimpan state yang berubah selama umur widget; tampilannya ditentukan oleh konfigurasi yang diterimanya. `StatefulWidget` memiliki objek `State` untuk menyimpan data yang dapat berubah dan membangun ulang tampilan, biasanya melalui `setState`. Pilih `StatelessWidget` untuk tampilan yang isinya tetap seperti halaman dan kartu pada tugas ini. Pilih `StatefulWidget` ketika interaksi mengubah data yang perlu ditampilkan, seperti formulir yang menyimpan input atau penghitung.

5. **Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana digunakan dalam `build`?**

   `BuildContext` adalah referensi ke lokasi sebuah widget di dalam widget tree. Melalui context, widget dapat mencari informasi atau layanan dari ancestor-nya, misalnya tema dengan `Theme.of(context)`, ukuran layar dengan `MediaQuery.of(context)`, dan `ScaffoldMessenger` untuk menampilkan `SnackBar`. Method `build(BuildContext context)` menerima context agar widget dapat menyusun tampilan berdasarkan posisi dan lingkungan tersebut.

6. **Apa itu hot reload dan apa bedanya dengan hot restart? Kapan hot restart atau full restart diperlukan?**

   Hot reload memasukkan perubahan kode ke aplikasi yang sedang berjalan dan umumnya mempertahankan state saat ini. Hot restart memulai ulang aplikasi Flutter dari awal sehingga state aplikasi direset. Hot reload cocok untuk perubahan UI dan logika yang tidak membutuhkan inisialisasi ulang. Gunakan hot restart jika perubahan menyentuh state awal atau proses inisialisasi yang tidak diterapkan ulang oleh hot reload. Full restart diperlukan bila perubahan native, plugin, atau konfigurasi platform perlu dibangun dan dimuat ulang.

## Pengungkapan penggunaan AI

OpenAI Codex membantu menyusun dan merapikan implementasi halaman Flutter serta draf dokumentasi. Saya perlu meninjau kembali kecocokan identitas, kode, dan penjelasan dengan materi perkuliahan sebelum pengumpulan.
