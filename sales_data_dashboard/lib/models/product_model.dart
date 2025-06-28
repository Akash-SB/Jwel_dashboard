// class ProductModel {
//   ProductModel({
//     required this.hsnCode,
//     required this.prodName,
//     required this.size,
//     required this.carat,
//     required this.rate,
//     required this.amount,
//     this.description,
//   });

//   final String hsnCode;
//   final String prodName;
//   final String size;
//   final String carat;
//   final String rate;
//   final String amount;
//   final String? description;
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final int? id;
  final String hsnCode;
  final String prodName;
  final String size;
  final String carat;
  final String rate;
  final String amount;
  final String? description;

  ProductModel({
    this.id,
    required this.hsnCode,
    required this.prodName,
    required this.size,
    required this.carat,
    required this.rate,
    required this.amount,
    this.description,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'hsnCode': hsnCode,
        'prodName': prodName,
        'size': size,
        'carat': carat,
        'rate': rate,
        'amount': amount,
        'description': description,
      };
}
