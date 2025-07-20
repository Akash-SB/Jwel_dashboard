enum Firm {
  sahajanand,
  harikrishnaEnterprise;

  String get name => this == Firm.sahajanand
      ? "Sahajanand Jewellers"
      : "Harikrishna Enterprise";

  static Firm fromString(String value) {
    return value == "Harikrishna Enterprise"
        ? Firm.harikrishnaEnterprise
        : Firm.sahajanand;
  }

  static String firmTypeToString(Firm type) {
    switch (type) {
      case Firm.sahajanand:
        return 'Sahajanand';
      case Firm.harikrishnaEnterprise:
        return 'Harikrishna Enterprise';
    }
  }

  static Firm firmTypeFromString(String value) {
    switch (value) {
      case 'Sahajanand':
        return Firm.sahajanand;
      case 'Harikrishna Enterprise':
        return Firm.harikrishnaEnterprise;
      default:
        throw Exception("Unknown FirmType: $value");
    }
  }

  String toShortString() => toString().split('.').last;
}
