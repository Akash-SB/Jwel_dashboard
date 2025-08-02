import 'dart:convert';

import 'firm_model.dart';
import 'party_model.dart';
import 'stock_item.dart';

class Purchase {
  final String id;
  final Party partyDetails;
  final StockItem stockDetails;
  final String? paymentOption;
  final String paymentStatus;
  final String description;
  final DateTime createdAt;
  final String firm;

  Purchase({
    required this.id,
    required this.partyDetails,
    required this.stockDetails,
    this.paymentOption,
    required this.paymentStatus,
    required this.description,
    required this.createdAt,
    required this.firm,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'party': jsonEncode(partyDetails.toMap()),
        'stock': jsonEncode(stockDetails.toMap()),
        'paymentOption': paymentOption,
        'paymentStatus': paymentStatus,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
        'firm': firm,
      };

  factory Purchase.fromMap(Map<String, dynamic> map) => Purchase(
        id: map['id'],
        partyDetails: Party.fromMap(jsonDecode(map['party'])),
        stockDetails: StockItem.fromMap(jsonDecode(map['stock'])),
        paymentOption: map['paymentOption'],
        paymentStatus: map['paymentStatus'],
        description: map['description'],
        createdAt: DateTime.parse(map['createdAt']),
        firm: map['firm'] ?? Firm.sahajanand.name,
      );

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'partyDetails': partyDetails,
        'stockDetails': stockDetails,
        'paymentOption': paymentOption,
        'paymentStatus': paymentStatus,
        'description': description,
        'firm': firm,
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
      'Payment Option': paymentOption,
      'Status': paymentStatus,
      'Created': createdAt.toIso8601String(),
      'Firm': firm,
    };
  }
}
