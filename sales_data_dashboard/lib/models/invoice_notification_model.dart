class InvoiceNotificationModel {
  final String id; // Unique ID (e.g., invoiceId + date)
  final String salesId;
  final String userId;
  final String message;
  final DateTime notifyDate;
  bool isPaid;
  bool isShown; // For local UI state

  InvoiceNotificationModel({
    required this.id,
    required this.salesId,
    required this.userId,
    required this.message,
    required this.notifyDate,
    this.isShown = false,
    this.isPaid = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'salesId': salesId,
      'userId': userId,
      'message': message,
      'notifyDate': notifyDate.toIso8601String(),
      'isPaid': isPaid ? 1 : 0,
      'isShown': isShown ? 1 : 0,
    };
  }

  factory InvoiceNotificationModel.fromMap(Map<String, dynamic> map) {
    return InvoiceNotificationModel(
      id: map['id'],
      salesId: map['salesId'],
      userId: map['userId'],
      message: map['message'],
      notifyDate: DateTime.parse(map['notifyDate']),
      isPaid: map['isPaid'] == 1,
      isShown: map['isShown'] == 1,
    );
  }
}
