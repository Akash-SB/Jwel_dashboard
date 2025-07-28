import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/firm_model.dart';
import 'package:sales_data_dashboard/models/stock_item.dart';
import 'package:sales_data_dashboard/screens/stock_management/store/stock_mgmt_store.dart';
import 'package:sales_data_dashboard/widgets/common_dropdown.dart';

import '../../../widgets/common_textfield.dart';
import '../../../widgets/normal_button.dart';

class StockFormWidget extends StatefulWidget {
  const StockFormWidget({super.key, required this.stockStore});
  final StockStore stockStore;

  @override
  State<StockFormWidget> createState() => _StockFormWidgetState();
}

class _StockFormWidgetState extends State<StockFormWidget> {
  final TextEditingController itemIdController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController hsnController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController caratController = TextEditingController();
  final TextEditingController quantController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  String selectedFirm = 'Sahajanand';

  void _setItemId(final String itemName, final String size) {
    final id = '$itemName-$size';
    itemIdController.text = id;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: Column(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(24.dp),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        _setItemId(value, sizeController.text);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16.dp,
                  ),
                  Expanded(
                    child: CommonDropdown(
                      label: 'Firm',
                      options: Firm.values.map((e) => e.name).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedFirm = value ?? 'Sahajanand';
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
                      controller: sizeController,
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
                      text: 'Add In Stock',
                      onPressed: () {
                        final stock = StockItem(
                          itemId: itemIdController.text,
                          itemName: itemNameController.text,
                          hsnCode: hsnController.text,
                          size: sizeController.text,
                          rate: double.tryParse(rateController.text) ?? 0.0,
                          carat: double.tryParse(caratController.text) ?? 0.0,
                          availableQuantity:
                              double.tryParse(quantController.text) ?? 0.0,
                          amount: double.tryParse(amountController.text) ?? 0.0,
                          description: descController.text,
                          firm: selectedFirm,
                        );
                        widget.stockStore.addStockItem(stock).then((_) {
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
