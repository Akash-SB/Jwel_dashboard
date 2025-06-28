import 'app_enum.dart';

class InvoiceModel {
  final String invoiceId;
  final String date;
  final String carat;
  final String rate;
  final String amount;
  final List<int> productIds;
  final TransactionTypeEnum transactionType;
  final UsertypeEnum custType;
  final String custName;
  final PaymentStatusEnum paymentStatus;
  final PaymentTypeEnum? paymentType;

  InvoiceModel({
    required this.invoiceId,
    required this.date,
    required this.carat,
    required this.rate,
    required this.amount,
    required this.productIds,
    required this.transactionType,
    required this.custType,
    required this.custName,
    required this.paymentStatus,
    this.paymentType,
  });

  Map<String, dynamic> toMap() => {
        'invoiceId': invoiceId,
        'date': date,
        'carat': carat,
        'rate': rate,
        'amount': amount,
        'productIds': productIds.join(','),
        'transactionType': transactionType.name,
        'custType': custType.name,
        'custName': custName,
        'paymentStatus': paymentStatus.name,
        'paymentType': paymentType?.name,
      };
}
