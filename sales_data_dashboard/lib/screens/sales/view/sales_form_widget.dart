import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/sales_model.dart';
import 'package:sales_data_dashboard/models/stock_item.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/screens/sales/store/sales_screen_store.dart';

import '../../../models/party_model.dart';
import '../../../widgets/common_dropdown.dart';
import '../../../widgets/common_textfield.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController salesDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController partyTypeController = TextEditingController();
  final TextEditingController intrstPerController = TextEditingController();
  final TextEditingController intrstAmountController = TextEditingController();
  final TextEditingController brokPerController = TextEditingController();
  final TextEditingController brokAmountController = TextEditingController();
  final TextEditingController hsnCodeController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemIdController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController availableQuantController =
      TextEditingController();
  final TextEditingController sellQuantController = TextEditingController();
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

  String paymentStatus = '';
  String paymentOption = '';

  void setBrokerageAmount() {
    if (brokPerController.text.isNotEmpty &&
        (amountController.text.isNotEmpty && amountController.text != '0.0')) {
      final brokPer = double.tryParse(brokPerController.text) ?? 0.0;
      final amount = double.tryParse(amountController.text) ?? 0.0;
      brokAmountController.text = ((brokPer / 100) * amount).toStringAsFixed(2);
    } else {
      brokAmountController.text = '0.0';
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.existingSale != null) {
      final stockData = widget.userDataStore.stockList.firstWhere(
          (element) =>
              element.itemId == widget.existingSale!.stockDetails.itemId,
          orElse: () => StockItem(
                itemId: '',
                itemName: '',
                size: '',
              ));

      final sale = widget.existingSale!;
      nameController.text = sale.partyDetails.name;
      salesDateController.text = sale.createdAt.toString().split(' ')[0];
      addressController.text = sale.partyDetails.address ?? '';
      mobileController.text = sale.partyDetails.mobileNumber ?? '';
      partyTypeController.text = sale.partyDetails.partyType;
      itemNameController.text = sale.stockDetails.itemName;
      itemIdController.text = sale.stockDetails.itemId;
      sizeController.text = sale.stockDetails.size;
      rateController.text = sale.stockDetails.rate.toString();
      availableQuantController.text = stockData.availableQuantity.toString();
      amountController.text = sale.stockDetails.amount.toString();
      dueDaysController.text = sale.dueDays.toString();
      noteController.text = sale.description ?? '';
      intrstPerController.text = sale.interestPercent?.toString() ?? '';
      intrstAmountController.text = sale.interestAmount?.toString() ?? '';
      brokPerController.text = sale.brokeragePercent?.toString() ?? '';
      brokAmountController.text = sale.brokerageAmount?.toString() ?? '';
      sellQuantController.text = sale.quantity.toString();
      agentNameController.text = sale.agentDetails?.name ?? '';
      agentAddressController.text = sale.agentDetails?.address ?? '';
      agentMobileController.text = sale.agentDetails?.mobileNumber ?? '';
      agentGstController.text = sale.agentDetails?.gstNumber ?? '';

      if (sale.agentDetails != null) {
        widget.salesScreenStore.setAgentDetails(sale.agentDetails!);
        widget.salesScreenStore.setIsAgentSelected(true);
      } else {
        widget.salesScreenStore.setIsAgentSelected(false);
      }
    }
  }

  void setAmount() {
    if (sellQuantController.text.isNotEmpty && rateController.text.isNotEmpty) {
      final quantity = double.tryParse(sellQuantController.text) ?? 0.0;
      final rate = double.tryParse(rateController.text) ?? 0.0;
      amountController.text = (quantity * rate).toStringAsFixed(2);
      setBrokerageAmount();
    } else {
      amountController.text = '0.0';
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
                              initialDate: salesDateController.text.isNotEmpty
                                  ? DateTime.tryParse(
                                          salesDateController.text) ??
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
                                        widget.salesScreenStore.customerType,
                                  ));
                          nameController.text = party.name;
                          addressController.text = party.address ?? '';
                          mobileController.text = party.mobileNumber ?? '';
                          partyTypeController.text = party.partyType;
                          if (partyTypeController.text.isNotEmpty) {
                            brokPerController.text = '';
                            brokAmountController.text = '';
                            intrstPerController.text = '';
                            intrstAmountController.text = '';
                          }
                          widget.salesScreenStore.setSelectedParty(party);
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
                          controller: nameController,
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
                  Observer(
                    builder: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (partyTypeController.text.isNotEmpty)
                            const Text(
                              'Interest / Brokerage Information',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0XFF111827),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          SizedBox(height: 12.dp),
                          if (partyTypeController.text.isNotEmpty &&
                              partyTypeController.text.toLowerCase() ==
                                  'company')
                            Row(
                              children: [
                                Expanded(
                                  child: CommonTextField(
                                    label: 'Interest Percent',
                                    controller: intrstPerController,
                                  ),
                                ),
                                SizedBox(
                                  width: 16.dp,
                                ),
                                Expanded(
                                  child: CommonTextField(
                                    label: 'Interest Amount',
                                    enabled: false,
                                    controller: intrstAmountController,
                                  ),
                                ),
                                SizedBox(
                                  width: 16.dp,
                                ),
                                const Expanded(child: SizedBox())
                              ],
                            ),
                          if (partyTypeController.text.isNotEmpty &&
                              partyTypeController.text.toLowerCase() == 'agent')
                            Row(
                              children: [
                                Expanded(
                                  child: CommonTextField(
                                    label: 'Brokergae Percent',
                                    onChanged: (p0) => setBrokerageAmount(),
                                    controller: brokPerController,
                                  ),
                                ),
                                SizedBox(
                                  width: 16.dp,
                                ),
                                Expanded(
                                  child: CommonTextField(
                                    label: 'Brokerage Amount',
                                    enabled: false,
                                    controller: brokAmountController,
                                  ),
                                ),
                                SizedBox(
                                  width: 16.dp,
                                ),
                                const Expanded(child: SizedBox())
                              ],
                            ),
                        ],
                      );
                    },
                  ),
                  // SizedBox(height: 24.dp),
                  // const Text(
                  //   'Agent Information',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     color: Color(0XFF111827),
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // Observer(builder: (context) {
                  //   return Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           IntrinsicWidth(
                  //             child: CustomRadioButton<String>(
                  //               title: 'Sale from agent',
                  //               value: 'agent',
                  //               groupValue: widget.salesScreenStore.customerType,
                  //               onChanged: (value) {
                  //                 setState(() {
                  //                   widget.salesScreenStore
                  //                       .setCustomerType(value!);
                  //                   widget.salesScreenStore
                  //                       .setIsAgentSelected(true);
                  //                   partyTypeController.text = 'Agent';
                  //                 });
                  //               },
                  //             ),
                  //           ),
                  //           IntrinsicWidth(
                  //             child: CustomRadioButton<String>(
                  //               title: 'Sale without agent',
                  //               value: 'noAgent',
                  //               groupValue: widget.salesScreenStore.customerType,
                  //               onChanged: (value) {
                  //                 setState(() {
                  //                   widget.salesScreenStore
                  //                       .setCustomerType(value!);
                  //                   widget.salesScreenStore
                  //                       .setIsAgentSelected(false);
                  //                   partyTypeController.text = 'No Agent';
                  //                 });
                  //               },
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(height: 8.dp),
                  //       if (widget.partyList != null &&
                  //           widget.partyList!.isNotEmpty &&
                  //           widget.salesScreenStore.isAgentSelected)
                  //         Observer(builder: (context) {
                  //           return SearchableTextField<String>(
                  //             label: 'Search by Agent ID',
                  //             options: widget.partyList!
                  //                 .where((party) =>
                  //                     party.partyType.toLowerCase() == 'agent')
                  //                 .map((e) => e.name)
                  //                 .toList(),
                  //             displayString: (s) => s,
                  //             onSelect: (val) {
                  //               final party = widget.partyList!
                  //                   .firstWhere((element) => element.name == val,
                  //                       orElse: () => Party(
                  //                             id: '',
                  //                             name: '',
                  //                             address: '',
                  //                             mobileNumber: '',
                  //                             gstNumber: null,
                  //                             partyType: widget
                  //                                 .salesScreenStore.customerType,
                  //                           ));
                  //               agentNameController.text = party.name;
                  //               agentAddressController.text = party.address ?? '';
                  //               agentMobileController.text =
                  //                   party.mobileNumber ?? '';
                  //               agentGstController.text = party.gstNumber ?? '';
                  //             },
                  //           );
                  //         })
                  //       else if (widget.salesScreenStore.isAgentSelected)
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Text(
                  //             'No Agent data available. Please add Agent first.',
                  //             style: TextStyle(color: Colors.red.shade700),
                  //           ),
                  //         ),
                  //     ],
                  //   );
                  // }),
                  // SizedBox(height: 12.dp),
                  // Observer(builder: (context) {
                  //   if (!widget.salesScreenStore.isAgentSelected) {
                  //     return const SizedBox.shrink();
                  //   }
                  //   return Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Expanded(
                  //             child: CommonTextField(
                  //               label: 'Name',
                  //               controller: agentNameController,
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 16.dp,
                  //           ),
                  //           Expanded(
                  //             child: CommonTextField(
                  //               label: 'Address',
                  //               controller: agentAddressController,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         children: [
                  //           Expanded(
                  //               child: CommonTextField(
                  //                   label: 'Mobile Number',
                  //                   controller: agentMobileController)),
                  //           SizedBox(width: 16.dp),
                  //           Expanded(
                  //               child: CommonTextField(
                  //                   label: 'GST Number (Optional)',
                  //                   controller: agentGstController)),
                  //           SizedBox(
                  //             width: 16.dp,
                  //           ),
                  //           Expanded(
                  //             child: CommonTextField(
                  //               label: 'Agent Brokerage',
                  //               controller: agentBrokerageController,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   );
                  // }),
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
                          itemIdController.text = item?.itemId ?? '';
                          itemNameController.text = item?.itemName ?? '';
                          sizeController.text = item?.quantity ?? '';
                          rateController.text = item?.rate.toString() ?? '';
                          hsnCodeController.text = item?.hsnCode ?? '';
                          availableQuantController.text =
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
                          label: 'Size',
                          controller: sizeController,
                          enabled: false,
                        ),
                      ),
                      SizedBox(width: 16.dp),
                      Expanded(
                          child: CommonTextField(
                        label: 'Available Quantity',
                        enabled: false,
                        controller: availableQuantController,
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          label: 'Sell Quantity',
                          controller: sellQuantController,
                          onChanged: (p0) {
                            setAmount();
                            setBrokerageAmount();
                          },
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Sell Quantity is required';
                            }
                            final sellQty = double.tryParse(p0) ?? 0.0;
                            final availableQty = double.tryParse(
                                    availableQuantController.text) ??
                                0.0;
                            if (sellQty > availableQty) {
                              return 'Sell Quantity cannot be more than Available Quantity';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16.dp),
                      Expanded(
                        child: CommonTextField(
                          label: 'Rate',
                          controller: rateController,
                          onChanged: (p0) {
                            setAmount();
                            setBrokerageAmount();
                          },
                        ),
                      ),
                      SizedBox(width: 16.dp),
                      Expanded(
                          child: CommonTextField(
                        label: 'Amount',
                        enabled: false,
                        controller: amountController,
                        onChanged: (p0) {
                          amountController.text = p0;
                          setAmount();
                        },
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
                  SizedBox(height: 8.dp),
                  CommonDropdown(
                    label: 'Due Days',
                    value: ['0', '30', '60', '45', '90', '120']
                            .contains(dueDaysController.text)
                        ? dueDaysController.text
                        : null,
                    options: const ['0', '30', '60', '45', '90', '120'],
                    onChanged: (p0) => dueDaysController.text = p0!,
                  ),
                  SizedBox(height: 8.dp),
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
                            if (_formKey.currentState!.validate()) {
                              final sale = Sale(
                                id: widget.existingSale != null
                                    ? widget.existingSale!.id
                                    : DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                partyDetails: Party(
                                  name: nameController.text,
                                  address: addressController.text,
                                  mobileNumber: mobileController.text,
                                  partyType:
                                      widget.salesScreenStore.customerType,
                                  id: '${DateTime.now().millisecondsSinceEpoch}',
                                ),
                                stockDetails: StockItem(
                                  itemId: itemIdController.text,
                                  itemName: itemNameController.text,
                                  hsnCode: hsnCodeController.text,
                                  quantity: sizeController.text,
                                  rate: rateController.text.isEmpty
                                      ? 0.0
                                      : double.parse(rateController.text),
                                  amount: amountController.text.isEmpty
                                      ? 0.0
                                      : double.parse(amountController.text),
                                  availableQuantity:
                                      availableQuantController.text.isEmpty
                                          ? 0.0
                                          : double.parse(
                                              availableQuantController.text),
                                  description: descriptionController.text,
                                  size: sizeController.text,
                                ),
                                agentDetails: widget
                                        .salesScreenStore.isAgentSelected
                                    ? Party(
                                        name: agentNameController.text,
                                        address: agentAddressController.text,
                                        mobileNumber:
                                            agentMobileController.text,
                                        gstNumber:
                                            agentGstController.text.isEmpty
                                                ? null
                                                : agentGstController.text,
                                        partyType: widget
                                            .salesScreenStore.customerType,
                                        id: '${DateTime.now().millisecondsSinceEpoch}',
                                      )
                                    : null,
                                dueDays: dueDaysController.text.isEmpty
                                    ? 60
                                    : int.parse(dueDaysController.text),
                                description: noteController.text,
                                createdAt: DateTime.now(),
                                quantity:
                                    double.tryParse(sellQuantController.text) ??
                                        0.0,
                              );

                              if (widget.existingSale != null) {
                                widget.salesScreenStore
                                    .updateSale(sale)
                                    .then((final onValue) {
                                  final updatedSalesList =
                                      widget.userDataStore.salesList.map((e) {
                                    if (e.id == sale.id) {
                                      return sale;
                                    }
                                    return e;
                                  }).toList();
                                  widget.userDataStore
                                      .setSalesList(updatedSalesList);
                                  widget.userDataStore.fetchStockList();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Sales Data ${sale.id} updated')),
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
                                  widget.userDataStore.setSalesList([
                                    ...widget.userDataStore.salesList,
                                    sale
                                  ]);
                                  widget.userDataStore.fetchStockList();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Sales Data ${sale.id} added')),
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
