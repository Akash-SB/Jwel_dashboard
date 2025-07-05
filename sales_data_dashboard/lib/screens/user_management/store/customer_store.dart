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
  void clearAllFilters() {
    searchController.text = '';
    setSearchText('');
    setSelectedUserType('All');
    setCurrentPageIndex(0);
    setSelectedRowCount('5');
    isFilterApplied = false;
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
      customers.add(customer.copyWith(id: int.tryParse(docRef.id)));
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
        customers[index] = customer.copyWith(id: int.tryParse(id));
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
}
