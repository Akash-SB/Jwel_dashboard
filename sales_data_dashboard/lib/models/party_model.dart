enum PartyTypeEnum {
  agent,
  all,
  company;

  String get name {
    switch (this) {
      case PartyTypeEnum.agent:
        return "Agent";
      case PartyTypeEnum.company:
        return "Company";
      case PartyTypeEnum.all:
        return "All";
    }
  }

  static PartyTypeEnum fromString(String value) {
    switch (value) {
      case "Agent":
        return PartyTypeEnum.agent;
      case "Company":
        return PartyTypeEnum.company;
      case "All":
        return PartyTypeEnum.all;
      default:
        return PartyTypeEnum.all; // fallback to 'all' if unknown
    }
  }
}

class Party {
  final String id;
  final String name;
  final String? address;
  final String? mobileNumber;
  final String? gstNumber;
  final String partyType; // "company" or "agent"

  Party({
    required this.id,
    required this.name,
    this.address,
    this.mobileNumber,
    this.gstNumber,
    required this.partyType,
  });

  // SQLite
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'mobileNumber': mobileNumber,
        'gstNumber': gstNumber,
        'partyType': partyType,
      };

  factory Party.fromMap(Map<String, dynamic> map) => Party(
        id: map['id'],
        name: map['name'],
        address: map['address'] ?? '',
        mobileNumber: map['mobileNumber'],
        gstNumber: map['gstNumber'] ?? '',
        partyType: map['partyType'],
      );

  // Firebase
  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'address': address,
        'mobileNumber': mobileNumber,
        'gstNumber': gstNumber,
        'partyType': partyType,
      };
}
