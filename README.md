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

# Tugas 8

### 1. Jelaskan perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()` pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Monokotil Shop saya?

Perbedaan utama terletak pada cara keduanya mengelola tumpukan (stack) navigasi halaman:

* **`Navigator.push()`**
    * **Cara Kerja:** "Mendorong" atau "menumpuk" halaman baru di atas halaman saat ini. Halaman yang lama (sebelumnya) **tetap ada** di dalam *stack* navigasi.
    * **Efek:** Pengguna dapat menekan tombol "kembali" (baik di `AppBar` atau tombol fisik perangkat) untuk kembali ke halaman sebelumnya.
    * **Kasus Penggunaan:** Ideal untuk alur di mana pengguna perlu kembali, seperti:
        * Dari *list* produk (`MyHomePage`) -> **push** -> ke halaman *detail* produk.
        * Setelah melihat detail, pengguna bisa "kembali" ke *list* produk.

* **`Navigator.pushReplacement()`**
    * **Cara Kerja:** "Mengganti" halaman saat ini dengan halaman baru. Halaman yang lama (sebelumnya) **dihapus** dari *stack* navigasi.
    * **Efek:** Pengguna tidak bisa kembali ke halaman sebelumnya karena halaman tersebut sudah tidak ada di *stack*. Tombol "kembali" di `AppBar` biasanya tidak akan muncul.
    * **Kasus Penggunaan:** Ideal untuk alur satu arah atau pergantian konteks utama, seperti:
        * Setelah pengguna berhasil *login*, kita menggunakan `pushReplacement` ke *homepage* agar pengguna tidak bisa "kembali" ke halaman *login*.
        * **Di aplikasi saya:** Saya menggunakan `pushReplacement` di `LeftDrawer` dan `new_card.dart` untuk berpindah antara `MyHomePage` dan `ShopFormPage`. Ini cocok karena keduanya adalah menu level atas, dan saya tidak ingin pengguna menumpuk halaman-halaman menu.

---

### 2. Bagaimana saya memanfaatkan hierarchy widget seperti `Scaffold`, `AppBar`, dan `Drawer` untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

Saya memanfaatkan hirarki ini dengan menjadikan `Scaffold` sebagai kerangka dasar untuk setiap halaman utama di aplikasi saya.

1.  **`Scaffold` sebagai Kerangka:** Setiap halaman utama, seperti `MyHomePage` dan `ShopFormPage`, dibungkus dengan `Scaffold`. `Scaffold` menyediakan "slot" standar untuk elemen UI umum.

2.  **`AppBar` untuk Konsistensi Judul:** Dengan menempatkan `AppBar` di properti `appBar` milik `Scaffold`, saya mendapatkan bilah judul yang konsisten di bagian atas setiap halaman. Saya dapat memberikan judul yang berbeda untuk setiap halaman (`'Monokotil Shop'` di *home*, `'Form Tambah Produk'` di form) namun dengan gaya visual yang seragam.

3.  **`Drawer` untuk Navigasi Terpusat:** Saya membuat satu widget kustom, `LeftDrawer`, yang berisi semua menu navigasi utama. Kemudian, di setiap `Scaffold` (baik di `MyHomePage` maupun `ShopFormPage`), saya memanggil `const LeftDrawer()` yang sama pada properti `drawer`.

Hasilnya, seluruh aplikasi memiliki struktur yang konsisten: `AppBar` di atas dan menu `Drawer` yang sama di samping, di mana pun pengguna berada.

---

### 3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti `Padding`, `SingleChildScrollView`, dan `ListView` saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi saya.

Widget tata letak ini sangat penting untuk membuat form yang fungsional dan rapi:

* **`Padding`**
    * **Kelebihan:** Memberikan jarak di sekeliling widget. Tanpa `Padding`, elemen form akan menempel satu sama lain dan menempel di tepi layar, membuatnya terlihat sempit dan sulit dibaca.
    * **Contoh di Aplikasi Saya:** Di `ShopFormPage`, setiap `TextFormField` (seperti "Nama Produk", "Detail Produk", dll.) saya bungkus dengan `Padding`. Ini memberikan jarak vertikal dan horizontal yang konsisten antar *field*, sehingga form terlihat jauh lebih rapi.

* **`SingleChildScrollView`**
    * **Kelebihan:** Memastikan konten di dalamnya (dalam hal ini, `Column` yang berisi form) dapat di-*scroll*. Ini adalah keharusan untuk form. Saat pengguna mengetik di *field* bagian bawah, *keyboard* akan muncul dan menutupi sebagian layar. `SingleChildScrollView` memungkinkan pengguna untuk *scroll* ke bawah dan melihat *field* yang sedang mereka isi.
    * **Contoh di Aplikasi Saya:** Di `ShopFormPage`, saya membungkus `Column` yang berisi semua `Padding` dan `TextFormField` dengan `SingleChildScrollView`. Ini mencegah *overflow error* dan memastikan form tetap dapat digunakan meskipun kontennya lebih panjang dari layar perangkat.

* **`ListView`**
    * **Kelebihan:** Mirip dengan `SingleChildScrollView`, `ListView` juga menyediakan fungsionalitas *scroll*. Kelebihan utamanya adalah *lazy loading*: `ListView` hanya me-*render* item yang terlihat di layar, sehingga sangat efisien untuk daftar yang *sangat* panjang (ribuan item).
    * **Contoh di Aplikasi Saya:** Meskipun saya tidak menggunakannya untuk `ShopFormPage` (karena `SingleChildScrollView` + `Column` sudah cukup untuk form yang tidak terlalu panjang), `ListView` adalah widget yang saya gunakan di `LeftDrawer` untuk menampilkan daftar menu navigasi.

---

### 4. Bagaimana saya menyesuaikan warna tema agar aplikasi Monokotil Shop memiliki identitas visual yang konsisten dengan brand toko?

Saya menyesuaikan warna tema secara terpusat di file `lib/main.dart`, di dalam widget `MaterialApp`.

1.  **Pengaturan `ThemeData`:** Di dalam `MaterialApp`, saya menggunakan properti `theme` untuk menentukan `ThemeData` global.
2.  **Menggunakan `ColorScheme`:** Di dalam `ThemeData`, saya mengatur `colorScheme`. Cara mudah untuk membuat skema warna yang kohesif adalah dengan `ColorScheme.fromSwatch()`.
3.  **Contoh di Aplikasi Saya:** Saat ini, saya menggunakan `ColorScheme.fromSwatch(primarySwatch: Colors.blue)`. Ini memberi tahu Flutter untuk menghasilkan seluruh palet warna (warna primer, sekunder, aksen, dll.) berdasarkan palet bawaan `Colors.blue`.

**Kelebihan Konsistensi:**
Dengan mengatur tema di satu tempat ini, semua widget lain di aplikasi seperti `AppBar` atau `ElevatedButton` akan secara otomatis mengambil warna dari `ColorScheme` tersebut.


# Tugas 9

### 1. Apakah bisa saya melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?

Ya, saya **bisa** melakukan pengambilan data JSON tanpa membuat model terlebih dahulu. Di Flutter, data JSON yang diterima dari Django dapat langsung diolah sebagai `Map<String, dynamic>` (untuk objek tunggal) atau `List<dynamic>` (untuk array).

Namun, melakukan hal tersebut **tidak lebih baik** daripada menggunakan model, karena:
* **Keamanan Tipe Data (Type Safety):** Tanpa model, saya harus mengakses data secara manual menggunakan string key (contoh: `data['fields']['price']`). Jika saya salah ketik nama key (misal `data['prices']`), error baru akan muncul saat aplikasi berjalan (*runtime error*). Dengan model `Product` yang sudah saya buat, compiler akan memberitahu jika ada akses properti yang salah sebelum aplikasi dijalankan.
* **Kemudahan Maintenance:** Jika struktur data dari Django berubah, saya hanya perlu memperbarui file `product.dart`. Tanpa model, saya harus mencari dan mengganti key string di setiap file yang menggunakan data tersebut.
* **Produktivitas:** Menggunakan model memungkinkan fitur *autocomplete* di IDE, sehingga saya bisa memanggil `product.fields.price` dengan mudah tanpa perlu menghafal struktur JSON mentah.

---

### 2. Sebutkan fungsi dari `CookieRequest` dan jelaskan mengapa instance `CookieRequest` perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

Fungsi utama `CookieRequest` (dari *package* `pbp_django_auth`) adalah untuk menangani permintaan HTTP (GET/POST) ke server Django sembari **menyimpan dan mengelola cookies** secara otomatis. Ini sangat krusial untuk fitur autentikasi, karena Django menggunakan *session cookie* untuk mengenali apakah pengguna sudah login atau belum.

Instance `CookieRequest` perlu dibagikan (*shared*) ke semua komponen aplikasi karena:
* **Konsistensi Sesi (Session Persistence):** Login yang berhasil akan menghasilkan *session ID* yang disimpan di cookie dalam instance `CookieRequest` tersebut. Jika saya membuat instance `CookieRequest` baru di setiap halaman (misal satu di `LoginPage` dan satu lagi di `ProductPage`), maka instance yang baru tidak akan memiliki cookie dari proses login sebelumnya. Akibatnya, server akan menganggap saya sebagai pengguna anonim (belum login) di halaman baru tersebut.
* **Implementasi di Monokotil Shop:** Oleh karena itu, saya menginisialisasi `CookieRequest` di `main.dart` menggunakan `Provider`, sehingga satu instance yang sama ("single source of truth") dapat diakses oleh `LoginPage`, `ProductPage`, dan `ShopFormPage`.

---

### 3. Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.

Mekanisme yang saya terapkan di halaman `list_product.dart` adalah sebagai berikut:

1.  **Inisialisasi Request:** Saya membuat fungsi asinkronus `fetchProduct()` yang memanggil `request.get('http://127.0.0.1:8000/get-product/')`.
2.  **Request ke Django:** `CookieRequest` mengirim permintaan HTTP GET ke URL Django.
3.  **Respon Server:** Django memproses permintaan di `views.py` (fungsi `show_json`) dan mengembalikan data produk dalam format JSON.
4.  **Decoding & Serialisasi:**
    * Flutter menerima respon.
    * Saya melakukan decode JSON menjadi objek Dart.
    * Saya melakukan iterasi pada data tersebut dan mengubahnya menjadi objek `Product` menggunakan `Product.fromJson(d)` yang telah didefinisikan di model.
5.  **Menampilkan Data (`FutureBuilder`):**
    * Saya menggunakan widget `FutureBuilder` untuk memantau status pengambilan data (`waiting`, `hasError`, atau `hasData`).
    * Saat status `waiting`, saya menampilkan `CircularProgressIndicator`.
    * Saat data tersedia (`hasData`), `ListView.builder` akan membangun tampilan kartu (`Card`) untuk setiap item `Product` yang berhasil diambil.

---

### 4. Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

Proses autentikasi yang terjadi di aplikasi saya adalah:

1.  **Input Data (Flutter):** Di halaman `LoginPage`, saya memasukkan *username* dan *password* ke dalam `TextField`, lalu menekan tombol "Login".
2.  **Pengiriman Data (Flutter -> Django):** Fungsi `onPressed` pada tombol memanggil `request.login()`, yang mengirimkan data tersebut via HTTP POST ke endpoint Django (`/auth/login/` atau endpoint kustom saya).
3.  **Validasi (Django):**
    * Django menerima data di `views.py`.
    * Fungsi `authenticate(username, password)` dipanggil untuk mengecek kecocokan data dengan database.
4.  **Pembuatan Sesi (Django):**
    * Jika valid, fungsi `login(request, user)` dipanggil untuk membuat sesi baru di sisi server.
    * Django merespons dengan status "success" dan menyertakan *session cookie* di header respons.
5.  **Penyimpanan Sesi (Flutter):** `CookieRequest` di Flutter menerima respons dan secara otomatis menyimpan cookie tersebut untuk request selanjutnya.
6.  **Navigasi (Flutter):** Karena `request.loggedIn` bernilai `true`, logika di `LoginPage` saya akan mengarahkan navigasi ke `MyHomePage` menggunakan `Navigator.pushReplacement`.

---

### 5. Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.

Berikut adalah widget utama yang saya gunakan dalam pengembangan integrasi ini:

* **`FutureBuilder`**: Untuk menangani proses *asynchronous* pengambilan data produk. Widget ini memungkinkan saya menampilkan *loading spinner* saat data sedang diambil dan menampilkan daftar produk saat data sudah siap.
* **`ListView.builder`**: Digunakan di `ProductPage` untuk membuat daftar produk yang dapat di-*scroll*. Widget ini efisien karena hanya merender item yang terlihat di layar.
* **`Card`**: Digunakan sebagai wadah visual untuk setiap item produk agar terlihat rapi dengan efek bayangan (shadow).
* **`Image.network`**: Saya gunakan untuk menampilkan *thumbnail* produk langsung dari URL yang disediakan oleh server Django.
* **`CircularProgressIndicator`**: Indikator visual (loading memutar) yang muncul saat aplikasi sedang menunggu respon dari server (baik saat login maupun ambil data).
* **`Provider`**: Digunakan di `main.dart` untuk menyuntikkan (*inject*) instance `CookieRequest` ke seluruh pohon widget aplikasi.
* **`InkWell`**: Saya bungkus `Card` produk dengan ini untuk memberikan efek riak air (*ripple effect*) saat produk diklik untuk melihat detail.
* **`SizedBox`**: Saya gunakan secara ekstensif untuk memberikan jarak (spasi) antar elemen, misalnya antara gambar dan teks deskripsi.
* **`ScaffoldMessenger`**: Untuk menampilkan `SnackBar` (pesan pop-up sementara) saat login berhasil atau gagal.