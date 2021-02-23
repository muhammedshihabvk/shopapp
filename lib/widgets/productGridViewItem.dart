import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/colorTray.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/screens/productDescriptionScreen.dart';
import 'package:shopapp/simple_log_printer.dart';

class ProductGridViewItem extends StatelessWidget {
  final logger = getLogger("ProductGridViewItem");
  // final String id;
  // final String title;
  // final String imageUrl;
  //
  // ProductGridViewItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    logger.i("build method of PLP single block");
    final product = Provider.of<Product>(context);
    final cart = Provider.of<CartProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDescriptionScreen.routeName,
            arguments: product.id,
          );
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.fitWidth,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            leading: IconButton(
              onPressed: product.toggleFavoriteButton ,
              icon: product.isFavorite ? Icon( Icons.favorite,color: Colors.red,) : Icon( Icons.favorite,color: ColorTray.primaryColour,),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorTray.primaryTextColor),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: ColorTray.primaryColour,
              ),
              onPressed: () {
                cart.addItem("idSample", product.title, 1, product.price,product.imageUrl,product.id);
              },
            ),
          ),
        ),
      ),
    );
  }
}
