class CartItem {
  final int id;
  final int customerId;
  final int productId;
  final String productName;
  final String productImage;
  final int quantity;
  final double sellingPrice;
  final double totalPrice;

  CartItem({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
    required this.sellingPrice,
    required this.productImage,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as int,
      productImage: json['productImage'] as String,
      customerId: json['customerId'] as int,
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      sellingPrice: double.parse(json['sellingPrice']),
      totalPrice: double.parse(json['totalPrice']),
    );
  }

  CartItem copyWith({
    int? id,
    int? customerId,
    int? productId,
    String? productName,
    int? quantity,
    double? sellingPrice,
    double? totalPrice,
    String? productImage,
  }) {
    return CartItem(
      productImage: productImage ?? this.productImage,
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
