import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/invoice_notification_model.dart';

class FirebaseService {
  static Future<void> saveNotification(InvoiceNotificationModel notif) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(notif.userId)
        .collection('notifications')
        .doc(notif.id)
        .set(notif.toMap());
  }
}
