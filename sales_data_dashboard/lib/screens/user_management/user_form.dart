import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/customer_model.dart';
import 'package:sales_data_dashboard/models/app_enum.dart';

import '../../widgets/normal_button.dart';

class CustomerForm extends StatefulWidget {
  final CustomerModel? existingCustomer;
  final void Function(CustomerModel) onSubmit;

  const CustomerForm({
    super.key,
    this.existingCustomer,
    required this.onSubmit,
  });

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();

  final _custNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _gstController = TextEditingController();
  final _addressController = TextEditingController();

  UsertypeEnum? _userType;

  @override
  void initState() {
    super.initState();
    final customer = widget.existingCustomer;
    if (customer != null) {
      _custNameController.text = customer.custName;
      _mobileController.text = customer.mobileNumber;
      _gstController.text = customer.gstNumber;
      _addressController.text = customer.address ?? '';
      _userType = customer.usertype;
    }
  }

  @override
  void dispose() {
    _custNameController.dispose();
    _mobileController.dispose();
    _gstController.dispose();
    _addressController.dispose();
    super.dispose();
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

  void _submitForm() {
    if (_formKey.currentState!.validate() && _userType != null) {
      final customerData = CustomerModel(
        id: widget.existingCustomer?.id,
        custName: _custNameController.text,
        mobileNumber: _mobileController.text,
        gstNumber: _gstController.text,
        usertype: _userType!,
        address: _addressController.text,
      );
      widget.onSubmit(customerData);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _custNameController,
                        decoration: _inputDecoration('Customer Name'),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Required'
                                : null,
                      ),
                    ),
                    SizedBox(
                      width: 12.dp,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: _inputDecoration('Mobile Number'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Required';
                          }
                          final isValid =
                              RegExp(r'^[0-9]{10}$').hasMatch(value);
                          return isValid ? null : 'Enter valid 10-digit number';
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.dp),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _gstController,
                        decoration: _inputDecoration('GST Number'),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Required'
                                : null,
                      ),
                    ),
                    SizedBox(
                      width: 12.dp,
                    ),
                    Expanded(
                      child: DropdownButtonFormField<UsertypeEnum>(
                        value: _userType,
                        iconEnabledColor: Colors.grey,
                        iconDisabledColor: Colors.grey,
                        decoration: _inputDecoration('Customer Type'),
                        items: UsertypeEnum.values.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() => _userType = value),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.dp),
                TextFormField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: _inputDecoration('Address (Optional)'),
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
                        text: widget.existingCustomer != null
                            ? 'Update Customer'
                            : 'Create Customer',
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
