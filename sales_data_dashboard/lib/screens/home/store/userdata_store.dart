import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';
import 'package:sales_data_dashboard/models/invoice_notification_model.dart';
import 'package:sales_data_dashboard/models/party_model.dart';
import 'package:sales_data_dashboard/models/purchase_model.dart';
import 'package:sales_data_dashboard/models/stock_item.dart';
import 'package:sqflite/sqflite.dart';

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
      FirebaseFirestore.instance.collection('StockInvoiceItems');

  late Database db;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  int tabIndex = 0;

  @action
  void setTab(int index) {
    tabIndex = index;
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
        final dueDate = sale.createdAt.add(Duration(days: sale.dueDays));
        final isDueToday = true;
        if (isDueToday && !notificationExists(sale.id)) {
          // Create notification model
          final notif = InvoiceNotificationModel(
            id: sale.id + today.toIso8601String().substring(0, 10),
            salesId: sale.id,
            userId: sale.partyDetails.id,
            message: 'Invoice due today for ${sale.partyDetails.name}',
            notifyDate: today,
            isPaid: sale.paymentStatus == 'paid',
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
          paymentStatus: 'paid',
          firm: salesList[saleIndex].firm,
          paymentOption: salesList[saleIndex].paymentOption,
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
          paymentStatus: 'paid',
          firm: sale.firm,
          paymentOption: sale.paymentOption,
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
}
