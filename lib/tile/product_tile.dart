import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/provider/product_provider.dart';

class ProductItemTile extends StatefulWidget {
  final Product product;
  const ProductItemTile({super.key, required this.product});

  @override
  State<ProductItemTile> createState() => _ProductItemTileState();
}

class _ProductItemTileState extends State<ProductItemTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 150, child: Image.network(widget.product.image)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                Text(widget.product.price.toString()),
              ],
            ),
            SizedBox(
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .addProduct(widget.product.name, widget.product.price,
                          widget.product.image);
                },
              ),
            )
          ],
        ),
        // child: ListTile(
        //   leading: SizedBox(
        //     width: 200,
        //     height: 300,
        //     child: Image.network(
        //       widget.product.image,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   title: Text(widget.product.name),
        //   subtitle: Text(widget.product.price.toString()),
        //   trailing: IconButton(
        //     icon: const Icon(Icons.add),
        //     onPressed: () {
        //       Provider.of<ProductProvider>(context, listen: false).addProduct(
        //           widget.product.name,
        //           widget.product.price,
        //           widget.product.image);
        //     },
        //   ),
        // ),
      ),
    );
  }
}
