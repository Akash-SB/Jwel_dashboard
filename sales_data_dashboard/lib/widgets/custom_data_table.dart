import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/widgets/custom_image_button.dart';
import 'package:sales_data_dashboard/widgets/custom_searchbar.dart';

import 'custom_dropdown_widget.dart';

class TableColumn {
  final String label;
  final String key;
  final bool isSortable;
  final bool isAction;

  TableColumn({
    required this.label,
    required this.key,
    this.isSortable = false,
    this.isAction = false,
  });
}

class CustomDataTable extends StatefulWidget {
  final List<TableColumn> columns;
  final List<Map<String, dynamic>> data;
  final void Function(Map<String, dynamic>)? onEdit;
  final void Function(Map<String, dynamic>)? onDelete;
  final int rowsPerPage;
  final List<String>? filterOptions;
  final void Function()? onExportPDF;
  final void Function()? onExportExcel;
  final String? clearSearchKey;
  final String? clearSelectedFilter;
  final bool resetPaginationAndSorting;

  const CustomDataTable({
    super.key,
    required this.columns,
    required this.data,
    this.onEdit,
    this.onDelete,
    this.rowsPerPage = 5,
    this.filterOptions,
    this.onExportPDF,
    this.onExportExcel,
    this.clearSearchKey,
    this.clearSelectedFilter,
    this.resetPaginationAndSorting = false,
  });

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  late String searchQuery;
  late String selectedFilter;
  int currentPage = 0;
  int rowsPerPage = 5;
  String? sortKey;
  bool sortAsc = true;

  @override
  void initState() {
    super.initState();
    searchQuery = widget.clearSearchKey ?? '';
    selectedFilter = widget.clearSelectedFilter ?? 'All';
    rowsPerPage = widget.rowsPerPage;
  }

  @override
  void didUpdateWidget(covariant CustomDataTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.resetPaginationAndSorting) {
      setState(() {
        searchQuery = widget.clearSearchKey ?? '';
        selectedFilter = widget.clearSelectedFilter ?? 'All';
        currentPage = 0;
        sortKey = null;
        sortAsc = true;
        rowsPerPage = widget.rowsPerPage;
      });
    }
  }

  List<Map<String, dynamic>> get filteredData {
    List<Map<String, dynamic>> filtered = widget.data;
    if (widget.filterOptions != null && selectedFilter != 'All') {
      filtered =
          filtered.where((item) => item['userType'] == selectedFilter).toList();
    }
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((item) => item.values.any((v) =>
              v.toString().toLowerCase().contains(searchQuery.toLowerCase())))
          .toList();
    }
    return filtered;
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

  void _clearAllFilters() {
    setState(() {
      searchQuery = '';
      selectedFilter = 'All';
      currentPage = 0;
      sortKey = null;
      sortAsc = true;
      rowsPerPage = widget.rowsPerPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (sortedData.length / rowsPerPage).ceil();
    return Column(
      children: [
        // Search & Filters
        Row(
          children: [
            if (widget.filterOptions != null) ...[
              CustomDropdownWidget(
                items: const [
                  'All',
                  'Company',
                  'Broker',
                ],
                iconPath: 'assets/icons/filter_icon.png',
                initialValue: 'User Type',
                tooltip: 'User Type',
                onSelected: (value) {
                  setState(() {
                    rowsPerPage = int.parse(value);
                    currentPage = 0;
                  });
                },
                label: 'Rows per page:',
                buttonSize: Size(150.dp, 40.dp),
                dropdownWidth: 150.dp,
              ),
            ],
            SizedBox(
              width: 8.dp,
            ),
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
            const Spacer(),
            Row(
              children: [
                CustomDropdownWidget(
                  items: const ['5', '10', '15', '20'],
                  iconPath: 'assets/icons/filter_icon.png',
                  tooltip: 'Rows per page',
                  initialValue: 'Row Count',
                  onSelected: (value) {
                    setState(() {
                      rowsPerPage = int.parse(value!);
                      currentPage = 0;
                    });
                  },
                  buttonSize: Size(100.dp, 40.dp),
                  dropdownWidth: 100.dp,
                  label: 'Rows per page:',
                ),
                SizedBox(
                  width: 12.dp,
                ),
                CustomImageButton(
                  imagePath: 'assets/icons/pdf_icon.png',
                  text: 'PDF',
                  borderColor: const Color(0xffE5E7EB),
                  buttonColor: Colors.white,
                  onClicked: widget.onExportPDF,
                ),
                SizedBox(
                  width: 12.dp,
                ),
                CustomImageButton(
                  imagePath: 'assets/icons/excel_icon.png',
                  text: 'Excel',
                  borderColor: const Color(0xffE5E7EB),
                  buttonColor: Colors.white,
                  onClicked: widget.onExportPDF,
                ),
                SizedBox(
                  width: 12.dp,
                ),
                Container(
                  height: 30.dp,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    icon: Image.asset(
                      'assets/icons/cross_icon.png',
                      color: Colors.grey,
                      width: 30.dp,
                      height: 30.dp,
                    ),
                    tooltip: 'Clear All Filters',
                    onPressed: _clearAllFilters,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.dp),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.dp),
            border: Border.all(
              color: const Color(
                0xffE5E7EB,
              ),
            ),
          ),
          child: Expanded(
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  showBottomBorder: false,
                  headingRowColor: WidgetStateProperty.all(
                    const Color(0xffF8FAFC),
                  ),
                  columns: widget.columns.map((col) {
                    return DataColumn(
                      label: InkWell(
                        onTap: col.isSortable ? () => _onSort(col.key) : null,
                        child: Row(
                          children: [
                            Text(col.label),
                            if (col.isSortable && sortKey == col.key)
                              Icon(
                                sortAsc
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                size: 14.dp,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  rows: paginatedData.map((row) {
                    return DataRow(
                      cells: widget.columns.map((col) {
                        if (col.isAction) {
                          return DataCell(Row(
                            children: [
                              IconButton(
                                icon: Image.asset(
                                  'assets/icons/edit_icon.png',
                                ),
                                onPressed: () => widget.onEdit?.call(row),
                              ),
                              IconButton(
                                icon: Image.asset(
                                  'assets/icons/delete_icon.png',
                                ),
                                onPressed: () => widget.onDelete?.call(row),
                              ),
                            ],
                          ));
                        }
                        return DataCell(
                          Text(
                            row[col.key].toString(),
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
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
}
