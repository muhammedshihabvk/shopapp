import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/colorTray.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/providers/products_provider.dart';

class ProductDescriptionScreen extends StatelessWidget {

  static const String routeName = "/ProductDescriptionScreen";

  @override
  Widget build(BuildContext context) {
    
    final productId = ModalRoute.of(context).settings.arguments as String;

    Product product =  Provider.of<ProductsProvider>(context).findById(productId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTray.primaryColour,
        title: Text("${product.title}"),
      ),
    );
  }
}
