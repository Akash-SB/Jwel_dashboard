import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/models/party_model.dart';
import 'package:sales_data_dashboard/models/stock_item.dart';
import '../../../models/payment_model.dart';

part 'payment_screen_store.g.dart';

class PaymentScreenStore = _PaymentScreenStore with _$PaymentScreenStore;

abstract class _PaymentScreenStore with Store {
  final CollectionReference paymentsRef =
      FirebaseFirestore.instance.collection('payments');

  late TextEditingController searchController = TextEditingController();

  @observable
  ObservableList<PaymentModel> paymentList = ObservableList<PaymentModel>();

  @observable
  ObservableList<Party> partiesList = ObservableList<Party>();

  @observable
  Observable<StockItem>? selectedItem;

  @observable
  Observable<Party>? selectedParty;

  @observable
  String selectedStatus = 'All';

  @observable
  String? sortKey;

  @observable
  int totalPages = 0;

  @observable
  bool sortAsc = true;

  @observable
  String customerType = 'agent';

  @observable
  bool isFilterApplied = false;

  @observable
  Observable<Party>? agentDetails;

  @observable
  bool isAgentSelected = true;

  @observable
  String searchedText = '';

  @observable
  String selectedRowCount = '10';

  @observable
  int currentTablePage = 0;

  @action
  void setIsAgentSelected(bool value) {
    isAgentSelected = value;
  }

  @action
  void setSelectedStatus(String value) {
    selectedStatus = value;
  }

  @action
  void isFiltersApplied() {
    isFilterApplied =
        searchedText.isNotEmpty || selectedStatus != 'All' || sortKey != null;
  }

  @action
  void setCustomerType(final String type) {
    customerType = type;
  }

  @action
  void setAgentDetails(final Party agent) {
    agentDetails = Observable(agent);
  }

  @action
  void setSelectedParty(final Party party) {
    selectedParty = Observable(party);
  }

  @action
  void setSearchText(final String text) {
    searchedText = text;
  }

  @action
  void setCurrentPageIndex(final int index) {
    currentTablePage = index;
  }

  @action
  void clearAllFilters() {
    searchController.text = '';
    setSelectedStatus('All');
    sortKey = null;
    setSearchText('');
    setCurrentPageIndex(0);
    isFilterApplied = false;
  }

  @computed
  List<PaymentModel> get paginatedData {
    final start = currentTablePage * int.parse(selectedRowCount);
    final end =
        (start + int.parse(selectedRowCount)).clamp(0, sortedData.length);
    return sortedData.sublist(start, end);
  }

  @action
  void setSortKey(String? key) {
    if (sortKey == key) {
      sortAsc = !sortAsc;
    } else {
      sortKey = key;
      sortAsc = true;
    }
  }

  @action
  void calculateTotalPages() {
    if (filteredData.isEmpty) {
      totalPages = 0;
    } else {
      totalPages = (filteredData.length / int.parse(selectedRowCount)).ceil();
    }
  }

  @computed
  List<PaymentModel> get sortedData {
    List<PaymentModel> sorted = [...filteredData];
    if (sortKey != null) {
      sorted.sort((a, b) {
        final aValue = a.toMap()[sortKey];
        final bValue = b.toMap()[sortKey];
        if (aValue == null || bValue == null) return 0;
        return sortAsc
            ? aValue.toString().compareTo(bValue.toString())
            : bValue.toString().compareTo(aValue.toString());
      });
    }
    return sorted;
  }

  @computed
  List<PaymentModel> get filteredData {
    List<PaymentModel> filtered = paymentList.toList();
    return filtered.where((payment) {
      final matchesSearch = searchedText.toLowerCase();
      final searchItem = payment.id.toLowerCase().contains(matchesSearch) ||
          (payment.stockDetails.quantity ?? '0')
              .toLowerCase()
              .contains(matchesSearch);
      return searchItem;
    }).toList();
  }

  /// Loading state
  @observable
  bool isLoading = false;

  /// Error state
  @observable
  String? errorMessage;

  @action
  void setErrorMessage(String? message) {
    errorMessage = message;
  }

  @action
  void setPaymentList(List<PaymentModel> payments) {
    paymentList = ObservableList<PaymentModel>.of(payments);
  }

  @action
  Future<void> fetchPayments() async {
    isLoading = true;
    errorMessage = null;
    try {
      final querySnapshot = await paymentsRef.get();
      final fetched = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return PaymentModel.fromMap(data);
      }).toList();

      paymentList = ObservableList<PaymentModel>.of(fetched);
    } catch (e) {
      setErrorMessage(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> addPayment(PaymentModel payment) async {
    try {
      await paymentsRef.doc(payment.id).set(payment.toMap());
      paymentList.add(payment);
    } catch (e) {
      setErrorMessage(e.toString());
    }
  }

  @action
  Future<void> updatePayment(PaymentModel payment) async {
    try {
      await paymentsRef.doc(payment.id).update(payment.toMap());
      final index = paymentList.indexWhere((p) => p.id == payment.id);
      if (index != -1) {
        paymentList[index] = payment;
      }
    } catch (e) {
      setErrorMessage(e.toString());
    }
  }

  @action
  Future<void> deletePayment(String id) async {
    try {
      await paymentsRef.doc(id).delete();
      paymentList.removeWhere((p) => p.id == id);
    } catch (e) {
      setErrorMessage(e.toString());
    }
  }
}
