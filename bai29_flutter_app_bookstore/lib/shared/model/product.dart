class Product {
  final String productId;
  final String productName;
  final String productImage;
  final int quantity;
  final double price;

  Product({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.price,
  });

  static List<Product> parseProductList(Map<String, dynamic> json) {
    var list = json["data"] as List;

    return list.map((product) => Product.fromJson(product)).toList();
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json["productId"],
      productName: json["productName"],
      productImage: json["productImage"],
      quantity: int.parse(json["quantity"].toString()),
      price: double.tryParse(json["price"].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "productImage": productImage,
        "quantity": quantity,
        "price": price,
      };
}
