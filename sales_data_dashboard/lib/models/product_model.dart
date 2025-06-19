class ProductModel {
  ProductModel({
    required this.hsnCode,
    required this.prodName,
    required this.size,
    required this.carat,
    required this.rate,
    required this.amount,
    this.description,
  });

  final String hsnCode;
  final String prodName;
  final String size;
  final String carat;
  final String rate;
  final String amount;
  final String? description;
}
