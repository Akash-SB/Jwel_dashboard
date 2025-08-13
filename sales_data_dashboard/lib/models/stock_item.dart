import 'firm_model.dart';

class StockItem {
  final String id;
  final String itemId; // itemName + size for uniqueness
  final String itemName;
  final String hsnCode;
  final String size;
  final double rate;
  final double carat;
  final double availableQuantity;
  final double amount;
  final String description;
  final String firm;

  StockItem({
    required this.id,
    required this.itemId,
    required this.itemName,
    required this.hsnCode,
    required this.size,
    required this.rate,
    required this.carat,
    required this.amount,
    required this.availableQuantity,
    required this.description,
    required this.firm,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'itemId': itemId,
        'itemName': itemName,
        'size': size,
        'hsnCode': hsnCode,
        'rate': rate,
        'carat': carat,
        'amount': amount,
        'availableQuantity': availableQuantity,
        'description': description,
        'firm': firm,
      };

  factory StockItem.fromMap(Map<String, dynamic> map) => StockItem(
        id: map['id'],
        itemId: map['itemId'],
        itemName: map['itemName'],
        size: map['size'],
        hsnCode: map['hsnCode'] ?? '',
        rate: map['rate'],
        carat: map['carat'],
        amount: map['amount'],
        availableQuantity: map['availableQuantity'],
        description: map['description'],
        firm: map['firm'] ?? Firm.sahajanand.name,
      );

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'itemId': itemId,
        'itemName': itemName,
        'size': size,
        'rate': rate,
        'carat': carat,
        'amount': amount,
        'hsnCode': hsnCode,
        'availableQuantity': availableQuantity,
        'description': description,
        'firm': firm
      };
}
