class Product {
  final String name;
  final String mediaUrl;
  final double price;
  String? currency;
  Product(
      {required this.name,
      required this.mediaUrl,
      required this.price,
      this.currency});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      mediaUrl: json['mediaUrl'],
      price: json['price'].toDouble(),
      currency: json['currency'],
    );
  }
}
