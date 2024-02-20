// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final int id;
  final String productName;
  final String productImage;
  final int productType;
  final String description;
  final double sellingPrice;
  final double pointsPrice;
  final int stockQuantity;
  final int storeId;
  final int categoryId;

  Product({
    required this.pointsPrice,
    required this.storeId,
    required this.categoryId,
    required this.productType,
    required this.id,
    required this.productName,
    required this.sellingPrice,
    required this.productImage,
    required this.description,
    required this.stockQuantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      storeId: json['storeId'],
      categoryId: json['categoryId'],
      productType: json['productType'],
      id: json['id'],
      productName: json['productName'].toString(),
      productImage: '',
      description: json['description'].toString(),
      stockQuantity: json['stockQuantity'],
      pointsPrice: double.parse(json['pointsPrice']),
      sellingPrice: double.parse(json['sellingPrice']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pointsPrice': pointsPrice,
      'storeId': storeId,
      'categoryId': categoryId,
      'productType': productType,
      'id': id,
      'productName': productName,
      'sellingPrice': sellingPrice,
      'productImage': productImage,
      'description': description,
      'stockQuantity': stockQuantity,
    };
  }
}
