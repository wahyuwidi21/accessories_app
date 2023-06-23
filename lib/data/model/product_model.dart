class ProductModel {
  late int productId;
  late String name;
  late String categoryId;
  late String category;
  late List<int> categoryBinary;
  late String imageUrl;
  late int price;

  ProductModel(
      {required this.productId,
      required this.name,
      required this.categoryId,
      required this.category,
      required this.categoryBinary,
      required this.price,
      required this.imageUrl});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    categoryId = json['category_id'];
    category = json['category'];
    categoryBinary = json['category_binary'];
    imageUrl = json['image_url'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['category'] = category;
    data['category_binary'] = categoryBinary;
    data['image_url'] = imageUrl;
    data['price'] = price;
    return data;
  }
}
