import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_data_dashboard/screens/invoice/invoice_screen.dart';
import 'app_enum.dart';

class InvoiceModel {
  final String invoiceId;
  final String? invoiceNumber;
  final String date;
  final String size;
  final String rate;
  final String amount;
  final TransactionTypeEnum transactionType;
  final UsertypeEnum custType;
  final String custName;
  final String? note;
  final String? productName;
  final String hsnCode;
  final String? interestDays;
  final String? custAddress;
  final String? custPhone;
  final String? custGst;
  final String? itemId;
  final CompanyModel selectedFirm;
  final UnitTypeEnum unitType;
  final String? id;

  InvoiceModel({
    required this.invoiceId,
    required this.date,
    required this.size,
    required this.rate,
    required this.amount,
    required this.productName,
    required this.transactionType,
    required this.custType,
    required this.custName,
    this.note,
    this.hsnCode = '',
    this.interestDays,
    this.custAddress,
    this.custPhone,
    this.custGst,
    this.itemId,
    required this.selectedFirm,
    this.invoiceNumber,
    this.unitType = UnitTypeEnum.KG,
    this.id,
  });

  /// Convert to Firestore map
  Map<String, dynamic> toMap() => {
        'invoiceId': invoiceId,
        'date': date,
        'carat': size,
        'rate': rate,
        'amount': amount,
        'productName': productName,
        'transactionType': transactionType.name,
        'custType': custType.name,
        'custName': custName,
        'createdAt': FieldValue.serverTimestamp(),
        'note': note,
        'hsnCode': hsnCode,
        'interestDays': interestDays,
        'custAddress': custAddress,
        'custPhone': custPhone,
        'custGst': custGst,
        'itemId': itemId,
        'selectedFirmName': jsonEncode(selectedFirm.toMap()),
        'invoiceNumber': invoiceNumber,
        'unitType': unitType.name,
        'id': id,
      };

  /// Construct from Firestore map
  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
        invoiceId: map['invoiceId'] ?? '',
        date: map['date'] ?? '',
        size: map['carat'] ?? '',
        rate: map['rate'] ?? '',
        amount: map['amount'] ?? '',
        id: map['id'] ?? '',
        productName: map['productName'] ?? '',
        transactionType: TransactionTypeEnum.values.firstWhere(
          (e) => e.name == map['transactionType'],
          orElse: () => TransactionTypeEnum.sell,
        ),
        custType: UsertypeEnum.values.firstWhere(
          (e) => e.name == map['custType'],
          orElse: () => UsertypeEnum.broker,
        ),
        unitType: UnitTypeEnum.values.firstWhere(
          (e) => e.name == map['unitType'],
          orElse: () => UnitTypeEnum.KG,
        ),
        custName: map['custName'] ?? '',
        invoiceNumber: map['invoiceNumber'] ?? '',
        note: map['note'],
        hsnCode: map['hsnCode'] ?? '',
        interestDays: map['interestDays'] ?? '',
        custAddress: map['custAddress'],
        custPhone: map['custPhone'],
        custGst: map['custGst'],
        itemId: map['itemId'],
        selectedFirm: CompanyModel(
          name:
              jsonDecode(map['selectedFirmName'])['name'] ?? 'Default Company',
          gstin: jsonDecode(map['selectedFirmName'])['gstin'] ?? '',
          address: jsonDecode(map['selectedFirmName'])['address'] ?? '',
          phone: jsonDecode(map['selectedFirmName'])['phone'] ?? '',
          email: jsonDecode(map['selectedFirmName'])['email'] ?? '',
          panNumber: jsonDecode(map['selectedFirmName'])['panNumber'] ?? '',
        ));
  }

  /// Construct from Firestore document snapshot
  factory InvoiceModel.fromDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return InvoiceModel.fromMap(doc.data());
  }

  /// Create a copy with a new invoice ID
  InvoiceModel copyWith({required String id}) {
    return InvoiceModel(
      invoiceId: invoiceId,
      date: date,
      size: size,
      rate: rate,
      amount: amount,
      productName: productName,
      transactionType: transactionType,
      custType: custType,
      custName: custName,
      note: note,
      hsnCode: hsnCode,
      interestDays: interestDays,
      custAddress: custAddress,
      custPhone: custPhone,
      custGst: custGst,
      itemId: itemId,
      selectedFirm: selectedFirm,
      invoiceNumber: invoiceNumber,
      unitType: unitType,
      id: id,
    );
  }

  double get parsedAmount => double.tryParse(amount) ?? 0.0;
  DateTime get parsedDate => DateTime.tryParse(date) ?? DateTime.now();
}
