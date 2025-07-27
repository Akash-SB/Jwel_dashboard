// sale_form.dart
import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

import '../../../models/firm_model.dart';
import '../../../models/sales_model.dart';
import '../../../widgets/common_dropdown.dart';
import '../../../widgets/common_textfield.dart';
import '../../../widgets/custom_radio_button.dart';
import '../../../widgets/normal_button.dart';
import '../../../widgets/searchable_textfield.dart';

class PurchaseFormWidget extends StatefulWidget {
  const PurchaseFormWidget({super.key});

  @override
  State<PurchaseFormWidget> createState() => _PurchaseFormWidgetState();
}

class _PurchaseFormWidgetState extends State<PurchaseFormWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController partyTypeController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController caratController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController itemIdController = TextEditingController();
  final TextEditingController hsnController = TextEditingController();
  final TextEditingController availableQuantController =
      TextEditingController();

  String partySelection = 'agent';
  String itemSelection = 'existing';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.dp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: CommonDropdown(
                    label: 'Firm',
                    options: [
                      Firm.firmTypeToString(Firm.sahajanand),
                      Firm.firmTypeToString(Firm.harikrishnaEnterprise),
                    ],
                  ),
                ),
                SizedBox(width: 16.dp),
                Expanded(
                  child: TextFormField(
                    initialValue: DateTime.now().toString().split(' ')[0],
                    decoration: InputDecoration(
                      labelText: 'Date',
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.dp),
                const Expanded(
                  child: SizedBox.shrink(),
                )
              ],
            ),
            SizedBox(height: 24.dp),
            const Text(
              'Customer Information',
              style: TextStyle(
                fontSize: 18,
                color: Color(0XFF111827),
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                IntrinsicWidth(
                  child: CustomRadioButton<String>(
                    title: 'Agent',
                    value: 'agent',
                    groupValue: partySelection,
                    onChanged: (value) =>
                        setState(() => partySelection = value!),
                  ),
                ),
                IntrinsicWidth(
                  child: CustomRadioButton<String>(
                    title: 'Company',
                    value: 'company',
                    groupValue: partySelection,
                    onChanged: (value) =>
                        setState(() => partySelection = value!),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.dp,
            ),
            SearchableTextField<String>(
              label: 'Search by Party ID',
              options: const ['P-1001', 'P-1002', 'P-1003'],
              displayString: (s) => s,
              onSelect: (val) {
                // Simulate autofill
                nameController.text = 'John Doe';
                addressController.text = '123 Main Street';
                mobileController.text = '9876543210';
                gstController.text = '22ABCDE1234FZ1';
                partyTypeController.text = partySelection;
              },
            ),
            Row(
              children: [
                Expanded(
                    child: CommonTextField(
                        label: 'Name', controller: nameController)),
                SizedBox(
                  width: 16.dp,
                ),
                Expanded(
                  child: CommonTextField(
                      label: 'Address', controller: addressController),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: CommonTextField(
                        label: 'Mobile Number', controller: mobileController)),
                const SizedBox(width: 16),
                Expanded(
                    child: CommonTextField(
                        label: 'GST Number (Optional)',
                        controller: gstController)),
                SizedBox(
                  width: 16.dp,
                ),
                Expanded(
                  child: CommonTextField(
                      label: 'Party Type', controller: partyTypeController),
                ),
              ],
            ),
            SizedBox(height: 24.dp),
            const Text('Item Information',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0XFF111827),
                  fontWeight: FontWeight.w600,
                )),
            Row(
              children: [
                IntrinsicWidth(
                  child: CustomRadioButton<String>(
                    title: 'Existing Item',
                    value: 'existing',
                    groupValue: itemSelection,
                    onChanged: (value) =>
                        setState(() => itemSelection = 'existing'),
                  ),
                ),
                IntrinsicWidth(
                  child: CustomRadioButton<String>(
                    title: 'New Item',
                    value: 'new',
                    groupValue: itemSelection,
                    onChanged: (value) => setState(() => itemSelection = 'new'),
                  ),
                ),
              ],
            ),
            if (itemSelection == 'existing') _existingItem() else _addNewItem(),
            SizedBox(height: 24.dp),
            const Text('Other Information',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0XFF111827),
                  fontWeight: FontWeight.w600,
                )),
            Row(
              children: [
                Expanded(
                  child: CommonDropdown(
                    label: 'Payment Status',
                    options: [
                      PaymentStatus.paid.name,
                      PaymentStatus.unpaid.name
                    ],
                  ),
                ),
                SizedBox(width: 16.dp),
                Expanded(
                  child: CommonDropdown(
                    label: 'Payment Type',
                    options: [
                      PaymentOption.bank.name,
                      PaymentOption.cash.name,
                      PaymentOption.cheque.name,
                      PaymentOption.upi.name,
                    ],
                  ),
                ),
                SizedBox(width: 16.dp),
                const Expanded(child: SizedBox.shrink())
              ],
            ),
            CommonTextField(
                label: 'Note (Optional)',
                controller: noteController,
                maxLines: 3),
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
                    text: 'Create Purchase',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _existingItem() {
    return Column(
      children: [
        SearchableTextField<String>(
          label: 'Search by Item ID',
          options: const ['ITEM-01', 'ITEM-02', 'ITEM-03'],
          displayString: (s) => s,
          onSelect: (val) {
            itemNameController.text = 'Gold Ring';
            sizeController.text = 'M';
            rateController.text = '5000';
            caratController.text = '22';
            quantityController.text = '2';
            amountController.text = '10000';
            descriptionController.text = '22 Carat Gold Ring';
          },
        ),
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
                controller: nameController,
              ),
            ),
            SizedBox(width: 16.dp),
            Expanded(
              child: CommonTextField(
                label: 'HSN Code',
                controller: hsnController,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CommonTextField(
                label: 'Size',
                controller: sizeController,
              ),
            ),
            SizedBox(
              width: 16.dp,
            ),
            Expanded(
              child: CommonTextField(
                label: 'Rate',
                controller: rateController,
              ),
            ),
            SizedBox(width: 16.dp),
            Expanded(
              child: CommonTextField(
                label: 'Carat',
                controller: caratController,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CommonTextField(
                label: 'Available Quantity',
                enabled: false,
                controller: availableQuantController,
              ),
            ),
            SizedBox(
              width: 16.dp,
            ),
            Expanded(
              child: CommonTextField(
                label: 'Buy Quantity',
                controller: quantityController,
              ),
            ),
            SizedBox(width: 16.dp),
            Expanded(
              child: CommonTextField(
                label: 'Amount',
                controller: amountController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _addNewItem() {
    return Column(
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
                controller: nameController,
              ),
            ),
            SizedBox(width: 16.dp),
            Expanded(
              child: CommonTextField(
                label: 'HSN Code',
                controller: hsnController,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CommonTextField(
                label: 'Size',
                controller: sizeController,
              ),
            ),
            SizedBox(
              width: 16.dp,
            ),
            Expanded(
              child: CommonTextField(
                label: 'Item Rate',
                controller: rateController,
              ),
            ),
            SizedBox(width: 16.dp),
            Expanded(
              child: CommonTextField(
                label: 'Item Carat',
                controller: caratController,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CommonTextField(
                label: 'Quantity',
                controller: quantityController,
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
          maxLines: 3,
          controller: descriptionController,
        ),
      ],
    );
  }
}
