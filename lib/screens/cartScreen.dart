import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/simple_log_printer.dart';
import 'package:shopapp/widgets/cartItemSkuBlock.dart';

import '../colorTray.dart';

class CartScreen extends StatelessWidget {
  final logger = getLogger("CartScreen");

  static const String routeName = "/CartScreen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTray.primaryColour,
        title: Text("My Cart"),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      textScaleFactor: 1.5,
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        "\$ ${cart.totalAmount.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: ColorTray.primaryTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: ColorTray.primaryColour,
                    ),
                    FlatButton(onPressed: () {}, child: Text("ORDER NOW")),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.getCartItemCount,
                itemBuilder: (context, index) => CartItemSkuBlock(
                  id: cart.getCartItems.values.toList()[index].id,
                  imageUrl: cart.getCartItems.values.toList()[index].imageUrl,
                  quantity: cart.getCartItems.values.toList()[index].quantity,
                  price: cart.getCartItems.values.toList()[index].price,
                  title: cart.getCartItems.values.toList()[index].title,
                  productId: cart.getCartItems.keys.toList()[index],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
