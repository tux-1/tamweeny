import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final double price;
  final String title;
  final String id;
  final String? subtitle;
  final String? description;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.price,
    required this.title,
    required this.imageUrl,
    this.subtitle,
    this.description,
    this.isFavorite = false,
  });

  void setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  // Future<void> toggleFavoriteStatus(
  // String token, String userId
  // ) async {
  // _setFavValue(!isFavorite);
  //   final url = Uri.https(
  //     'shopapp-3f885-default-rtdb.europe-west1.firebasedatabase.app',
  //     '/userFavorites/$userId/$id.json',
  //     {'auth': token},
  //   );
  //   var oldFavorite = isFavorite;
  //   isFavorite = !isFavorite;
  //   notifyListeners();
  //   try {
  //     //for patch, put & delete http package won't throw an error if u remove .json
  //     final response = await http.put(
  //       url,
  //       body: json.encode(
  //         isFavorite,
  //       ),
  //     );
  //     if (response.statusCode >= 400) {
  //       _setFavValue(oldFavorite);
  //     }
  //   } catch (error) {
  //     _setFavValue(oldFavorite);
  //     throw HttpException('Could not favorite');
  // }
  // }
}
