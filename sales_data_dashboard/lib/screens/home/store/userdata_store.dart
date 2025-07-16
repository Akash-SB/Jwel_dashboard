import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:sales_data_dashboard/models/customer_model.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';

import '../../../models/product_model.dart';

part 'userdata_store.g.dart';

class UserDataStore = _UserDataStore with _$UserDataStore;

abstract class _UserDataStore with Store {
  final CollectionReference customersRef =
      FirebaseFirestore.instance.collection('customers');

  final CollectionReference invoicesRef =
      FirebaseFirestore.instance.collection('invoices');

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');

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
  ObservableList<InvoiceModel> sixMonthTxnList = ObservableList.of([]);

  @observable
  ObservableList<CustomerModel> customers = ObservableList.of([]);

  @observable
  ObservableList<ProductModel> products = ObservableList.of([]);

  @action
  Future<void> fetchCustomers() async {
    isLoading = true;
    errorMessage = null;
    try {
      final snapshot = await customersRef.get();
      customers = ObservableList.of(
        snapshot.docs.map(
          (doc) => CustomerModel.fromMap({
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
  Future<void> fetchProducts() async {
    isLoading = true;
    errorMessage = null;
    try {
      final snapshot = await productsRef.get();
      products = ObservableList.of(
        snapshot.docs.map(
          (doc) => ProductModel.fromMap({
            ...doc.data() as Map<String, dynamic>,
          }, id: doc.id),
        ),
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
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
  void getLastSixMonthsTxns(List<InvoiceModel> allInvoices) {
    final now = DateTime.now();
    final sixMonthsAgo = DateTime(now.year, now.month - 6, now.day);

    setSixMonthTxn(ObservableList.of(allInvoices.where((invoice) {
      final invoiceDate = DateTime.parse(invoice.date);
      return invoiceDate.isAfter(sixMonthsAgo);
    })));
  }

  @action
  void setSixMonthTxn(List<InvoiceModel> invoiceList) {
    sixMonthTxnList = ObservableList.of(invoiceList);
  }

  @action
  void setInvoices(List<InvoiceModel> invoiceList) {
    invoices = ObservableList.of(invoiceList);
  }

  @action
  void setCustomers(List<CustomerModel> customerList) {
    customers = ObservableList.of(customerList);
  }

  @action
  void setProducts(List<ProductModel> productList) {
    products = ObservableList.of(productList);
  }
}
