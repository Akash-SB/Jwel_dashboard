import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_enum.dart';

class CustomerModel {
  final int? id;
  final String custName;
  final String mobileNumber;
  final String gstNumber;
  final UsertypeEnum usertype;
  final String? address;

  CustomerModel({
    this.id,
    required this.custName,
    required this.mobileNumber,
    required this.gstNumber,
    required this.usertype,
    this.address,
  });

  /// Convert to Firestore map
  Map<String, dynamic> toMap() => {
        'id': id,
        'custName': custName,
        'mobileNumber': mobileNumber,
        'gstNumber': gstNumber,
        'usertype': usertype.name,
        'address': address,
        'createdAt': FieldValue.serverTimestamp(),
      };

  /// Convert to plain JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'custName': custName,
        'mobileNumber': mobileNumber,
        'gstNumber': gstNumber,
        'usertype': usertype.name,
        'address': address,
      };

  /// Construct from Firestore map
  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'],
      custName: map['custName'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      gstNumber: map['gstNumber'] ?? '',
      usertype: UsertypeEnum.values.firstWhere(
        (e) => e.name == map['usertype'],
        orElse: () => UsertypeEnum.Broker,
      ),
      address: map['address'],
    );
  }

  /// Construct from Firestore document snapshot
  factory CustomerModel.fromDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return CustomerModel.fromMap(doc.data());
  }

  /// Clone with optional field overrides
  CustomerModel copyWith({
    int? id,
    String? custName,
    String? mobileNumber,
    String? gstNumber,
    UsertypeEnum? usertype,
    String? address,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      custName: custName ?? this.custName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      gstNumber: gstNumber ?? this.gstNumber,
      usertype: usertype ?? this.usertype,
      address: address ?? this.address,
    );
  }
}
