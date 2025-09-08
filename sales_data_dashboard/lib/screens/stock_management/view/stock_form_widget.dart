import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/firm_model.dart';
import 'package:sales_data_dashboard/models/stock_item.dart';
import 'package:sales_data_dashboard/screens/stock_management/store/stock_mgmt_store.dart';
import 'package:sales_data_dashboard/widgets/common_dropdown.dart';

import '../../../widgets/common_textfield.dart';
import '../../../widgets/normal_button.dart';

class StockFormWidget extends StatefulWidget {
  const StockFormWidget({
    super.key,
    this.existingStockItem,
    required this.stockStore,
  });
  final StockStore stockStore;
  final StockItem? existingStockItem;

  @override
  State<StockFormWidget> createState() => _StockFormWidgetState();
}

class _StockFormWidgetState extends State<StockFormWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController itemIdController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController hsnController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController caratController = TextEditingController();
  final TextEditingController quantController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  String selectedFirm = 'Sahajanand Gems';

  void _setItemId(final String itemName, final String size) {
    final id = '$itemName-$size';
    itemIdController.text = id;
  }

  @override
  void initState() {
    super.initState();
    if (widget.existingStockItem != null) {
      final stockItem = widget.existingStockItem;
      itemIdController.text = stockItem?.itemId ?? '';
      itemNameController.text = stockItem?.itemName ?? '';
      hsnController.text = stockItem?.hsnCode ?? '';
      quantityController.text = stockItem?.quantity ?? '';
      rateController.text = stockItem?.rate.toString() ?? '';
      quantController.text = stockItem?.availableQuantity.toString() ?? '';
      amountController.text = stockItem?.amount.toString() ?? '';
      descController.text = stockItem?.description ?? 'NA';
    }
  }

  @override
  void dispose() {
    itemIdController.dispose();
    itemNameController.dispose();
    hsnController.dispose();
    quantityController.dispose();
    rateController.dispose();
    caratController.dispose();
    quantController.dispose();
    amountController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(24.dp),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                            label: 'Item Id',
                            enabled: false,
                            controller: itemIdController,
                          ),
                        ),
                        SizedBox(
                          width: 16.dp,
                        ),
                        Expanded(
                          child: CommonTextField(
                            label: 'Item Name',
                            controller: itemNameController,
                            onChanged: (value) {
                              _setItemId(value, quantityController.text);
                            },
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Required'
                                    : null,
                          ),
                        ),
                        SizedBox(
                          width: 16.dp,
                        ),
                        Expanded(
                          child: CommonDropdown(
                            label: 'Firm',
                            value: selectedFirm,
                            options: Firm.values.map((e) => e.name).toList(),
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Required'
                                    : null,
                            onChanged: (value) {
                              setState(() {
                                selectedFirm = value ?? 'Sahajanand Gems';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                            label: 'HSN Code',
                            controller: hsnController,
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Required'
                                    : null,
                          ),
                        ),
                        SizedBox(
                          width: 16.dp,
                        ),
                        Expanded(
                          child: CommonTextField(
                            label: 'Size',
                            onChanged: (p0) => _setItemId(
                              itemNameController.text,
                              p0,
                            ),
                            controller: quantityController,
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Required'
                                    : null,
                          ),
                        ),
                        SizedBox(
                          width: 16.dp,
                        ),
                        Expanded(
                          child: CommonTextField(
                            label: 'Rate (₹)',
                            controller: rateController,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                            label: 'Quantity',
                            controller: quantController,
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Required'
                                    : null,
                          ),
                        ),
                        SizedBox(
                          width: 16.dp,
                        ),
                        Expanded(
                          child: CommonTextField(
                            label: 'Carat',
                            controller: caratController,
                          ),
                        ),
                        SizedBox(
                          width: 16.dp,
                        ),
                        Expanded(
                          child: CommonTextField(
                            label: 'Amount',
                            controller: amountController,
                          ),
                        ),
                      ],
                    ),
                    CommonTextField(
                      label: 'Description',
                      controller: descController,
                      maxLines: 3,
                    ),
                    SizedBox(height: 24.dp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IntrinsicWidth(
                          child: NormalButton(
                            text: 'Cancle',
                            textColor: const Color(0xFF374151),
                            filledColor: const Color(0xFFF3F4F6),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        SizedBox(
                          width: 16.dp,
                        ),
                        IntrinsicWidth(
                          child: NormalButton(
                            text: widget.existingStockItem != null
                                ? 'Update Stock'
                                : 'Add In Stock',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final stock = StockItem(
                                  itemId: itemIdController.text,
                                  itemName: itemNameController.text,
                                  hsnCode: hsnController.text,
                                  quantity: quantityController.text,
                                  rate: double.tryParse(rateController.text) ??
                                      0.0,
                                  availableQuantity:
                                      double.tryParse(quantController.text) ??
                                          0.0,
                                  amount:
                                      double.tryParse(amountController.text) ??
                                          0.0,
                                  description: descController.text,
                                );
                                if (widget.existingStockItem != null) {
                                  widget.stockStore
                                      .updateStockItem(stock)
                                      .then((_) {
                                    Navigator.pop(context);
                                    widget.stockStore.setErrorMessage('');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Stock data updated successfully')),
                                    );
                                  }).onError(
                                    (error, stackTrace) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Something went wrong while updating Stock data: ${widget.stockStore.errorMessage}')),
                                      );
                                    },
                                  );
                                } else {
                                  widget.stockStore
                                      .addStockItem(stock)
                                      .then((_) {
                                    widget.stockStore.setErrorMessage('');
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Stock data added successfully')),
                                    );
                                  }).onError(
                                    (error, stackTrace) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Something went wrong while adding Stock data: ${widget.stockStore.errorMessage}')),
                                      );
                                    },
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
