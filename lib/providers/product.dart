

class Product  {
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

  
}
