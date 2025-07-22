import 'dart:convert';

import 'package:sales_data_dashboard/models/sales_model.dart';

import 'firm_model.dart';
import 'party_model.dart';
import 'stock_item.dart';

class Purchase {
  final String id;
  final Party partyDetails;
  final StockItem stockDetails;
  final PaymentOption? paymentOption;
  final PaymentStatus paymentStatus;
  final String description;
  final DateTime createdAt;
  final bool synced;
  final Firm firm;

  Purchase({
    required this.id,
    required this.partyDetails,
    required this.stockDetails,
    this.paymentOption,
    required this.paymentStatus,
    required this.description,
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
        'description': description,
        'createdAt': createdAt.toIso8601String(),
        'synced': synced ? 1 : 0,
        'firm': firm.toShortString(),
      };

  factory Purchase.fromMap(Map<String, dynamic> map) => Purchase(
        id: map['id'],
        partyDetails: Party.fromMap(jsonDecode(map['party'])),
        stockDetails: StockItem.fromMap(jsonDecode(map['stock'])),
        paymentOption: map['paymentOption'],
        paymentStatus: map['paymentStatus'],
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
        'description': description,
        'createdAt': createdAt.toIso8601String(),
      };

  /// For Firebase
  Map<String, dynamic> toJson() => toMap();
  factory Purchase.fromJson(Map<String, dynamic> json) =>
      Purchase.fromMap(json);

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
      'Created': createdAt.toIso8601String(),
      'Firm': firm.name,
    };
  }
}
