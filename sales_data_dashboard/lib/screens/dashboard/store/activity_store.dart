import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/activity_model.dart';
import '../../../models/invoice_model.dart';

part 'activity_store.g.dart';

class ActivityStore = _ActivityStore with _$ActivityStore;

abstract class _ActivityStore with Store {
  final _collection = FirebaseFirestore.instance.collection('activities');
  final CollectionReference invoicesRef =
      FirebaseFirestore.instance.collection('invoices');

  @observable
  ObservableList<InvoiceModel> invoices = ObservableList.of([]);

  // 🔹 Observable list of activities
  @observable
  ObservableList<Activity> activities = ObservableList<Activity>();

  // 🔹 Observable loading state
  @observable
  bool isLoading = false;

  // 🔹 Load all activities (one-time)
  @action
  Future<void> loadActivities() async {
    try {
      isLoading = true;
      final snapshot =
          await _collection.orderBy('date', descending: true).get();
      activities = ObservableList.of(
        snapshot.docs.map((doc) => Activity.fromDocument(doc)),
      );
    } finally {
      isLoading = false;
    }
  }

  // 🔹 Listen to activities (realtime)
  Future listenToActivities() {
    return _collection.orderBy('date', descending: true).snapshots().listen(
      (snapshot) {
        activities = ObservableList.of(
          snapshot.docs.map((doc) => Activity.fromDocument(doc)),
        );
      },
    ).asFuture(); // optional if you want to await, otherwise ignore
  }

  // 🔹 Add a new activity
  @action
  Future<void> addActivity(Activity activity) async {
    await _collection.add(activity.toMap());
  }

  // 🔹 Delete an activity
  @action
  Future<void> deleteActivity(String id) async {
    await _collection.doc(id).delete();
  }

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
