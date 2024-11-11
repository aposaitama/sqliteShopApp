import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/product_provider.dart';
import 'package:shop/tile/product_tile.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Consumer<ProductProvider>(
            builder: (context, product, child) {
              final products = product.products;
              if (products.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductItemTile(product: product);
                    },
                  ),
                );
              } else {
                return const Center(child: Text('No products available'));
              }
            },
          ),
          // GestureDetector(
          //   onTap: () {
          //     Provider.of<ProductProvider>(context, listen: false).addProduct(
          //         'PS4',
          //         1800,
          //         'https://content.rozetka.com.ua/goods/images/big/431948817.png');
          //   },
          //   child: Container(
          //     color: Colors.amber,
          //     width: 100,
          //     height: 200,
          //     child: Text('Add'),
          //   ),
          // )
        ],
      ),
    );
  }
}
