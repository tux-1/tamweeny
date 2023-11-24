import 'package:flutter/material.dart';

import 'product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    Product(
      id: '5',
      price: 5,
      title: 'title5',
      imageUrl:
          'https://static.vecteezy.com/system/resources/previews/009/399/398/non_2x/old-vintage-book-clipart-design-illustration-free-png.png',
    ),
    Product(
      id: '6',
      price: 6,
      title: 'title6',
      subtitle: '500g',
      imageUrl: 'https://pngimg.com/d/rice_PNG11.png',
    ),
    Product(
      id: '7',
      price: 7,
      title: 'title7ssssssssssssssssssssssssssssssssssssssss',
      subtitle: '1book',
      imageUrl:
          'https://static.vecteezy.com/system/resources/previews/009/399/398/non_2x/old-vintage-book-clipart-design-illustration-free-png.png',
    ),
    Product(
      id: '7',
      price: 7,
      title: 'title7',
      imageUrl:
          'https://static.vecteezy.com/system/resources/previews/009/399/398/non_2x/old-vintage-book-clipart-design-illustration-free-png.png',
    ),
  ];

  List<Product> get items {
    return _items;
  }

  // void setFav(String id, bool favStatus) {
  //   var test = _items.where((item) => item.id == id) as Product;
  //   test.isFavorite = favStatus;
  // }
}
