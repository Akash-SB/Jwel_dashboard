class InvoiceLedgerModel {
  final String date;
  final String prodName;
  final String paymentType;
  final String? dueDays;
  final String? credit;
  final String? debit;

  InvoiceLedgerModel({
    required this.date,
    required this.prodName,
    required this.paymentType,
    this.dueDays,
    this.credit,
    this.debit,
  });
}
