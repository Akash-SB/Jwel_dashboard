import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_enum.dart';

class InvoiceModel {
  final String invoiceId;
  final String date;
  final String size;
  final String rate;
  final String amount;
  final List<int> productIds;
  final TransactionTypeEnum transactionType;
  final UsertypeEnum custType;
  final String custName;
  final PaymentStatusEnum paymentStatus;
  final PaymentTypeEnum? paymentType;
  final String? note;

  InvoiceModel({
    required this.invoiceId,
    required this.date,
    required this.size,
    required this.rate,
    required this.amount,
    required this.productIds,
    required this.transactionType,
    required this.custType,
    required this.custName,
    required this.paymentStatus,
    this.paymentType,
    this.note,
  });

  /// Convert to Firestore map
  Map<String, dynamic> toMap() => {
        'invoiceId': invoiceId,
        'date': date,
        'carat': size,
        'rate': rate,
        'amount': amount,
        'productIds': productIds,
        'transactionType': transactionType.name,
        'custType': custType.name,
        'custName': custName,
        'paymentStatus': paymentStatus.name,
        'paymentType': paymentType?.name,
        'createdAt': FieldValue.serverTimestamp(),
        'note': note,
      };

  /// Construct from Firestore map
  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      invoiceId: map['invoiceId'] ?? '',
      date: map['date'] ?? '',
      size: map['carat'] ?? '',
      rate: map['rate'] ?? '',
      amount: map['amount'] ?? '',
      productIds: List<int>.from(map['productIds'] ?? []),
      transactionType: TransactionTypeEnum.values.firstWhere(
        (e) => e.name == map['transactionType'],
        orElse: () => TransactionTypeEnum.sell,
      ),
      custType: UsertypeEnum.values.firstWhere(
        (e) => e.name == map['custType'],
        orElse: () => UsertypeEnum.broker,
      ),
      custName: map['custName'] ?? '',
      paymentStatus: PaymentStatusEnum.values.firstWhere(
        (e) => e.name == map['paymentStatus'],
        orElse: () => PaymentStatusEnum.unpaid,
      ),
      paymentType: map['paymentType'] != null
          ? PaymentTypeEnum.values.firstWhere(
              (e) => e.name == map['paymentType'],
              orElse: () => PaymentTypeEnum.cash,
            )
          : null,
    );
  }

  /// Construct from Firestore document snapshot
  factory InvoiceModel.fromDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return InvoiceModel.fromMap(doc.data());
  }

  /// Create a copy with a new invoice ID
  InvoiceModel copyWith({required String invoiceId, required String id}) {
    return InvoiceModel(
      invoiceId: invoiceId,
      date: date,
      size: size,
      rate: rate,
      amount: amount,
      productIds: List<int>.from(productIds),
      transactionType: transactionType,
      custType: custType,
      custName: custName,
      paymentStatus: paymentStatus,
      paymentType: paymentType,
      note: note,
    );
  }
}
