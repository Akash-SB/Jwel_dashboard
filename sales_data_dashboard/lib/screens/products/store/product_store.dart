import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_data_dashboard/models/product_model.dart';

part 'product_store.g.dart';

class ProductStore = _ProductStore with _$ProductStore;

abstract class _ProductStore with Store {
  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');

  @observable
  ObservableList<ProductModel> products = ObservableList.of([]);

  @action
  void setProducts(List<ProductModel> newProducts) {
    products = ObservableList.of(newProducts);
  }

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  late TextEditingController searchController;

  @observable
  String searchedText = '';

  @observable
  String selectedRowCount = '5';

  @observable
  bool isFilterApplied = false;

  @observable
  int currentTablePage = 0;

  @observable
  int totalPages = 0;

  @observable
  ProductModel? selectedProduct;

  @action
  void setSelectedProduct(ProductModel? product) {
    selectedProduct = product;
  }

  @action
  void setSearchText(final String text) {
    searchedText = text;
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
    setCurrentPageIndex(0);
    setSelectedRowCount('5');
    isFilterApplied = false;
  }

  @action
  void initializeSearchController() {
    searchController = TextEditingController();
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
  Future<void> addProduct(ProductModel product) async {
    isLoading = true;
    errorMessage = null;
    try {
      final data = product.toMap();
      final docRef = await productsRef.add(data);
      products.add(product.copyWith(id: docRef.id));
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateProduct(String id, ProductModel product) async {
    isLoading = true;
    errorMessage = null;
    try {
      final data = product.toMap();
      await productsRef.doc(id).update(data);
      final index = products.indexWhere((existing) => existing.id == id);
      if (index != -1) {
        products[index] = product.copyWith(id: id);
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deleteProduct(String id) async {
    isLoading = true;
    errorMessage = null;
    try {
      await productsRef.doc(id).delete();
      products.removeWhere((existing) => existing.id == id);
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
  List<ProductModel> get filteredData {
    List<ProductModel> filtered = products.toList();
    if (searchedText.isNotEmpty) {
      filtered = filtered
          .where((item) => item.toMap().values.any((v) =>
              v.toString().toLowerCase().contains(searchedText.toLowerCase())))
          .toList();
    }
    return filtered;
  }

  @computed
  List<ProductModel> get sortedData {
    List<ProductModel> sorted = [...filteredData];
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
  List<ProductModel> get paginatedData {
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
