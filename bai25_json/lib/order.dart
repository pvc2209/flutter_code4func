class Order {
  int orderId;
  User user;
  List<Product> products;

  Order({
    required this.orderId,
    required this.user,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json["orderId"],
      user: User.fromJson(json["user"]),
      products: Product.parseData(json),
    );
  }

  Map<String, dynamic> toJson() {
    // Return về 1 map :)
    return {
      "orderId": orderId,
      "user": user.toJson(),
      "products":
          List<dynamic>.from(products.map((product) => product.toJson())),
    };
  }
}

class User {
  String fullName;
  String email;

  User({required this.fullName, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json["fullName"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {"fullName": fullName, "email": email};
}

class Product {
  int productId;
  String productName;
  int quantity;
  double price;

  Product({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json["productId"],
      productName: json["productName"],
      quantity: json["quantity"],
      price: json["price"],
    );
  }

  static List<Product> parseData(Map<String, dynamic> json) {
    var list = json["products"] as List;
    return list.map((product) => Product.fromJson(product)).toList();
  }

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "quantity": quantity,
        "price": price,
      };
}
