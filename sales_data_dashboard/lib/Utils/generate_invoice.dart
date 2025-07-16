import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/screens/invoice/invoice_screen.dart';
import '../models/invoice_model.dart';

/// Generate PDF as bytes
Future<Uint8List> generateTransactionInvoicePdfBytes(
    InvoiceModel tx, CompanyModel selectedParentCompany) async {
  final pdf = pw.Document();

  // Load logo
  final ByteData logoData = await rootBundle.load('assets/logo.png');
  final Uint8List logoBytes = logoData.buffer.asUint8List();

  // Load font for ₹ symbol
  final robotoFont =
      pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf'));

  // Calculations
  final double qty = double.tryParse(tx.size) ?? 0;
  final double rate = double.tryParse(tx.rate) ?? 0;
  final double baseAmount = double.tryParse(tx.amount) ?? (qty * rate);

  const double gstRate = 0.0025; // 0.25%
  final double gstAmount = baseAmount * gstRate;
  final double rawTotal = baseAmount + gstAmount;
  final double roundOff = rawTotal.roundToDouble() - rawTotal;
  final double grandTotal = rawTotal + roundOff;

  final formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      build: (context) => [
        // Header
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Image(pw.MemoryImage(logoBytes), width: 80),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(selectedParentCompany.name,
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        font: robotoFont)),
                pw.Text("GSTIN: ${selectedParentCompany.gstin}",
                    style: pw.TextStyle(font: robotoFont)),
                pw.Text("Phone: ${selectedParentCompany.phone}",
                    style: pw.TextStyle(font: robotoFont)),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 20),

        // Invoice info
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Invoice No: ${tx.invoiceId}",
                    style: pw.TextStyle(font: robotoFont)),
                pw.Text("Date: ${tx.date}",
                    style: pw.TextStyle(font: robotoFont)),
                pw.Text("Transaction Type: ${tx.transactionType.name}",
                    style: pw.TextStyle(font: robotoFont)),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text("Customer: ${tx.custName}",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, font: robotoFont)),
                pw.Text("Customer Type: ${tx.custType.name}",
                    style: pw.TextStyle(font: robotoFont)),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 20),

        // Table
        pw.TableHelper.fromTextArray(
          border: pw.TableBorder.all(),
          headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold, font: robotoFont, fontSize: 10),
          cellStyle: pw.TextStyle(font: robotoFont, fontSize: 9),
          cellAlignments: {
            0: pw.Alignment.center,
            1: pw.Alignment.centerLeft,
            2: pw.Alignment.center,
            3: pw.Alignment.centerRight,
            4: pw.Alignment.centerRight,
            5: pw.Alignment.center,
            6: pw.Alignment.centerRight,
          },
          headers: [
            'Sl No',
            'Description of Goods',
            'HSN/SAC',
            'Quantity',
            'Rate',
            'per',
            'Amount'
          ],
          data: [
            [
              '1',
              tx.note ?? 'Goods',
              tx.hsnCode,
              '${tx.size} Carat',
              tx.rate,
              'Carat',
              formatter.format(baseAmount),
            ],
            [
              '',
              'IGST',
              '',
              '',
              '0.25%',
              '',
              formatter.format(gstAmount),
            ],
            [
              '',
              'ROUND OFF',
              '',
              '',
              '',
              '',
              formatter.format(roundOff),
            ],
          ],
        ),

        // Total
        pw.Container(
          alignment: pw.Alignment.centerRight,
          padding: const pw.EdgeInsets.only(top: 12),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text("Total: ",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                      font: robotoFont)),
              pw.SizedBox(width: 10),
              pw.Text(formatter.format(grandTotal),
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14,
                      font: robotoFont)),
            ],
          ),
        ),

        pw.SizedBox(height: 16),
        pw.Text("Amount Chargeable (in words):",
            style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                font: robotoFont)),
        pw.Text(convertNumberToWords(grandTotal),
            style: pw.TextStyle(fontSize: 10, font: robotoFont)),

        pw.SizedBox(height: 20),
        pw.Text("E. & O.E",
            style: pw.TextStyle(
                fontSize: 10,
                fontStyle: pw.FontStyle.italic,
                font: robotoFont)),
        pw.SizedBox(height: 30),
        pw.Text("Thank you for your business!",
            style:
                pw.TextStyle(fontStyle: pw.FontStyle.italic, font: robotoFont)),
      ],
    ),
  );

  return pdf.save();
}

/// Show preview in a modal with download
Future<void> showInvoicePreview(
    BuildContext context, InvoiceModel tx, CompanyModel selectedCompany) async {
  final bytes = await generateTransactionInvoicePdfBytes(tx, selectedCompany);

  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Invoice Preview',
                      style: Theme.of(ctx).textTheme.titleLarge),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'Close',
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: PdfPreview(
              build: (format) async => bytes,
              canChangePageFormat: false,
              canChangeOrientation: false,
              allowPrinting: false,
              allowSharing: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Close')),
                SizedBox(width: 20.dp),
                ElevatedButton.icon(
                  icon: const Icon(Icons.download),
                  label: const Text('Download'),
                  onPressed: () async {
                    final file = File(
                        'C:/Users/Public/Downloads/invoice_${tx.invoiceId}.pdf');
                    await file.writeAsBytes(bytes).then((final onValue) {
                      Navigator.of(ctx).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Saved to ${file.path}')),
                      );
                    });
                  },
                ),
                SizedBox(width: 12.dp),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

/// Convert to words (handles rupees and paise)
String convertNumberToWords(double number) {
  int rupees = number.floor();
  int paise = ((number - rupees) * 100).round();
  String words = _convertIntToWords(rupees) + ' Rupees';
  if (paise > 0) {
    words += ' and ${_convertIntToWords(paise)} Paise';
  }
  return words + ' Only';
}

String _convertIntToWords(int number) {
  if (number == 0) return 'Zero';

  final units = [
    '',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine'
  ];
  final teens = [
    'Ten',
    'Eleven',
    'Twelve',
    'Thirteen',
    'Fourteen',
    'Fifteen',
    'Sixteen',
    'Seventeen',
    'Eighteen',
    'Nineteen'
  ];
  final tens = [
    '',
    '',
    'Twenty',
    'Thirty',
    'Forty',
    'Fifty',
    'Sixty',
    'Seventy',
    'Eighty',
    'Ninety'
  ];

  String part(int n) {
    String s = '';
    if (n >= 100) {
      s += '${units[n ~/ 100]} Hundred ';
      n %= 100;
    }
    if (n >= 20) {
      s += '${tens[n ~/ 10]} ';
      if (n % 10 > 0) s += '${units[n % 10]} ';
    } else if (n >= 10) {
      s += '${teens[n - 10]} ';
    } else if (n > 0) {
      s += '${units[n]} ';
    }
    return s.trim();
  }

  String words = '';
  if ((number ~/ 10000000) > 0) {
    words += '${part(number ~/ 10000000)} Crore ';
    number %= 10000000;
  }
  if ((number ~/ 100000) > 0) {
    words += '${part(number ~/ 100000)} Lakh ';
    number %= 100000;
  }
  if ((number ~/ 1000) > 0) {
    words += '${part(number ~/ 1000)} Thousand ';
    number %= 1000;
  }
  if ((number ~/ 100) > 0) {
    words += '${part(number ~/ 100)} Hundred ';
    number %= 100;
  }
  if (number > 0) {
    words += part(number);
  }
  return words.trim();
}

Future<CompanyModel?> showCompanyPicker(
    BuildContext context, List<CompanyModel> companies) async {
  CompanyModel? selectedCompany;

  return showDialog<CompanyModel>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text('Select Company'),
        content: StatefulBuilder(
          builder: (ctx, setState) {
            return DropdownButtonFormField<CompanyModel>(
              decoration: const InputDecoration(labelText: 'Company'),
              value: selectedCompany,
              items: companies.map((c) {
                return DropdownMenuItem<CompanyModel>(
                  value: c,
                  child: Text(c.name),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedCompany = val;
                });
              },
              validator: (val) =>
                  val == null ? 'Please select a company' : null,
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedCompany != null) {
                Navigator.of(ctx).pop(selectedCompany);
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
