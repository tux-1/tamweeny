class HistoryOrder {
  final int id;
  final String orderDate;
  final double orderPrice;
  final int customerId;

  HistoryOrder({
    required this.id,
    required this.orderDate,
    required this.orderPrice,
    required this.customerId,
  });

  factory HistoryOrder.fromJson(Map<String, dynamic> json) {
    return HistoryOrder(
      id: json['id'],
      orderDate: json['orderDate'],
      orderPrice: double.parse(json['orderPrice']),
      customerId: json['customerId'],
    );
  }
}
