import 'firm_model.dart';

enum PartyTypeEnum {
  agent,
  company;

  String get name => this == PartyTypeEnum.agent ? "Agent" : "Company";

  static PartyTypeEnum fromString(String value) {
    return value == "Agent" ? PartyTypeEnum.agent : PartyTypeEnum.company;
  }
}

class Party {
  final String id;
  final String name;
  final String address;
  final String mobileNumber;
  final String? gstNumber;
  final String partyType; // "company" or "agent"
  final String firm;
  final String? brokerage; // Optional field for agent brokerage

  Party({
    required this.id,
    required this.name,
    required this.address,
    required this.mobileNumber,
    this.gstNumber,
    required this.partyType,
    required this.firm,
    this.brokerage,
  });

  // SQLite
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'mobileNumber': mobileNumber,
        'gstNumber': gstNumber,
        'partyType': partyType,
        'firm': firm,
        'brokerage': brokerage,
      };

  factory Party.fromMap(Map<String, dynamic> map) => Party(
        id: map['id'],
        name: map['name'],
        address: map['address'],
        mobileNumber: map['mobileNumber'],
        gstNumber: map['gstNumber'] ?? '',
        partyType: map['partyType'],
        firm: map['firm'] ?? Firm.sahajanand.name,
        brokerage: map['brokerage'],
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
        'brokerage': brokerage,
      };
}
