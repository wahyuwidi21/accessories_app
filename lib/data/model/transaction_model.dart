class TransactionModel {
  late String transactionId;
  late int totalPrice;
  late int totalProduct;

  TransactionModel(
      {required this.transactionId,
      required this.totalPrice,
      required this.totalProduct});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    totalPrice = json['total_price'];
    totalProduct = json['total_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    data['total_price'] = totalPrice;
    data['total_product'] = totalProduct;

    return data;
  }
}
