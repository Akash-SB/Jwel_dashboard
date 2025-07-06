import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/models/product_model.dart';

class ProductForm extends StatefulWidget {
  final ProductModel? existingProduct;
  final void Function(ProductModel) onSubmit;

  const ProductForm({
    super.key,
    this.existingProduct,
    required this.onSubmit,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();

  final _hsnController = TextEditingController();
  final _nameController = TextEditingController();
  final _sizeController = TextEditingController();
  final _rateController = TextEditingController();
  final _amountController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final product = widget.existingProduct;
    if (product != null) {
      _hsnController.text = product.hsnCode;
      _nameController.text = product.prodName;
      _sizeController.text = product.size;
      _rateController.text = product.rate;
      _amountController.text = product.amount;
      _descController.text = product.description ?? '';
    }
  }

  @override
  void dispose() {
    _hsnController.dispose();
    _nameController.dispose();
    _sizeController.dispose();
    _rateController.dispose();
    _amountController.dispose();
    _descController.dispose();
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
    if (_formKey.currentState!.validate()) {
      final product = ProductModel(
        id: widget.existingProduct?.id ?? UniqueKey().toString(),
        hsnCode: _hsnController.text,
        prodName: _nameController.text,
        size: _sizeController.text,
        rate: _rateController.text,
        amount: _amountController.text,
        description: _descController.text,
      );
      widget.onSubmit(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                TextFormField(
                  controller: _hsnController,
                  decoration: _inputDecoration('HSN Code'),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  decoration: _inputDecoration('Product Name'),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _sizeController,
                  decoration: _inputDecoration('Size'),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _rateController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Rate'),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Amount'),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descController,
                  maxLines: 3,
                  decoration: _inputDecoration('Description (Optional)'),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          widget.existingProduct != null
                              ? 'Update Product'
                              : 'Create Product',
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
