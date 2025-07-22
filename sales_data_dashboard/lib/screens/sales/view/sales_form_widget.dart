// sale_form.dart
import 'package:flutter/material.dart';

import '../../../widgets/common_dropdown.dart';
import '../../../widgets/common_textfield.dart';
import '../../../widgets/searchable_textfield.dart';

class SalesFormWidget extends StatefulWidget {
  const SalesFormWidget({super.key});

  @override
  State<SalesFormWidget> createState() => _SalesFormWidgetState();
}

class _SalesFormWidgetState extends State<SalesFormWidget> {
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

  String partySelection = 'agent';
  String itemSelection = 'existing';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: CommonTextField(
                    label: 'ID',
                    initialValue: 'AUTO-12345',
                    enabled: false,
                  ),
                ),
                const SizedBox(width: 16),
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
              ],
            ),
            const SizedBox(height: 24),
            const Text('Customer Information',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Agent'),
                    value: 'agent',
                    groupValue: partySelection,
                    onChanged: (value) =>
                        setState(() => partySelection = value!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Company'),
                    value: 'company',
                    groupValue: partySelection,
                    onChanged: (value) =>
                        setState(() => partySelection = value!),
                  ),
                ),
              ],
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
            CommonTextField(label: 'Name', controller: nameController),
            CommonTextField(label: 'Address', controller: addressController),
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
              ],
            ),
            CommonTextField(
                label: 'Party Type', controller: partyTypeController),
            const SizedBox(height: 24),
            const Text('Item Information',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Existing Item'),
                    value: 'existing',
                    groupValue: itemSelection,
                    onChanged: (value) =>
                        setState(() => itemSelection = value!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('New Item'),
                    value: 'new',
                    groupValue: itemSelection,
                    onChanged: (value) =>
                        setState(() => itemSelection = value!),
                  ),
                ),
              ],
            ),
            if (itemSelection == 'existing')
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
                        label: 'Item Name', controller: itemNameController)),
                const SizedBox(width: 16),
                Expanded(
                    child: CommonTextField(
                        label: 'Size', controller: sizeController)),
                const SizedBox(width: 16),
                Expanded(
                    child: CommonTextField(
                        label: 'Rate', controller: rateController)),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: CommonTextField(
                        label: 'Carat', controller: caratController)),
                const SizedBox(width: 16),
                Expanded(
                    child: CommonTextField(
                        label: 'Quantity', controller: quantityController)),
                const SizedBox(width: 16),
                Expanded(
                    child: CommonTextField(
                        label: 'Amount', controller: amountController)),
              ],
            ),
            CommonTextField(
                label: 'Description',
                controller: descriptionController,
                maxLines: 3),
            const SizedBox(height: 24),
            const Text('Other Information',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Row(
              children: [
                Expanded(child: CommonDropdown(label: 'Payment Status')),
                SizedBox(width: 16),
                Expanded(child: CommonDropdown(label: 'Payment Type')),
                SizedBox(width: 16),
                Expanded(child: CommonDropdown(label: 'Transaction Type')),
              ],
            ),
            CommonTextField(
                label: 'Note (Optional)',
                controller: noteController,
                maxLines: 3),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Create Sale'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
