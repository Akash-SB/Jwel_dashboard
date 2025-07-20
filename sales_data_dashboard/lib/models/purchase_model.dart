import 'package:sales_data_dashboard/models/sales_model.dart';

import 'firm_model.dart';

class Purchase {
  final String id;
  final String itemName;
  final String size;
  final double carat;
  final double rate;
  final double amount;
  final PaymentOption paymentOption;
  final PaymentStatus paymentStatus;
  final DateTime dueDate;
  final String description;
  final DateTime createdAt;
  final bool synced;
  final Firm firm;

  Purchase({
    required this.id,
    required this.itemName,
    required this.size,
    required this.carat,
    required this.rate,
    required this.amount,
    required this.paymentOption,
    required this.paymentStatus,
    required this.dueDate,
    required this.description,
    required this.createdAt,
    required this.firm,
    this.synced = false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'itemName': itemName,
        'size': size,
        'carat': carat,
        'rate': rate,
        'amount': amount,
        'paymentOption': paymentOption,
        'paymentStatus': paymentStatus,
        'dueDate': dueDate.toIso8601String(),
        'description': description,
        'createdAt': createdAt.toIso8601String(),
        'synced': synced ? 1 : 0,
        'firm': firm.toShortString(),
      };

  factory Purchase.fromMap(Map<String, dynamic> map) => Purchase(
        id: map['id'],
        itemName: map['itemName'],
        size: map['size'],
        carat: map['carat'],
        rate: map['rate'],
        amount: map['amount'],
        paymentOption: map['paymentOption'],
        paymentStatus: map['paymentStatus'],
        dueDate: DateTime.parse(map['dueDate']),
        description: map['description'],
        createdAt: DateTime.parse(map['createdAt']),
        synced: map['synced'] == 1,
        firm: Firm.fromString(map['firm']),
      );

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'itemName': itemName,
        'size': size,
        'carat': carat,
        'rate': rate,
        'amount': amount,
        'paymentOption': paymentOption,
        'paymentStatus': paymentStatus,
        'dueDate': dueDate.toIso8601String(),
        'description': description,
        'createdAt': createdAt.toIso8601String(),
      };
}
