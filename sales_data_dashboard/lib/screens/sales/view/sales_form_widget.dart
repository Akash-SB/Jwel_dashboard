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
  SalesFormWidget(
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

  @override
  void initState() {
    super.initState();
    if (widget.existingSale != null) {
      final sale = widget.existingSale!;
      nameController.text = sale.partyDetails.name;
      addressController.text = sale.partyDetails.address;
      mobileController.text = sale.partyDetails.mobileNumber;
      gstController.text = sale.partyDetails.gstNumber ?? '';
      partyTypeController.text = sale.partyDetails.partyType;
      itemNameController.text = sale.stockDetails.itemName;
      hsnCodeController.text = sale.stockDetails.hsnCode;
      itemNameController.text = sale.stockDetails.itemId;
      sizeController.text = sale.stockDetails.size;
      rateController.text = sale.stockDetails.rate.toString();
      caratController.text = sale.stockDetails.carat.toString();
      quantityController.text = sale.stockDetails.amount.toString();
      amountController.text = sale.stockDetails.amount.toString();
      descriptionController.text = sale.description ?? '';
      dueDaysController.text = sale.dueDays.toString();
      noteController.text = sale.description ?? '';
      agentNameController.text = sale.agentDetails?.name ?? '';
      agentAddressController.text = sale.agentDetails?.address ?? '';
      agentMobileController.text = sale.agentDetails?.mobileNumber ?? '';
      agentGstController.text = sale.agentDetails?.gstNumber ?? '';
      agentBrokerageController.text = sale.agentDetails?.brokerage ?? '';
      if (sale.agentDetails != null) {
        widget.salesScreenStore.setAgentDetails(sale.agentDetails!);
        widget.salesScreenStore.setIsAgentSelected(true);
      }
      widget.salesScreenStore.setSelectedFilterFirm(sale.firm.name);
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
                SizedBox(height: 24.dp),
                if (widget.partyList != null && widget.partyList!.isNotEmpty)
                  Observer(builder: (context) {
                    return SearchableTextField<String>(
                      label: 'Search by Party ID',
                      options: widget.partyList!
                          .where((party) =>
                              party.firm ==
                                  widget.salesScreenStore.selectedFilterFirm &&
                              party.partyType.toLowerCase() == 'company')
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
                                      partyType:
                                          widget.salesScreenStore.customerType,
                                      firm: widget
                                          .salesScreenStore.selectedFilterFirm,
                                    ));
                        nameController.text = party.name;
                        addressController.text = party.address;
                        mobileController.text = party.mobileNumber;
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
                SizedBox(height: 24.dp),
                const Text('Item Information',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0XFF111827),
                      fontWeight: FontWeight.w600,
                    )),
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
                        sizeController.text = item?.size ?? '';
                        rateController.text = item?.rate.toString() ?? '';
                        caratController.text = item?.carat.toString() ?? '';
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
                            label: 'Carat', controller: caratController)),
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
                                    party.firm ==
                                        widget.salesScreenStore
                                            .selectedFilterFirm &&
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
                                            firm: widget.salesScreenStore
                                                .selectedFilterFirm,
                                          ));
                              agentNameController.text = party.name;
                              agentAddressController.text = party.address;
                              agentMobileController.text = party.mobileNumber;
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
                        text: 'Create Sale',
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
                              firm: widget.salesScreenStore.selectedFilterFirm,
                            ),
                            stockDetails: StockItem(
                              itemId: itemNameController.text,
                              itemName: itemNameController.text,
                              hsnCode: hsnCodeController.text,
                              size: sizeController.text,
                              rate: rateController.text.isEmpty
                                  ? 0.0
                                  : double.parse(rateController.text),
                              carat: caratController.text.isEmpty
                                  ? 0.0
                                  : double.parse(caratController.text),
                              amount: amountController.text.isEmpty
                                  ? 0.0
                                  : double.parse(amountController.text),
                              availableQuantity: quantityController.text.isEmpty
                                  ? 0.0
                                  : double.parse(quantityController.text),
                              description: descriptionController.text,
                              firm: widget.salesScreenStore.selectedFilterFirm,
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
                                    brokerage:
                                        agentBrokerageController.text.isEmpty
                                            ? null
                                            : agentBrokerageController.text,
                                    partyType:
                                        widget.salesScreenStore.customerType,
                                    id: '${DateTime.now().millisecondsSinceEpoch}',
                                    firm: widget
                                        .salesScreenStore.selectedFilterFirm,
                                  )
                                : null,
                            paymentOption: 'cash',
                            paymentStatus: PaymentStatus.unpaid.name,
                            dueDays: dueDaysController.text.isEmpty
                                ? 60
                                : int.parse(dueDaysController.text),
                            description: descriptionController.text,
                            createdAt: DateTime.now(),
                            firm: widget.salesScreenStore.selectedFilterFirm ==
                                    Firm.sahajanand.name
                                ? Firm.sahajanand
                                : Firm.harikrishnaEnterprise,
                          );

                          widget.salesScreenStore
                              .addSale(sale)
                              .then((final onValue) {
                            widget.userDataStore.setSalesList(
                                [...widget.userDataStore.salesList, sale]);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Sales Data ${sale.id} added')),
                            );
                          }).onError(
                            (error, stackTrace) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Something went wrong while creating Sales data')),
                              );
                            },
                          );
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
