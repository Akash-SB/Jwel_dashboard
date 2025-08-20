import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/stock_item.dart';
import 'package:sales_data_dashboard/screens/purchase/store/purchase_screen_store.dart';

import '../../../models/firm_model.dart';
import '../../../models/party_model.dart';
import '../../../models/purchase_model.dart';
import '../../../models/sales_model.dart';
import '../../../widgets/common_dropdown.dart';
import '../../../widgets/common_textfield.dart';
import '../../../widgets/custom_radio_button.dart';
import '../../../widgets/normal_button.dart';
import '../../../widgets/searchable_textfield.dart';

class PurchaseFormWidget extends StatefulWidget {
  const PurchaseFormWidget({
    super.key,
    required this.purchaseStore,
    this.existingPurchase,
  });
  final PurchaseScreenStore purchaseStore;
  final Purchase? existingPurchase;

  @override
  State<PurchaseFormWidget> createState() => _PurchaseFormWidgetState();
}

class _PurchaseFormWidgetState extends State<PurchaseFormWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController firmTypeController = TextEditingController();
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

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.existingPurchase != null) {
      final purchase = widget.existingPurchase!;
      nameController.text = purchase.partyDetails.name;
      addressController.text = purchase.partyDetails.address ?? '';
      mobileController.text = purchase.partyDetails.mobileNumber;
      gstController.text = purchase.partyDetails.gstNumber ?? '';
      firmTypeController.text = purchase.partyDetails.firm;
      itemIdController.text = purchase.stockDetails.itemId;
      itemNameController.text = purchase.stockDetails.itemName;
      sizeController.text = purchase.stockDetails.size;
      rateController.text = purchase.stockDetails.rate.toString();
      caratController.text = purchase.stockDetails.carat.toString();
      availableQuantController.text =
          purchase.stockDetails.availableQuantity.toString();
      quantityController.text = purchase.buyQuantity.toString();
      amountController.text = purchase.stockDetails.amount.toString();
      descriptionController.text = purchase.stockDetails.description;
      noteController.text = purchase.description;
      dateController.text =
          "${purchase.createdAt.day.toString().padLeft(2, '0')}-${purchase.createdAt.month.toString().padLeft(2, '0')}-${purchase.createdAt.year}";
      widget.purchaseStore.setSelectedPaymentStatus(purchase.paymentStatus);
      widget.purchaseStore.setSelectedPaymentType(purchase.paymentOption);
    } else {
      dateController.text =
          "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}";
    }
  }

  void setAmount() {
    if (quantityController.text.isNotEmpty && rateController.text.isNotEmpty) {
      final quantity = double.tryParse(quantityController.text) ?? 0.0;
      final rate = double.tryParse(rateController.text) ?? 0.0;
      amountController.text = (quantity * rate).toStringAsFixed(2);
    } else {
      amountController.text = '';
    }
  }

  void _setItemId(final String itemName, final String size) {
    final id = '$itemName-$size';
    itemIdController.text = id;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.dp),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Observer(builder: (context) {
                return Row(
                  children: [
                    Expanded(
                      child: CommonDropdown(
                        label: 'Firm',
                        value: widget.purchaseStore.selectedFirmType,
                        options: [
                          Firm.sahajanand.name,
                          Firm.harikrishnaEnterprise.name
                        ],
                      ),
                    ),
                    SizedBox(width: 16.dp),
                    Expanded(
                      child: TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                          labelText: 'Date',
                          suffixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          // Validate date format: DD-MM-YYYY
                          final dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
                          if (value == null || value.isEmpty) {
                            return 'Please enter a date';
                          }
                          if (!dateRegex.hasMatch(value)) {
                            return 'Date must be in DD-MM-YYYY format';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16.dp),
                    const Expanded(
                      child: SizedBox.shrink(),
                    )
                  ],
                );
              }),
              SizedBox(height: 24.dp),
              const Text(
                'Customer Information',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0XFF111827),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Observer(builder: (context) {
                return Row(
                  children: [
                    IntrinsicWidth(
                      child: CustomRadioButton<String>(
                        title: 'Agent',
                        value: 'agent',
                        groupValue: widget.purchaseStore.selectedPartyType,
                        onChanged: (value) {
                          widget.purchaseStore.setSelectedPartyType(value!);
                          widget.purchaseStore.getPartyIds();
                        },
                      ),
                    ),
                    IntrinsicWidth(
                      child: CustomRadioButton<String>(
                          title: 'Company',
                          value: 'company',
                          groupValue: widget.purchaseStore.selectedPartyType,
                          onChanged: (value) => widget.purchaseStore
                              .setSelectedPartyType(value!)),
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
                  options: widget.purchaseStore.partyIds,
                  displayString: (s) => s,
                  onSelect: (val) {
                    final partyDetails = widget.purchaseStore.getPartyById(val);
                    if (partyDetails != null) {
                      widget.purchaseStore.setselectedParty(partyDetails);
                      nameController.text = partyDetails.name;
                      addressController.text = partyDetails.address ?? '';
                      mobileController.text = partyDetails.mobileNumber;
                      gstController.text = partyDetails.gstNumber ?? '';
                      firmTypeController.text = partyDetails.firm;
                      setAmount();
                    }
                  },
                );
              }),
              Observer(builder: (context) {
                return Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        label: 'Name',
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
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
                );
              }),
              Row(
                children: [
                  Expanded(
                    child: CommonTextField(
                      label: 'Mobile Number',
                      controller: mobileController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a mobile number';
                        }
                        final numValue = int.tryParse(value);
                        if (numValue == null) {
                          return 'Number must be a digits';
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.dp),
                  Expanded(
                    child: CommonTextField(
                      label: 'GST Number (Optional)',
                      controller: gstController,
                    ),
                  ),
                  SizedBox(
                    width: 16.dp,
                  ),
                  Expanded(
                    child: CommonTextField(
                        label: 'Firm Type',
                        controller: firmTypeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a firm type';
                          }
                          return null;
                        }),
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
              if (widget.existingPurchase == null)
                Observer(builder: (context) {
                  return Row(
                    children: [
                      IntrinsicWidth(
                        child: CustomRadioButton<String>(
                            title: 'Existing Item',
                            value: 'existing',
                            groupValue: widget.purchaseStore.itemSelectionType,
                            onChanged: (value) {
                              widget.purchaseStore.setItemSelectionType(value!);
                              if (value == 'existing') {
                                itemIdController.clear();
                                nameController.clear();
                                itemNameController.clear();
                                sizeController.clear();
                                rateController.clear();
                                caratController.clear();
                                quantityController.clear();
                                amountController.clear();
                                descriptionController.clear();
                              }
                            }),
                      ),
                      IntrinsicWidth(
                        child: CustomRadioButton<String>(
                            title: 'New Item',
                            value: 'newItem',
                            groupValue: widget.purchaseStore.itemSelectionType,
                            onChanged: (final value) {
                              widget.purchaseStore.setItemSelectionType(value!);
                              if (value == 'newItem') {
                                itemIdController.clear();
                                nameController.clear();
                                itemNameController.clear();
                                sizeController.clear();
                                rateController.clear();
                                caratController.clear();
                                quantityController.clear();
                                amountController.clear();
                                descriptionController.clear();
                              }
                            }),
                      ),
                    ],
                  );
                }),
              SizedBox(height: 12.dp),
              Observer(
                builder: (context) {
                  if (widget.purchaseStore.itemSelectionType.toLowerCase() ==
                      'existing') {
                    return _existingItem();
                  } else {
                    return _addNewItem();
                  }
                },
              ),
              SizedBox(height: 24.dp),
              const Text('Other Information',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0XFF111827),
                    fontWeight: FontWeight.w600,
                  )),
              Observer(builder: (context) {
                return Row(
                  children: [
                    Expanded(
                      child: CommonDropdown(
                        label: 'Payment Status',
                        value: widget.purchaseStore.selectedPaymentStatus,
                        options: [
                          PaymentStatus.paid.name,
                          PaymentStatus.unpaid.name
                        ],
                        onChanged: (value) => widget.purchaseStore
                            .setSelectedPaymentStatus(value),
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
                        onChanged: (value) =>
                            widget.purchaseStore.setSelectedPaymentType(value),
                      ),
                    ),
                    SizedBox(width: 16.dp),
                    const Expanded(child: SizedBox.shrink())
                  ],
                );
              }),
              CommonTextField(
                  label: 'Note (Optional)',
                  controller: noteController,
                  maxLines: 3),
              SizedBox(height: 24.dp),
              Observer(builder: (context) {
                return Row(
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
                        text: widget.existingPurchase != null
                            ? 'Update Purchase'
                            : 'Create Purchase',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.purchaseStore.setShowLoader(true);
                            if (widget.existingPurchase == null) {
                              final partyDetails =
                                  widget.purchaseStore.selectedParty;
                              StockItem selectedItem;
                              if (widget.purchaseStore.itemSelectionType ==
                                  'existing') {
                                selectedItem =
                                    widget.purchaseStore.selectedStockItem!;
                                final updatedItem = StockItem(
                                  amount:
                                      double.tryParse(amountController.text) ??
                                          0.0,
                                  description: descriptionController.text,
                                  firm: firmTypeController.text,
                                  itemId: selectedItem.itemId,
                                  itemName: itemNameController.text,
                                  size: sizeController.text,
                                  rate: double.tryParse(rateController.text) ??
                                      0.0,
                                  carat:
                                      double.tryParse(caratController.text) ??
                                          0.0,
                                  availableQuantity:
                                      selectedItem.availableQuantity +
                                          (double.tryParse(
                                                  quantityController.text) ??
                                              0.0),
                                  hsnCode: hsnController.text,
                                );
                                widget.purchaseStore
                                    .updateStockItem(updatedItem);
                              } else {
                                selectedItem = StockItem(
                                  itemId: itemIdController.text,
                                  itemName: itemNameController.text,
                                  size: sizeController.text,
                                  rate: double.tryParse(rateController.text) ??
                                      0.0,
                                  carat:
                                      double.tryParse(caratController.text) ??
                                          0.0,
                                  availableQuantity: double.tryParse(
                                          quantityController.text) ??
                                      0.0,
                                  hsnCode: hsnController.text,
                                  amount:
                                      double.tryParse(amountController.text) ??
                                          0.0,
                                  description: descriptionController.text,
                                  firm: firmTypeController.text,
                                );
                                widget.purchaseStore.addStockItem(
                                  selectedItem,
                                );
                              }
                              final purchase = Purchase(
                                createdAt: DateTime.parse(
                                  '${dateController.text.split('-')[2]}-${dateController.text.split('-')[1].padLeft(2, '0')}-${dateController.text.split('-')[0].padLeft(2, '0')}',
                                ),
                                firm: widget.purchaseStore.selectedFirmType,
                                description: descriptionController.text,
                                id: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                partyDetails: partyDetails!,
                                stockDetails: selectedItem,
                                paymentStatus:
                                    widget.purchaseStore.selectedPaymentStatus,
                                paymentOption:
                                    widget.purchaseStore.selectedPaymentType,
                                buyQuantity:
                                    double.tryParse(quantityController.text) ??
                                        0,
                              );
                              widget.purchaseStore.addPurchase(purchase);
                              Navigator.pop(context);
                              widget.purchaseStore.setShowLoader(false);
                            } else {
                              Party? partyDetails;
                              if (widget.purchaseStore.selectedParty != null) {
                                partyDetails =
                                    widget.purchaseStore.selectedParty;
                              } else {
                                partyDetails =
                                    widget.existingPurchase?.partyDetails;
                              }
                              final selectedItem = StockItem(
                                itemId: itemIdController.text,
                                itemName: itemNameController.text,
                                size: sizeController.text,
                                rate:
                                    double.tryParse(rateController.text) ?? 0.0,
                                carat: double.tryParse(caratController.text) ??
                                    0.0,
                                availableQuantity:
                                    double.tryParse(quantityController.text) ??
                                        0.0,
                                hsnCode: hsnController.text,
                                amount:
                                    double.tryParse(amountController.text) ??
                                        0.0,
                                description: descriptionController.text,
                                firm: firmTypeController.text,
                              );
                              final purchase = Purchase(
                                createdAt: DateTime.parse(
                                  '${dateController.text.split('-')[2]}-${dateController.text.split('-')[1].padLeft(2, '0')}-${dateController.text.split('-')[0].padLeft(2, '0')}',
                                ),
                                firm: widget.purchaseStore.selectedFirmType,
                                description: descriptionController.text,
                                id: widget.existingPurchase?.id ?? '',
                                partyDetails: partyDetails!,
                                stockDetails: selectedItem,
                                paymentStatus:
                                    widget.purchaseStore.selectedPaymentStatus,
                                paymentOption:
                                    widget.purchaseStore.selectedPaymentType,
                                buyQuantity:
                                    double.tryParse(quantityController.text) ??
                                        0,
                              );
                              widget.purchaseStore.updatePurchase(purchase);
                              Navigator.pop(context);
                              widget.purchaseStore.setShowLoader(false);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _existingItem() {
    return Observer(builder: (context) {
      return Column(
        children: [
          SearchableTextField<String>(
            label: 'Search by Item ID',
            options: widget.purchaseStore.getStockListNames(),
            isEnable: widget.existingPurchase == null,
            displayString: (s) => s,
            onSelect: (val) {
              final stockItem = widget.purchaseStore.getStockItemById(val);
              if (stockItem != null) {
                widget.purchaseStore.setSelectedStockItem(stockItem);
                itemIdController.text = stockItem.itemId;
                itemNameController.text = stockItem.itemName;
                sizeController.text = stockItem.size;
                rateController.text = stockItem.rate.toString();
                caratController.text = stockItem.carat.toString();
                availableQuantController.text =
                    stockItem.availableQuantity.toString();
                quantityController.clear();
                amountController.clear();
                descriptionController.clear();
              }
            },
          ),
          Row(
            children: [
              Expanded(
                child: CommonTextField(
                  label: 'Item Id',
                  enabled: false,
                  controller: itemIdController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an item';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 16.dp,
              ),
              Expanded(
                child: CommonTextField(
                  label: 'Item Name',
                  controller: itemNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an item name';
                    }
                    return null;
                  },
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
                  onChanged: (p0) => setAmount(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a rate';
                    }
                    final numValue = double.tryParse(value);
                    if (numValue == null) {
                      return 'Rate must be a number';
                    }
                    return null;
                  },
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
          Observer(builder: (context) {
            return Row(
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
                    onChanged: (p0) => setAmount(),
                    enabled: widget.existingPurchase == null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a quantity';
                      }
                      final numValue = double.tryParse(value);
                      if (numValue == null) {
                        return 'Quantity must be a number';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 16.dp),
                Expanded(
                  child: CommonTextField(
                    label: 'Amount',
                    controller: amountController,
                    validator: (value) {
                      if ((rateController.text.isEmpty ||
                          quantityController.text.isEmpty)) {
                        return 'Please enter both rate and quantity';
                      }
                      final numValue = double.tryParse(value ?? '');
                      if (numValue == null) {
                        return 'Amount must be a number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            );
          }),
        ],
      );
    });
  }

  Widget _addNewItem() {
    return Observer(builder: (context) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CommonTextField(
                  label: 'Item Id',
                  enabled: false,
                  controller: itemIdController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an item';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 16.dp,
              ),
              Expanded(
                child: CommonTextField(
                  label: 'Item Name',
                  controller: itemNameController,
                  onChanged: (p0) {
                    _setItemId(p0, sizeController.text);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an item name';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a size';
                    }
                    return null;
                  },
                  onChanged: (p0) {
                    _setItemId(itemNameController.text, p0);
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a quantity';
                    }
                    return null;
                  },
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
    });
  }
}
