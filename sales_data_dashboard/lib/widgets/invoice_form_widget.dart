import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';
import 'package:sales_data_dashboard/models/app_enum.dart';
import 'package:sales_data_dashboard/models/invoice_stock_model.dart';
import 'package:sales_data_dashboard/models/party_model.dart';
import 'package:sales_data_dashboard/screens/invoice/invoice_screen.dart';
import 'package:sales_data_dashboard/screens/invoice/store/invoice_store.dart';
import 'package:sales_data_dashboard/widgets/custom_radio_button.dart';
import 'package:sales_data_dashboard/widgets/normal_button.dart';

class InvoiceForm extends StatefulWidget {
  final InvoiceModel? existingInvoice;
  final void Function(InvoiceModel) onSubmit;
  final List<Party>? customers;
  final List<InvoiceStockModel>? products;
  final InvoiceStore invoiceStore;
  final CompanyModel selectedFirm;

  const InvoiceForm({
    super.key,
    this.existingInvoice,
    required this.onSubmit,
    this.customers,
    this.products,
    required this.invoiceStore,
    required this.selectedFirm,
  });

  @override
  State<InvoiceForm> createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  final _formKey = GlobalKey<FormState>();

  final _invoiceIdController = TextEditingController();
  final _dateController = TextEditingController();
  final _sizeController = TextEditingController();
  final _rateController = TextEditingController();
  final _amountController = TextEditingController();
  final _daysOfIntstController = TextEditingController();
  final _custNameController = TextEditingController();
  final _custAddressController = TextEditingController();
  final _custPhoneController = TextEditingController();
  final _custGstController = TextEditingController();
  final _noteController = TextEditingController();
  final _prodNameController = TextEditingController();
  final _hsnCodeController = TextEditingController();
  final _itemIdController = TextEditingController();

  TransactionTypeEnum? _transactionType;
  UsertypeEnum? _custType;
  Party? _selectedCustomer;
  UnitTypeEnum? _unitType;

  @override
  void initState() {
    super.initState();
    final invoice = widget.existingInvoice;

    if (invoice != null) {
      _invoiceIdController.text = invoice.invoiceId;
      _dateController.text = invoice.date;
      _sizeController.text = invoice.size;
      _rateController.text = invoice.rate;
      _amountController.text = invoice.amount;
      _daysOfIntstController.text = invoice.interestDays.toString();
      _custNameController.text = invoice.custName;
      _noteController.text = invoice.note ?? '';
      _transactionType = invoice.transactionType;
      _custType = invoice.custType;
      _unitType = invoice.unitType;
      // _paymentStatus = invoice.paymentStatus;
      // _paymentType = invoice.paymentType;
      _hsnCodeController.text = invoice.hsnCode;
      _prodNameController.text = invoice.productName ?? '';
      _custAddressController.text = invoice.custAddress ?? '';
      _custPhoneController.text = invoice.custPhone ?? '';
      _custGstController.text = invoice.custGst ?? '';
      _itemIdController.text = invoice.itemId ?? '';
    } else {
      _invoiceIdController.text =
          '${DateTime.now().year}-${(DateTime.now().year + 1).toString().substring(2)}/00${(widget.invoiceStore.invoices.length + 1).toString()}';
      _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    }
  }

  @override
  void dispose() {
    _invoiceIdController.dispose();
    _dateController.dispose();
    _sizeController.dispose();
    _rateController.dispose();
    _amountController.dispose();
    _daysOfIntstController.dispose();
    _custNameController.dispose();
    _noteController.dispose();
    _prodNameController.dispose();
    _hsnCodeController.dispose();
    _itemIdController.dispose();
    super.dispose();
  }

  void _setAmount(String size, String rate) {
    final doubleSize = double.tryParse(size) ?? 0;
    final doubleRate = double.tryParse(rate) ?? 0;
    final amount = doubleSize * doubleRate;
    _amountController.text = amount.toString();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _transactionType != null &&
        _custType != null) {
      final invoiceData = InvoiceModel(
        invoiceId: _invoiceIdController.text,
        date: _dateController.text,
        size: _sizeController.text,
        rate: _rateController.text,
        amount: _amountController.text,
        interestDays: _daysOfIntstController.text,
        custName: _custNameController.text,
        note: _noteController.text,
        transactionType: _transactionType!,
        custType: _custType!,
        unitType: _unitType!,
        productName: _prodNameController.text,
        hsnCode: _hsnCodeController.text,
        custAddress: _custAddressController.text,
        custPhone: _custPhoneController.text,
        custGst: _custGstController.text,
        itemId: _itemIdController.text,
        selectedFirm: widget.selectedFirm,
        invoiceNumber: widget.existingInvoice != null
            ? widget.existingInvoice?.invoiceNumber
            : (widget.invoiceStore.invoices.length + 1).toString(),
      );
      clearControllers();
      widget.onSubmit(invoiceData);
      Navigator.of(context).pop();
    }
  }

  void clearControllers() {
    _invoiceIdController.clear();
    _dateController.clear();
    _sizeController.clear();
    _rateController.clear();
    _amountController.clear();
    _daysOfIntstController.clear();
    _custNameController.clear();
    _noteController.clear();
    _prodNameController.clear();
    _hsnCodeController.clear();
    _custAddressController.clear();
    _custPhoneController.clear();
    _custGstController.clear();
    _transactionType = null;
    _custType = null;
    _unitType = null;
    _selectedCustomer = null;
    _itemIdController.clear();
  }

  final List<Map<String, String>> _hsnSuggestions = [
    {'label': 'Precious Gemstone', 'code': '710391'},
    {'label': 'Semi Precious', 'code': '710399'},
    {'label': 'Pearl', 'code': '710110'},
    {'label': 'Diamond', 'code': '710239'},
    {'label': 'Coral', 'code': '960110'},
  ];

  Future<void> _pickDate() async {
    final initialDate =
        DateTime.tryParse(_dateController.text) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  void _setItemId(final String itemName, final String size) {
    final id = '$itemName-$size';
    _itemIdController.text = id;
  }

  InputDecoration _inputDecoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon) : null,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.dp),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.dp),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.dp),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800.dp,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.dp),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 24.dp),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 300.dp,
                      child: TextFormField(
                        controller: _dateController,
                        readOnly: true,
                        onTap: _pickDate,
                        decoration: _inputDecoration('Date',
                            icon: Icons.calendar_today),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.dp),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 300.dp,
                      child: TextFormField(
                        controller: _invoiceIdController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration('Invoice ID'),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.dp),
              Text(
                'Product Information :',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Observer(builder: (context) {
                return Row(
                  children: [
                    IntrinsicWidth(
                      child: CustomRadioButton<String>(
                          title: 'Existing Item',
                          value: 'existing',
                          groupValue: widget.invoiceStore.itemSelectionType,
                          onChanged: (value) {
                            widget.invoiceStore.setItemSelectionType(value!);
                            if (value == 'existing') {
                              _prodNameController.clear();
                              _sizeController.clear();
                              _rateController.clear();
                              _amountController.clear();
                            }
                          }),
                    ),
                    IntrinsicWidth(
                      child: CustomRadioButton<String>(
                          title: 'New Item',
                          value: 'newItem',
                          groupValue: widget.invoiceStore.itemSelectionType,
                          onChanged: (final value) {
                            widget.invoiceStore.setItemSelectionType(value!);
                            if (value == 'newItem') {
                              _prodNameController.clear();
                              _sizeController.clear();
                              _rateController.clear();
                              _amountController.clear();
                            }
                          }),
                    ),
                  ],
                );
              }),
              SizedBox(height: 12.dp),
              if (widget.products != null && widget.products!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.dp),
                    Row(
                      children: [
                        Observer(
                          builder: (context) => (widget
                                      .invoiceStore.itemSelectionType ==
                                  'existing')
                              ? Flexible(
                                  child: Autocomplete<InvoiceStockModel>(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                      if (textEditingValue.text.isEmpty) {
                                        return const Iterable<
                                            InvoiceStockModel>.empty();
                                      }
                                      return widget.products != null
                                          ? widget.products!.where(
                                              (InvoiceStockModel product) =>
                                                  product
                                                      .itemName
                                                      .toLowerCase()
                                                      .contains(textEditingValue
                                                          .text
                                                          .toLowerCase()),
                                            )
                                          : [];
                                    },
                                    displayStringForOption:
                                        (InvoiceStockModel option) =>
                                            option.itemName,
                                    initialValue: TextEditingValue(
                                        text: _prodNameController.text),
                                    fieldViewBuilder: (context, controller,
                                        focusNode, onFieldSubmitted) {
                                      return TextFormField(
                                        controller: controller,
                                        focusNode: focusNode,
                                        decoration:
                                            _inputDecoration('Product Name'),
                                        validator: (value) =>
                                            value == null || value.isEmpty
                                                ? 'Product name required'
                                                : null,
                                        onChanged: (value) {
                                          _prodNameController.text = value;
                                        },
                                      );
                                    },
                                    optionsViewBuilder: (context,
                                        AutocompleteOnSelected<
                                                InvoiceStockModel>
                                            onSelected,
                                        options) {
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          elevation: 4,
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth:
                                                    230.dp), // Adjust as needed
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: options.length,
                                              itemBuilder: (context, index) {
                                                final InvoiceStockModel option =
                                                    options.elementAt(index);
                                                return ListTile(
                                                  title: Text(option.itemName),
                                                  onTap: () {
                                                    onSelected(option);
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    onSelected: (InvoiceStockModel selection) {
                                      setState(() {
                                        _prodNameController.text =
                                            selection.itemName;
                                        _sizeController.text =
                                            selection.itemWeight.toString();
                                        _rateController.text =
                                            selection.rate.toString();
                                        _amountController.text =
                                            selection.amount.toString();
                                        _hsnCodeController.text =
                                            selection.hsdCode;
                                        _itemIdController.text =
                                            selection.itemId;
                                      });
                                    },
                                  ),
                                )
                              : Flexible(
                                  child: TextFormField(
                                    controller: _prodNameController,
                                    keyboardType: TextInputType.number,
                                    decoration:
                                        _inputDecoration('Product Name'),
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Required'
                                            : null,
                                    onChanged: (value) {
                                      _setItemId(value, _sizeController.text);
                                    },
                                  ),
                                ),
                        ),
                        SizedBox(
                          width: 12.dp,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: _sizeController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration('Size'),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required'
                                : null,
                            onChanged: (value) {
                              _setItemId(_prodNameController.text, value);
                              _setAmount(
                                  _sizeController.text, _rateController.text);
                            },
                          ),
                        ),
                        SizedBox(width: 12.dp),
                        Flexible(
                          child: TextFormField(
                            controller: _rateController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration('Rate'),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required'
                                : null,
                            onChanged: (value) =>
                                _setAmount(_sizeController.text, value),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.dp,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration('Amount'),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required'
                                : null,
                          ),
                        ),
                        SizedBox(width: 12.dp),
                        Flexible(
                            // child: TextFormField(
                            //   controller: _hsnCodeController,
                            //   decoration: _inputDecoration('HSN Code'),
                            //   validator: (value) => value == null || value.isEmpty
                            //       ? 'Required'
                            //       : null,
                            // ),
                            child: Autocomplete<Map<String, String>>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return _hsnSuggestions;
                            }
                            return _hsnSuggestions.where((option) =>
                                option['label']!.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase()) ||
                                option['code']!
                                    .contains(textEditingValue.text));
                          },

                          // IMPORTANT: Show only code in textfield
                          displayStringForOption: (option) => option['code']!,

                          fieldViewBuilder: (context, controller, focusNode,
                              onFieldSubmitted) {
                            controller.text = _hsnCodeController.text;

                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: _inputDecoration('HSN Code'),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Required'
                                      : null,
                              onChanged: (value) {
                                _hsnCodeController.text = value;
                              },
                            );
                          },

                          onSelected: (selection) {
                            _hsnCodeController.text = selection['code']!;
                          },

                          optionsViewBuilder: (context, onSelected, options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                elevation: 4,
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 300.dp),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      final option = options.elementAt(index);
                                      return ListTile(
                                        title: Text(
                                            "${option['label']} (${option['code']})"),
                                        onTap: () {
                                          onSelected(option);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                        SizedBox(
                          width: 12.dp,
                        ),
                        Flexible(
                          child: DropdownButtonFormField<UnitTypeEnum>(
                            focusColor: Colors.white,
                            value: _unitType,
                            decoration: _inputDecoration('Unit Type'),
                            items: [
                              UnitTypeEnum.KG,
                              UnitTypeEnum.CTS,
                            ].map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e.name.toUpperCase()),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() => _unitType = value),
                            validator: (value) =>
                                value == null ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              else
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'No products available. Please add products first.',
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
              SizedBox(height: 24.dp),
              Text(
                'Customer Information :',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 12.dp),
              if (widget.customers != null && widget.customers!.isNotEmpty)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Autocomplete<Party>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return const Iterable<Party>.empty();
                              }
                              return widget.customers!.where(
                                (Party party) => party.name
                                    .toLowerCase()
                                    .contains(
                                        textEditingValue.text.toLowerCase()),
                              );
                            },
                            displayStringForOption: (Party option) =>
                                option.name,
                            initialValue: TextEditingValue(
                                text: _custNameController.text),
                            fieldViewBuilder: (context, controller, focusNode,
                                onFieldSubmitted) {
                              return TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: _inputDecoration('Customer Name'),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Customer name required'
                                        : null,
                                onChanged: (value) {
                                  _custNameController.text = value;
                                },
                              );
                            },
                            optionsViewBuilder: (context,
                                AutocompleteOnSelected<Party> onSelected,
                                options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  elevation: 4,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 230.dp,
                                    ), // Adjust as needed
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: options.length,
                                      itemBuilder: (context, index) {
                                        final Party option =
                                            options.elementAt(index);
                                        return ListTile(
                                          title: Text(option.name),
                                          onTap: () {
                                            onSelected(option);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            onSelected: (Party selection) {
                              setState(() {
                                _selectedCustomer = selection;
                                _custNameController.text = selection.name;
                                _custType = selection.partyType == 'broker'
                                    ? UsertypeEnum.broker
                                    : UsertypeEnum.company;
                                _custAddressController.text =
                                    selection.address ?? '';
                                _custPhoneController.text =
                                    selection.mobileNumber ?? '';
                                _custGstController.text =
                                    selection.gstNumber.toString();
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 12.dp,
                        ),
                        Flexible(
                          child: DropdownButtonFormField<UsertypeEnum>(
                            focusColor: Colors.white,
                            value: _selectedCustomer != null
                                ? _selectedCustomer!.partyType == 'broker'
                                    ? UsertypeEnum.broker
                                    : UsertypeEnum.company
                                : _custType,
                            decoration: _inputDecoration('Customer Type'),
                            items: [
                              UsertypeEnum.broker,
                              UsertypeEnum.company,
                            ].map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e.name.toUpperCase()),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() => _custType = value),
                            validator: (value) =>
                                value == null ? 'Required' : null,
                          ),
                        ),
                        SizedBox(
                          width: 12.dp,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: _daysOfIntstController,
                            keyboardType: TextInputType.number,
                            decoration:
                                _inputDecoration('Days of Interest (Optional)'),
                            // validator: (value) => value == null || value.isEmpty
                            //     ? 'Required'
                            //     : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.dp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _custAddressController,
                            decoration: _inputDecoration('Customer Address'),
                          ),
                        ),
                        SizedBox(width: 12.dp),
                        Flexible(
                          child: TextFormField(
                            controller: _custPhoneController,
                            keyboardType: TextInputType.phone,
                            decoration: _inputDecoration('Customer Phone'),
                          ),
                        ),
                        SizedBox(width: 12.dp),
                        Flexible(
                          child: TextFormField(
                            controller: _custGstController,
                            decoration: _inputDecoration('Customer GST'),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              else
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'No Customers available. Please add products first.',
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
              const SizedBox(height: 24),
              Text(
                'Other Information :',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 12.dp),
              Row(
                children: [
                  // Expanded(
                  //   child: DropdownButtonFormField<PaymentStatusEnum>(
                  //     value: _paymentStatus,
                  //     focusColor: Colors.white,
                  //     decoration: _inputDecoration('Payment Status'),
                  //     items: [
                  //       PaymentStatusEnum.paid,
                  //       PaymentStatusEnum.unpaid,
                  //     ].map((e) {
                  //       return DropdownMenuItem(
                  //         value: e,
                  //         child: Text(e.name.toUpperCase()),
                  //       );
                  //     }).toList(),
                  //     onChanged: (value) =>
                  //         setState(() => _paymentStatus = value),
                  //     validator: (value) => value == null ? 'Required' : null,
                  //   ),
                  // ),
                  // const SizedBox(width: 12),
                  // Expanded(
                  //   child: DropdownButtonFormField<PaymentTypeEnum>(
                  //     value: _paymentType,
                  //     focusColor: Colors.white,
                  //     decoration: _inputDecoration('Payment Type'),
                  //     items: [
                  //       PaymentTypeEnum.cash,
                  //       PaymentTypeEnum.cheque,
                  //       PaymentTypeEnum.online,
                  //     ].map((e) {
                  //       return DropdownMenuItem(
                  //         value: e,
                  //         child: Text(e.name.toUpperCase()),
                  //       );
                  //     }).toList(),
                  //     onChanged: (value) => setState(
                  //       () => _paymentType = value,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(width: 12.dp),
                  Expanded(
                    child: DropdownButtonFormField<TransactionTypeEnum>(
                      value: _transactionType,
                      focusColor: Colors.white,
                      decoration: _inputDecoration('Transaction Type'),
                      items: TransactionTypeEnum.values.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e.name.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => _transactionType = value),
                      validator: (value) => value == null ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.dp),
              TextFormField(
                controller: _noteController,
                decoration: _inputDecoration('Note (Optional)'),
                maxLines: 3,
              ),
              SizedBox(height: 24.dp),
              const SizedBox(
                width: double.infinity,
                child: Divider(
                  color: Color(0xFFE5E7EB),
                ),
              ),
              SizedBox(height: 12.dp),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IntrinsicWidth(
                    child: NormalButton(
                      onPressed: () => Navigator.pop(context),
                      text: 'Cancel',
                      filledColor: const Color(0xFFF3F4F6),
                      textColor: Colors.blue,
                      borderColor: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(width: 12.dp),
                  IntrinsicWidth(
                    child: NormalButton(
                      onPressed: _submitForm,
                      text: widget.existingInvoice != null
                          ? 'Update Invoice'
                          : 'Create Invoice',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
