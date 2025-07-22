import 'firm_model.dart';

class StockItem {
  final String itemId; // itemName + size for uniqueness
  final String itemName;
  final String size;
  final double rate;
  final double carat;
  final double availableQuantity;
  final double amount;
  final String description;
  final bool synced;
  final Firm firm;

  StockItem({
    required this.itemId,
    required this.itemName,
    required this.size,
    required this.rate,
    required this.carat,
    required this.amount,
    required this.availableQuantity,
    required this.description,
    required this.firm,
    this.synced = false,
  });

  Map<String, dynamic> toMap() => {
        'itemId': itemId,
        'itemName': itemName,
        'size': size,
        'rate': rate,
        'carat': carat,
        'amount': amount,
        'availableQuantity': availableQuantity,
        'description': description,
        'synced': synced ? 1 : 0,
        'firm': Firm.firmTypeToString(firm),
      };

  factory StockItem.fromMap(Map<String, dynamic> map) => StockItem(
        itemId: map['itemId'],
        itemName: map['itemName'],
        size: map['size'],
        rate: map['rate'],
        carat: map['carat'],
        amount: map['amount'],
        availableQuantity: map['availableQuantity'],
        description: map['description'],
        synced: map['synced'] == 1,
        firm: Firm.fromString(map['firm']),
      );

  Map<String, dynamic> toFirestore() => {
        'itemId': itemId,
        'itemName': itemName,
        'size': size,
        'rate': rate,
        'carat': carat,
        'amount': amount,
        'availableQuantity': availableQuantity,
        'description': description,
        'firm': firm
      };
}
