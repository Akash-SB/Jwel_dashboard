import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';
part 'invoice_store.g.dart';

class InvoiceStore = _InvoiceStore with _$InvoiceStore;

abstract class _InvoiceStore with Store {
  final CollectionReference invoicesRef =
      FirebaseFirestore.instance.collection('invoices');

  @observable
  ObservableList<InvoiceModel> invoices = ObservableList.of([]);

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

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
  Future<void> addInvoice(InvoiceModel invoice) async {
    isLoading = true;
    errorMessage = null;
    try {
      final data = invoice.toMap();
      final docRef = await invoicesRef.add(data);
      invoices.add(invoice.copyWith(invoiceId: docRef.id, id: docRef.id));
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateInvoice(String id, InvoiceModel invoice) async {
    isLoading = true;
    errorMessage = null;
    try {
      await invoicesRef.doc(id).update(invoice.toMap());
      final index = invoices.indexWhere((inv) => inv.invoiceId == id);
      if (index != -1) {
        invoices[index] = invoice.copyWith(invoiceId: id, id: id);
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deleteInvoice(String id) async {
    isLoading = true;
    errorMessage = null;
    try {
      await invoicesRef.doc(id).delete();
      invoices.removeWhere((inv) => inv.invoiceId == id);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
