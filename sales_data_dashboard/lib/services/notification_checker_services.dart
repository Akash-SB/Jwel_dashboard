// import 'package:sales_data_dashboard/models/invoice_notification_model.dart';
// import 'package:sales_data_dashboard/models/sales_model.dart';
// import 'firebase_services.dart';
// import 'notification_db_services.dart';
// import 'notification_service.dart';

// class NotificationCheckerService {
//   static Future<void> checkInvoicesForToday(List<Sale> salesList) async {
//     final today = DateTime.now();

//     for (final sales in salesList) {
//         final salesDate = sales.createdAt;
//         final dueDate = salesDate.add(Duration(days: sales.dueDays));
//         final daysLeft = dueDate.difference(today).inDays;
//         if (daysLeft == 0) {
//           final notificationId =
//               '${sales.id}_${today.toIso8601String().substring(0, 10)}';

//           // Check if this was already notified today
//           final alreadyExists =
//               await NotificationDBService.notificationExists(notificationId);
//           if (alreadyExists) continue;

//           final message = (daysLeft == 3)
//               ? 'Interest period ends in 3 days.'
//               : 'Interest period ends today!';

//           final notif = InvoiceNotificationModel(
//             id: notificationId,
//             salesId: sales.id,
//             userId: sales.partyDetails.id,
//             message: message,
//             notifyDate: today,
//           );

//           // Save to Firebase
//           await FirebaseService.saveNotification(notif);

//           // Show local notification
//           await NotificationService.showNotification(
//             id: notificationId.hashCode,
//             title: 'Invoice Alert',
//             body: message,
//             onPaid: () {
//               // Handle "Paid" action
//               NotificationService.onPaidCallback?.call();
//             },
//           );
//         }
//     }
//   }
// }
