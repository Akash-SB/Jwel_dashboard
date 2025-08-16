class InvoiceStockModel {
  final String itemId;
  final String itemName;
  final String hsdCode;
  final double itemWeight;
  final double rate;
  final double amount;
  final String firm;
  final String? description;

  InvoiceStockModel({
    required this.itemId,
    required this.itemName,
    required this.hsdCode,
    required this.itemWeight,
    required this.rate,
    required this.amount,
    required this.firm,
    this.description,
  });

  factory InvoiceStockModel.fromJson(Map<String, dynamic> json) {
    return InvoiceStockModel(
      itemId: json['itemId'] ?? '',
      firm: json['firm'] ?? '',
      itemName: json['itemName'] ?? '',
      hsdCode: json['hsdCode'] ?? '',
      itemWeight: (json['itemWeight'] ?? 0).toDouble(),
      rate: (json['rate'] ?? 0).toDouble(),
      amount: (json['amount'] ?? 0).toDouble(),
      description: json['description'] ?? 'NA',
    );
  }

  factory InvoiceStockModel.fromMap(Map<String, dynamic> data) {
    return InvoiceStockModel(
      itemId: data['itemId'] ?? '',
      firm: data['firm'] ?? '',
      itemName: data['itemName'] ?? '',
      hsdCode: data['hsdCode'] ?? '',
      itemWeight: (data['itemWeight'] ?? 0).toDouble(),
      rate: (data['rate'] ?? 0).toDouble(),
      amount: (data['amount'] ?? 0).toDouble(),
      description: data['description'] ?? 'NA',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prodId': itemId,
      'firm': firm,
      'prodName': itemName,
      'hsdCode': hsdCode,
      'prodWeight': itemWeight,
      'rate': rate,
      'amount': amount,
      'description': description,
    };
  }
}
