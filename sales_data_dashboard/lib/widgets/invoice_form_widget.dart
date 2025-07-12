import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/customer_model.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';
import 'package:sales_data_dashboard/models/app_enum.dart';
import 'package:sales_data_dashboard/models/product_model.dart';
import 'package:sales_data_dashboard/widgets/normal_button.dart';

class InvoiceForm extends StatefulWidget {
  final InvoiceModel? existingInvoice;
  final void Function(InvoiceModel) onSubmit;
  final List<CustomerModel>? customers;
  final List<ProductModel>? products;

  const InvoiceForm({
    super.key,
    this.existingInvoice,
    required this.onSubmit,
    this.customers,
    this.products,
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
  final _custNameController = TextEditingController();
  final _noteController = TextEditingController();
  final _prodNameController = TextEditingController();

  TransactionTypeEnum? _transactionType;
  UsertypeEnum? _custType;
  PaymentStatusEnum? _paymentStatus;
  PaymentTypeEnum? _paymentType;
  CustomerModel? _selectedCustomer;
  ProductModel? _selectedProduct;

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
      _custNameController.text = invoice.custName;
      _noteController.text = invoice.note ?? '';
      _transactionType = invoice.transactionType;
      _custType = invoice.custType;
      _paymentStatus = invoice.paymentStatus;
      _paymentType = invoice.paymentType;
    } else {
      _invoiceIdController.text =
          DateTime.now().millisecondsSinceEpoch.toString();
      _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
  }

  @override
  void dispose() {
    _invoiceIdController.dispose();
    _dateController.dispose();
    _sizeController.dispose();
    _rateController.dispose();
    _amountController.dispose();
    _custNameController.dispose();
    _noteController.dispose();
    _prodNameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _transactionType != null &&
        _custType != null &&
        _paymentStatus != null) {
      final invoiceData = InvoiceModel(
        invoiceId: _invoiceIdController.text,
        date: _dateController.text,
        size: _sizeController.text,
        rate: _rateController.text,
        amount: _amountController.text,
        custName: _custNameController.text,
        note: _noteController.text,
        transactionType: _transactionType!,
        custType: _custType!,
        paymentStatus: _paymentStatus!,
        paymentType: _paymentType,
        productIds: [],
      );

      widget.onSubmit(invoiceData);
    }
  }

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
      _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  InputDecoration _inputDecoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800.dp,
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
                      decoration:
                          _inputDecoration('Date', icon: Icons.calendar_today),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Date required'
                          : null,
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
            if (widget.products != null && widget.products!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.dp),
                  Row(
                    children: [
                      Flexible(
                        child: Autocomplete<ProductModel>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return const Iterable<ProductModel>.empty();
                            }
                            return widget.products != null
                                ? widget.products!.where(
                                    (ProductModel product) => product.prodName
                                        .toLowerCase()
                                        .contains(textEditingValue.text
                                            .toLowerCase()),
                                  )
                                : [];
                          },
                          displayStringForOption: (ProductModel option) =>
                              option.prodName,
                          initialValue:
                              TextEditingValue(text: _prodNameController.text),
                          fieldViewBuilder: (context, controller, focusNode,
                              onFieldSubmitted) {
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: _inputDecoration('Product Name'),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Product name required'
                                      : null,
                              onChanged: (value) {
                                _custNameController.text = value;
                              },
                            );
                          },
                          optionsViewBuilder: (context,
                              AutocompleteOnSelected<ProductModel> onSelected,
                              options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                elevation: 4,
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 230.dp), // Adjust as needed
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      final ProductModel option =
                                          options.elementAt(index);
                                      return ListTile(
                                        title: Text(option.prodName),
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
                          onSelected: (ProductModel selection) {
                            setState(() {
                              _selectedProduct = selection;
                              _prodNameController.text = selection.prodName;
                              _sizeController.text = selection.size;
                              _rateController.text = selection.rate;
                              _amountController.text = selection.amount;
                            });
                          },
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
                      const Flexible(child: SizedBox()),
                      const Flexible(child: SizedBox()),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Autocomplete<CustomerModel>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<CustomerModel>.empty();
                        }
                        return widget.customers!.where(
                          (CustomerModel customer) => customer.custName
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()),
                        );
                      },
                      displayStringForOption: (CustomerModel option) =>
                          option.custName,
                      initialValue:
                          TextEditingValue(text: _prodNameController.text),
                      fieldViewBuilder:
                          (context, controller, focusNode, onFieldSubmitted) {
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: _inputDecoration('Customer Name'),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Customer name required'
                              : null,
                          onChanged: (value) {
                            _prodNameController.text = value;
                          },
                        );
                      },
                      optionsViewBuilder: (context,
                          AutocompleteOnSelected<CustomerModel> onSelected,
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
                                  final CustomerModel option =
                                      options.elementAt(index);
                                  return ListTile(
                                    title: Text(option.custName),
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
                      onSelected: (CustomerModel selection) {
                        setState(() {
                          _selectedCustomer = selection;
                          _custNameController.text = selection.custName;
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
                          ? _selectedCustomer!.usertype
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
                      onChanged: (value) => setState(() => _custType = value),
                      validator: (value) => value == null ? 'Required' : null,
                    ),
                  ),
                  SizedBox(
                    width: 12.dp,
                  ),
                  const Flexible(child: SizedBox()),
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
                Expanded(
                  child: DropdownButtonFormField<PaymentStatusEnum>(
                    value: _paymentStatus,
                    focusColor: Colors.white,
                    decoration: _inputDecoration('Payment Status'),
                    items: [
                      PaymentStatusEnum.paid,
                      PaymentStatusEnum.unpaid,
                    ].map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _paymentStatus = value),
                    validator: (value) => value == null ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<PaymentTypeEnum>(
                    value: _paymentType,
                    focusColor: Colors.white,
                    decoration: _inputDecoration('Payment Type'),
                    items: [
                      PaymentTypeEnum.cash,
                      PaymentTypeEnum.cheque,
                      PaymentTypeEnum.online,
                    ].map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) => setState(
                      () => _paymentType = value,
                    ),
                  ),
                ),
                SizedBox(width: 12.dp),
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
            SizedBox(height: 24.dp),
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
    );
  }
}
