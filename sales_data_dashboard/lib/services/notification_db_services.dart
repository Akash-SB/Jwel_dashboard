import 'package:sqflite/sqflite.dart';

import '../models/invoice_notification_model.dart';
import 'database_services.dart';

class NotificationDBService {
  static Future<void> saveNotification(InvoiceNotificationModel notif) async {
    final db = await DatabaseService()
        .getNotfDatabase(); // your existing database getter
    await db.insert('notifications', notif.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<bool> notificationExists(String id) async {
    final db = await DatabaseService().getNotfDatabase();
    final result =
        await db.query('notifications', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }

  static Future<List<InvoiceNotificationModel>> getAllNotifications() async {
    final db = await DatabaseService().getNotfDatabase();
    final maps = await db.query('notifications', orderBy: 'notifyDate DESC');
    return maps.map((e) => InvoiceNotificationModel.fromMap(e)).toList();
  }

  static Future<void> markAsRead(String id) async {
    final db = await DatabaseService().getNotfDatabase();
    await db.update('notifications', {'isRead': 1},
        where: 'id = ?', whereArgs: [id]);
  }
}
