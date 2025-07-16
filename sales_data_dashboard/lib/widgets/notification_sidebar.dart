import 'package:flutter/material.dart';

import '../models/invoice_notification_model.dart';
import '../services/notification_db_services.dart';

class NotificationSidebar extends StatelessWidget {
  final List<InvoiceNotificationModel> notifications;

  const NotificationSidebar({
    super.key,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Notifications", style: Theme.of(context).textTheme.titleLarge),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (ctx, index) {
                final notif = notifications[index];
                return ListTile(
                  title: Text(notif.message),
                  subtitle: Text(notif.notifyDate.toLocal().toString()),
                  trailing: notif.isRead
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : Icon(Icons.circle, color: Colors.grey),
                  onTap: () async {
                    await NotificationDBService.markAsRead(notif.id);
                    Navigator.pop(context);
                    // Optionally refresh UI
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
