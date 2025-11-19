import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:monokotil_shop/models/product.dart';
import 'package:monokotil_shop/screens/detail_product.dart'; 

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<List<Product>> fetchProduct(CookieRequest request) async {
    // Ganti URL dengan endpoint PWS kamu
    final response = await request.get('https://rafsanjani41-monokotilshop.pbp.cs.ui.ac.id/get-product/');

    // Konversi JSON ke List<Product>
    var listData = <Product>[];
    for (var d in response) {
      if (d != null) {
        listData.add(Product.fromJson(d));
      }
    }
    return listData;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum ada data produk.",
                      style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final product = snapshot.data![index];
                  
                  // Membungkus Card dengan InkWell agar bisa ditekan
                  return InkWell(
                    onTap: () {
                      // Navigasi ke halaman detail dengan membawa objek product
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
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
                            const SizedBox(height: 10),
                            Text("Price: Rp ${product.fields.price}"),
                            const SizedBox(height: 10),
                            Text(
                              product.fields.description,
                              maxLines: 2, // Batasi deskripsi agar rapi di list
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            // Indikator visual untuk produk unggulan
                            if (product.fields.isFeatured)
                                const Chip(
                                  label: Text('Unggulan', style: TextStyle(fontSize: 10)),
                                  backgroundColor: Colors.amber,
                                  padding: EdgeInsets.zero,
                                ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}