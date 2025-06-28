import 'usertype_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class CustomerModel {
//   CustomerModel({
//     required this.custName,
//     required this.mobileNumber,
//     required this.gstNumber,
//     this.address,
//     required this.daysOfInterest,
//     required this.usertype,
//   });
//   final String custName;
//   final String mobileNumber;
//   final String gstNumber;
//   final UsertypeEnum usertype;
//   final String? address;
//   final int daysOfInterest;
// }

class CustomerModel {
  final String id; // Firestore document ID
  final String custName;
  final String mobileNumber;
  final String gstNumber;
  final UsertypeEnum usertype;
  final String? address;
  final int daysOfInterest;

  CustomerModel({
    required this.id,
    required this.custName,
    required this.mobileNumber,
    required this.gstNumber,
    required this.usertype,
    required this.daysOfInterest,
    this.address,
  });

  /// Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'custName': custName,
      'mobileNumber': mobileNumber,
      'gstNumber': gstNumber,
      'usertype': usertype.name,
      'address': address,
      'daysOfInterest': daysOfInterest,
    };
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => toMap();

  /// Create from map
  factory CustomerModel.fromMap(Map<String, dynamic> map,
      {required String id}) {
    return CustomerModel(
      id: id,
      custName: map['custName'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      gstNumber: map['gstNumber'] ?? '',
      address: map['address'],
      daysOfInterest: map['daysOfInterest'] ?? 0,
      usertype: UsertypeEnum.values.firstWhere(
        (e) => e.name == map['usertype'],
        orElse: () => UsertypeEnum.broker,
      ),
    );
  }

  /// Create from Firestore DocumentSnapshot
  factory CustomerModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CustomerModel.fromMap(data, id: doc.id);
  }

  CustomerModel copyWith({
    String? id,
    String? custName,
    String? mobileNumber,
    String? gstNumber,
    UsertypeEnum? usertype,
    String? address,
    int? daysOfInterest,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      custName: custName ?? this.custName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      gstNumber: gstNumber ?? this.gstNumber,
      usertype: usertype ?? this.usertype,
      address: address ?? this.address,
      daysOfInterest: daysOfInterest ?? this.daysOfInterest,
    );
  }
}
