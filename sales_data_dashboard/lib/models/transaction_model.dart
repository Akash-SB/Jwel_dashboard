import 'package:sales_data_dashboard/models/app_enum.dart';

// class TransactionModel {
//   TransactionModel({
//     required this.invoiceId,
//     required this.date,
//     required this.carat,
//     required this.rate,
//     required this.amount,
//     required this.products,
//     required this.transactionType,
//     required this.custType,
//     required this.custName,
//     required this.paymentStatus,
//     this.paymentType,
//   });
//   final String invoiceId;
//   final String date;
//   final String carat;
//   final String rate;
//   final String amount;
//   final List<String> products;
//   final TransactionTypeEnum transactionType;
//   final UsertypeEnum custType;
//   final String custName;
//   final PaymentStatusEnum paymentStatus;
//   final PaymentTypeEnum? paymentType;
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String invoiceId;
  final String date;
  final String carat;
  final String rate;
  final String amount;
  final List<String> products;
  final TransactionTypeEnum transactionType;
  final UsertypeEnum custType;
  final String custName;
  final PaymentStatusEnum paymentStatus;
  final PaymentTypeEnum? paymentType;

  TransactionModel({
    required this.id,
    required this.invoiceId,
    required this.date,
    required this.carat,
    required this.rate,
    required this.amount,
    required this.products,
    required this.transactionType,
    required this.custType,
    required this.custName,
    required this.paymentStatus,
    this.paymentType,
  });

  /// Convert model to Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'invoiceId': invoiceId,
      'date': date,
      'carat': carat,
      'rate': rate,
      'amount': amount,
      'products': products,
      'transactionType': transactionType.name,
      'custType': custType.name,
      'custName': custName,
      'paymentStatus': paymentStatus.name,
      'paymentType': paymentType?.name,
    };
  }

  /// Convert to JSON (same as toMap here)
  Map<String, dynamic> toJson() => toMap();

  /// Create from map (Firestore or JSON)
  factory TransactionModel.fromMap(Map<String, dynamic> map,
      {required String id}) {
    return TransactionModel(
      id: id,
      invoiceId: map['invoiceId'] ?? '',
      date: map['date'] ?? '',
      carat: map['carat'] ?? '',
      rate: map['rate'] ?? '',
      amount: map['amount'] ?? '',
      products: List<String>.from(map['products'] ?? []),
      transactionType: TransactionTypeEnum.values.firstWhere(
        (e) => e.name == map['transactionType'],
        orElse: () => TransactionTypeEnum.sells,
      ),
      custType: UsertypeEnum.values.firstWhere(
        (e) => e.name == map['custType'],
        orElse: () => UsertypeEnum.broker,
      ),
      custName: map['custName'] ?? '',
      paymentStatus: PaymentStatusEnum.values.firstWhere(
        (e) => e.name == map['paymentStatus'],
        orElse: () => PaymentStatusEnum.unPaid,
      ),
      paymentType: map['paymentType'] != null
          ? PaymentTypeEnum.values.firstWhere(
              (e) => e.name == map['paymentType'],
              orElse: () => PaymentTypeEnum.cash,
            )
          : null,
    );
  }

  /// Create from Firestore DocumentSnapshot
  factory TransactionModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TransactionModel.fromMap(data, id: doc.id);
  }

  /// Copy with method
  TransactionModel copyWith({
    String? id,
    String? invoiceId,
    String? date,
    String? carat,
    String? rate,
    String? amount,
    List<String>? products,
    TransactionTypeEnum? transactionType,
    UsertypeEnum? custType,
    String? custName,
    PaymentStatusEnum? paymentStatus,
    PaymentTypeEnum? paymentType,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      date: date ?? this.date,
      carat: carat ?? this.carat,
      rate: rate ?? this.rate,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      transactionType: transactionType ?? this.transactionType,
      custType: custType ?? this.custType,
      custName: custName ?? this.custName,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentType: paymentType ?? this.paymentType,
    );
  }
}
