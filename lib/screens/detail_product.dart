import 'package:flutter/material.dart';
import 'package:monokotil_shop/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk (jika ada)
            if (product.fields.thumbnail != null && product.fields.thumbnail!.isNotEmpty)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.fields.thumbnail!,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 100, color: Colors.grey);
                    },
                  ),
                ),
              ),
            const SizedBox(height: 20),

            // Nama Produk
            Text(
              product.fields.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Kategori & Rarity (Badge)
            Row(
              children: [
                Chip(
                  label: Text(product.fields.category),
                  backgroundColor: Colors.blue[100],
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text('Rarity: ${product.fields.rarity}'),
                  backgroundColor: Colors.purple[100],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Harga
            Text(
              "Price: Rp ${product.fields.price}",
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // Stok
            Text(
              "Stock: ${product.fields.stocks}",
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20),

            const Divider(),
            const SizedBox(height: 10),

            // Deskripsi
            const Text(
              "Description:",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.fields.description,
              style: const TextStyle(fontSize: 16.0),
            ),
            
            const SizedBox(height: 40),
            
            // Tombol Kembali
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: const Text(
                  'Back to List',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}