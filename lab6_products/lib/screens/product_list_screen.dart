
import 'package:material_ui/material_ui.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  final List<Product> products = const [
    Product(
      id: 'P001',
      title: 'Wireless Mouse',
      description:
          'Comfortable wireless mouse for daily work.',
      rating: 4.5,
    ),
    Product(
      id: 'P002',
      title: 'Notebook Set',
      description:
          'A set of notebooks for school and office use.',
      rating: 4.2,
    ),
    Product(
      id: 'P003',
      title: 'Desk Lamp',
      description:
          'Adjustable desk lamp for studying and reading.',
      rating: 4.7,
    ),Product(
      id: 'P004',
      title: 'PS5',
      description:
          'You can play the latest games with this console.',
      rating: 3.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF206B4B),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE4F1E9),
                child: Icon(
                  Icons.circle_outlined,
                  color: Color(0xFF206B4B),
                ),
              ),

              title: Text(
                product.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                'Rating: ${product.rating.toStringAsFixed(1)} / 5',
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF206B4B),
                size: 18,
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailScreen(
                      product: product,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
