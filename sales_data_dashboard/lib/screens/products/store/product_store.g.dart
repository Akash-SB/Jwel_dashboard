// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductStore on _ProductStore, Store {
  Computed<List<ProductModel>>? _$filteredDataComputed;

  @override
  List<ProductModel> get filteredData => (_$filteredDataComputed ??=
          Computed<List<ProductModel>>(() => super.filteredData,
              name: '_ProductStore.filteredData'))
      .value;
  Computed<List<ProductModel>>? _$sortedDataComputed;

  @override
  List<ProductModel> get sortedData => (_$sortedDataComputed ??=
          Computed<List<ProductModel>>(() => super.sortedData,
              name: '_ProductStore.sortedData'))
      .value;
  Computed<List<ProductModel>>? _$paginatedDataComputed;

  @override
  List<ProductModel> get paginatedData => (_$paginatedDataComputed ??=
          Computed<List<ProductModel>>(() => super.paginatedData,
              name: '_ProductStore.paginatedData'))
      .value;

  late final _$productsAtom =
      Atom(name: '_ProductStore.products', context: context);

  @override
  ObservableList<ProductModel> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<ProductModel> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ProductStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_ProductStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$searchedTextAtom =
      Atom(name: '_ProductStore.searchedText', context: context);

  @override
  String get searchedText {
    _$searchedTextAtom.reportRead();
    return super.searchedText;
  }

  @override
  set searchedText(String value) {
    _$searchedTextAtom.reportWrite(value, super.searchedText, () {
      super.searchedText = value;
    });
  }

  late final _$selectedRowCountAtom =
      Atom(name: '_ProductStore.selectedRowCount', context: context);

  @override
  String get selectedRowCount {
    _$selectedRowCountAtom.reportRead();
    return super.selectedRowCount;
  }

  @override
  set selectedRowCount(String value) {
    _$selectedRowCountAtom.reportWrite(value, super.selectedRowCount, () {
      super.selectedRowCount = value;
    });
  }

  late final _$isFilterAppliedAtom =
      Atom(name: '_ProductStore.isFilterApplied', context: context);

  @override
  bool get isFilterApplied {
    _$isFilterAppliedAtom.reportRead();
    return super.isFilterApplied;
  }

  @override
  set isFilterApplied(bool value) {
    _$isFilterAppliedAtom.reportWrite(value, super.isFilterApplied, () {
      super.isFilterApplied = value;
    });
  }

  late final _$currentTablePageAtom =
      Atom(name: '_ProductStore.currentTablePage', context: context);

  @override
  int get currentTablePage {
    _$currentTablePageAtom.reportRead();
    return super.currentTablePage;
  }

  @override
  set currentTablePage(int value) {
    _$currentTablePageAtom.reportWrite(value, super.currentTablePage, () {
      super.currentTablePage = value;
    });
  }

  late final _$totalPagesAtom =
      Atom(name: '_ProductStore.totalPages', context: context);

  @override
  int get totalPages {
    _$totalPagesAtom.reportRead();
    return super.totalPages;
  }

  @override
  set totalPages(int value) {
    _$totalPagesAtom.reportWrite(value, super.totalPages, () {
      super.totalPages = value;
    });
  }

  late final _$selectedProductAtom =
      Atom(name: '_ProductStore.selectedProduct', context: context);

  @override
  ProductModel? get selectedProduct {
    _$selectedProductAtom.reportRead();
    return super.selectedProduct;
  }

  @override
  set selectedProduct(ProductModel? value) {
    _$selectedProductAtom.reportWrite(value, super.selectedProduct, () {
      super.selectedProduct = value;
    });
  }

  late final _$sortKeyAtom =
      Atom(name: '_ProductStore.sortKey', context: context);

  @override
  String? get sortKey {
    _$sortKeyAtom.reportRead();
    return super.sortKey;
  }

  @override
  set sortKey(String? value) {
    _$sortKeyAtom.reportWrite(value, super.sortKey, () {
      super.sortKey = value;
    });
  }

  late final _$sortAscAtom =
      Atom(name: '_ProductStore.sortAsc', context: context);

  @override
  bool get sortAsc {
    _$sortAscAtom.reportRead();
    return super.sortAsc;
  }

  @override
  set sortAsc(bool value) {
    _$sortAscAtom.reportWrite(value, super.sortAsc, () {
      super.sortAsc = value;
    });
  }

  late final _$fetchProductsAsyncAction =
      AsyncAction('_ProductStore.fetchProducts', context: context);

  @override
  Future<void> fetchProducts() {
    return _$fetchProductsAsyncAction.run(() => super.fetchProducts());
  }

  late final _$addProductAsyncAction =
      AsyncAction('_ProductStore.addProduct', context: context);

  @override
  Future<void> addProduct(ProductModel product) {
    return _$addProductAsyncAction.run(() => super.addProduct(product));
  }

  late final _$updateProductAsyncAction =
      AsyncAction('_ProductStore.updateProduct', context: context);

  @override
  Future<void> updateProduct(String id, ProductModel product) {
    return _$updateProductAsyncAction
        .run(() => super.updateProduct(id, product));
  }

  late final _$deleteProductAsyncAction =
      AsyncAction('_ProductStore.deleteProduct', context: context);

  @override
  Future<void> deleteProduct(String id) {
    return _$deleteProductAsyncAction.run(() => super.deleteProduct(id));
  }

  late final _$_ProductStoreActionController =
      ActionController(name: '_ProductStore', context: context);

  @override
  void setProducts(List<ProductModel> newProducts) {
    final _$actionInfo = _$_ProductStoreActionController.startAction(
        name: '_ProductStore.setProducts');
    try {
      return super.setProducts(newProducts);
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedProduct(ProductModel? product) {
    final _$actionInfo = _$_ProductStoreActionController.startAction(
        name: '_ProductStore.setSelectedProduct');
    try {
      return super.setSelectedProduct(product);
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchText(String text) {
    final _$actionInfo = _$_ProductStoreActionController.startAction(
        name: '_ProductStore.setSearchText');
    try {
      return super.setSearchText(text);
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedRowCount(String text) {
    final _$actionInfo = _$_ProductStoreActionController.startAction(
        name: '_ProductStore.setSelectedRowCount');
    try {
      return super.setSelectedRowCount(text);
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentPageIndex(int index) {
    final _$actionInfo = _$_ProductStoreActionController.startAction(
        name: '_ProductStore.setCurrentPageIndex');
    try {
      return super.setCurrentPageIndex(index);
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calculateTotalPages() {
    final _$actionInfo = _$_ProductStoreActionController.startAction(
        name: '_ProductStore.calculateTotalPages');
    try {
      return super.calculateTotalPages();
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAllFilters() {
    final _$actionInfo = _$_ProductStoreActionController.startAction(
        name: '_ProductStore.clearAllFilters');
    try {
      return super.clearAllFilters();
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initializeSearchController() {
    final _$actionInfo = _$_ProductStoreActionController.startAction(
        name: '_ProductStore.initializeSearchController');
    try {
      return super.initializeSearchController();
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSortKey(String? key) {
    final _$actionInfo = _$_ProductStoreActionController.startAction(
        name: '_ProductStore.setSortKey');
    try {
      return super.setSortKey(key);
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
searchedText: ${searchedText},
selectedRowCount: ${selectedRowCount},
isFilterApplied: ${isFilterApplied},
currentTablePage: ${currentTablePage},
totalPages: ${totalPages},
selectedProduct: ${selectedProduct},
sortKey: ${sortKey},
sortAsc: ${sortAsc},
filteredData: ${filteredData},
sortedData: ${sortedData},
paginatedData: ${paginatedData}
    ''';
  }
}
