import '../models/invoice_notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationDBService {
  static final _collection = FirebaseFirestore.instance.collection('notifications');

  static Future<void> saveNotification(InvoiceNotificationModel notif) async {
    await _collection.doc(notif.id).set(notif.toMap());
  }

  static Future<bool> notificationExists(String id) async {
    final doc = await _collection.doc(id).get();
    return doc.exists;
  }

  static Future<List<InvoiceNotificationModel>> getAllNotifications() async {
    final querySnapshot = await _collection.orderBy('notifyDate', descending: true).get();
    return querySnapshot.docs
        .map((doc) => InvoiceNotificationModel.fromMap(doc.data()))
        .toList();
  }

  static Future<void> markAsRead(String id) async {
    await _collection.doc(id).update({'isRead': 1});
  }
}
