import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TransactionTypeEnum { buy, sell }

enum UsertypeEnum { broker, company }

enum PaymentStatusEnum { paid, unpaid }

enum PaymentTypeEnum { cash, cheque, online }

class InvoiceForm extends StatefulWidget {
  final Map<String, dynamic>? existingInvoice;
  final void Function(Map<String, dynamic>) onSubmit;

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
      _invoiceIdController.text = invoice['invoiceId'];
      _dateController.text = invoice['date'];
      _caratController.text = invoice['carat'];
      _rateController.text = invoice['rate'];
      _amountController.text = invoice['amount'];
      _custNameController.text = invoice['custName'];
      _noteController.text = invoice['note'] ?? '';
      _transactionType = invoice['transactionType'];
      _custType = invoice['custType'];
      _paymentStatus = invoice['paymentStatus'];
      _paymentType = invoice['paymentType'];
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
      final invoiceData = {
        'invoiceId': _invoiceIdController.text,
        'date': _dateController.text,
        'carat': _caratController.text,
        'rate': _rateController.text,
        'amount': _amountController.text,
        'custName': _custNameController.text,
        'note': _noteController.text,
        'transactionType': _transactionType!,
        'custType': _custType!,
        'paymentStatus': _paymentStatus!,
        'paymentType': _paymentType,
        'productIds': [], // Placeholder for future product selection
      };

      widget.onSubmit(invoiceData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.existingInvoice != null
                      ? 'Edit Invoice'
                      : 'Add Invoice',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _invoiceIdController,
                  decoration: InputDecoration(labelText: 'Invoice ID'),
                  readOnly: true,
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: 'Date (yyyy-MM-dd)'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _caratController,
                  decoration: InputDecoration(labelText: 'Carat'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _rateController,
                  decoration: InputDecoration(labelText: 'Rate'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _custNameController,
                  decoration: InputDecoration(labelText: 'Customer Name'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                DropdownButtonFormField<TransactionTypeEnum>(
                  value: _transactionType,
                  items: TransactionTypeEnum.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                                e.toString().split('.').last.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _transactionType = value),
                  decoration: InputDecoration(labelText: 'Transaction Type'),
                  validator: (value) =>
                      value == null ? 'Select transaction type' : null,
                ),
                DropdownButtonFormField<UsertypeEnum>(
                  value: _custType,
                  items: UsertypeEnum.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                                e.toString().split('.').last.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _custType = value),
                  decoration: InputDecoration(labelText: 'Customer Type'),
                  validator: (value) =>
                      value == null ? 'Select customer type' : null,
                ),
                DropdownButtonFormField<PaymentStatusEnum>(
                  value: _paymentStatus,
                  items: PaymentStatusEnum.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                                e.toString().split('.').last.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _paymentStatus = value),
                  decoration: InputDecoration(labelText: 'Payment Status'),
                  validator: (value) =>
                      value == null ? 'Select payment status' : null,
                ),
                DropdownButtonFormField<PaymentTypeEnum>(
                  value: _paymentType,
                  items: PaymentTypeEnum.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                                e.toString().split('.').last.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _paymentType = value),
                  decoration: InputDecoration(labelText: 'Payment Type'),
                ),
                TextFormField(
                  controller: _noteController,
                  decoration: InputDecoration(labelText: 'Note (Optional)'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    widget.existingInvoice != null
                        ? 'Update Invoice'
                        : 'Create Invoice',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
