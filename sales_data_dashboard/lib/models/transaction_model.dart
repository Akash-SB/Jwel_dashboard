import 'package:sales_data_dashboard/models/usertype_enum.dart';

class TransactionModel {
  TransactionModel({
    required this.invoiceId,
    required this.date,
    required this.carat,
    required this.rate,
    required this.amount,
    required this.products,
    required this.transactionType,
    required this.custType,
    required this.custName,
    required this.paymentStatus,
    this.paymentType,
  });
  final String invoiceId;
  final String date;
  final String carat;
  final String rate;
  final String amount;
  final List<String> products;
  final TransactionTypeEnum transactionType;
  final UsertypeEnum custType;
  final String custName;
  final PaymentStatusEnum paymentStatus;
  final PaymentTypeEnum? paymentType;
}
