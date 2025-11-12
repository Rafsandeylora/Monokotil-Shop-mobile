import 'package:flutter/material.dart';
// TODO: Import drawer yang sudah dibuat sebelumnya
import 'package:monokotil_shop/widgets/left_drawer.dart';

class ShopFormPage extends StatefulWidget {
  const ShopFormPage({super.key});

  @override
  State<ShopFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<ShopFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _description = '';
  String _category = 'jersey';
  String _thumbnail = '';
  int _price = 0;
  int _stocks = 0;
  int _rarity = 0;
  bool _isFeatured = false;

  final List<String> _categories = [
    'jersey',
    'hat',
    'merchandise',
    'ball',
    'handsign',
    'analysis',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Form Tambah Produk')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Title ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Nama Produk',
                    labelText: 'Nama Produk',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama Produk tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // === Content ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Detail Produk',
                    labelText: 'Detail Produk',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Detail Produk tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  value: _category,
                  items: _categories
                      .map(
                        (cat) => DropdownMenuItem<String>(
                          value: cat,
                          child: Text(cat[0].toUpperCase() + cat.substring(1)),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue ?? _category;
                    });
                  },
                ),
              ),

              // === Thumbnail URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'URL Thumbnail (opsional)',
                    labelText: 'URL Thumbnail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value ?? '';
                    });
                  },
                ),
              ),
              // === Price ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Harga Produk',
                    labelText: 'Harga Produk',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    int? number = int.tryParse(value);
                    if (number != null) {
                      setState(() {
                        _price = number;
                      });
                    }
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Harga tidak boleh kosong!';
                    }
                    if(int.tryParse(value) == null){
                      return "Harga harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),
              // === Stocks ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Stok Produk',
                    labelText: 'Stok Produk',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    int? number = int.tryParse(value);
                    if (number != null) {
                      setState(() {
                        _stocks = number;
                      });
                    }
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Stok tidak boleh kosong!';
                    }
                    if(int.tryParse(value) == null){
                      return "Stok harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),
              // === Rarity ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Kelangkaan Produk',
                    labelText: 'Kelangkaan Produk',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    int? number = int.tryParse(value);
                    if (number != null) {
                      setState(() {
                        _stocks = number;
                      });
                    }
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Kelangkaan tidak boleh kosong!';
                    }
                    if(int.tryParse(value) == null){
                      return "Kelangkaan harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),
              // === Is Featured ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text('Tandai sebagai Produk Unggulan'),
                  value: _isFeatured,
                  onChanged: (bool value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog<void>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Produk berhasil tersimpan'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Produk: $_name'),
                                    Text('Detail Produk: $_description'),
                                    Text('Kategori: $_category'),
                                    Text('Thumbnail: $_thumbnail'),
                                    Text('Harga: $_price'),
                                    Text('Stok: $_stocks'),
                                    Text('Kelangkaan: $_rarity'),
                                    Text(
                                      'Unggulan: ${_isFeatured ? 'Ya' : 'Tidak'}',
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            );
                          },
                        );
                        _formKey.currentState!.reset();
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
