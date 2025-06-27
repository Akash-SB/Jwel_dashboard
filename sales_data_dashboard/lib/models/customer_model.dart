import 'app_enum.dart';

class CustomerModel {
  final int? id;
  final String custName;
  final String mobileNumber;
  final String gstNumber;
  final UsertypeEnum usertype;
  final String? address;
  final int daysOfInterest;

  CustomerModel({
    this.id,
    required this.custName,
    required this.mobileNumber,
    required this.gstNumber,
    required this.usertype,
    this.address,
    required this.daysOfInterest,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'custName': custName,
        'mobileNumber': mobileNumber,
        'gstNumber': gstNumber,
        'usertype': usertype.name,
        'address': address,
        'daysOfInterest': daysOfInterest,
      };
}
