import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sales_data_dashboard/models/app_enum.dart';
import 'package:sales_data_dashboard/models/stock_party_ledger.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';

import '../../../models/party_model.dart';

part 'party_details_screen_store.g.dart';

class PartyDetailsStore = _PartyDetailsStore with _$PartyDetailsStore;

abstract class _PartyDetailsStore with Store {
  _PartyDetailsStore({
    required this.userDataStore,
  });

  final UserDataStore userDataStore;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference get _collection => _firestore.collection('PartyDetails');

  late final searchcontroller = TextEditingController();

  @observable
  ObservableList<Party> partiesList = ObservableList<Party>();

  @observable
  ObservableList<StockPartyLedger> partyLedgerList =
      ObservableList<StockPartyLedger>();

  @observable
  String? sortKey;

  @observable
  int totalPages = 0;

  @observable
  bool sortAsc = true;

  @observable
  Observable<Party>? selectedParty;

  @observable
  String selectedTransType = 'All';

  @observable
  String selectedTransStatus = 'All';

  @action
  void setSelectedTransType(final value) {
    selectedTransType = value;
  }

  @observable
  bool isInfoFilterApplied = false;

  @observable
  int currentInfoTablePage = 0;

  @observable
  int totalinfoPages = 0;

  @observable
  String? errorMessage;

  @action
  void setErrorMessage(String? message) {
    errorMessage = message;
  }

  @action
  void setSelectedTransStatus(final value) {
    selectedTransStatus = value;
  }

  @action
  void setTotalinfoPages(final int index) {
    totalinfoPages = index;
  }

  @observable
  TransactionTypeEnum selectedFilterTransactionType = TransactionTypeEnum.sell;

  @action
  void setPartyLedgerList(final List<StockPartyLedger> list) {
    partyLedgerList
      ..clear()
      ..addAll(list);
  }

  @action
  void isInfoFilterAppliedCheck() {
    isInfoFilterApplied =
        selectedTransType != 'All' || selectedTransStatus != 'All';
  }

  @action
  void setSelectedFilterTransactionType(TransactionTypeEnum value) {
    selectedFilterTransactionType = value;
  }

  @action
  void setSelectedParty(Party? party) {
    selectedParty = party != null ? Observable<Party>(party) : null;
  }

  @observable
  Observable<bool> showPartyInfo = Observable<bool>(false);

  @action
  void togglePartyInfo(bool value) {
    runInAction(() {
      showPartyInfo.value = value;
    });
  }

  @action
  void setPartiesList(List<Party> partyList) {
    partiesList = ObservableList.of(partyList);
  }

  @action
  void setCurrentInfoTablePage(final int index) {
    currentInfoTablePage = index;
  }

  @action
  Future<void> addPartyDetails(Party party) async {
    try {
      await _collection.doc(party.id).set(party.toMap());
      userDataStore.partiesList.add(party);
      partiesList.add(party);
    } catch (e) {
      setErrorMessage('Error adding party: $e');

      print('Error adding party: $e');
    }
  }

  @action
  void clearInfoFilter() {
    setSelectedTransStatus('All');
    setSelectedTransType('All');
    setCurrentInfoTablePage(0);
    isInfoFilterApplied = false;
  }

  @action
  void filterLedgerList() {
    List<StockPartyLedger> ledgers = [];
    ledgers.addAll(
      userDataStore.salesList
          .where((final sale) =>
              sale.partyDetails.name == selectedParty?.value.name)
          .map(
            (final sale) => StockPartyLedger(
              id: sale.id,
              createdAt: sale.createdAt,
              customerId: sale.partyDetails.id,
              customerName: sale.partyDetails.name,
              productId: sale.stockDetails.itemId,
              quantity: sale.stockDetails.availableQuantity.toString(),
              amount: sale.stockDetails.amount.toString(),
              paymentStatus: sale.paymentStatus,
              firm: sale.firm.name,
              transType: TransType.sale.name,
              description: sale.description,
              dueDays: sale.dueDays,
              agentName: sale.agentDetails?.name ?? 'NA',
              brokerage: sale.agentDetails?.brokerage ?? 'NA',
              partialPaymentDetails: sale.partialPaymentDetails,
            ),
          ),
    );
    ledgers.addAll(
      userDataStore.purchaseList
          .where((final purchase) =>
              purchase.partyDetails.name == selectedParty?.value.name)
          .map(
            (final purchase) => StockPartyLedger(
              id: purchase.id,
              createdAt: purchase.createdAt,
              customerId: purchase.partyDetails.id,
              customerName: purchase.partyDetails.name,
              productId: purchase.stockDetails.itemId,
              quantity: purchase.stockDetails.availableQuantity.toString(),
              amount: purchase.stockDetails.amount.toString(),
              paymentStatus: purchase.paymentStatus,
              firm: purchase.firm,
              transType: TransType.purchase.name,
              description: purchase.description,
              agentName: purchase.agentDetails?.name ?? 'NA',
              brokerage: purchase.agentDetails?.brokerage ?? 'NA',
              paymentOption: purchase.paymentOption,
            ),
          ),
    );
    ledgers.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    partyLedgerList.clear();
    setPartyLedgerList(ledgers);
  }

  @action
  Future<void> updatePartyDetails(Party party) async {
    try {
      await _collection.doc(party.id).update(party.toMap());
      final index = partiesList.indexWhere((s) => s.id == party.id);
      final indexUserData =
          userDataStore.partiesList.indexWhere((s) => s.id == party.id);

      if (index != -1) {
        partiesList[index] = party;
      }
      if (indexUserData != -1) {
        userDataStore.partiesList[indexUserData] = party;
      }
    } catch (e) {
      setErrorMessage('Error updating party: $e');
    }
  }

  @action
  Future<void> deletePartyDetails(String id) async {
    try {
      await _collection.doc(id).delete();
      partiesList.removeWhere((s) => s.id == id);
      userDataStore.partiesList.removeWhere((s) => s.id == id);
    } catch (e) {
      setErrorMessage('Error deleting party: $e');
    }
  }

  @action
  void calculateInfoTotalPages() {
    if (filteredInfoData.isEmpty) {
      totalinfoPages = 0;
    } else {
      totalinfoPages =
          (filteredInfoData.length / int.parse(selectedRowCount)).ceil();
    }
  }

  @action
  void setSearchText(final String text) {
    searchedText = text;
  }

  @observable
  bool isFilterApplied = false;

  @observable
  String selectedFormPartyType = 'Agent';

  @observable
  String selectedFormFirmType = 'Sahajanand Gems';

  @action
  void setSelectedFormPartyType(String value) {
    selectedFormPartyType = value;
  }

  @action
  void setSelectedFormFirmType(String value) {
    selectedFormFirmType = value;
  }

  @computed
  List<StockPartyLedger> get filteredInfoData {
    List<StockPartyLedger> filtered = partyLedgerList.toList();
    return filtered.where((item) {
      final typeMatch = selectedTransType == 'All'
          ? true
          : item.transType == selectedTransType;
      final statusType = selectedTransStatus == 'All'
          ? true
          : item.paymentStatus.toLowerCase() ==
              selectedTransStatus.toLowerCase();
      return typeMatch && statusType;
    }).toList();
  }

  @computed
  List<StockPartyLedger> get paginatedInfoData {
    final start = currentInfoTablePage * int.parse(selectedRowCount);
    final end =
        (start + int.parse(selectedRowCount)).clamp(0, filteredInfoData.length);
    return filteredInfoData.sublist(start, end);
  }

  @action
  String setPartyId(String itemName, String partyType) {
    if (partyType == 'Agent') {
      return 'A-$itemName';
    } else if (partyType == 'Company') {
      return 'C-$itemName';
    } else {
      return 'A-$itemName';
    }
  }

  @observable
  String searchedText = '';

  @observable
  String selectedRowCount = '10';

  @observable
  int currentTablePage = 0;

  @action
  void setCurrentPageIndex(final int index) {
    currentTablePage = index;
  }

  @observable
  String selectedFilterFirm = 'All';

  @observable
  String selectedFilterPartyType = 'All';

  @action
  void setSelectedFilterPartyType(String value) {
    selectedFilterPartyType = value;
  }

  @action
  void setSelectedFilterFirm(String firm) {
    selectedFilterFirm = firm;
  }

  @action
  void isFiltersApplied() {
    isFilterApplied = searchedText.isNotEmpty ||
        selectedFilterFirm != 'All' ||
        selectedFilterPartyType != 'All' ||
        sortKey != null;
  }

  @computed
  List<Party> get paginatedData {
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
  List<Party> get sortedData {
    List<Party> sorted = [...filteredData];
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
  List<Party> get filteredData {
    List<Party> filtered = partiesList.toList();
    return filtered.where((party) {
      final matchesSearch = searchedText.toLowerCase();
      final searchItem = party.id.toLowerCase().contains(matchesSearch) ||
          party.name.toLowerCase().contains(matchesSearch) ||
          party.mobileNumber.toLowerCase().contains(matchesSearch);
      final matchesFirm =
          selectedFilterFirm == 'All' ? true : party.firm == selectedFilterFirm;
      final matchesPartyType = selectedFilterPartyType == 'All'
          ? true
          : party.partyType == selectedFilterPartyType;
      return searchItem && matchesFirm && matchesPartyType;
    }).toList();
  }

  @action
  void clearAllFilters() {
    searchcontroller.text = '';
    setSelectedFilterFirm('All');
    setSelectedFilterPartyType('All');
    sortKey = null;
    setSearchText('');
    setCurrentPageIndex(0);
    isFilterApplied = false;
  }
}
