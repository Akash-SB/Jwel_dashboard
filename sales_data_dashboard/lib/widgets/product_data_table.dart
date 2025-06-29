import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/widgets/custom_image_button.dart';
import 'package:sales_data_dashboard/widgets/custom_searchbar.dart';

class ProductDataTable extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final void Function(Map<String, dynamic>)? onEdit;
  final void Function(Map<String, dynamic>)? onDelete;
  final void Function()? onAddProduct;
  final int rowsPerPage;

  const ProductDataTable({
    super.key,
    required this.data,
    this.onEdit,
    this.onDelete,
    this.onAddProduct,
    this.rowsPerPage = 5,
  });

  @override
  State<ProductDataTable> createState() => _ProductDataTableState();
}

class _ProductDataTableState extends State<ProductDataTable> {
  String searchQuery = '';
  String selectedStatus = 'All';
  int currentPage = 0;
  late int rowsPerPage;
  String? sortKey;
  bool sortAsc = true;

  @override
  void initState() {
    super.initState();
    rowsPerPage = widget.rowsPerPage;
  }

  void _onSort(String key) {
    setState(() {
      if (sortKey == key) {
        sortAsc = !sortAsc;
      } else {
        sortKey = key;
        sortAsc = true;
      }
    });
  }

  void _clearFilters() {
    setState(() {
      searchQuery = '';
      selectedStatus = 'All';
      currentPage = 0;
      sortKey = null;
      sortAsc = true;
    });
  }

  String _getStockStatus(Map<String, dynamic> product) {
    int qty = int.tryParse(product['availableQty'].toString()) ?? 0;
    int minStock = int.tryParse(product['minimumStock'].toString()) ?? 0;

    if (qty <= 0) return 'Out of Stock';
    if (qty < minStock) return 'Low Stock';
    return 'In Stock';
  }

  List<Map<String, dynamic>> get filteredData {
    return widget.data.where((item) {
      final query = searchQuery.toLowerCase();
      final matchesSearch =
          item['prodName'].toString().toLowerCase().contains(query) ||
              item['description'].toString().toLowerCase().contains(query) ||
              item['amount'].toString().toLowerCase().contains(query) ||
              item['rate'].toString().toLowerCase().contains(query) ||
              item['hsnCode'].toString().toLowerCase().contains(query);

      final status = _getStockStatus(item);
      final matchesStatus = selectedStatus == 'All' || status == selectedStatus;

      return matchesSearch && matchesStatus;
    }).toList();
  }

  List<Map<String, dynamic>> get sortedData {
    List<Map<String, dynamic>> sorted = [...filteredData];
    if (sortKey != null) {
      sorted.sort((a, b) => sortAsc
          ? a[sortKey].toString().compareTo(b[sortKey].toString())
          : b[sortKey].toString().compareTo(a[sortKey].toString()));
    }
    return sorted;
  }

  List<Map<String, dynamic>> get paginatedData {
    final start = currentPage * rowsPerPage;
    final end = (start + rowsPerPage).clamp(0, sortedData.length);
    return sortedData.sublist(start, end);
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (sortedData.length / rowsPerPage).ceil();

    return Column(
      children: [
        // Search, Filter, Add Product
        Row(
          children: [
            SizedBox(
              width: 300.dp,
              height: 40.dp,
              child: CustomSearchBar(
                controller: TextEditingController(text: searchQuery),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    currentPage = 0;
                  });
                },
              ),
            ),
            SizedBox(width: 12.dp),
            DropdownButton<String>(
              value: selectedStatus,
              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                  currentPage = 0;
                });
              },
              items: ['All', 'In Stock', 'Low Stock', 'Out of Stock']
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              hint: const Text('Filter by Status'),
            ),
            const Spacer(),
            CustomImageButton(
              imagePath: 'assets/icons/add_product_icon.png',
              text: 'Add Product',
              onClicked: widget.onAddProduct,
              borderColor: Colors.blue,
              buttonColor: Colors.blue.shade50,
            ),
            SizedBox(width: 12.dp),
            Container(
              height: 30.dp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
              child: IconButton(
                splashColor: Colors.transparent,
                padding: EdgeInsets.zero,
                icon: Icon(Icons.clear, size: 20.dp, color: Colors.grey),
                tooltip: 'Clear All Filters',
                onPressed: _clearFilters,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.dp),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.dp),
            border: Border.all(color: const Color(0xffE5E7EB)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              showBottomBorder: false,
              headingRowColor: WidgetStateProperty.all(
                const Color(0xffF8FAFC),
              ),
              columns: [
                _buildDataColumn('Product Name', 'prodName', true),
                _buildDataColumn('HSN Code', 'hsnCode', false),
                _buildDataColumn('Size', 'size', true),
                _buildDataColumn('Carat', 'carat', true),
                _buildDataColumn('Rate', 'rate', true),
                _buildDataColumn('Amount', 'amount', true),
                _buildDataColumn('Available Qty', 'availableQty', false),
                const DataColumn(label: Text('Status')),
                _buildDataColumn('Description', 'description', false),
                const DataColumn(label: Text('Actions')),
              ],
              rows: paginatedData.map((product) {
                final status = _getStockStatus(product);
                return DataRow(cells: [
                  DataCell(Text(product['prodName'] ?? '')),
                  DataCell(Text(product['hsnCode'] ?? '')),
                  DataCell(Text(product['size'] ?? '')),
                  DataCell(Text(product['carat'] ?? '')),
                  DataCell(Text(product['rate'] ?? '')),
                  DataCell(Text(product['amount'] ?? '')),
                  DataCell(Text(product['availableQty'].toString())),
                  DataCell(Text(status)),
                  DataCell(Text(product['description'] ?? '')),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/icons/edit_icon.png'),
                        onPressed: () => widget.onEdit?.call(product),
                      ),
                      IconButton(
                        icon: Image.asset('assets/icons/delete_icon.png'),
                        onPressed: () => widget.onDelete?.call(product),
                      ),
                    ],
                  )),
                ]);
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed:
                  currentPage > 0 ? () => setState(() => currentPage--) : null,
              icon: const Icon(Icons.chevron_left),
            ),
            Text('Page ${currentPage + 1} of $totalPages'),
            IconButton(
              onPressed: currentPage < totalPages - 1
                  ? () => setState(() => currentPage++)
                  : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ],
    );
  }

  DataColumn _buildDataColumn(String label, String key, bool isSortable) {
    return DataColumn(
      label: InkWell(
        onTap: isSortable ? () => _onSort(key) : null,
        child: Row(
          children: [
            Text(label),
            if (isSortable && sortKey == key)
              Icon(
                sortAsc ? Icons.arrow_upward : Icons.arrow_downward,
                size: 14.dp,
              ),
          ],
        ),
      ),
    );
  }
}
