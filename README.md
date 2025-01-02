# NewsApp - Mobile News Application

NewsApp adalah aplikasi mobile native yang menampilkan berita terkini dari berbagai sumber menggunakan API dari NewsAPI. Aplikasi ini memberikan pengalaman pengguna yang sederhana dan efektif dalam menjelajahi berita dari berbagai kategori.

## Fitur Utama

1. Kategori Berita - Jelajahi berita berdasarkan berbagai kategori seperti Teknologi, Olahraga, Kesehatan, dan lain-lain.

2. Sumber Berita - Lihat daftar sumber berita yang tersedia dalam setiap kategori.

3. Artikel Berita - Tampilkan artikel dari sumber berita yang dipilih.

4. Detail Artikel - Baca detail artikel langsung di dalam aplikasi menggunakan WebView.

5. Pencarian Berita & Sumber - Cari sumber berita atau artikel tertentu berdasarkan kata kunci.

6. Endless Scrolling - Muat lebih banyak sumber dan artikel secara otomatis saat melakukan scrolling.

7. Handling Positive/Negative Cases - Aplikasi ini menampilkan pesan yang sesuai jika terjadi kesalahan atau data kosong.

## Teknologi yang Digunakan

1. Flutter (Dart) - Framework utama untuk pengembangan aplikasi.

2. HTTP - Digunakan untuk mengambil data dari API.

3. Provider - State management untuk mengelola data aplikasi.

4. WebView - Untuk menampilkan detail artikel berita.

## Instalasi dan Konfigurasi

1. Clone repository ini:

`git clone https://github.com/vchandra22/portal-berita-flutter.git`

2. Masuk ke direktori proyek:

3. cd portal-berita-flutter

4. Install dependencies:

`flutter pub get`

5. Konfigurasi API Key:

6. Daftar akun di NewsAPI.

7. Dapatkan API key.

8. Tambahkan API key ke file lib/services/news_service.dart:

`final String apiKey = 'YOUR_API_KEY_HERE';`

## Jalankan Aplikasi:

`flutter run`

## Kontribusi

Jika Anda ingin berkontribusi ke proyek ini, silakan kunjungi [repository GitHub](https://github.com/vchandra22/portal-berita-flutter) untuk informasi lebih lanjut.

