import 'package:flutter/material.dart';
import 'package:monokotil_shop/models/product.dart';
import 'package:monokotil_shop/widgets/left_drawer.dart';
import 'package:monokotil_shop/screens/detail_product.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>> fetchProduct(CookieRequest request) async {
    // Gunakan 10.0.2.2 untuk Emulator Android, atau 127.0.0.1 untuk Web/iOS Simulator
    final response = await request.get('https://rafsanjani41-monokotilshop.pbp.cs.ui.ac.id/get-product/');

    var data = response;

    List<Product> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(Product.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      backgroundColor: const Color(0xFFF3F4F6),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada data produk."));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                final product = snapshot.data![index];

                // LOGIKA URL GAMBAR:
                // Django ImageField menyimpan path relatif (misal: "products/gambar.jpg").
                // Kita perlu menambahkan Base URL di depannya.
                // Sesuaikan Base URL ini dengan environment Anda!
                String baseUrl = "http://127.0.0.1:8000/media/"; 
                String? imageUrl;
                if (product.fields.thumbnail != null && product.fields.thumbnail!.isNotEmpty) {
                   imageUrl = "$baseUrl${product.fields.thumbnail}";
                }

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    clipBehavior: Clip.antiAlias, // Agar gambar terpotong mengikuti rounded corner
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- BAGIAN GAMBAR (THUMBNAIL) ---
                        if (imageUrl != null)
                          SizedBox(
                            height: 200, // Tinggi gambar fix agar rapi
                            width: double.infinity,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover, // Gambar memenuhi lebar
                              errorBuilder: (context, error, stackTrace) {
                                // Jika gambar gagal dimuat (misal 404 atau path salah)
                                return Container(
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                  ),
                                );
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          )
                        else
                          // Placeholder jika tidak ada gambar
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                            ),
                          ),

                        // --- BAGIAN KONTEN TEKS ---
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.fields.name,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Rp ${product.fields.price}",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.fields.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  _buildBadge(product.fields.category, Colors.blue.shade50, Colors.blue.shade700),
                                  const SizedBox(width: 8),
                                  _buildBadge("Rarity: ${product.fields.rarity}", Colors.purple.shade50, Colors.purple.shade700),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}