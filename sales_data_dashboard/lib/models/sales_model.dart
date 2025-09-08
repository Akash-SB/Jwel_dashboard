import 'dart:convert';
import 'package:sales_data_dashboard/models/stock_item.dart';

import 'party_model.dart';

enum PaymentStatus { paid, unpaid }

enum PaymentOption { cash, bank, cheque, upi }

class PartialPaymentDetails {
  final double amountPaid;
  final DateTime paymentDate;
  final String? paymentMethod;

  PartialPaymentDetails({
    required this.amountPaid,
    required this.paymentDate,
    this.paymentMethod,
  });

  Map<String, dynamic> toMap() => {
        'amountPaid': amountPaid,
        'paymentDate': paymentDate.toIso8601String(),
        'paymentMethod': paymentMethod,
      };

  factory PartialPaymentDetails.fromMap(Map<String, dynamic> map) =>
      PartialPaymentDetails(
        amountPaid: map['amountPaid'] as double,
        paymentDate: DateTime.parse(map['paymentDate']),
        paymentMethod: map['paymentMethod'] as String?,
      );
}

class Sale {
  final String id;
  final Party partyDetails;
  final StockItem stockDetails;
  final String? paymentOption;
  final double? interestPercent;
  final double? interestAmount;
  final double? brokeragePercent;
  final double? brokerageAmount;
  final int? dueDays;
  final String? description;
  final DateTime createdAt;
  final Party? agentDetails;
  final List<PartialPaymentDetails>? partialPaymentDetails;

  Sale({
    required this.id,
    required this.partyDetails,
    required this.stockDetails,
    required this.paymentOption,
    this.dueDays,
    this.description,
    required this.createdAt,
    this.agentDetails,
    this.partialPaymentDetails,
    this.interestPercent,
    this.interestAmount,
    this.brokeragePercent,
    this.brokerageAmount,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'party': jsonEncode(partyDetails.toMap()),
        'stock': jsonEncode(stockDetails.toMap()),
        'paymentOption': paymentOption,
        'dueDays': dueDays,
        'description': description,
        'interestPercent': interestPercent,
        'interestAmount': interestAmount,
        'brokeragePercent': brokeragePercent,
        'brokerageAmount': brokerageAmount,
        'createdAt': createdAt.toIso8601String(),
        'agentDetails':
            agentDetails != null ? jsonEncode(agentDetails?.toMap()) : null,
        'partialPaymentDetails': partialPaymentDetails != null
            ? jsonEncode(partialPaymentDetails?.map((e) => e.toMap()).toList())
            : null,
      };

  factory Sale.fromMap(Map<String, dynamic> map) => Sale(
        id: map['id'],
        partyDetails: Party.fromMap(jsonDecode(map['party'])),
        stockDetails: StockItem.fromMap(jsonDecode(map['stock'])),
        paymentOption: map['paymentOption'],
        dueDays: map['dueDays'] as int,
        interestPercent: map['interestPercent'] != null
            ? (map['interestPercent'] as num).toDouble()
            : null,
        interestAmount: map['interestAmount'] != null
            ? (map['interestAmount'] as num).toDouble()
            : null,
        brokeragePercent: map['brokeragePercent'] != null
            ? (map['brokeragePercent'] as num).toDouble()
            : null,
        description: map['description'],
        createdAt: DateTime.parse(map['createdAt']),
        agentDetails:
            map['agentDetails'] != null && !map['agentDetails'].contains('null')
                ? Party.fromMap(jsonDecode(map['agentDetails']))
                : null,
        partialPaymentDetails: map['partialPaymentDetails'] != null
            ? (jsonDecode(map['partialPaymentDetails']) as List)
                .map((e) => PartialPaymentDetails.fromMap(e))
                .toList()
            : null,
      );

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'partyDetails': partyDetails,
        'stockDetails': stockDetails,
        'paymentOption': paymentOption,
        'dueDays': dueDays,
        'interestPercent': interestPercent,
        'interestAmount': interestAmount,
        'brokeragePercent': brokeragePercent,
        'brokerageAmount': brokerageAmount,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
        'agentDetails': agentDetails?.toMap(),
        'partialPaymentDetails':
            partialPaymentDetails?.map((e) => e.toMap()).toList(),
      };

  /// For Firebase
  Map<String, dynamic> toJson() => toMap();
  factory Sale.fromJson(Map<String, dynamic> json) => Sale.fromMap(json);

  /// For Google Sheets: flat map with essential info
  Map<String, dynamic> toSheetRow() {
    return {
      'Sale ID': id,
      'Party': partyDetails.name,
      'Item': stockDetails.itemId,
      'Qty': stockDetails.availableQuantity,
      'Amount': stockDetails.amount,
      'Payment Option': paymentOption,
      'Due Days': dueDays,
      'interestPercent': interestPercent,
      'interestAmount': interestAmount,
      'brokeragePercent': brokeragePercent,
      'brokerageAmount': brokerageAmount,
      'Created': createdAt.toIso8601String(),
      'Agent': agentDetails?.name ?? 'N/A',
      'Partial Payments': partialPaymentDetails != null
          ? partialPaymentDetails?.map((e) =>
              {'Amount': e.amountPaid, 'Date': e.paymentDate.toIso8601String()})
          : [],
    };
  }
}
