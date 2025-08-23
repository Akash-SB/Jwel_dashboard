class InvoiceStockLedgerModel {
  final String date;
  final String itemName;
  final String partyName;
  final String paymentType;
  final double? dueDays;
  final double? credit;
  final double? debit;

  InvoiceStockLedgerModel({
    required this.date,
    required this.itemName,
    required this.partyName,
    required this.paymentType,
    this.dueDays,
    this.credit,
    this.debit,
  });
}

enum PaymentType {
  sale,
  purchase,
  all,
}

extension PaymentTypeName on PaymentType {
  String get name {
    switch (this) {
      case PaymentType.sale:
        return 'Sale';
      case PaymentType.purchase:
        return 'Purchase';
      case PaymentType.all:
        return 'All';
    }
  }
}
