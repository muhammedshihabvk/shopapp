import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/colorTray.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/providers/products_provider.dart';

class ProductDescriptionScreen extends StatelessWidget {
  static const String routeName = "/ProductDescriptionScreen";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;

    Product product =
        Provider.of<ProductsProvider>(context).findById(productId);

    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTray.primaryColour,
        title: Text("${product.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // color: Colors.green,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Text(product.title),
            Text(product.description),
            Text(
              product.price.toString(),
              textScaleFactor: 2,
            ),
            FlatButton(
                color: Colors.deepOrange,
                onPressed: () {
                  cart.addItem(DateTime.now().toString(), product.title, 1, product.price, product.imageUrl, product.id);
                },
                child: Text("ADD TO CART"))
          ],
        ),
      ),
    );
  }
}
