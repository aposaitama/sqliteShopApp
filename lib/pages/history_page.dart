import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/product_provider.dart';
import 'package:shop/tile/cart_tile.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ProductProvider>(builder: (context, history, child) {
        final historyItems = history.productsHistory;
        if (historyItems.isNotEmpty) {
          return ListView.builder(
            itemCount: historyItems.length,
            itemBuilder: (context, index) {
              final product = historyItems[index];
              return CartItemTile(product: product);
            },
          );
        } else {
          return const Center(child: Text('Cart is empty'));
        }
      }),
    );
  }
}
