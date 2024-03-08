class Product {
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
  final bool favoriteStats;

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
    required this.favoriteStats,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      storeId: json['storeId'],
      categoryId: json['categoryId'],
      productType: json['productType'],
      id: json['id'],
      productName: json['productName'].toString(),
      productImage: json['productImage'].toString(),
      description: json['description'].toString(),
      stockQuantity: json['stockQuantity'],
      pointsPrice: double.parse(json['pointsPrice']),
      sellingPrice: double.parse(json['sellingPrice']),
      favoriteStats: json['favoriteStats'] == 1,
    );
  }

  Product copyWith({
    int? id,
    String? productName,
    String? productImage,
    int? productType,
    String? description,
    double? sellingPrice,
    double? pointsPrice,
    int? stockQuantity,
    int? storeId,
    int? categoryId,
    bool? favoriteStats,
  }) {
    return Product(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productType: productType ?? this.productType,
      description: description ?? this.description,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      pointsPrice: pointsPrice ?? this.pointsPrice,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      storeId: storeId ?? this.storeId,
      categoryId: categoryId ?? this.categoryId,
      favoriteStats: favoriteStats ?? this.favoriteStats,
    );
  }
}
