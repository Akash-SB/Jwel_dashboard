import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/firm_model.dart';
import 'package:sales_data_dashboard/models/sales_model.dart';
import 'package:sales_data_dashboard/screens/sales/store/sales_screen_store.dart';

import '../../../widgets/common_dropdown.dart';
import '../../../widgets/common_textfield.dart';
import '../../../widgets/custom_radio_button.dart';
import '../../../widgets/normal_button.dart';
import '../../../widgets/searchable_textfield.dart';

class SalesFormWidget extends StatefulWidget {
  const SalesFormWidget({super.key, required this.salesScreenStore});
  final SalesScreenStore salesScreenStore;

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
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
                    Observer(builder: (context) {
                      return Expanded(
                        child: CommonDropdown(
                          label: 'Firm',
                          value: widget.salesScreenStore.selectedFirmType,
                          onChanged: (final value) {
                            widget.salesScreenStore.setSelectedFirmType(value!);
                          },
                          options: [
                            Firm.firmTypeToString(Firm.sahajanand),
                            Firm.firmTypeToString(Firm.harikrishnaEnterprise),
                          ],
                        ),
                      );
                    }),
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
                SizedBox(
                  height: 12.dp,
                ),
                Observer(builder: (context) {
                  return Row(
                    children: [
                      IntrinsicWidth(
                        child: CustomRadioButton<String>(
                          title: 'Agent',
                          value: 'agent',
                          groupValue: widget.salesScreenStore.customerType,
                          onChanged: (value) {
                            setState(() {
                              widget.salesScreenStore.setCustomerType(value!);
                              partyTypeController.text = 'Agent';
                            });
                          },
                        ),
                      ),
                      IntrinsicWidth(
                        child: CustomRadioButton<String>(
                          title: 'Company',
                          value: 'company',
                          groupValue: widget.salesScreenStore.customerType,
                          onChanged: (value) {
                            setState(() {
                              widget.salesScreenStore.setCustomerType(value!);
                              partyTypeController.text = 'company';
                            });
                          },
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(
                  height: 12.dp,
                ),
                Observer(builder: (context) {
                  return SearchableTextField<String>(
                    label: 'Search by Party ID',
                    options: widget.salesScreenStore.getListOfPartyNames(),
                    displayString: (s) => s,
                    onSelect: (val) {
                      final party =
                          widget.salesScreenStore.getSelectedParty(val);
                      if (party != null) {
                        widget.salesScreenStore.setSelectedParty(party);
                        setState(() {
                          nameController.text = party.name;
                          addressController.text = party.address;
                          mobileController.text = party.mobileNumber;
                          gstController.text = party.gstNumber ?? '';
                        });
                      }
                    },
                  );
                }),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        label: 'Name',
                        controller: nameController,
                      ),
                    ),
                    SizedBox(
                      width: 16.dp,
                    ),
                    Expanded(
                      child: CommonTextField(
                        label: 'Address',
                        controller: addressController,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: CommonTextField(
                            label: 'Mobile Number',
                            controller: mobileController)),
                    SizedBox(width: 16.dp),
                    Expanded(
                        child: CommonTextField(
                            label: 'GST Number (Optional)',
                            controller: gstController)),
                    SizedBox(
                      width: 16.dp,
                    ),
                    Expanded(
                      child: CommonTextField(
                        enabled: false,
                        label: 'Party Type',
                        controller: partyTypeController,
                      ),
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
                            label: 'Item Name',
                            controller: itemNameController)),
                    SizedBox(width: 16.dp),
                    Expanded(
                        child: CommonTextField(
                            label: 'Size', controller: sizeController)),
                    SizedBox(width: 16.dp),
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
                    SizedBox(width: 16.dp),
                    Expanded(
                        child: CommonTextField(
                            label: 'Quantity', controller: quantityController)),
                    SizedBox(width: 16.dp),
                    Expanded(
                        child: CommonTextField(
                            label: 'Amount', controller: amountController)),
                  ],
                ),
                CommonTextField(
                    label: 'Description',
                    controller: descriptionController,
                    maxLines: 3),
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
                        text: 'Create Sale',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
