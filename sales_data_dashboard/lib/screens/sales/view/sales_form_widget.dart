import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/firm_model.dart';
import 'package:sales_data_dashboard/models/sales_model.dart';
import 'package:sales_data_dashboard/models/stock_item.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/screens/sales/store/sales_screen_store.dart';

import '../../../models/party_model.dart';
import '../../../widgets/common_dropdown.dart';
import '../../../widgets/common_textfield.dart';
import '../../../widgets/custom_radio_button.dart';
import '../../../widgets/normal_button.dart';
import '../../../widgets/searchable_textfield.dart';
import '../../dashboard/store/activity_store.dart';

class SalesFormWidget extends StatefulWidget {
  const SalesFormWidget(
      {super.key,
      required this.salesScreenStore,
      required this.partyList,
      required this.stockItemList,
      this.existingSale,
      required this.activityStore,
      required this.userDataStore});
  final SalesScreenStore salesScreenStore;
  final List<Party>? partyList;
  final List<StockItem>? stockItemList;
  final Sale? existingSale;
  final DashboardStore activityStore;
  final UserDataStore userDataStore;

  @override
  State<SalesFormWidget> createState() => _SalesFormWidgetState();
}

class _SalesFormWidgetState extends State<SalesFormWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController salesDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController partyTypeController = TextEditingController();
  final TextEditingController hsnCodeController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController caratController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController dueDaysController = TextEditingController();
  final TextEditingController agentNameController = TextEditingController();
  final TextEditingController agentAddressController = TextEditingController();
  final TextEditingController agentMobileController = TextEditingController();
  final TextEditingController agentGstController = TextEditingController();
  final TextEditingController agentBrokerageController =
      TextEditingController();
  List<PartialPaymentDetails> partialPaymentDetails = [];
  final TextEditingController partialPaymentAmountController =
      TextEditingController();
  final TextEditingController partialPaymentDateController =
      TextEditingController();

  void addPartialPaymentDetail() {
    if (partialPaymentAmountController.text.isNotEmpty &&
        partialPaymentDateController.text.isNotEmpty) {
      partialPaymentDetails.add(PartialPaymentDetails(
        amountPaid: double.tryParse(partialPaymentAmountController.text) ?? 0.0,
        paymentDate: DateTime.tryParse(partialPaymentDateController.text) ??
            DateTime.now(),
      ));
      partialPaymentAmountController.clear();
      partialPaymentDateController.clear();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.existingSale != null) {
      final sale = widget.existingSale!;
      nameController.text = sale.partyDetails.name;
      salesDateController.text = sale.createdAt.toString().split(' ')[0];
      addressController.text = sale.partyDetails.address ?? '';
      mobileController.text = sale.partyDetails.mobileNumber ?? '';
      gstController.text = sale.partyDetails.gstNumber ?? '';
      partyTypeController.text = sale.partyDetails.partyType;
      itemNameController.text = sale.stockDetails.itemName;
      hsnCodeController.text = sale.stockDetails.hsnCode ?? '';
      itemNameController.text = sale.stockDetails.itemId;
      sizeController.text = sale.stockDetails.quantity;
      rateController.text = sale.stockDetails.rate.toString();
      quantityController.text = sale.stockDetails.amount.toString();
      amountController.text = sale.stockDetails.amount.toString();
      descriptionController.text = sale.description ?? '';
      dueDaysController.text = sale.dueDays.toString();
      noteController.text = sale.description ?? '';
      agentNameController.text = sale.agentDetails?.name ?? '';
      agentAddressController.text = sale.agentDetails?.address ?? '';
      agentMobileController.text = sale.agentDetails?.mobileNumber ?? '';
      agentGstController.text = sale.agentDetails?.gstNumber ?? '';
      partialPaymentDetails = sale.partialPaymentDetails ?? [];
      if (sale.agentDetails != null) {
        widget.salesScreenStore.setAgentDetails(sale.agentDetails!);
        widget.salesScreenStore.setIsAgentSelected(true);
      } else {
        widget.salesScreenStore.setIsAgentSelected(false);
      }
    }
  }

  void setAmount() {
    if (quantityController.text.isNotEmpty && rateController.text.isNotEmpty) {
      final quantity = double.tryParse(quantityController.text) ?? 0.0;
      final rate = double.tryParse(rateController.text) ?? 0.0;
      amountController.text = (quantity * rate).toStringAsFixed(2);
    }
  }

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
                      child: GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: salesDateController.text.isNotEmpty
                                ? DateTime.tryParse(salesDateController.text) ??
                                    DateTime.now()
                                : DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            salesDateController.text =
                                picked.toString().split(' ')[0];
                            setState(() {});
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: salesDateController,
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
                    Observer(builder: (context) {
                      return Expanded(
                        child: CommonDropdown(
                          label: 'Firm',
                          value: widget.salesScreenStore.selectedFilterFirm,
                          onChanged: (final value) {
                            widget.salesScreenStore
                                .setSelectedFilterFirm(value!);
                          },
                          options: [
                            Firm.sahajanand.name,
                            Firm.harikrishnaEnterprise.name,
                          ],
                        ),
                      );
                    }),
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
                        final party = widget.partyList!
                            .firstWhere((element) => element.name == val,
                                orElse: () => Party(
                                      id: '',
                                      name: '',
                                      address: '',
                                      mobileNumber: '',
                                      gstNumber: null,
                                      partyType:
                                          widget.salesScreenStore.customerType,
                                    ));
                        nameController.text = party.name;
                        addressController.text = party.address ?? '';
                        mobileController.text = party.mobileNumber ?? '';
                        gstController.text = party.gstNumber ?? '';
                        partyTypeController.text = party.partyType;
                        widget.salesScreenStore.setSelectedParty(party);
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
                  ],
                ),
                SizedBox(height: 12.dp),
                const Text(
                  'Agent Information',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0XFF111827),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Observer(builder: (context) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          IntrinsicWidth(
                            child: CustomRadioButton<String>(
                              title: 'Sale from agent',
                              value: 'agent',
                              groupValue: widget.salesScreenStore.customerType,
                              onChanged: (value) {
                                setState(() {
                                  widget.salesScreenStore
                                      .setCustomerType(value!);
                                  widget.salesScreenStore
                                      .setIsAgentSelected(true);
                                  partyTypeController.text = 'Agent';
                                });
                              },
                            ),
                          ),
                          IntrinsicWidth(
                            child: CustomRadioButton<String>(
                              title: 'Sale without agent',
                              value: 'noAgent',
                              groupValue: widget.salesScreenStore.customerType,
                              onChanged: (value) {
                                setState(() {
                                  widget.salesScreenStore
                                      .setCustomerType(value!);
                                  widget.salesScreenStore
                                      .setIsAgentSelected(false);
                                  partyTypeController.text = 'No Agent';
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.dp),
                      if (widget.partyList != null &&
                          widget.partyList!.isNotEmpty &&
                          widget.salesScreenStore.isAgentSelected)
                        Observer(builder: (context) {
                          return SearchableTextField<String>(
                            label: 'Search by Agent ID',
                            options: widget.partyList!
                                .where((party) =>
                                    party.partyType.toLowerCase() == 'agent')
                                .map((e) => e.name)
                                .toList(),
                            displayString: (s) => s,
                            onSelect: (val) {
                              final party = widget.partyList!
                                  .firstWhere((element) => element.name == val,
                                      orElse: () => Party(
                                            id: '',
                                            name: '',
                                            address: '',
                                            mobileNumber: '',
                                            gstNumber: null,
                                            partyType: widget
                                                .salesScreenStore.customerType,
                                          ));
                              agentNameController.text = party.name;
                              agentAddressController.text = party.address ?? '';
                              agentMobileController.text =
                                  party.mobileNumber ?? '';
                              agentGstController.text = party.gstNumber ?? '';
                            },
                          );
                        })
                      else if (widget.salesScreenStore.isAgentSelected)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'No Agent data available. Please add Agent first.',
                            style: TextStyle(color: Colors.red.shade700),
                          ),
                        ),
                    ],
                  );
                }),
                SizedBox(height: 12.dp),
                Observer(builder: (context) {
                  if (!widget.salesScreenStore.isAgentSelected) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              label: 'Name',
                              controller: agentNameController,
                            ),
                          ),
                          SizedBox(
                            width: 16.dp,
                          ),
                          Expanded(
                            child: CommonTextField(
                              label: 'Address',
                              controller: agentAddressController,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CommonTextField(
                                  label: 'Mobile Number',
                                  controller: agentMobileController)),
                          SizedBox(width: 16.dp),
                          Expanded(
                              child: CommonTextField(
                                  label: 'GST Number (Optional)',
                                  controller: agentGstController)),
                          SizedBox(
                            width: 16.dp,
                          ),
                          Expanded(
                            child: CommonTextField(
                              label: 'Agent Brokerage',
                              controller: agentBrokerageController,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
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
                      options:
                          widget.stockItemList?.map((e) => e.itemId).toList() ??
                              [],
                      displayString: (s) => s,
                      onSelect: (val) {
                        final item = widget.stockItemList
                            ?.firstWhere((element) => element.itemId == val);
                        itemNameController.text = item?.itemName ?? '';
                        sizeController.text = item?.quantity ?? '';
                        rateController.text = item?.rate.toString() ?? '';
                        descriptionController.text = item?.description ?? '';
                        hsnCodeController.text = item?.hsnCode ?? '';
                        quantityController.text =
                            item?.availableQuantity.toString() ?? '';
                        setAmount();
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
                            controller: itemNameController)),
                    SizedBox(width: 16.dp),
                    Expanded(
                        child: CommonTextField(
                            label: 'Size', controller: sizeController)),
                    SizedBox(width: 16.dp),
                    Expanded(
                      child: CommonTextField(
                        label: 'Rate',
                        controller: rateController,
                        onChanged: (p0) => setAmount(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        label: 'Carat',
                        controller: caratController,
                      ),
                    ),
                    SizedBox(width: 16.dp),
                    Expanded(
                        child: CommonTextField(
                      label: 'Quantity',
                      controller: quantityController,
                      onChanged: (p0) => setAmount(),
                    )),
                    SizedBox(width: 16.dp),
                    Expanded(
                        child: CommonTextField(
                      label: 'Amount',
                      controller: amountController,
                      onChanged: (p0) => setAmount(),
                    )),
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
                    Expanded(
                        child: CommonTextField(
                            label: 'Due Days', controller: dueDaysController)),
                  ],
                ),
                SizedBox(height: 12.dp),
                if (widget.existingSale != null) ...[
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          label: 'Partial Payment Amount',
                          controller: partialPaymentAmountController,
                        ),
                      ),
                      SizedBox(width: 16.dp),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              partialPaymentDateController.text =
                                  picked.toString().split(' ')[0];
                              setState(() {});
                            }
                          },
                          child: AbsorbPointer(
                            child: CommonTextField(
                              label: 'Partial Payment Date',
                              controller: partialPaymentDateController,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.dp),
                      ElevatedButton(
                        onPressed: addPartialPaymentDetail,
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.dp),
                  if (partialPaymentDetails.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Partial Payment List:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: partialPaymentDetails.length,
                          itemBuilder: (context, index) {
                            final detail = partialPaymentDetails[index];
                            return ListTile(
                              title: Text(
                                  'Amount: ${detail.amountPaid.toStringAsFixed(2)}'),
                              subtitle: Text(
                                  'Date: ${detail.paymentDate.toString().split(' ')[0]}'),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    partialPaymentDetails.removeAt(index);
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                ],
                SizedBox(height: 12.dp),
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
                        text: widget.existingSale != null
                            ? 'Update Sale'
                            : 'Create Sale',
                        onPressed: () {
                          final sale = Sale(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            partyDetails: Party(
                              name: nameController.text,
                              address: addressController.text,
                              mobileNumber: mobileController.text,
                              gstNumber: gstController.text.isEmpty
                                  ? null
                                  : gstController.text,
                              partyType: widget.salesScreenStore.customerType,
                              id: '${DateTime.now().millisecondsSinceEpoch}',
                            ),
                            stockDetails: StockItem(
                              itemId: itemNameController.text,
                              itemName: itemNameController.text,
                              hsnCode: hsnCodeController.text,
                              quantity: sizeController.text,
                              rate: rateController.text.isEmpty
                                  ? 0.0
                                  : double.parse(rateController.text),
                              amount: amountController.text.isEmpty
                                  ? 0.0
                                  : double.parse(amountController.text),
                              availableQuantity: quantityController.text.isEmpty
                                  ? 0.0
                                  : double.parse(quantityController.text),
                              description: descriptionController.text,
                            ),
                            agentDetails: widget
                                    .salesScreenStore.isAgentSelected
                                ? Party(
                                    name: agentNameController.text,
                                    address: agentAddressController.text,
                                    mobileNumber: agentMobileController.text,
                                    gstNumber: agentGstController.text.isEmpty
                                        ? null
                                        : agentGstController.text,
                                    partyType:
                                        widget.salesScreenStore.customerType,
                                    id: '${DateTime.now().millisecondsSinceEpoch}',
                                  )
                                : null,
                            paymentOption: 'cash',
                            dueDays: dueDaysController.text.isEmpty
                                ? 60
                                : int.parse(dueDaysController.text),
                            description: descriptionController.text,
                            createdAt: DateTime.now(),
                            partialPaymentDetails: partialPaymentDetails,
                          );

                          if (widget.existingSale != null) {
                            widget.salesScreenStore
                                .updateSale(sale)
                                .then((final onValue) {
                              widget.userDataStore.setSalesList(
                                  [...widget.userDataStore.salesList, sale]);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Sales Data ${sale.id} updated')),
                              );
                            }).onError(
                              (error, stackTrace) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Something went wrong while updating Sales data: ${widget.salesScreenStore.errorMessage}')),
                                );
                              },
                            );
                          } else {
                            widget.salesScreenStore
                                .addSale(sale)
                                .then((final onValue) {
                              widget.userDataStore.setSalesList(
                                  [...widget.userDataStore.salesList, sale]);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Sales Data ${sale.id} added')),
                              );
                            }).onError(
                              (error, stackTrace) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Something went wrong while creating Sales data: ${widget.salesScreenStore.errorMessage}')),
                                );
                              },
                            );
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
    );
  }
}
