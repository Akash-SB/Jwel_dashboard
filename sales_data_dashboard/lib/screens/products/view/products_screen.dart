import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/widgets/custom_searchbar.dart';
import '../../../models/product_model.dart';
import '../../../widgets/custom_image_button.dart';
import '../../../widgets/filter_dropdown_button.dart';
import '../../../widgets/normal_button.dart';
import '../store/product_store.dart';
import 'product_form_widget.dart';

final getIt = GetIt.instance;

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductStore productStore;
  late UserDataStore userDataStore;

  @override
  void initState() {
    super.initState();
    if (!getIt.isRegistered<ProductStore>()) {
      getIt.registerFactory<ProductStore>(() => ProductStore());
    }

    if (!GetIt.I.isRegistered<UserDataStore>()) {
      GetIt.I.registerSingleton<UserDataStore>(UserDataStore());
    }
    userDataStore = GetIt.I<UserDataStore>();
    productStore = getIt<ProductStore>();
    productStore.initializeSearchController();
    if (userDataStore.products.isEmpty) {
      productStore.fetchProducts();
      userDataStore.setProducts(productStore.products);
    } else {
      productStore.setProducts(userDataStore.products);
    }
    productStore.calculateTotalPages();
  }

  @override
  Widget build(BuildContext context) {
    final List<TableColumn> columns = [
      TableColumn(label: 'Product Id', key: 'id', isSortable: true),
      TableColumn(label: 'HSN Code', key: 'hsnCode'),
      TableColumn(label: 'Size', key: 'size', isSortable: true),
      TableColumn(label: 'Rate', key: 'rate', isSortable: true),
      TableColumn(label: 'Amount', key: 'amount', isSortable: true),
      TableColumn(label: 'Description', key: 'description'),
      TableColumn(label: 'Actions', key: 'actions', isAction: true),
    ];
    return Observer(builder: (context) {
      return Container(
        color: const Color.fromARGB(143, 255, 255, 255),
        padding: EdgeInsets.all(24.dp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.dp,
            ),
            Observer(builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'User Management',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(
                        0xFF1F2937,
                      ),
                    ),
                  ),
                  IntrinsicWidth(
                    child: NormalButton(
                      text: 'Add New User',
                      onPressed: () => _openForm(context),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 24.dp),
            Observer(builder: (context) {
              return SizedBox(
                height: 40.dp,
                child: Row(
                  children: [
                    SizedBox(
                      width: 300.dp,
                      child: CustomSearchBar(
                        controller: TextEditingController(),
                        onChanged: (final value) {
                          productStore.setSearchText(value);
                        },
                        hintText: 'Search By Name, SSN Number, GST Number',
                      ),
                    ),
                    const Spacer(),
                    FilterDropdownButton(
                      selectedValue: productStore.selectedRowCount,
                      onChanged: (final value) {
                        productStore.setSelectedRowCount(value ?? '5');
                      },
                      items: const [
                        '5',
                        '10',
                        '15',
                        '20',
                      ],
                    ),
                    SizedBox(
                      width: 12.dp,
                    ),
                    CustomImageButton(
                      imagePath: 'assets/icons/pdf_icon.png',
                      text: 'PDF',
                      borderColor: const Color(0xffE5E7EB),
                      buttonColor: Colors.white,
                      onClicked: () {},
                      // onClicked: widget.onExportPDF,
                    ),
                    SizedBox(
                      width: 12.dp,
                    ),
                    CustomImageButton(
                      imagePath: 'assets/icons/excel_icon.png',
                      text: 'Excel',
                      borderColor: const Color(0xffE5E7EB),
                      buttonColor: Colors.white,
                      onClicked: () {},
                      // onClicked: widget.onExportPDF,
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
                        onPressed: () {},
                        // onPressed: _clearAllFilters,
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(
              height: 24.dp,
            ),
            Observer(builder: (context) {
              return Expanded(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.dp),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 0.5,
                        ),
                      ),
                      child: DataTable(
                        headingRowHeight: 48,
                        dataRowMinHeight: 48,
                        headingRowColor:
                            WidgetStateProperty.all(Colors.grey.shade100),
                        dataRowColor: WidgetStateProperty.resolveWith(
                            (states) => Colors.white),
                        showBottomBorder: false,
                        columns: columns.map((col) {
                          return DataColumn(
                            label: InkWell(
                              onTap: col.isSortable
                                  ? () => productStore.setSortKey(col.key)
                                  : null,
                              child: Row(
                                children: [
                                  Text(col.label),
                                  if (col.isSortable &&
                                      productStore.sortKey == col.key)
                                    Icon(
                                      productStore.sortAsc
                                          ? Icons.arrow_upward
                                          : Icons.arrow_downward,
                                      size: 14.dp,
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        rows: productStore.paginatedData.map((row) {
                          return DataRow(
                            cells: columns.map((col) {
                              if (col.isAction) {
                                return DataCell(Row(
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/icons/edit_icon.png',
                                      ),
                                      onPressed: () => _openForm(context, row),
                                    ),
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/icons/delete_icon.png',
                                      ),
                                      onPressed: () => _onDelete(context, row),
                                    ),
                                  ],
                                ));
                              }
                              return DataCell(
                                InkWell(
                                  onTap: () {
                                    productStore.setSelectedProduct(row);
                                  },
                                  child: Text(
                                    _getCellValue(row, col.key),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            Observer(builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: productStore.currentTablePage > 0
                        ? () => productStore.setCurrentPageIndex(
                            productStore.currentTablePage - 1)
                        : null,
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Text(
                      'Page ${productStore.currentTablePage + 1} of ${productStore.totalPages}'),
                  IconButton(
                    onPressed: productStore.currentTablePage <
                            productStore.totalPages - 1
                        ? () => productStore.setCurrentPageIndex(
                            productStore.currentTablePage + 1)
                        : null,
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              );
            }),
          ],
        ),
      );
    });
  }

  String _getCellValue(ProductModel row, String key) {
    switch (key) {
      case 'id':
        return row.id;
      case 'hsnCode':
        return row.hsnCode;
      case 'size':
        return row.size;
      case 'rate':
        return row.rate;
      case 'amount':
        return row.amount;
      case 'description':
        return row.description ?? '';

      default:
        return '';
    }
  }

  void _openForm(BuildContext context, [ProductModel? product]) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(product == null ? 'Add Product' : 'Edit Product'),
          content: SizedBox(
            width: 400, // Adjust as needed
            child: ProductForm(
              existingProduct: product,
              onSubmit: (productData) {
                if (product?.id != null) {
                  productStore.updateProduct(product!.id!, productData);
                } else {
                  productStore.addProduct(productData);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Product ${productData.prodName} ${product?.id != null ? 'updated' : 'added'}')),
                );
                Navigator.pop(context); // Close dialog
              },
            ),
          ),
        );
      },
    );
  }

  void _onDelete(BuildContext context, ProductModel product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                productStore.deleteProduct(
                  product.id,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

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
