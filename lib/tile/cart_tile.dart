import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/provider/product_provider.dart';

class CartItemTile extends StatefulWidget {
  final Product product;
  const CartItemTile({super.key, required this.product});

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
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
          trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                if (widget.product.id != null) {
                  Provider.of<ProductProvider>(context, listen: false)
                      .removeProduct(widget.product
                          .id!); // Use the ! to assert the id is non-null
                }
              }),
        ),
      ),
    );
  }
}
