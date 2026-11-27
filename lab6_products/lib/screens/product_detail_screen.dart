
import 'package:material_ui/material_ui.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF206B4B),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFFE4F1E9),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 55,
                color: Color(0xFF206B4B),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              product.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF206B4B),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              product.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              'Rating: ${product.rating.toStringAsFixed(1)} / 5',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF206B4B),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              'Product ID: ${product.id}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
