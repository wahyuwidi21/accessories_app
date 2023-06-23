class CategoryModel {
  late int categoryId;
  late String name;
  late List<int> binary;

  CategoryModel(
      {required this.categoryId, required this.name, required this.binary});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    binary = json['binary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['name'] = name;
    data['binary'] = binary;
    return data;
  }
}
