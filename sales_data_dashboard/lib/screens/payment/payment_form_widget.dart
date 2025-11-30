import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/app_enum.dart';
import 'package:sales_data_dashboard/models/payment_model.dart';
import 'package:sales_data_dashboard/models/stock_item.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/screens/payment/store/payment_screen_store.dart';
import 'package:sales_data_dashboard/widgets/common_dropdown.dart';

import '../../../models/party_model.dart';
import '../../../widgets/common_textfield.dart';
import '../../../widgets/normal_button.dart';
import '../../../widgets/searchable_textfield.dart';

class PaymentFormWidget extends StatefulWidget {
  const PaymentFormWidget(
      {super.key,
      required this.paymentScreenStore,
      required this.partyList,
      required this.stockItemList,
      this.existingPayment,
      required this.userDataStore});
  final PaymentScreenStore paymentScreenStore;
  final List<Party>? partyList;
  final List<StockItem>? stockItemList;
  final PaymentModel? existingPayment;
  final UserDataStore userDataStore;

  @override
  State<PaymentFormWidget> createState() => _PaymentFormWidgetState();
}

class _PaymentFormWidgetState extends State<PaymentFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController paymentDateController = TextEditingController();
  final TextEditingController partyNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController partyTypeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController itemIDController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController hsnCodeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController paymentTypeController = TextEditingController();
  final TextEditingController paymentNatureController = TextEditingController();

  String paymentStatus = '';
  String paymentOption = '';

  @override
  void initState() {
    super.initState();
    if (widget.existingPayment != null) {
      final payment = widget.existingPayment!;
      partyNameController.text = payment.party.name;
      paymentDateController.text = payment.date.toString().split(' ')[0];
      itemIDController.text = payment.stockDetails.itemId;
      mobileController.text = payment.party.mobileNumber ?? '';
      partyTypeController.text = payment.party.partyType;
      addressController.text = payment.party.address ?? '';
      itemNameController.text =
          '${payment.stockDetails.itemName}-${payment.stockDetails.size}';
      hsnCodeController.text = payment.stockDetails.hsnCode ?? '';
      amountController.text = payment.amount.toString();
      paymentTypeController.text = payment.paymentType.name;
      paymentNatureController.text = payment.paymentNature.name;
    }
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
                        child: GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: paymentDateController.text.isNotEmpty
                                  ? DateTime.tryParse(
                                          paymentDateController.text) ??
                                      DateTime.now()
                                  : DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              paymentDateController.text =
                                  picked.toString().split(' ')[0];
                              setState(() {});
                            }
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: paymentDateController,
                              decoration: InputDecoration(
                                labelText: 'Date',
                                suffixIcon: const Icon(Icons.calendar_today),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.dp),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  SizedBox(height: 12.dp),
                  const Text(
                    'Party Details',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0XFF111827),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.dp),
                  if (widget.partyList != null && widget.partyList!.isNotEmpty)
                    Observer(builder: (context) {
                      return SearchableTextField<String>(
                        label: 'Search by Party ID',
                        options: widget.partyList!.map((e) => e.name).toList(),
                        displayString: (s) => s,
                        onSelect: (val) {
                          final party = widget.partyList!.firstWhere(
                              (element) => element.name == val,
                              orElse: () => Party(
                                    id: '',
                                    name: '',
                                    address: '',
                                    mobileNumber: '',
                                    gstNumber: null,
                                    partyType:
                                        widget.paymentScreenStore.customerType,
                                  ));
                          partyNameController.text = party.name;
                          mobileController.text = party.mobileNumber ?? '';
                          partyTypeController.text = party.partyType;
                          addressController.text = party.address ?? '';

                          widget.paymentScreenStore.setSelectedParty(party);
                          setState(() {});
                        },
                      );
                    })
                  else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'No Party data available. Please add Party first.',
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          label: 'Name',
                          controller: partyNameController,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          enabled: false,
                        ),
                      ),
                      SizedBox(
                        width: 16.dp,
                      ),
                      Expanded(
                        child: CommonTextField(
                          label: 'Mobile Number',
                          controller: mobileController,
                        ),
                      ),
                      SizedBox(
                        width: 16.dp,
                      ),
                      Expanded(
                        child: CommonTextField(
                          label: 'Party Type',
                          enabled: false,
                          controller: partyTypeController,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Party Type is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  CommonTextField(
                    label: 'Address',
                    maxLines: 2,
                    controller: addressController,
                  ),
                  SizedBox(height: 12.dp),
                  const Text('Item Information',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0XFF111827),
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    height: 12.dp,
                  ),
                  if (widget.stockItemList != null &&
                      widget.stockItemList!.isNotEmpty)
                    Observer(builder: (context) {
                      return SearchableTextField<String>(
                        label: 'Search by Item ID',
                        options: widget.stockItemList
                                ?.map((e) => e.itemId)
                                .toList() ??
                            [],
                        displayString: (s) => s,
                        onSelect: (val) {
                          final item = widget.stockItemList
                              ?.firstWhere((element) => element.itemId == val);
                          itemNameController.text = item?.itemName ?? '';
                          hsnCodeController.text = item?.hsnCode ?? '';
                        },
                      );
                    })
                  else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'No Stock Item data available. Please add Stock Item first.',
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          label: 'Item Name',
                          controller: itemNameController,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Item Name is required';
                            }
                            return null;
                          },
                          enabled: false,
                        ),
                      ),
                      SizedBox(width: 16.dp),
                      Expanded(
                        child: CommonTextField(
                          label: 'HSN Code',
                          controller: hsnCodeController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.dp),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          label: 'Amount',
                          controller: amountController,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Amount is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16.dp),
                      Expanded(
                        child: CommonDropdown(
                          label: 'Payment Type',
                          value: [
                            PaymentTypeEnum.cash.name,
                            PaymentTypeEnum.online.name,
                            PaymentTypeEnum.cheque.name,
                            PaymentTypeEnum.all.name,
                          ].contains(paymentTypeController.text)
                              ? paymentTypeController.text
                              : null,
                          options: [
                            PaymentTypeEnum.cash.name,
                            PaymentTypeEnum.online.name,
                            PaymentTypeEnum.cheque.name,
                            PaymentTypeEnum.all.name,
                          ],
                          onChanged: (p0) {
                            paymentTypeController.text = p0 ?? '';
                          },
                        ),
                      ),
                      SizedBox(width: 12.dp),
                      Expanded(
                        child: CommonDropdown(
                          label: 'Payment Nature',
                          value: ['credit', 'debit']
                                  .contains(paymentNatureController.text)
                              ? paymentNatureController.text
                              : null,
                          options: const [
                            'credit',
                            'debit',
                          ],
                          onChanged: (p0) {
                            paymentNatureController.text = p0 ?? '';
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.dp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IntrinsicWidth(
                        child: NormalButton(
                          text: 'Cancel',
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
                          text: widget.existingPayment != null
                              ? 'Update Payment'
                              : 'Create Payment',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final payment = PaymentModel(
                                id: widget.existingPayment != null
                                    ? widget.existingPayment!.id
                                    : DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                party: Party(
                                  name: partyNameController.text,
                                  address: addressController.text,
                                  mobileNumber: mobileController.text,
                                  partyType: widget.paymentScreenStore
                                          .selectedParty?.value.partyType ??
                                      widget.paymentScreenStore.customerType,
                                  id: '${DateTime.now().millisecondsSinceEpoch}',
                                ),
                                stockDetails: StockItem(
                                  itemId: itemNameController.text,
                                  itemName: itemNameController.text,
                                  hsnCode: hsnCodeController.text,
                                  quantity: widget.paymentScreenStore
                                          .selectedItem?.value.quantity ??
                                      '0',
                                  rate: widget.paymentScreenStore.selectedItem
                                          ?.value.rate ??
                                      0.0,
                                  amount: widget.paymentScreenStore.selectedItem
                                          ?.value.amount ??
                                      0.0,
                                  availableQuantity: widget
                                          .paymentScreenStore
                                          .selectedItem
                                          ?.value
                                          .availableQuantity ??
                                      0.0,
                                  description: widget.paymentScreenStore
                                          .selectedItem?.value.description ??
                                      '',
                                  size: widget.paymentScreenStore.selectedItem
                                          ?.value.size ??
                                      '0',
                                ),
                                amount:
                                    double.tryParse(amountController.text) ??
                                        0.0,
                                date: paymentDateController.text.isNotEmpty
                                    ? DateTime.tryParse(
                                        paymentDateController.text)
                                    : null,
                                paymentType: paymentTypeController.text ==
                                        'cash'
                                    ? PaymentTypeEnum.cash
                                    : paymentTypeController.text == 'online'
                                        ? PaymentTypeEnum.online
                                        : paymentTypeController.text == 'cheque'
                                            ? PaymentTypeEnum.cheque
                                            : PaymentTypeEnum.all,
                                paymentNature:
                                    paymentNatureController.text == 'credit'
                                        ? PaymentNature.credit
                                        : PaymentNature.debit,
                              );

                              if (widget.existingPayment != null) {
                                widget.paymentScreenStore
                                    .updatePayment(payment)
                                    .then((final onValue) {
                                  widget.paymentScreenStore.fetchPayments();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Payment Data ${payment.id} updated')),
                                  );
                                }).onError(
                                  (error, stackTrace) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Something went wrong while updating Payment data: ${widget.paymentScreenStore.errorMessage}')),
                                    );
                                  },
                                );
                              } else {
                                widget.paymentScreenStore
                                    .addPayment(payment)
                                    .then((final onValue) {
                                  widget.userDataStore.setPaymentList([
                                    ...widget.userDataStore.paymentList,
                                    payment
                                  ]);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Payment Data ${payment.id} added')),
                                  );
                                }).onError(
                                  (error, stackTrace) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Something went wrong while creating Payment data: ${widget.paymentScreenStore.errorMessage}')),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
