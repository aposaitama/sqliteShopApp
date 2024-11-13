import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/provider/product_provider.dart';

class HistoryItemTile extends StatefulWidget {
  final Product product;
  const HistoryItemTile({super.key, required this.product});

  @override
  State<HistoryItemTile> createState() => _HistoryItemTileState();
}

class _HistoryItemTileState extends State<HistoryItemTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: SizedBox(
              width: 135,
              height: 135,
              child: Image.network(
                widget.product.image,
                fit: BoxFit.contain,
              )),
          title: Text(widget.product.name),
          subtitle: Text(widget.product.price.toString()),
        ),
      ),
    );
  }
}
