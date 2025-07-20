import 'package:sales_data_dashboard/models/firm_model.dart';

enum PaymentStatus { paid, unpaid }
enum PaymentOption { cash, bank, cheque, upi }

class Sale {
  final String id;
  final String partyId;
  final String itemId;
  final String size;
  final double carat;
  final double rate;
  final double amount;
  final PaymentOption? paymentOption;
  final PaymentStatus paymentStatus;
  final int dueDays;
  final String? description;
  final double? brokeragePercent;
  final DateTime createdAt;
  final bool synced;
  final Firm firm;

  Sale({
    required this.id,
    required this.partyId,
    required this.itemId,
    required this.size,
    required this.carat,
    required this.rate,
    required this.amount,
    required this.paymentOption,
    required this.paymentStatus,
    required this.dueDays,
    this.description,
    this.brokeragePercent,
    required this.createdAt,
    required this.firm,
    this.synced = false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'partyId': partyId,
        'itemId': itemId,
        'size': size,
        'carat': carat,
        'rate': rate,
        'amount': amount,
        'paymentOption': paymentOption,
        'paymentStatus': paymentStatus,
        'dueDays': dueDays,
        'description': description,
        'brokeragePercent': brokeragePercent,
        'createdAt': createdAt.toIso8601String(),
        'synced': synced ? 1 : 0,
        'firm': Firm.firmTypeToString(firm),
      };

  factory Sale.fromMap(Map<String, dynamic> map) => Sale(
        id: map['id'],
        partyId: map['partyId'],
        itemId: map['itemId'],
        size: map['size'],
        carat: map['carat'],
        rate: map['rate'],
        amount: map['amount'],
        paymentOption: map['paymentOption'],
        paymentStatus: map['paymentStatus'],
        dueDays: map['dueDate'],
        description: map['description'],
        brokeragePercent: map['brokeragePercent'],
        createdAt: DateTime.parse(map['createdAt']),
        synced: map['synced'] == 1,
        firm: Firm.fromString(map['firm']),
      );

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'partyId': partyId,
        'itemId': itemId,
        'size': size,
        'carat': carat,
        'rate': rate,
        'amount': amount,
        'paymentOption': paymentOption,
        'paymentStatus': paymentStatus,
        'dueDays': dueDays,
        'description': description,
        'brokeragePercent': brokeragePercent,
        'createdAt': createdAt.toIso8601String(),
        'firm': firm
      };
}
