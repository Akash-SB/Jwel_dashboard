import 'dart:convert';

import 'package:sales_data_dashboard/models/firm_model.dart';
import 'package:sales_data_dashboard/models/stock_item.dart';

import 'party_model.dart';

enum PaymentStatus { paid, unpaid }

enum PaymentOption { cash, bank, cheque, upi }

class Sale {
  final String id;
  final Party partyDetails;
  final StockItem stockDetails;
  final PaymentOption? paymentOption;
  final PaymentStatus paymentStatus;
  final int dueDays;
  final String? description;
  final DateTime createdAt;
  final bool synced;
  final Firm firm;

  Sale({
    required this.id,
    required this.partyDetails,
    required this.stockDetails,
    required this.paymentOption,
    required this.paymentStatus,
    required this.dueDays,
    this.description,
    required this.createdAt,
    required this.firm,
    this.synced = false,
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
        'synced': synced ? 1 : 0,
        'firm': Firm.firmTypeToString(firm),
      };

  factory Sale.fromMap(Map<String, dynamic> map) => Sale(
        id: map['id'],
        partyDetails: Party.fromMap(jsonDecode(map['party'])),
        stockDetails: StockItem.fromMap(jsonDecode(map['stock'])),
        paymentOption: map['paymentOption'],
        paymentStatus: map['paymentStatus'],
        dueDays: map['dueDate'],
        description: map['description'],
        createdAt: DateTime.parse(map['createdAt']),
        synced: map['synced'] == 1,
        firm: Firm.fromString(map['firm']),
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
        'firm': firm
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
      'Payment Option': paymentOption?.name,
      'Status': paymentStatus.name,
      'Due Days': dueDays,
      'Created': createdAt.toIso8601String(),
      'Firm': firm.name,
    };
  }
}
