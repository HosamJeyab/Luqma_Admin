class OrderItemModel {
  final String productId;
  final String name;
  final int quantity;
  final double price;
  final String imageUrl;
  

  OrderItemModel({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image'] ?? '',
    );
  }
}
