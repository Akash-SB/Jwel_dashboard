import 'dart:convert';

import 'package:sales_data_dashboard/models/firm_model.dart';
import 'package:sales_data_dashboard/models/stock_item.dart';

import 'party_model.dart';

enum PaymentStatus { paid, unpaid }

enum PaymentOption { cash, bank, cheque, upi }

class PartialPaymentDetails {
  final double amountPaid;
  final DateTime paymentDate;

  PartialPaymentDetails({
    required this.amountPaid,
    required this.paymentDate,
  });

  Map<String, dynamic> toMap() => {
        'amountPaid': amountPaid,
        'paymentDate': paymentDate.toIso8601String(),
      };

  factory PartialPaymentDetails.fromMap(Map<String, dynamic> map) =>
      PartialPaymentDetails(
        amountPaid: map['amountPaid'] as double,
        paymentDate: DateTime.parse(map['paymentDate']),
      );
}

class Sale {
  final String id;
  final Party partyDetails;
  final StockItem stockDetails;
  final String? paymentOption;
  final String paymentStatus;
  final int dueDays;
  final String? description;
  final DateTime createdAt;
  final Firm firm;
  final Party? agentDetails;
  final List<PartialPaymentDetails>? partialPaymentDetails;

  Sale({
    required this.id,
    required this.partyDetails,
    required this.stockDetails,
    required this.paymentOption,
    required this.paymentStatus,
    this.dueDays = 60,
    this.description,
    required this.createdAt,
    required this.firm,
    this.agentDetails,
    this.partialPaymentDetails,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'party': jsonEncode(partyDetails.toMap()),
        'stock': jsonEncode(stockDetails.toMap()),
        'paymentOption': paymentOption,
        'paymentStatus': paymentStatus,
        'dueDays': dueDays,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
        'firm': Firm.firmTypeToString(firm),
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
        paymentStatus: map['paymentStatus'],
        dueDays: map['dueDays'] as int,
        description: map['description'],
        createdAt: DateTime.parse(map['createdAt']),
        firm: Firm.fromString(map['firm']),
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
        'paymentStatus': paymentStatus,
        'dueDays': dueDays,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
        'firm': firm.toString(),
        'agentDetails': agentDetails?.toMap(),
        'partialPaymentDetails': partialPaymentDetails != null
            ? partialPaymentDetails?.map((e) => e.toMap()).toList()
            : null,
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
      'Status': paymentStatus,
      'Due Days': dueDays,
      'Created': createdAt.toIso8601String(),
      'Firm': firm.name,
      'Agent': agentDetails?.name ?? 'N/A',
      'Agent Brokerage': agentDetails?.brokerage ?? 'N/A',
      'Partial Payments': partialPaymentDetails != null
          ? partialPaymentDetails?.map((e) =>
              {'Amount': e.amountPaid, 'Date': e.paymentDate.toIso8601String()})
          : [],
    };
  }
}
