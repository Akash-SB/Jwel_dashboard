import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';
import 'package:sales_data_dashboard/screens/invoice/store/invoice_store.dart';
import '../../widgets/invoice_form_widget.dart';
import '../../widgets/stat_card_grid_widget.dart';
import 'invoice_data_table.dart';

final getIt = GetIt.instance;

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late InvoiceStore invoiceStore;

  @override
  void initState() {
    if (!getIt.isRegistered<InvoiceStore>()) {
      getIt.registerFactory<InvoiceStore>(() => InvoiceStore());
    }

    invoiceStore = getIt<InvoiceStore>();
    invoiceStore.fetchInvoices(); // Fetch invoices from Firestore

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
          SizedBox(height: 20.dp),
          Row(
            children: [
              Expanded(
                child: StatCardGridWidget(
                  cards: [
                    StatCardModel(
                      title: "Total Items",
                      value: "120",
                      subtitle: "Total items in stock",
                      iconData: Icons.home,
                      gradientColors: [
                        const Color(0xffC084FC),
                        const Color(0xffA855F7),
                      ],
                    ),
                    StatCardModel(
                      title: "Low Stock Items",
                      value: "8",
                      subtitle: "Number of items that are running low",
                      iconData: Icons.home,
                      gradientColors: [
                        const Color(0xff60A5FA),
                        const Color(0xff3B82F6),
                      ],
                    ),
                    StatCardModel(
                      title: "In Stock Items",
                      value: "40",
                      subtitle: "Number of items past their expiration date",
                      iconData: Icons.home,
                      gradientColors: [
                        const Color(0xff4ADE80),
                        const Color(0xff22C55E),
                      ],
                    ),
                    StatCardModel(
                      title: "Out of Stock Items",
                      value: "15",
                      subtitle: "Count of items currently out of stock",
                      iconData: Icons.home,
                      gradientColors: [
                        const Color(0xffF87171),
                        const Color(0xffEF4444),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.dp),
          Expanded(
            child: InvoiceDataTable(
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => InvoiceForm(
        existingInvoice: existingInvoice,
        onSubmit: (invoiceData) {
          invoiceStore.addInvoice(invoiceData);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invoice ${invoiceData.invoiceId} added')),
          );
          Navigator.pop(context); // Close bottom sheet
        },
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
