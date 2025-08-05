import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_data_dashboard/models/invoice_notification_model.dart';

import '../../../models/invoice_model.dart';

part 'activity_store.g.dart';

class DashboardStore = _DashboardStore with _$DashboardStore;

abstract class _DashboardStore with Store {
  final CollectionReference invoicesRef =
      FirebaseFirestore.instance.collection('invoices');

  @observable
  ObservableList<InvoiceModel> invoices = ObservableList.of([]);

  @observable
  ObservableList<InvoiceNotificationModel> notifications =
      ObservableList<InvoiceNotificationModel>();

  @action
  void setnotificationList(List<InvoiceNotificationModel> list) {
    notifications = ObservableList.of(list);
  }

  // 🔹 Observable loading state
  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> fetchInvoices() async {
    isLoading = true;
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
    } finally {
      isLoading = false;
    }
  }

  @action
  void setInvoices(List<InvoiceModel> invoices) {
    this.invoices = ObservableList.of(invoices);
  }
}
