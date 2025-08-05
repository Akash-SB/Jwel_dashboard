class StockPartyLedger {
  final String id;
  final DateTime createdAt;
  final String customerId;
  final String productId;
  final String quantity;
  final String amount;
  final String paymentStatus;
  final int? dueDays;
  final String? description;
  final String firm;
  final String transType;

  StockPartyLedger(
      {required this.id,
      required this.createdAt,
      required this.customerId,
      required this.productId,
      required this.quantity,
      required this.amount,
      required this.paymentStatus,
      this.dueDays,
      this.description,
      required this.firm,
      required this.transType});
}

enum TransType {
  sale,
  purchase;

  String get name => this == TransType.sale ? "Sale" : "Purchase";
}
