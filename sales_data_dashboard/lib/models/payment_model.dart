import 'package:sales_data_dashboard/models/app_enum.dart';
import 'package:sales_data_dashboard/models/party_model.dart';
import 'package:sales_data_dashboard/models/stock_item.dart';

class PaymentModel {
  final String id;
  final Party party;
  final double amount;
  final DateTime? date;
  final PaymentTypeEnum paymentType;
  final PaymentNature paymentNature;
  final StockItem stockDetails;

  PaymentModel({
    required this.id,
    required this.party,
    required this.amount,
    this.date,
    this.paymentType = PaymentTypeEnum.cash,
    this.paymentNature = PaymentNature.credit,
    required this.stockDetails,
  });

  // SQLite
  Map<String, dynamic> toMap() => {
        'id': id,
        'party': party.toMap(),
        'amount': amount,
        'date': date?.toIso8601String(),
        'paymentType': paymentType.name,
        'paymentNature': paymentNature.name,
        'stockDetails': stockDetails.toMap(),
      };

  factory PaymentModel.fromMap(Map<String, dynamic> map) => PaymentModel(
        id: map['id'],
        party: Party.fromMap(map['party']),
        amount: map['amount'],
        date: map['date'] != null ? DateTime.parse(map['date']) : null,
        paymentType: map['paymentType'] != null
            ? PaymentTypeEnum.values.firstWhere(
                (e) => e.name == map['paymentType'],
                orElse: () => PaymentTypeEnum.cash,
              )
            : PaymentTypeEnum.cash,
        paymentNature: map['paymentNature'] != null
            ? PaymentNature.values.firstWhere(
                (e) => e.name == map['paymentNature'],
                orElse: () => PaymentNature.credit,
              )
            : PaymentNature.credit,
        stockDetails: StockItem.fromMap(map['stockDetails']),
      );

  // Firebase
  Map<String, dynamic> toFirestore() => {
        'id': id,
        'party': party.toMap(),
        'amount': amount,
        'date': date?.toIso8601String(),
        'paymentType': paymentType.name,
        'paymentNature': paymentNature.name,
        'stockDetails': stockDetails.toMap(),
      };
}
