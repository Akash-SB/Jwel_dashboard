import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';
import 'package:sales_data_dashboard/models/invoice_notification_model.dart';
import 'package:sales_data_dashboard/models/party_model.dart';
import 'package:sales_data_dashboard/models/payment_model.dart';
import 'package:sales_data_dashboard/models/purchase_model.dart';
import 'package:sales_data_dashboard/models/stock_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;

import '../../../models/invoice_stock_model.dart';
import '../../../models/sales_model.dart';

part 'userdata_store.g.dart';

class UserDataStore = _UserDataStore with _$UserDataStore;

abstract class _UserDataStore with Store {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference notificationRef =
      FirebaseFirestore.instance.collection('notifications');

  final CollectionReference invoicesRef =
      FirebaseFirestore.instance.collection('invoices');

  final CollectionReference stockItemRefs =
      FirebaseFirestore.instance.collection('StockItems');

  final CollectionReference partiesRefs =
      FirebaseFirestore.instance.collection('PartyDetails');

  final CollectionReference salesRefs =
      FirebaseFirestore.instance.collection('sales');

  final CollectionReference purchaseRefs =
      FirebaseFirestore.instance.collection('purchases');

  final CollectionReference stockInvoiceItemRefs =
      FirebaseFirestore.instance.collection('InvoiceStockItems');

  final CollectionReference paymentItemRefs =
      FirebaseFirestore.instance.collection('payments');

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late Database db;

  @observable
  bool isLoading = false;

  @observable
  Observable<bool> isAllDataLoaded = Observable(false);

  @action
  void setIsAllDataLoaded(final bool value) {
    isAllDataLoaded.value = value;
  }

  @observable
  String? errorMessage;

  @observable
  int tabIndex = 0;

  @observable
  List<SidebarItem> sidebarItems = [
    SidebarItem(icon: Icons.dashboard, label: "Dashboard"),
    SidebarItem(icon: Icons.people, label: "Party Details"),
    SidebarItem(icon: Icons.inventory, label: "Item Details"),
    SidebarItem(icon: Icons.bar_chart, label: "Sales"),
    SidebarItem(icon: Icons.shopping_cart, label: "Purchase"),
    SidebarItem(icon: Icons.attach_money, label: "Payments"),
    SidebarItem(
      icon: Icons.receipt_long,
      label: "Bill Management",
      subItems: [
        SidebarItem(icon: Icons.receipt, label: "Invoices"),
        SidebarItem(icon: Icons.store, label: "Invoice Stock"),
      ],
    ),
  ];

  @action
  void setSidebarExpanded(int index, bool isExpanded) {
    sidebarItems.forEach((item) => item.isExpanded = false);
    sidebarItems[index].isExpanded = !isExpanded;
  }

  @action
  void setTab(int index) {
    tabIndex = index;
  }

  Future<void> initialize() async {
    // Initialize time zone data
    tzdata.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation('Asia/Kolkata')); // Set to your local timezone

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

  Future<void> showNotification({
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

  @observable
  ObservableList<InvoiceModel> invoices = ObservableList.of([]);

  @observable
  ObservableList<Sale> sixMonthSalesList = ObservableList.of([]);

  @observable
  ObservableList<Purchase> sixMonthPurchaseList = ObservableList.of([]);

  @observable
  ObservableList<StockItem> stockList = ObservableList.of([]);

  @observable
  ObservableList<Sale> salesList = ObservableList.of([]);

  @observable
  ObservableList<Purchase> purchaseList = ObservableList.of([]);

  @observable
  ObservableList<Party> partiesList = ObservableList.of([]);

  @observable
  ObservableList<InvoiceNotificationModel> notfList = ObservableList.of([]);

  @observable
  ObservableList<InvoiceStockModel> stockItemList = ObservableList.of([]);

  @observable
  ObservableList<PaymentModel> paymentList = ObservableList.of([]);

  @action
  void fillNotificationList(List<InvoiceNotificationModel> list) {
    notfList = ObservableList.of(list);
  }

  @action
  Future<void> setNotificationList(final List<Sale> salesList) async {
    try {
      // Fetch existing notifications from Firestore
      final snapshot = await notificationRef.get();
      final existingNotifications = snapshot.docs
          .map((doc) => InvoiceNotificationModel.fromMap({
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              }))
          .toList();

      // Helper to check if notification already exists for a sale
      bool notificationExists(String saleId) {
        return existingNotifications.any((notif) => notif.salesId == saleId);
      }

      final today = DateTime.now();

      for (final sale in salesList) {
        final dueDate = sale.createdAt.add(Duration(days: sale.dueDays ?? 0));
        final isDueToday = dueDate.isBefore(today) || dueDate == today;
        if (isDueToday && !notificationExists(sale.id)) {
          // Create notification model
          final notif = InvoiceNotificationModel(
            id: sale.id + today.toIso8601String().substring(0, 10),
            salesId: sale.id,
            userId: sale.partyDetails.id,
            message:
                'Invoice due on ${dueDate.day}/${dueDate.month}/${dueDate.year} for ${sale.partyDetails.name}',
            notifyDate: today,
            isShown: false,
          );

          // Add to Firestore
          await notificationRef.add(notif.toMap());

          // Optionally add to local list
          notfList.add(notif);
        }
      }
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> setNotificationAsPaid(String id, List<Sale> salesList) async {
    final index = notfList.indexWhere((notif) => notif.id == id);
    if (index != -1) {
      // Find the sale related to this notification
      final saleIndex =
          salesList.indexWhere((sale) => sale.id == notfList[index].salesId);
      // Update notification: mark as paid and shown
      notfList[index] = InvoiceNotificationModel(
        id: notfList[index].id,
        salesId: notfList[index].salesId,
        userId: notfList[index].userId,
        message: notfList[index].message,
        notifyDate: notfList[index].notifyDate,
        isPaid: true,
        isShown: true,
      );
      // Optionally update the sale's payment status if found
      if (saleIndex != -1) {
        salesList[saleIndex] = Sale(
          id: salesList[saleIndex].id,
          partyDetails: salesList[saleIndex].partyDetails,
          createdAt: salesList[saleIndex].createdAt,
          dueDays: salesList[saleIndex].dueDays,
          stockDetails: salesList[saleIndex].stockDetails,
          description: salesList[saleIndex].description,
        );
      }
      // Update the notification in Firestore
      await notificationRef.doc(id).update({
        'isPaid': true,
        'isShown': true,
      });

      await salesRefs
          .doc(notfList[index].salesId)
          .update({'paymentStatus': 'paid'});
    }
  }

  @action
  Future<void> fetchInvoices() async {
    isLoading = true;
    errorMessage = null;
    try {
      final snapshot = await invoicesRef.get();
      invoices = ObservableList.of(
        snapshot.docs.map(
          (doc) => InvoiceModel.fromMap({
            ...doc.data() as Map<String, dynamic>,
            'invoiceId': doc.id, // Ensure the Firestore doc id is set
          }),
        ),
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> fetchStockItemList() async {
    isLoading = true;
    errorMessage = null;
    try {
      final snapshot = await stockInvoiceItemRefs.get();
      stockItemList = ObservableList.of(
        snapshot.docs.map(
          (doc) => InvoiceStockModel.fromMap({
            ...doc.data() as Map<String, dynamic>,
            'id': doc.id, // Ensure the Firestore doc id is set
          }),
        ),
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> fetchStockList() async {
    try {
      final querySnapshot = await stockItemRefs.get();
      final fetched = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return StockItem.fromMap(data);
      }).toList();

      stockList = ObservableList<StockItem>.of(fetched);
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> fetchPartyList() async {
    try {
      final querySnapshot = await partiesRefs.get();
      final fetched = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Party.fromMap(data);
      }).toList();
      partiesList = ObservableList<Party>.of(fetched);
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> fetchSalesList() async {
    try {
      final querySnapshot = await salesRefs.get();
      final fetched = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Sale.fromMap(data);
      }).toList();
      salesList = ObservableList<Sale>.of(fetched);
      for (int i = 0; i < salesList.length; i++) {
        if (salesList[i].partyDetails.partyType.toLowerCase() == "company") {
          final sale = salesList[i];
          final dueDate = sale.createdAt.add(Duration(days: sale.dueDays ?? 0));
          final today = DateTime.now();
          if (dueDate.isBefore(today) || dueDate.isAtSameMomentAs(today)) {
            final overdueDays = today.difference(dueDate).inDays;
            // Only apply interest if overdueDays > 0
            if (overdueDays > 0 && sale.interestPercent != null) {
              double interestAmount = overdueDays * (sale.interestPercent ?? 0);
              salesList[i] = Sale(
                id: sale.id,
                partyDetails: sale.partyDetails,
                createdAt: sale.createdAt,
                dueDays: sale.dueDays,
                stockDetails: sale.stockDetails,
                description: sale.description,
                interestAmount: interestAmount,
                brokerageAmount: (sale.brokerageAmount ?? 0),
                agentDetails: sale.agentDetails,
                interestPercent: sale.interestPercent,
                brokeragePercent: sale.brokeragePercent,
              );
            } else {
              salesList[i] = Sale(
                id: sale.id,
                partyDetails: sale.partyDetails,
                createdAt: sale.createdAt,
                dueDays: sale.dueDays,
                stockDetails: sale.stockDetails,
                description: sale.description,
                interestAmount: 0,
                brokerageAmount: (sale.brokerageAmount ?? 0),
                agentDetails: sale.agentDetails,
                interestPercent: sale.interestPercent,
                brokeragePercent: sale.brokeragePercent,
              );
            }
          } else {
            salesList[i] = Sale(
              id: sale.id,
              partyDetails: sale.partyDetails,
              createdAt: sale.createdAt,
              dueDays: sale.dueDays,
              stockDetails: sale.stockDetails,
              description: sale.description,
              interestAmount: 0,
            );
          }
        }
      }
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> fetchPurchaseList() async {
    try {
      final querySnapshot = await purchaseRefs.get();
      final fetched = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Purchase.fromMap(data);
      }).toList();
      purchaseList = ObservableList<Purchase>.of(fetched);
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> getAllData() async {
    isLoading = true;
    errorMessage = null;
    await fetchStockList();
    await fetchSalesList();
    await fetchPurchaseList();
    await fetchPartyList();
    await fetchInvoices();
    await fetchStockItemList();
    await setNotificationList(salesList);
    isLoading = false;
    getLastSixMonthsTxns(salesList, purchaseList);
  }

  @action
  void getLastSixMonthsTxns(List<Sale> allSales, List<Purchase> allPurchase) {
    final now = DateTime.now();
    final sixMonthsAgo = DateTime(now.year, now.month - 6, now.day);

    setSixMonthSales(ObservableList.of(allSales.where((sale) {
      final salesDate = sale.createdAt;
      return salesDate.isAfter(sixMonthsAgo);
    })));

    setSixMonthPurchase(ObservableList.of(allPurchase.where((purchase) {
      final purchaseDate = purchase.createdAt;
      return purchaseDate.isAfter(sixMonthsAgo);
    })));
  }

  @action
  void setSixMonthSales(List<Sale> salesList) {
    sixMonthSalesList = ObservableList.of(salesList);
  }

  Future<void> updateNotifcations(
    final List<InvoiceNotificationModel> notifications,
  ) async {
    isLoading = true;
    try {
      // Step 1: Delete all existing notifications from Firestore
      final snapshot = await notificationRef.get();
      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }

      // Step 2: Add the new notifications from the passed list
      for (final notification in notifications) {
        final data = notification
            .toMap(); // Ensure toMap() method is defined in your model
        await notificationRef.add(data);
      }

      // Step 3: Fetch again to update local observable list
      final updatedSnapshot = await notificationRef.get();
      notfList = ObservableList.of(
        updatedSnapshot.docs.map(
          (doc) => InvoiceNotificationModel.fromMap({
            ...doc.data() as Map<String, dynamic>,
            'id': doc.id,
          }),
        ),
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateSalesStatus(String salesId) async {
    try {
      await salesRefs.doc(salesId).update({'paymentStatus': 'paid'});

      final index = salesList.indexWhere((s) => s.id == salesId);
      if (index != -1) {
        final sale = salesList[index];
        salesList[index] = Sale(
          id: sale.id,
          partyDetails: sale.partyDetails,
          createdAt: sale.createdAt,
          dueDays: sale.dueDays,
          stockDetails: sale.stockDetails,
          description: sale.description,
        );
      }
      notfList = ObservableList.of(notfList.map((notif) {
        if (notif.salesId == salesId) {
          return InvoiceNotificationModel(
            id: notif.id,
            salesId: notif.salesId,
            userId: notif.userId,
            message: notif.message,
            notifyDate: notif.notifyDate,
            isPaid: true,
            isShown: true,
          );
        }
        return notif;
      }));
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  void setSixMonthPurchase(List<Purchase> purchaseList) {
    sixMonthPurchaseList = ObservableList.of(purchaseList);
  }

  @action
  void setInvoices(List<InvoiceModel> invoiceList) {
    invoices = ObservableList.of(invoiceList);
  }

  @action
  void setStockList(List<StockItem> stockItems) {
    stockList = ObservableList.of(stockItems);
  }

  @action
  void setPartiesList(List<Party> partyList) {
    partiesList = ObservableList.of(partyList);
  }

  @action
  void setSalesList(List<Sale> sales) {
    salesList = ObservableList.of(sales);
  }

  @action
  void setPurchaseList(List<Purchase> purchases) {
    purchaseList = ObservableList.of(purchases);
  }

  @action
  void setInvoiceStockList(List<InvoiceStockModel> stockItems) {
    stockItemList = ObservableList.of(stockItems);
  }

  @action
  void setPaymentList(List<PaymentModel> payments) {
    paymentList = ObservableList.of(payments);
  }
}

class SidebarItem {
  final IconData icon;
  final String label;
  final List<SidebarItem>? subItems;
  bool isExpanded;

  SidebarItem({required this.icon, required this.label, this.subItems})
      : isExpanded = false;
}
