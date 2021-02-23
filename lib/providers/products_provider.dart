
import 'package:flutter/material.dart';
import 'package:shopapp/dummyData.dart';

import 'product.dart';

class ProductsProvider with ChangeNotifier{
  bool _favoriteOnlyFlag = false;
  List<Product> _items = [...productDummyList];

   void showFavoritesOnly(){
    _favoriteOnlyFlag=true;
    notifyListeners();
  }

   void showAllProducts(){
    _favoriteOnlyFlag=false;
    notifyListeners();
  }

  List<Product> get getItems{
      return [..._items];
  }

  List<Product> get getFavItems{
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String id){
    return _items.firstWhere((element) => element.id == id);
  }

  addProduct(Product product){
    _items.add(product);
    notifyListeners();
  }
}