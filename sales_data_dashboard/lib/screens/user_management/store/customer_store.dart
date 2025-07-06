import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../models/customer_model.dart';

part 'customer_store.g.dart';

class CustomerStore = _CustomerStore with _$CustomerStore;

abstract class _CustomerStore with Store {
  final CollectionReference customersRef =
      FirebaseFirestore.instance.collection('customers');

  @observable
  ObservableList<CustomerModel> customers = ObservableList.of([]);

  @action
  void setCustomers(List<CustomerModel> newCustomers) {
    customers = ObservableList.of(newCustomers);
  }

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  late TextEditingController searchController;

  @observable
  String searchedText = '';

  @observable
  String selectedUserType = 'All';

  @observable
  String selectedRowCount = '5';

  @observable
  bool isFilterApplied = false;

  @observable
  int currentTablePage = 0;

  @observable
  int totalPages = 0;

  @observable
  bool isToggle = false;

  @observable
  CustomerModel? selectedCustomer;

  @action
  void setSelectedCustomer(CustomerModel? customer) {
    selectedCustomer = customer;
  }

  @action
  void toggleFilter() {
    isToggle = !isToggle;
  }

  @action
  void setSearchText(final String text) {
    searchedText = text;
  }

  @action
  void setSelectedUserType(final String text) {
    selectedUserType = text;
  }

  @action
  void setSelectedRowCount(final String text) {
    selectedRowCount = text;
  }

  @action
  void setCurrentPageIndex(final int index) {
    currentTablePage = index;
  }

  @action
  void calculateTotalPages() {
    if (filteredData.isEmpty) {
      totalPages = 0;
    } else {
      totalPages = (filteredData.length / int.parse(selectedRowCount)).ceil();
    }
  }

  @action
  void clearAllFilters() {
    searchController.text = '';
    setSearchText('');
    setSelectedUserType('All');
    setCurrentPageIndex(0);
    setSelectedRowCount('5');
    isFilterApplied = false;
  }

  @action
  void initializeSearchController() {
    searchController = TextEditingController();
  }

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
  Future<void> addCustomer(CustomerModel customer) async {
    isLoading = true;
    errorMessage = null;
    try {
      final data = customer.toMap();
      final docRef = await customersRef.add(data);
      customers.add(customer.copyWith(id: docRef.id));
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateCustomer(String id, CustomerModel customer) async {
    isLoading = true;
    errorMessage = null;
    try {
      final data = customer.toMap();
      await customersRef.doc(id).update(data);
      final index = customers.indexWhere((existing) => existing.id == id);
      if (index != -1) {
        customers[index] = customer.copyWith(id: id);
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deleteCustomer(String id) async {
    isLoading = true;
    errorMessage = null;
    try {
      await customersRef.doc(id).delete();
      customers.removeWhere((existing) => existing.id == id);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @observable
  String? sortKey;

  @observable
  bool sortAsc = true;

  @computed
  List<CustomerModel> get filteredData {
    List<CustomerModel> filtered = customers.toList();
    if (selectedUserType != 'All') {
      filtered = filtered
          .where((item) =>
              item.usertype.name.toLowerCase() ==
              selectedUserType.toLowerCase())
          .toList();
    }
    if (searchedText.isNotEmpty) {
      filtered = filtered
          .where((item) => item.toMap().values.any((v) =>
              v.toString().toLowerCase().contains(searchedText.toLowerCase())))
          .toList();
    }
    return filtered;
  }

  @computed
  List<CustomerModel> get sortedData {
    List<CustomerModel> sorted = [...filteredData];
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
  List<CustomerModel> get paginatedData {
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
}
