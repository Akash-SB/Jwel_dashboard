class InvoiceNotificationModel {
  final String id; // Unique ID (e.g., invoiceId + date)
  final String invoiceId;
  final String userId;
  final String message;
  final DateTime notifyDate;
  final bool isRead;

  InvoiceNotificationModel({
    required this.id,
    required this.invoiceId,
    required this.userId,
    required this.message,
    required this.notifyDate,
    this.isRead = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoiceId': invoiceId,
      'userId': userId,
      'message': message,
      'notifyDate': notifyDate.toIso8601String(),
      'isRead': isRead ? 1 : 0,
    };
  }

  factory InvoiceNotificationModel.fromMap(Map<String, dynamic> map) {
    return InvoiceNotificationModel(
      id: map['id'],
      invoiceId: map['invoiceId'],
      userId: map['userId'],
      message: map['message'],
      notifyDate: DateTime.parse(map['notifyDate']),
      isRead: map['isRead'] == 1,
    );
  }
}
