import 'app_enum.dart';

class LedgerModel {
  final String ledgerId;
  final String customerId;
  final String? invoiceId;
  final DateTime date;
  final LedgerTransactionType transactionType;
  final double amount;
  final PaymentTypeEnum? paymentType;
  final String? note;

  LedgerModel({
    required this.ledgerId,
    required this.customerId,
    this.invoiceId,
    required this.date,
    required this.transactionType,
    required this.amount,
    this.paymentType,
    this.note,
  });

  Map<String, dynamic> toMap() => {
        'ledgerId': ledgerId,
        'customerId': customerId,
        'invoiceId': invoiceId,
        'date': date.toIso8601String(),
        'transactionType': transactionType.name,
        'amount': amount,
        'paymentType': paymentType?.name,
        'note': note,
      };
}
