import 'package:sales_data_dashboard/models/invoice_notification_model.dart';
import '../models/invoice_model.dart';
import 'firebase_services.dart';
import 'notification_db_services.dart';
import 'notification_service.dart';

class NotificationCheckerService {
  static Future<void> checkInvoicesForToday(List<InvoiceModel> invoices) async {
    final today = DateTime.now();

    for (final invoice in invoices) {
      if (invoice.interestDays != null) {
        final invoiceDate = DateTime.parse(invoice.date);
        final dueDate = invoiceDate.add(Duration(
          days: int.tryParse(invoice.interestDays ?? '') ?? 0,
        ));
        final daysLeft = dueDate.difference(today).inDays;

        if (daysLeft == 3 || daysLeft == 0) {
          final notificationId =
              '${invoice.invoiceId}_${today.toIso8601String().substring(0, 10)}';

          // Check if this was already notified today
          final alreadyExists =
              await NotificationDBService.notificationExists(notificationId);
          if (alreadyExists) continue;

          final message = (daysLeft == 3)
              ? 'Interest period for invoice ${invoice.invoiceId} ends in 3 days.'
              : 'Interest period for invoice ${invoice.invoiceId} ends today!';

          final notif = InvoiceNotificationModel(
            id: notificationId,
            invoiceId: invoice.invoiceId,
            userId: invoice.custName,
            message: message,
            notifyDate: today,
          );

          // Save to SQLite
          await NotificationDBService.saveNotification(notif);

          // Save to Firebase
          await FirebaseService.saveNotification(notif);

          // Show local notification
          await NotificationService.showNotification(
            id: notificationId.hashCode,
            title: 'Invoice Alert',
            body: message,
          );
        }
      }
    }
  }
}
