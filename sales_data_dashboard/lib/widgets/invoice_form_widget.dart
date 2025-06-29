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
        'productIds': [],
      };

      widget.onSubmit(invoiceData);
    }
  }

  Widget _sectionTitle(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.existingInvoice != null
                      ? 'Edit Invoice'
                      : 'Create Invoice',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 20),
                _sectionTitle("Invoice Info"),
                TextFormField(
                  controller: _invoiceIdController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Invoice ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'Date (yyyy-MM-dd)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 20),
                _sectionTitle("Product Details"),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _caratController,
                        decoration: const InputDecoration(
                          labelText: 'Carat',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _rateController,
                        decoration: const InputDecoration(
                          labelText: 'Rate',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _sectionTitle("Customer Details"),
                TextFormField(
                  controller: _custNameController,
                  decoration: const InputDecoration(
                    labelText: 'Customer Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<TransactionTypeEnum>(
                        value: _transactionType,
                        items: TransactionTypeEnum.values
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name.toUpperCase()),
                                ))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _transactionType = value),
                        decoration: const InputDecoration(
                          labelText: 'Transaction Type',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<UsertypeEnum>(
                        value: _custType,
                        items: UsertypeEnum.values
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name.toUpperCase()),
                                ))
                            .toList(),
                        onChanged: (value) => setState(() => _custType = value),
                        decoration: const InputDecoration(
                          labelText: 'Customer Type',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _sectionTitle("Payment Info"),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<PaymentStatusEnum>(
                        value: _paymentStatus,
                        items: PaymentStatusEnum.values
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name.toUpperCase()),
                                ))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _paymentStatus = value),
                        decoration: const InputDecoration(
                          labelText: 'Payment Status',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<PaymentTypeEnum>(
                        value: _paymentType,
                        items: PaymentTypeEnum.values
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name.toUpperCase()),
                                ))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _paymentType = value),
                        decoration: const InputDecoration(
                          labelText: 'Payment Type',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: 'Note (Optional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: Icon(widget.existingInvoice != null
                        ? Icons.edit
                        : Icons.add),
                    label: Text(
                      widget.existingInvoice != null
                          ? 'Update Invoice'
                          : 'Create Invoice',
                      style: const TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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
