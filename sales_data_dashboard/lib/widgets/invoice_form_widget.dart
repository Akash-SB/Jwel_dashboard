import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';
import 'package:sales_data_dashboard/models/app_enum.dart';

class InvoiceForm extends StatefulWidget {
  final InvoiceModel? existingInvoice;
  final void Function(InvoiceModel) onSubmit;

  const InvoiceForm({
    super.key,
    this.existingInvoice,
    required this.onSubmit,
  });

  @override
  State<InvoiceForm> createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  final _formKey = GlobalKey<FormState>();

  final _invoiceIdController = TextEditingController();
  final _dateController = TextEditingController();
  final _caratController = TextEditingController();
  final _rateController = TextEditingController();
  final _amountController = TextEditingController();
  final _custNameController = TextEditingController();
  final _noteController = TextEditingController();

  TransactionTypeEnum? _transactionType;
  UsertypeEnum? _custType;
  PaymentStatusEnum? _paymentStatus;
  PaymentTypeEnum? _paymentType;

  @override
  void initState() {
    super.initState();
    final invoice = widget.existingInvoice;

    if (invoice != null) {
      _invoiceIdController.text = invoice.invoiceId;
      _dateController.text = invoice.date;
      _caratController.text = invoice.carat;
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
    _caratController.dispose();
    _rateController.dispose();
    _amountController.dispose();
    _custNameController.dispose();
    _noteController.dispose();
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
        carat: _caratController.text,
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
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.existingInvoice != null
                      ? 'Edit Invoice'
                      : 'Create Invoice',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // Invoice ID
                TextFormField(
                  controller: _invoiceIdController,
                  readOnly: true,
                  decoration: _inputDecoration('Invoice ID'),
                ),
                const SizedBox(height: 12),

                // Date Picker
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: _pickDate,
                  decoration:
                      _inputDecoration('Date', icon: Icons.calendar_today),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Date required' : null,
                ),
                const SizedBox(height: 24),

                // Product Details
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _caratController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration('Carat'),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _rateController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration('Rate'),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration('Amount'),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Customer Name
                TextFormField(
                  controller: _custNameController,
                  decoration: _inputDecoration('Customer Name'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Customer name required'
                      : null,
                ),
                const SizedBox(height: 12),

                // Transaction Type & Customer Type
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<TransactionTypeEnum>(
                        value: _transactionType,
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
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<UsertypeEnum>(
                        value: _custType,
                        decoration: _inputDecoration('Customer Type'),
                        items: UsertypeEnum.values.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() => _custType = value),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Payment Info
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<PaymentStatusEnum>(
                        value: _paymentStatus,
                        decoration: _inputDecoration('Payment Status'),
                        items: PaymentStatusEnum.values.map((e) {
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
                        decoration: _inputDecoration('Payment Type'),
                        items: PaymentTypeEnum.values.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => _paymentType = value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Note
                TextFormField(
                  controller: _noteController,
                  decoration: _inputDecoration('Note (Optional)'),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),

                // Submit Button
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(
                          widget.existingInvoice != null
                              ? 'Update Invoice'
                              : 'Create Invoice',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
