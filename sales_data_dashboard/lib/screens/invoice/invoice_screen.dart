import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/screens/invoice/store/invoice_store.dart';
import '../../widgets/invoice_form_widget.dart';
import 'invoice_data_table.dart';

final getIt = GetIt.instance;

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late InvoiceStore invoiceStore;
  late UserDataStore userDataStore;

  @override
  void initState() {
    if (!getIt.isRegistered<InvoiceStore>()) {
      getIt.registerSingleton<InvoiceStore>(InvoiceStore());
    }

    if (!GetIt.I.isRegistered<UserDataStore>()) {
      GetIt.I.registerSingleton<UserDataStore>(UserDataStore());
    }
    userDataStore = GetIt.I<UserDataStore>();

    invoiceStore = getIt<InvoiceStore>();

    if (userDataStore.invoices.isEmpty) {
      invoiceStore.fetchInvoices();
      userDataStore.setInvoices(invoiceStore.invoices);
    } else {
      invoiceStore.setInvoices(userDataStore.invoices);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(24.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          SizedBox(height: 24.dp),
          Expanded(
            child: Observer(builder: (context) {
              return InvoiceDataTable(
                data: invoiceStore.invoices, // from the store's invoices list
                onDelete: (invoice) => _confirmDelete(context, invoice),
                onEdit: (invoice) => _openInvoiceForm(context, invoice),
                onExportPDF: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Exporting to PDF...')),
                  );
                },
                onExportExcel: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Exporting to Excel...')),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Invoice Management",
          style: TextStyle(
            color: const Color(0xff1F2937),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          onPressed: () => _openInvoiceForm(context),
          child: const Text(
            "Create an Invoice",
          ),
        )
      ],
    );
  }

  void _openInvoiceForm(BuildContext context, [InvoiceModel? existingInvoice]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        scrollable: true,
        content: InvoiceForm(
          existingInvoice: existingInvoice,
          onSubmit: (invoiceData) {
            invoiceStore.addInvoice(invoiceData);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Invoice ${invoiceData.invoiceId} added')),
            );
            Navigator.pop(context); // Close bottom sheet
          },
          customers: userDataStore.customers,
          products: userDataStore.products,
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, InvoiceModel invoice) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Invoice'),
        content: Text(
            'Are you sure you want to delete invoice ${invoice.invoiceId}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              invoiceStore.deleteInvoice(invoice.invoiceId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Invoice ${invoice.invoiceId} deleted')),
              );
              setState(() {});
              Navigator.pop(ctx);
            },
            child: Text('Yes, Delete'),
          ),
        ],
      ),
    );
  }
}
