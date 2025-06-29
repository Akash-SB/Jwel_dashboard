import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.dp),
      child: const TransactionsTable(),
    );
  }
}

class UserDataSourse extends DataTableSource {
  final List<UserDataModel> _allUserData;
  List<UserDataModel> _filteredData;

  UserDataSourse(this._allUserData) : _filteredData = List.from(_allUserData);

  void sort<T>(
      Comparable<T> Function(UserDataModel txn) getField, bool ascending) {
    _filteredData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _filteredData.length) return null;
    final txn = _filteredData[index];
    return DataRow(cells: [
      DataCell(Text(txn.name)),
      DataCell(Text(txn.mobileNo)),
      DataCell(Text(txn.gstNo)),
      DataCell(Text(txn.daysOfIntrst.toString())),
      DataCell(Text(txn.userType)),
      DataCell(Text(txn.address ?? '-')),
    ]);
  }

  @override
  int get rowCount => _filteredData.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

final List<UserDataModel> _sampleData = [
  UserDataModel(
    name: "Amit Brokerage House",
    mobileNo: "9876543210",
    gstNo: "27ABCDE1234F1Z5",
    address: "Mumbai, Maharashtra",
    daysOfIntrst: 160,
    userType: "broker",
  ),
  UserDataModel(
    name: "Verma Trading Co.",
    mobileNo: "9123456789",
    gstNo: "07FGHIJ5678K2Z6",
    address: "Delhi",
    daysOfIntrst: 90,
    userType: "company",
  ),
  UserDataModel(
    name: "Patel Brokers",
    mobileNo: "9988776655",
    gstNo: "24LMNOP9101Q3Z7",
    address: "Ahmedabad, Gujarat",
    daysOfIntrst: 120,
    userType: "broker",
  ),
  UserDataModel(
    name: "Joshi Industries",
    mobileNo: "9090909090",
    gstNo: "29QRSTU1121R4Z8",
    address: null, // address optional
    daysOfIntrst: 75,
    userType: "company",
  ),
  UserDataModel(
    name: "Mehta Brokerage Services",
    mobileNo: "8800554433",
    gstNo: "32VWXYZ3141S5Z9",
    address: "Bangalore, Karnataka",
    daysOfIntrst: 150,
    userType: "broker",
  ),
];

class UserDataModel {
  final String name;
  final String mobileNo;
  final String gstNo;
  final String? address;
  final double daysOfIntrst;
  final String userType;

  UserDataModel({
    required this.name,
    required this.mobileNo,
    required this.gstNo,
    this.address,
    required this.daysOfIntrst,
    required this.userType,
  });
}

class TransactionsTable extends StatefulWidget {
  const TransactionsTable({super.key});

  @override
  State<TransactionsTable> createState() => _TransactionsTableState();
}

class _TransactionsTableState extends State<TransactionsTable> {
  late UserDataSourse _dataSource;
  final TextEditingController _searchController = TextEditingController();
  String? _selectedType;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _dataSource = UserDataSourse(_sampleData);
  }

  // void _applyFilter() {
  //   _dataSource.filter(_searchController.text, _selectedType);
  // }

  // void _sort<T>(
  //     Comparable<T> Function(Transaction txn) getField, int columnIndex) {
  //   setState(() {
  //     _sortColumnIndex = columnIndex;
  //     _sortAscending = !_sortAscending;
  //   });
  //   _dataSource.sort(getField, _sortAscending);
  // }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Invoices",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              "Create an Invoice",
            ),
          )
        ],
      );
    }

    return Scaffold(
      body: Column(
        children: [
          // Filters and Search
          header(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // DropdownButton<String>(
                //   value: _selectedType,
                //   hint: const Text("All Types"),
                //   items: ['Sells', 'Purchase', 'All'].map((type) {
                //     return DropdownMenuItem(value: type, child: Text(type));
                //   }).toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       _selectedType = value;
                //       // _applyFilter();
                //     });
                //   },
                // ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "Search by name or parameter...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => () {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: PaginatedDataTable(
              header: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Flexible(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Flexible(
                    flex: 2,
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: "Search by name or parameter...",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              16,
                            ),
                          ),
                        ),
                      ),
                      onChanged: (value) => () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  DropdownButton<String>(
                    value: _selectedType,
                    hint: const Text("All Types"),
                    items: ['Broker', 'Company', 'All'].map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value;
                        // _applyFilter();
                      });
                    },
                  ),
                ],
              ),
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              columns: const [
                DataColumn(
                  label: Text('Name'),
                  // onSort: (colIndex, _) =>
                  //     _sort((txn) => txn.parameter, colIndex),
                ),
                DataColumn(
                  label: Text('Mobile Number'),
                  // onSort: (colIndex, _) => _sort((txn) => txn.date, colIndex),
                ),
                DataColumn(
                  label: Text('GST Number'),
                  // numeric: true,
                  // onSort: (colIndex, _) => _sort((txn) => txn.carat, colIndex),
                ),
                DataColumn(
                  label: Text('Days Of Interest'),
                  // numeric: true,
                  // onSort: (colIndex, _) => _sort((txn) => txn.rate, colIndex),
                ),
                DataColumn(
                  label: Text('User Type'),
                  // numeric: true,
                  // onSort: (colIndex, _) => _sort((txn) => txn.amount, colIndex),
                ),
                DataColumn(label: Text('Address')),
              ],
              source: _dataSource,
              rowsPerPage: 5,
              showCheckboxColumn: false,
              showEmptyRows: false,
            ),
          ),
        ],
      ),
    );
  }
}
