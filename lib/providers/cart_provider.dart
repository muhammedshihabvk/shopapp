import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem(
      {this.id,
      this.title,
      this.quantity,
      this.price,
      this.imageUrl,
      this.productId});
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _item = {};

  Map<String, CartItem> get getCartItems {
    return {..._item};
  }

  double get totalAmount {
    var total = 0.0;
    _item.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  int get getCartItemCount {
    return _item.length;
  }

  void addItem(String Id, String title, int quantity, double price,
      String imageUrl, String productId) {
    if (_item.containsKey(productId)) {
      _item.update(
          productId,
          (existingCardItem) => CartItem(
              id: existingCardItem.id,
              title: existingCardItem.title,
              price: existingCardItem.price,
              quantity: existingCardItem.quantity + 1,
              imageUrl: existingCardItem.imageUrl,
              productId: productId));
    } else {
      _item.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1,
              imageUrl: imageUrl,
              productId: productId));
    }
    notifyListeners();
  }

  void removeItem(String productId){
    _item.remove(productId);
    notifyListeners();
  }
}
