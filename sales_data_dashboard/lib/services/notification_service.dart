import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const linuxInit =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    const windowsInit = WindowsInitializationSettings(
      appName: 'Sahajanand Gems Dashboard', // Your app name
      appUserModelId: 'com.sahajanand.gems',
      guid: '9fa09333-bd09-4a1b-bb1c-6200f1e25c88',
    );

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
      linux: linuxInit,
      windows: windowsInit,
    );

    await _notificationsPlugin.initialize(initSettings);
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    // Copy asset image to a file
    final byteData = await rootBundle.load('assets/logo.png');
    final tempDir = await getTemporaryDirectory();
    final imagePath = '${tempDir.path}/logo_win.png';
    final file = File(imagePath);
    await file.writeAsBytes(byteData.buffer.asUint8List());

    // Create URI
    final imageUri = Uri.file(imagePath);
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
      'interest_channel_id',
      'Interest Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails generalNotificationDetails = NotificationDetails(
        android: androidDetails,
        windows: WindowsNotificationDetails(
          images: [
            WindowsImage(imageUri,
                altText: 'Company logo',
                placement: WindowsImagePlacement.appLogoOverride,
                crop: WindowsImageCrop.circle),
          ],
        ));

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local)
          .add(const Duration(seconds: 1)), // Instant trigger
      generalNotificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
