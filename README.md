# Tugas 7

### 1.Jelaskan apa itu *widget tree* pada Flutter dan bagaimana hubungan *parent-child* (induk-anak) bekerja antar widget.

**Widget Tree** (Pohon Widget) adalah representasi struktural dari seluruh antarmuka pengguna (UI)  di Flutter. Karena "segalanya adalah widget" di Flutter, UI dibangun dengan cara menyusun widget di dalam widget lain, menciptakan hierarki. Struktur bersarang inilah yang disebut sebagai *widget tree*.

Hubungan **parent-child** (induk-anak) adalah inti dari *widget tree*:

* **Parent (Induk):** Adalah widget yang "membungkus" atau berisi widget lain. Contoh: `Column` adalah *parent* bagi widget-widget di dalamnya.
* **Child (Anak):** Adalah widget yang berada di dalam *parent*. Contoh: `Text` di dalam `Column` adalah *child* dari `Column`.

Cara kerjanya adalah sebagai berikut:
1.  **Kendali dari Atas ke Bawah:** *Parent* "memberitahu" *child*-nya batasan (disebut *constraints*), seperti "kamu boleh memiliki lebar maksimal 300 piksel".
2.  **Ukuran dari Bawah ke Atas:** *Child* kemudian "memutuskan" ukurannya sendiri berdasarkan batasan tersebut (misalnya, "OK, saya akan menggunakan lebar 250 piksel") dan memberitahu *parent*.
3.  **Posisi dari Atas ke Bawah:** *Parent* kemudian "memutuskan" di mana harus meletakkan *child*-nya (misalnya, di tengah layar).

---

### 2.Sebutkan semua *widget* yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

Berikut adalah widget-widget utama yang digunakan dalam proyek `monokotil_shop` ini:

**Widget Kustom (Dibuat Sendiri):**
* **`MyHomePage`**: Widget `StatelessWidget` yang menjadi halaman utama aplikasi. Berfungsi sebagai "layar" yang menampung dan menyusun semua widget lainnya.
* **`InfoCard`**: Widget `StatelessWidget` kustom yang berfungsi untuk menampilkan kartu informasi (NPM, Nama, Kelas). Menggunakan `Card` dan `Column` untuk menyusun teks `title` dan `content`.
* **`ItemCard`**: Widget `StatelessWidget` kustom yang berfungsi untuk menampilkan satu item menu (seperti "All Products") dalam bentuk kotak berwarna dengan ikon dan teks. Menggunakan `Material`, `InkWell`, dan `Column`.

**Widget Tata Letak (Layout):**
* **`Scaffold`**: Menyediakan struktur visual dasar halaman, termasuk `appBar` dan `body`.
* **`Column`**: Menyusun *children* (widget-widget di dalamnya) secara vertikal. Digunakan untuk tata letak utama halaman, di dalam `InfoCard`, dan di dalam `ItemCard`.
* **`Row`**: Menyusun 3 `InfoCard` secara horizontal.
* **`Padding`**: Memberikan ruang kosong (jarak) di sekeliling *child*-nya. Digunakan untuk memberi jarak pada `body` utama dan di atas teks sambutan.
* **`SizedBox`**: Membuat kotak dengan ukuran tetap. Digunakan untuk memberi jarak vertikal antar elemen.
* **`Center`**: Memposisikan *child*-nya di tengah. Digunakan untuk menengahkan `Column` yang berisi teks sambutan dan `GridView`.
* **`GridView`**: Menampilkan daftar `ItemCard` dalam format grid 3 kolom yang dapat digulir.
* **`Container`**: "Kotak" serbaguna yang digunakan di dalam `InfoCard` (untuk mengatur lebar responsif dan `padding`) dan `ItemCard` (untuk `padding`).

**Widget Tampilan & Fungsional:**
* **`AppBar`**: Bilah atas aplikasi yang menampilkan `title`.
* **`Text`**: Menampilkan string teks. Digunakan untuk judul `AppBar`, teks sambutan, judul dan konten `InfoCard`, serta nama item di `ItemCard`.
* **`Card`**: Membuat panel persegi panjang dengan *elevation* (bayangan). Digunakan sebagai dasar dari `InfoCard`.
* **`Material`**: Menyediakan *canvas* untuk `InkWell` di `ItemCard`, serta mengatur warna latar belakang (`item.color`) dan `borderRadius`.
* **`InkWell`**: Membuat *child*-nya (`Container` di `ItemCard`) dapat merespons sentuhan (tap) dan menampilkan efek *ripple* (percikan).
* **`Icon`**: Menampilkan ikon grafis. Digunakan di dalam `ItemCard`.

**Widget Utilitas (Penyedia Data/Konteks):**
* **`Theme`**: Digunakan untuk mengakses data tema aplikasi, seperti `colorScheme.primary` untuk warna `AppBar`.
* **`MediaQuery`**: Digunakan di `InfoCard` untuk mendapatkan lebar layar perangkat (`MediaQuery.of(context).size.width`) agar ukuran kartu bisa responsif.
* **`ScaffoldMessenger`**: Mengelola dan menampilkan `SnackBar` saat `ItemCard` ditekan.
* **`SnackBar`**: Pesan sementara yang muncul di bagian bawah layar untuk memberi tahu pengguna bahwa mereka telah menekan tombol.
---

### 3.Apa fungsi dari widget `MaterialApp`? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

Fungsi utama `MaterialApp` adalah **mengonfigurasi aplikasi dengan fungsionalitas dan gaya Material Design.**

Secara spesifik, `MaterialApp` melakukan hal-hal berikut:

1.  **Manajemen Tema:** Menerapkan `ThemeData` (tema global) ke seluruh aplikasi, sehingga semua widget di bawahnya dapat menggunakan skema warna dan gaya teks yang konsisten.
2.  **Manajemen Navigasi:** Menyiapkan `Navigator` utama, yang memungkinkan perpindahan antar halaman/layar menggunakan *routes* (rute).
3.  **Pengaturan Awal:** Mengatur *widget* mana yang akan ditampilkan sebagai halaman *default* (menggunakan properti `home`).

**Mengapa digunakan sebagai widget root?**
`MaterialApp` digunakan sebagai *widget root* (widget paling atas di *tree*) karena ia **menyediakan konteks (context) penting** yang dibutuhkan oleh hampir semua widget lain di dalam aplikasi.

Banyak widget inti Flutter (seperti `Scaffold`, `Dialog`, atau `Navigator`) perlu "mencari" `MaterialApp` di atas mereka dalam *widget tree* untuk dapat berfungsi dengan benar. Tanpa `MaterialApp`, widget-widget tersebut tidak akan dapat menemukan `Theme` atau `Navigator` yang dibutuhkannya.

---

### 4.Jelaskan perbedaan antara `StatelessWidget` dan `StatefulWidget`. Kapan kamu memilih salah satunya?

Perbedaan utamanya terletak pada **kemampuan untuk berubah setelah dibangun.**

* **`StatelessWidget` (Widget Tanpa Status)**
    * **Sifat:** *Immutable* (tidak dapat berubah).
    * **Data:** Datanya tidak pernah berubah setelah *widget* dibuat.
    * **Siklus Hidup:** Hanya memiliki metode `build()`.
    * **Cara Kerja:** Widget ini digambar sekali dan tidak akan pernah digambar ulang *kecuali* jika data input dari *parent*-nya berubah.

* **`StatefulWidget` (Widget Dengan Status)**
    * **Sifat:** *Mutable* (dapat berubah).
    * **Data:** Memiliki objek `State` internal yang dapat menyimpan data yang bisa berubah seiring waktu.
    * **Siklus Hidup:** Memiliki siklus hidup yang lebih kompleks (`createState()`, `initState()`, `build()`, `setState()`, `dispose()`).
    * **Cara Kerja:** Dapat memicu *rebuild* (penggambaran ulang) dirinya sendiri kapan saja dengan memanggil metode `setState()`.

**Kapan memilih salah satunya?**

* **Pilih `StatelessWidget` jika:** Widget **statis** dan tidak perlu berubah berdasarkan interaksi pengguna atau data internal (contoh: ikon, label teks, judul).
* **Pilih `StatefulWidget` jika:** Widget **dinamis** dan perlu mengubah tampilannya selama *runtime* (contoh: *checkbox*, *slider*, *form input*).

---

### 5.Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana penggunaannya di metode `build`?

**Apa itu `BuildContext`?**
`BuildContext` adalah "lokator" atau "pegangan" yang **memberi tahu sebuah widget di mana lokasinya saat ini** di dalam *widget tree*. Setiap *widget* memiliki `BuildContext`-nya sendiri.

**Mengapa penting?**
`BuildContext` sangat penting karena ia adalah satu-satunya cara bagi sebuah *widget* untuk **berinteraksi dengan *widget tree* di sekitarnya**, terutama dengan "leluhur" (ancestor) atau *widget* yang berada di atasnya.

Fungsi utamanya adalah untuk "mengambil" atau "meminta" layanan dari *widget* leluhur. Contoh:

* `Theme.of(context)`: Mencari `Theme` terdekat di atasnya.
* `Navigator.of(context)`: Mencari `Navigator` terdekat untuk berpindah halaman.
* `ScaffoldMessenger.of(context)`: Mencari `ScaffoldMessenger` untuk menampilkan `SnackBar`.

**Bagaimana penggunaannya di metode `build`?**
Metode `build` memiliki tanda tangan `Widget build(BuildContext context)`. Parameter `context` inilah yang digunakan untuk melakukan pencarian ke atas *tree* seperti pada contoh di atas.

---

### 6.Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

Keduanya adalah fitur yang mempercepat proses *development*, tetapi bekerja dengan cara yang sangat berbeda.

* ** Hot Reload (Muat Ulang Instan)**
    * **Apa yang dilakukannya?** Menyuntikkan *file* kode sumber yang telah diperbarui ke dalam **Dart Virtual Machine (VM)** yang sedang berjalan.
    * **Hasil:** *Framework* Flutter membangun ulang *widget tree* (memanggil ulang metode `build()`).
    * **State:** **State (status) aplikasi tetap terjaga**. Nilai variabel dalam `State`  tidak akan hilang.
    * **Kapan digunakan?** Saat membuat perubahan pada UI atau logika di dalam metode `build`.

* ** Hot Restart (Mulai Ulang Cepat)**
    * **Apa yang dilakukannya?** **Membuang Dart VM** yang ada dan membuat yang baru, lalu memuat ulang seluruh kode aplikasi dari awal.
    * **Hasil:** Aplikasi dimulai ulang dari awal.
    * **State:** **Semua state aplikasi hilang (direset)** ke nilai *default*-nya.
    * **Kapan digunakan?** Saat  membuat perubahan besar yang tidak dapat ditangani oleh *hot reload* (misalnya mengubah data di `initState()`).

