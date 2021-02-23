import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/colorTray.dart';
import 'package:shopapp/providers/cart_provider.dart';

class CartItemSkuBlock extends StatelessWidget {

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String imageUrl;

  CartItemSkuBlock({this.id,this.price,this.quantity,this.title,this.imageUrl,this.productId});


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.only(right: 10),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        alignment: Alignment.centerRight,
        color: ColorTray.red,
        child: Icon(Icons.delete,color: ColorTray.primaryTextColor,size: 30,),
      ),
      onDismissed: (direction) {
          Provider.of<CartProvider>(context,listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(2),
          child: ListTile(
            leading: CircleAvatar(child: Image.network(imageUrl),),
            title: Text(title),
            subtitle: Row(children: [
              Text(price.toString()+ "x" + quantity.toString()+"=${price*quantity}"),
            ],),
          ),
        ),
      ),
    );
  }
}
