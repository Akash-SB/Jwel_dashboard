class StockItem {
  final String itemId; // itemName + size for uniqueness
  final String itemName;
  final String? hsnCode;
  final String size;
  final String? quantity;
  final double? rate;
  final double? availableQuantity;
  final double? amount;
  final String? description;

  StockItem({
    required this.itemId,
    required this.itemName,
    required this.size,
    this.hsnCode,
    this.quantity,
    this.rate,
    this.amount,
    this.availableQuantity,
    this.description,
  });

  Map<String, dynamic> toMap() => {
        'itemId': itemId,
        'itemName': itemName,
        'quantity': quantity,
        'hsnCode': hsnCode,
        'rate': rate,
        'size': size,
        'amount': amount,
        'availableQuantity': availableQuantity,
        'description': description,
      };

  factory StockItem.fromMap(Map<String, dynamic> map) => StockItem(
        itemId: map['itemId'],
        itemName: map['itemName'],
        quantity: map['quantity'] ?? '',
        hsnCode: map['hsnCode'],
        rate: map['rate'],
        amount: map['amount'],
        availableQuantity: map['availableQuantity'],
        description: map['description'],
        size: map['size'],
      );

  Map<String, dynamic> toFirestore() => {
        'itemId': itemId,
        'itemName': itemName,
        'quantity': quantity,
        'rate': rate,
        'amount': amount,
        'size': size,
        'hsnCode': hsnCode,
        'availableQuantity': availableQuantity,
        'description': description,
      };
}
