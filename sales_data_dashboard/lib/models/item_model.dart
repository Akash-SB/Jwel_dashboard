class Item {
  final String id; // e.g., "ruby-4mm"
  final String name;
  final String hsnCode;
  final String size;
  final double carat;
  final double rate;
  final double amount;
  final String description;

  Item({
    required this.id,
    required this.name,
    required this.hsnCode,
    required this.size,
    required this.carat,
    required this.rate,
    required this.amount,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'hsnCode': hsnCode,
      'size': size,
      'carat': carat,
      'rate': rate,
      'amount': amount,
      'description': description,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      hsnCode: map['hsnCode'],
      size: map['size'],
      carat: map['carat'],
      rate: map['rate'],
      amount: map['amount'],
      description: map['description'],
    );
  }
}
