// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final int productId;
  final String productName;
  final String productImage;
  final String description;
  final double selling_price;
  final double pointsPrice;
  final int stock_quantity;
  final int store_id;
  final int cat_id;
  final int productType;

  Product({
    required this.pointsPrice,
    required this.store_id,
    required this.cat_id,
    required this.productType,
    required this.productId,
    required this.productName,
    required this.selling_price,
    required this.productImage,
    required this.description,
    required this.stock_quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      store_id: json['store_id'],
      cat_id: json['cat_id'],
      productType: json['productType'],
      productId: json['productId'],
      productName: json['productName'].toString(),
      productImage: json['productImage'].toString(),
      description: json['description'].toString(),
      stock_quantity: json['stock_quantity'],
      pointsPrice: double.parse(json['pointsPrice']),
      selling_price: double.parse(json['selling_price']) ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pointsPrice': pointsPrice,
      'store_id': store_id,
      'cat_id': cat_id,
      'productType': productType,
      'productId': productId,
      'productName': productName,
      'selling_price': selling_price,
      'productImage': productImage,
      'description': description,
      'stock_quantity': stock_quantity,
    };
  }
}
