import 'package:sales_data_dashboard/models/sales_model.dart';

class StockPartyLedger {
  final String id;
  final DateTime createdAt;
  final String customerId;
  final String customerName;
  final String productId;
  final String quantity;
  final String amount;
  final String paymentStatus;
  final String? paymentOption;
  final int? dueDays;
  final String? description;
  final String firm;
  final String? agentName;
  final String? brokerage;
  final String transType;
  final List<PartialPaymentDetails>? partialPaymentDetails;

  StockPartyLedger({
    required this.id,
    required this.createdAt,
    required this.customerId,
    required this.customerName,
    required this.productId,
    required this.quantity,
    required this.amount,
    required this.paymentStatus,
    this.agentName,
    this.brokerage,
    this.paymentOption,
    this.dueDays,
    this.description,
    required this.firm,
    required this.transType,
    this.partialPaymentDetails,
  });
}

enum TransType {
  sale,
  purchase,
  all;

  String get name {
    switch (this) {
      case TransType.sale:
        return "Sale";
      case TransType.purchase:
        return "Purchase";
      case TransType.all:
        return "All";
    }
  }
}
