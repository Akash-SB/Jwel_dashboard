import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String hsnCode;
  final String prodName;
  final String size;
  final String carat;
  final String rate;
  final String amount;
  final String? description;
  final int availableQty;
  final int minimumStock;

  ProductModel({
    required this.id,
    required this.hsnCode,
    required this.prodName,
    required this.size,
    required this.carat,
    required this.rate,
    required this.amount,
    this.description,
    required this.availableQty,
    required this.minimumStock,
  });

  /// Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'hsnCode': hsnCode,
      'prodName': prodName,
      'size': size,
      'carat': carat,
      'rate': rate,
      'amount': amount,
      'description': description,
      'availableQty': availableQty,
      'minimumStock': minimumStock,
    };
  }

  /// Convert to JSON (useful for local storage/APIs)
  Map<String, dynamic> toJson() => toMap();

  /// Create a model from map
  factory ProductModel.fromMap(Map<String, dynamic> map, {required String id}) {
    return ProductModel(
      id: id,
      hsnCode: map['hsnCode'] ?? '',
      prodName: map['prodName'] ?? '',
      size: map['size'] ?? '',
      carat: map['carat'] ?? '',
      rate: map['rate'] ?? '',
      amount: map['amount'] ?? '',
      description: map['description'],
      availableQty: map['availableQty'] ?? 0,
      minimumStock: map['minimumStock'] ?? 0,
    );
  }

  /// Create a model from Firestore document snapshot
  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel.fromMap(data, id: doc.id);
  }

  /// Create a copy with new values (for state updates)
  ProductModel copyWith({
    String? id,
    String? hsnCode,
    String? prodName,
    String? size,
    String? carat,
    String? rate,
    String? amount,
    String? description,
  }) {
    return ProductModel(
      id: id ?? this.id,
      hsnCode: hsnCode ?? this.hsnCode,
      prodName: prodName ?? this.prodName,
      size: size ?? this.size,
      carat: carat ?? this.carat,
      rate: rate ?? this.rate,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      availableQty: this.availableQty,
      minimumStock: this.minimumStock,
    );
  }
}
