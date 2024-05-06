class Order {
  final int id;
  final String orderPrice;
  final int transactionNumber;
  final String transactionDate;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String userLat;
  final String userLong;
  final String deliveryStatus;
  final int customerId;
  final List<OrderItem> ordersMade;

  Order({
    required this.id,
    required this.orderPrice,
    required this.transactionNumber,
    required this.transactionDate,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.deliveryStatus,
    required this.userLat,
    required this.userLong,
    required this.customerId,
    required this.ordersMade,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    List<dynamic> ordersJson = json['ordersMade'];
    List<OrderItem> orders =
        ordersJson.map((orderJson) => OrderItem.fromJson(orderJson)).toList();

    return Order(
      id: json['id'],
      deliveryStatus: json['deliveryStatus'],
      orderPrice: json['orderPrice'],
      transactionNumber: json['transactionNumber'],
      transactionDate: json['transactionDate'],
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      customerAddress: json['customerAddress'],
      userLat: json['userLat'],
      userLong: json['userLong'],
      customerId: json['customerId'],
      ordersMade: orders,
    );
  }
}

class OrderItem {
  final int productId;
  final String productName;
  final String categoryName;
  final int quantity;
  final double totalPrice;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.categoryName,
    required this.quantity,
    required this.totalPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      productName: json['productName'],
      categoryName: json['categoryName'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'].toDouble(),
    );
  }
}
