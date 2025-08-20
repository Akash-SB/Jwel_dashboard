enum Firm {
  all,
  sahajanand,
  harikrishnaEnterprise;

  String get name {
    switch (this) {
      case Firm.sahajanand:
        return "Sahajanand Gems";
      case Firm.harikrishnaEnterprise:
        return "Harikrishna Enterprise";
      case Firm.all:
        return "All";
    }
  }

  static Firm fromString(String value) {
    return value == "Harikrishna Enterprise"
        ? Firm.harikrishnaEnterprise
        : Firm.sahajanand;
  }

  static String firmTypeToString(Firm type) {
    switch (type) {
      case Firm.sahajanand:
        return 'Sahajanand Gems';
      case Firm.harikrishnaEnterprise:
        return 'Harikrishna Enterprise';
      case Firm.all:
        return 'All';
    }
  }

  static Firm firmTypeFromString(String value) {
    switch (value) {
      case 'Sahajanand Gems':
        return Firm.sahajanand;
      case 'Harikrishna Enterprise':
        return Firm.harikrishnaEnterprise;
      default:
        throw Exception("Unknown FirmType: $value");
    }
  }

  String toShortString() => toString().split('.').last;
}
