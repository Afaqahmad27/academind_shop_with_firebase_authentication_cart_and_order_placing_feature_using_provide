import 'package:flutter/foundation.dart';

import 'product.dart';

class Products with ChangeNotifier{
  List<Product> _items=[
    Product(
        id: 'p1',
        title: 'Red Shirt',
        description: 'A red shirt - it is pretty red!',
        price: 29.99,
        imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578__480.jpg'),
    Product(
        id: 'p2',
        title: 'Yellow Scarf',
        description: 'A Yellow Scarf - it looks so amazing!',
        price: 16.99,
        imageUrl:
        'https://m.media-amazon.com/images/I/91xZDGQ2t2L._AC_UL320_.jpg'),
    Product(
        id: 'p3',
        title: 'Trouser',
        description: 'A Modern Trouser - It makes the fashion perfect!',
        price: 44.99,
        imageUrl:
        'https://media.istockphoto.com/photos/mouse-pink-color-trouser-for-younger-girls-picture-id1371290249?b=1&k=20&m=1371290249&s=170667a&w=0&h=Hynx7TPl4fBbh8rXeJu1IglCdiEapU3Hdu5pFf8eUEU='),
    Product(
        id: 'p4',
        title: 'Pan',
        description: 'An Original Pan - Prepare any meal you want!',
        price: 37.99,
        imageUrl:
        'https://cdn.pixabay.com/photo/2014/12/02/14/50/pan-554072__480.jpg'),
  ];
  List<Product> get item{
    return [..._items];
  }
  List<Product> get favItems{
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }
  Product findById(String id){
   return _items.firstWhere((prod) => prod.id==id);
  }
  void addProduct(){
    // _items.add(value);
    notifyListeners();
  }
}