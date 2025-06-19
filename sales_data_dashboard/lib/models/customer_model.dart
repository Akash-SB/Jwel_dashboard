import 'usertype_enum.dart';

class CustomerModel {
  CustomerModel({
    required this.custName,
    required this.mobileNumber,
    required this.gstNumber,
    this.address,
    required this.daysOfInterest,
    required this.usertype,
  });
  final String custName;
  final String mobileNumber;
  final String gstNumber;
  final UsertypeEnum usertype;
  final String? address;
  final int daysOfInterest;
}
