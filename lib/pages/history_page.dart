import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/product_provider.dart';
import 'package:shop/tile/cart_tile.dart';
import 'package:shop/tile/history_tile.dart';

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
        automaticallyImplyLeading: false,
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ProductProvider>(builder: (context, history, child) {
        final groupedHistory = history.groupedHistory;
        if (groupedHistory.isNotEmpty) {
          return ListView.builder(
            itemCount: groupedHistory.length,
            itemBuilder: (context, index) {
              final checkoutId = groupedHistory.keys.elementAt(index);
              final products = groupedHistory[checkoutId]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Checkout ID: $checkoutId',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, productIndex) {
                      final product = products[productIndex];
                      return HistoryItemTile(product: product);
                    },
                  ),
                ],
              );
            },
          );
        } else {
          return const Center(child: Text('No purchase history available'));
        }
      }),
    );
  }
}
