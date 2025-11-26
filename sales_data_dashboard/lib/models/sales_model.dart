import 'dart:convert';
import 'package:sales_data_dashboard/models/stock_item.dart';

import 'party_model.dart';

class Sale {
  final String id;
  final Party partyDetails;
  final StockItem stockDetails;
  final double? interestPercent;
  final double? interestAmount;
  final double? brokeragePercent;
  final double? brokerageAmount;
  final int? dueDays;
  final String? description;
  final DateTime createdAt;
  final Party? agentDetails;
  final double? quantity;

  Sale({
    required this.id,
    required this.partyDetails,
    required this.stockDetails,
    this.dueDays,
    this.description,
    required this.createdAt,
    this.agentDetails,
    this.interestPercent,
    this.interestAmount,
    this.brokeragePercent,
    this.brokerageAmount,
    this.quantity,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'party': jsonEncode(partyDetails.toMap()),
        'stock': jsonEncode(stockDetails.toMap()),
        'dueDays': dueDays,
        'description': description,
        'interestPercent': interestPercent,
        'interestAmount': interestAmount,
        'brokeragePercent': brokeragePercent,
        'brokerageAmount': brokerageAmount,
        'createdAt': createdAt.toIso8601String(),
        'agentDetails':
            agentDetails != null ? jsonEncode(agentDetails?.toMap()) : null,
        'quantity': quantity,
      };

  factory Sale.fromMap(Map<String, dynamic> map) => Sale(
        id: map['id'],
        partyDetails: Party.fromMap(jsonDecode(map['party'])),
        stockDetails: StockItem.fromMap(jsonDecode(map['stock'])),
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
        quantity: map['quantity'] != null
            ? (map['quantity'] as num).toDouble()
            : null,
      );

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'partyDetails': partyDetails,
        'stockDetails': stockDetails,
        'dueDays': dueDays,
        'interestPercent': interestPercent,
        'interestAmount': interestAmount,
        'brokeragePercent': brokeragePercent,
        'brokerageAmount': brokerageAmount,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
        'agentDetails': agentDetails?.toMap(),
        'quantity': quantity,
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
      'Due Days': dueDays,
      'interestPercent': interestPercent,
      'interestAmount': interestAmount,
      'brokeragePercent': brokeragePercent,
      'brokerageAmount': brokerageAmount,
      'Created': createdAt.toIso8601String(),
      'Agent': agentDetails?.name ?? 'N/A',
      'Quantity': quantity,
    };
  }
}
