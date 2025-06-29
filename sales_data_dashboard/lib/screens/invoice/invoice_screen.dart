import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import '../../models/app_enum.dart' as app_enum;
import '../../models/invoice_model.dart';
import '../../widgets/invoice_form_widget.dart';
import '../../widgets/stat_card_grid_widget.dart';
import 'invoice_data_table.dart';

final List<Map<String, dynamic>> invoiceList = [
  {
    'invoiceId': 'INV001',
    'date': '2025-06-01',
    'carat': '5',
    'rate': '12000',
    'amount': '60000',
    'productIds': [1, 2],
    'transactionType': app_enum.TransactionTypeEnum.sale,
    'custType': app_enum.UsertypeEnum.company,
    'custName': 'Royal Jewels',
    'paymentStatus': app_enum.PaymentStatusEnum.paid,
    'paymentType': app_enum.PaymentTypeEnum.cash,
    'note': 'Delivered on time'
  },
  {
    'invoiceId': 'INV002',
    'date': '2025-06-03',
    'carat': '3',
    'rate': '8000',
    'amount': '24000',
    'productIds': [3],
    'transactionType': app_enum.TransactionTypeEnum.purchase,
    'custType': app_enum.UsertypeEnum.broker,
    'custName': 'Gem Broker Co.',
    'paymentStatus': app_enum.PaymentStatusEnum.unpaid,
    'paymentType': app_enum.PaymentTypeEnum.cheque,
    'note': 'Cheque clearance pending'
  },
  {
    'invoiceId': 'INV003',
    'date': '2025-06-05',
    'carat': '7',
    'rate': '15000',
    'amount': '105000',
    'productIds': [4, 5],
    'transactionType': app_enum.TransactionTypeEnum.sale,
    'custType': app_enum.UsertypeEnum.company,
    'custName': 'Diamond World',
    'paymentStatus': app_enum.PaymentStatusEnum.paid,
    'paymentType': app_enum.PaymentTypeEnum.online,
    'note': null
  }
];

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
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
              data: invoiceList, // from the mock list or Firestore
              onDelete: (invoice) => _confirmDelete(context, invoice),
              onEdit: (invoice) => _openInvoiceForm(context, invoice),
              onExportPDF: () {
                // TODO: Implement PDF export
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exporting to PDF...')),
                );
              },
              onExportExcel: () {
                // TODO: Implement Excel export
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
            fontSize: 8,
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

  void _openInvoiceForm(BuildContext context,
      [Map<String, dynamic>? existingInvoice]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => InvoiceForm(
        existingInvoice: existingInvoice, // null for Add, pass Map for Edit
        onSubmit: (invoiceData) {
          // Example: add to your list or push to Firestore
          setState(() {
            if (existingInvoice != null) {
              final index = invoiceList.indexWhere(
                  (i) => i['invoiceId'] == existingInvoice['invoiceId']);
              invoiceList[index] = invoiceData;
            } else {
              invoiceList.add(invoiceData);
            }
          });

          Navigator.pop(context); // Close bottom sheet
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, Map<String, dynamic> invoice) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Invoice'),
        content: Text(
            'Are you sure you want to delete invoice ${invoice['invoiceId']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                invoiceList
                    .removeWhere((i) => i['invoiceId'] == invoice['invoiceId']);
              });
              Navigator.pop(ctx);
            },
            child: Text('Yes, Delete'),
          ),
        ],
      ),
    );
  }
}
