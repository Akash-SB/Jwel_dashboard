import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20.dp),
        child: const TransactionsTable(),
      ),
    );
  }
}

class TransactionDataSource extends DataTableSource {
  final List<Transaction> _allData;
  List<Transaction> _filteredData;

  TransactionDataSource(this._allData) : _filteredData = List.from(_allData);

  void filter(String searchQuery, String? typeFilter) {
    _filteredData = _allData.where((txn) {
      final matchesSearch =
          txn.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              txn.parameter.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesType =
          typeFilter == null || txn.type == typeFilter || typeFilter == 'All';
      return matchesSearch && matchesType;
    }).toList();
    notifyListeners();
  }

  void sort<T>(
      Comparable<T> Function(Transaction txn) getField, bool ascending) {
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
      DataCell(Text(txn.parameter)),
      DataCell(Text(txn.date)),
      DataCell(Text(txn.carat.toStringAsFixed(2))),
      DataCell(Text(txn.rate.toStringAsFixed(2))),
      DataCell(Text(txn.amount.toStringAsFixed(2))),
      DataCell(Container(
        padding: EdgeInsets.symmetric(horizontal: 10.dp, vertical: 6.dp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: txn.type == 'Sells' ? Colors.green[100] : Colors.red[100],
        ),
        child: Text(
          txn.type,
          style:
              TextStyle(color: txn.type == 'Sells' ? Colors.green : Colors.red),
        ),
      )),
      DataCell(Text(txn.userType)),
      DataCell(Text(txn.name)),
    ]);
  }

  @override
  int get rowCount => _filteredData.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

final List<Transaction> _sampleData = [
  Transaction(
    parameter: 'INV842002',
    date: '27th Jul 2021',
    carat: 68.89,
    rate: 1600.00,
    amount: 26500.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Kim Girocking',
  ),
  Transaction(
    parameter: 'INV842004',
    date: '25th Jul 2021',
    carat: 70.5,
    rate: 1550.00,
    amount: 32800.50,
    type: 'Purchase',
    userType: 'Company',
    name: 'Jackson Balabala',
  ),
  Transaction(
    parameter: 'INV842005',
    date: '20th Jul 2021',
    carat: 55.20,
    rate: 1700.00,
    amount: 18900.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Claudia Emmay',
  ),
  Transaction(
    parameter: 'INV842006',
    date: '20th Jul 2021',
    carat: 80.10,
    rate: 1620.00,
    amount: 45300.25,
    type: 'Purchase',
    userType: 'Company',
    name: 'Park Jo Soo',
  ),
  Transaction(
    parameter: 'INV842007',
    date: '18th Jul 2021',
    carat: 65.00,
    rate: 1580.00,
    amount: 22150.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Clarisa Hercules',
  ),
  Transaction(
    parameter: 'INV842002',
    date: '27th Jul 2021',
    carat: 68.89,
    rate: 1600.00,
    amount: 26500.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Kim Girocking',
  ),
  Transaction(
    parameter: 'INV842004',
    date: '25th Jul 2021',
    carat: 70.5,
    rate: 1550.00,
    amount: 32800.50,
    type: 'Purchase',
    userType: 'Company',
    name: 'Jackson Balabala',
  ),
  Transaction(
    parameter: 'INV842005',
    date: '20th Jul 2021',
    carat: 55.20,
    rate: 1700.00,
    amount: 18900.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Claudia Emmay',
  ),
  Transaction(
    parameter: 'INV842006',
    date: '20th Jul 2021',
    carat: 80.10,
    rate: 1620.00,
    amount: 45300.25,
    type: 'Purchase',
    userType: 'Company',
    name: 'Park Jo Soo',
  ),
  Transaction(
    parameter: 'INV842007',
    date: '18th Jul 2021',
    carat: 65.00,
    rate: 1580.00,
    amount: 22150.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Clarisa Hercules',
  ),
  Transaction(
    parameter: 'INV842002',
    date: '27th Jul 2021',
    carat: 68.89,
    rate: 1600.00,
    amount: 26500.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Kim Girocking',
  ),
  Transaction(
    parameter: 'INV842004',
    date: '25th Jul 2021',
    carat: 70.5,
    rate: 1550.00,
    amount: 32800.50,
    type: 'Purchase',
    userType: 'Company',
    name: 'Jackson Balabala',
  ),
  Transaction(
    parameter: 'INV842005',
    date: '20th Jul 2021',
    carat: 55.20,
    rate: 1700.00,
    amount: 18900.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Claudia Emmay',
  ),
  Transaction(
    parameter: 'INV842006',
    date: '20th Jul 2021',
    carat: 80.10,
    rate: 1620.00,
    amount: 45300.25,
    type: 'Purchase',
    userType: 'Company',
    name: 'Park Jo Soo',
  ),
  Transaction(
    parameter: 'INV842007',
    date: '18th Jul 2021',
    carat: 65.00,
    rate: 1580.00,
    amount: 22150.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Clarisa Hercules',
  ),
  Transaction(
    parameter: 'INV842002',
    date: '27th Jul 2021',
    carat: 68.89,
    rate: 1600.00,
    amount: 26500.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Kim Girocking',
  ),
  Transaction(
    parameter: 'INV842004',
    date: '25th Jul 2021',
    carat: 70.5,
    rate: 1550.00,
    amount: 32800.50,
    type: 'Purchase',
    userType: 'Company',
    name: 'Jackson Balabala',
  ),
  Transaction(
    parameter: 'INV842005',
    date: '20th Jul 2021',
    carat: 55.20,
    rate: 1700.00,
    amount: 18900.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Claudia Emmay',
  ),
  Transaction(
    parameter: 'INV842006',
    date: '20th Jul 2021',
    carat: 80.10,
    rate: 1620.00,
    amount: 45300.25,
    type: 'Purchase',
    userType: 'Company',
    name: 'Park Jo Soo',
  ),
  Transaction(
    parameter: 'INV842007',
    date: '18th Jul 2021',
    carat: 65.00,
    rate: 1580.00,
    amount: 22150.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Clarisa Hercules',
  ),
  Transaction(
    parameter: 'INV842002',
    date: '27th Jul 2021',
    carat: 68.89,
    rate: 1600.00,
    amount: 26500.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Kim Girocking',
  ),
  Transaction(
    parameter: 'INV842004',
    date: '25th Jul 2021',
    carat: 70.5,
    rate: 1550.00,
    amount: 32800.50,
    type: 'Purchase',
    userType: 'Company',
    name: 'Jackson Balabala',
  ),
  Transaction(
    parameter: 'INV842005',
    date: '20th Jul 2021',
    carat: 55.20,
    rate: 1700.00,
    amount: 18900.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Claudia Emmay',
  ),
  Transaction(
    parameter: 'INV842006',
    date: '20th Jul 2021',
    carat: 80.10,
    rate: 1620.00,
    amount: 45300.25,
    type: 'Purchase',
    userType: 'Company',
    name: 'Park Jo Soo',
  ),
  Transaction(
    parameter: 'INV842007',
    date: '18th Jul 2021',
    carat: 65.00,
    rate: 1580.00,
    amount: 22150.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Clarisa Hercules',
  ),
  Transaction(
    parameter: 'INV842002',
    date: '27th Jul 2021',
    carat: 68.89,
    rate: 1600.00,
    amount: 26500.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Kim Girocking',
  ),
  Transaction(
    parameter: 'INV842004',
    date: '25th Jul 2021',
    carat: 70.5,
    rate: 1550.00,
    amount: 32800.50,
    type: 'Purchase',
    userType: 'Company',
    name: 'Jackson Balabala',
  ),
  Transaction(
    parameter: 'INV842005',
    date: '20th Jul 2021',
    carat: 55.20,
    rate: 1700.00,
    amount: 18900.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Claudia Emmay',
  ),
  Transaction(
    parameter: 'INV842006',
    date: '20th Jul 2021',
    carat: 80.10,
    rate: 1620.00,
    amount: 45300.25,
    type: 'Purchase',
    userType: 'Company',
    name: 'Park Jo Soo',
  ),
  Transaction(
    parameter: 'INV842007',
    date: '18th Jul 2021',
    carat: 65.00,
    rate: 1580.00,
    amount: 22150.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Clarisa Hercules',
  ),
  Transaction(
    parameter: 'INV842002',
    date: '27th Jul 2021',
    carat: 68.89,
    rate: 1600.00,
    amount: 26500.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Kim Girocking',
  ),
  Transaction(
    parameter: 'INV842004',
    date: '25th Jul 2021',
    carat: 70.5,
    rate: 1550.00,
    amount: 32800.50,
    type: 'Purchase',
    userType: 'Company',
    name: 'Jackson Balabala',
  ),
  Transaction(
    parameter: 'INV842005',
    date: '20th Jul 2021',
    carat: 55.20,
    rate: 1700.00,
    amount: 18900.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Claudia Emmay',
  ),
  Transaction(
    parameter: 'INV842006',
    date: '20th Jul 2021',
    carat: 80.10,
    rate: 1620.00,
    amount: 45300.25,
    type: 'Purchase',
    userType: 'Company',
    name: 'Park Jo Soo',
  ),
  Transaction(
    parameter: 'INV842007',
    date: '18th Jul 2021',
    carat: 65.00,
    rate: 1580.00,
    amount: 22150.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Clarisa Hercules',
  ),
  Transaction(
    parameter: 'INV842002',
    date: '27th Jul 2021',
    carat: 68.89,
    rate: 1600.00,
    amount: 26500.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Kim Girocking',
  ),
  Transaction(
    parameter: 'INV842004',
    date: '25th Jul 2021',
    carat: 70.5,
    rate: 1550.00,
    amount: 32800.50,
    type: 'Purchase',
    userType: 'Company',
    name: 'Jackson Balabala',
  ),
  Transaction(
    parameter: 'INV842005',
    date: '20th Jul 2021',
    carat: 55.20,
    rate: 1700.00,
    amount: 18900.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Claudia Emmay',
  ),
  Transaction(
    parameter: 'INV842006',
    date: '20th Jul 2021',
    carat: 80.10,
    rate: 1620.00,
    amount: 45300.25,
    type: 'Purchase',
    userType: 'Company',
    name: 'Park Jo Soo',
  ),
  Transaction(
    parameter: 'INV842007',
    date: '18th Jul 2021',
    carat: 65.00,
    rate: 1580.00,
    amount: 22150.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Clarisa Hercules',
  ),
  Transaction(
    parameter: 'INV842002',
    date: '27th Jul 2021',
    carat: 68.89,
    rate: 1600.00,
    amount: 26500.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Kim Girocking',
  ),
  Transaction(
    parameter: 'INV842004',
    date: '25th Jul 2021',
    carat: 70.5,
    rate: 1550.00,
    amount: 32800.50,
    type: 'Purchase',
    userType: 'Company',
    name: 'Jackson Balabala',
  ),
  Transaction(
    parameter: 'INV842005',
    date: '20th Jul 2021',
    carat: 55.20,
    rate: 1700.00,
    amount: 18900.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Claudia Emmay',
  ),
  Transaction(
    parameter: 'INV842006',
    date: '20th Jul 2021',
    carat: 80.10,
    rate: 1620.00,
    amount: 45300.25,
    type: 'Purchase',
    userType: 'Company',
    name: 'Park Jo Soo',
  ),
  Transaction(
    parameter: 'INV842007',
    date: '18th Jul 2021',
    carat: 65.00,
    rate: 1580.00,
    amount: 22150.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Clarisa Hercules',
  ),
  Transaction(
    parameter: 'INV842002',
    date: '27th Jul 2021',
    carat: 68.89,
    rate: 1600.00,
    amount: 26500.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Kim Girocking',
  ),
  Transaction(
    parameter: 'INV842004',
    date: '25th Jul 2021',
    carat: 70.5,
    rate: 1550.00,
    amount: 32800.50,
    type: 'Purchase',
    userType: 'Company',
    name: 'Jackson Balabala',
  ),
  Transaction(
    parameter: 'INV842005',
    date: '20th Jul 2021',
    carat: 55.20,
    rate: 1700.00,
    amount: 18900.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Claudia Emmay',
  ),
  Transaction(
    parameter: 'INV842006',
    date: '20th Jul 2021',
    carat: 80.10,
    rate: 1620.00,
    amount: 45300.25,
    type: 'Purchase',
    userType: 'Company',
    name: 'Park Jo Soo',
  ),
  Transaction(
    parameter: 'INV842007',
    date: '18th Jul 2021',
    carat: 65.00,
    rate: 1580.00,
    amount: 22150.00,
    type: 'Sells',
    userType: 'Broker',
    name: 'Clarisa Hercules',
  ),
];

class Transaction {
  final String parameter;
  final String date;
  final double carat;
  final double rate;
  final double amount;
  final String type;
  final String userType;
  final String name;

  Transaction({
    required this.parameter,
    required this.date,
    required this.carat,
    required this.rate,
    required this.amount,
    required this.type,
    required this.userType,
    required this.name,
  });
}

class TransactionsTable extends StatefulWidget {
  const TransactionsTable({super.key});

  @override
  State<TransactionsTable> createState() => _TransactionsTableState();
}

class _TransactionsTableState extends State<TransactionsTable> {
  late TransactionDataSource _dataSource;
  final TextEditingController _searchController = TextEditingController();
  String? _selectedType;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _dataSource = TransactionDataSource(_sampleData);
  }

  void _applyFilter() {
    _dataSource.filter(_searchController.text, _selectedType);
  }

  void _sort<T>(
      Comparable<T> Function(Transaction txn) getField, int columnIndex) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = !_sortAscending;
    });
    _dataSource.sort(getField, _sortAscending);
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Invoices",
            style: TextStyle(
              fontSize: 10.sp,
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
                DropdownButton<String>(
                  value: _selectedType,
                  hint: const Text("All Types"),
                  items: ['Sells', 'Purchase', 'All'].map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value;
                      _applyFilter();
                    });
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "Search by name or parameter...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _applyFilter(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: PaginatedDataTable(
              header: const Text('Transaction Records'),
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              columns: [
                DataColumn(
                  label: const Text('Parameter'),
                  onSort: (colIndex, _) =>
                      _sort((txn) => txn.parameter, colIndex),
                ),
                DataColumn(
                  label: const Text('Date'),
                  onSort: (colIndex, _) => _sort((txn) => txn.date, colIndex),
                ),
                DataColumn(
                  label: const Text('Carat'),
                  numeric: true,
                  onSort: (colIndex, _) => _sort((txn) => txn.carat, colIndex),
                ),
                DataColumn(
                  label: const Text('Rate'),
                  numeric: true,
                  onSort: (colIndex, _) => _sort((txn) => txn.rate, colIndex),
                ),
                DataColumn(
                  label: const Text('Amount'),
                  numeric: true,
                  onSort: (colIndex, _) => _sort((txn) => txn.amount, colIndex),
                ),
                const DataColumn(label: Text('Type')),
                const DataColumn(label: Text('User')),
                const DataColumn(label: Text('Name')),
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
