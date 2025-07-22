import 'firm_model.dart';

class Party {
  final String id;
  final String name;
  final String address;
  final String mobileNumber;
  final String? gstNumber;
  final String partyType; // "company" or "agent"
  final bool synced;
  final Firm firm;

  Party({
    required this.id,
    required this.name,
    required this.address,
    required this.mobileNumber,
    this.gstNumber,
    required this.partyType,
    this.synced = false,
    required this.firm,
  });

  // SQLite
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'mobileNumber': mobileNumber,
        'gstNumber': gstNumber,
        'partyType': partyType,
        'synced': synced ? 1 : 0,
        'firm': firm.toShortString(),
      };

  factory Party.fromMap(Map<String, dynamic> map) => Party(
        id: map['id'],
        name: map['name'],
        address: map['address'],
        mobileNumber: map['mobileNumber'],
        gstNumber: map['gstNumber'] ?? '',
        partyType: map['partyType'],
        synced: map['synced'] == 1,
        firm: Firm.fromString(map['firm']),
      );

  // Firebase
  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'address': address,
        'mobileNumber': mobileNumber,
        'gstNumber': gstNumber,
        'partyType': partyType,
        'firm': firm,
      };
}
