import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/product_provider.dart';
import 'package:shop/tile/cart_tile.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<ProductProvider>(
              builder: (context, cart, child) {
                final cartItems = cart.productsCart;
                if (cartItems.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cartItems[index];
                        return CartItemTile(product: product);
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('Cart is empty'));
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<ProductProvider>(
                    builder: (context, value, child) {
                      return Text(
                          'Your total cart summ is:: ${value.totalCost()}');
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<ProductProvider>(context, listen: false)
                          .checkOut();
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(67, 176, 42, 1),
                          borderRadius: BorderRadius.circular(14)),
                      child: const Center(
                          child: Text(
                        'CheckOUT',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
