class CartModel {
  late int productId;
  late String name;
  late String category;
  late List<int> categoryBinary;
  late int price;
  late int quantity;

  CartModel(
      {required this.productId,
      required this.name,
      required this.category,
      required this.categoryBinary,
      required this.price,
      required this.quantity});

  CartModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    category = json['category'];
    categoryBinary = List<int>.from(json["category_binary"].map((x) => x));
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['name'] = name;
    data['category'] = category;
    data['category_binary'] = List<dynamic>.from(categoryBinary.map((x) => x));
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}
