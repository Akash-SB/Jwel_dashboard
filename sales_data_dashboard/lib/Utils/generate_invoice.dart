import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/invoice_model.dart';
import 'package:intl/intl.dart';

Future<void> generateTransactionInvoicePdf(
    InvoiceModel tx, final BuildContext context) async {
  final pdf = pw.Document();

  // Load logo
  final ByteData logoData = await rootBundle.load('assets/logo.jpg');
  final Uint8List logoBytes = logoData.buffer.asUint8List();
  final robotoFont =
      pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf'));

  // Financial calculations
  final double qty = double.tryParse(tx.size) ?? 0;
  final double rate = double.tryParse(tx.rate) ?? 0;
  final double baseAmount = double.tryParse(tx.amount) ?? (qty * rate);

  const double gstRate = 0.0025; // 0.25%
  final double gstAmount = baseAmount * gstRate;
  final double rawTotal = baseAmount + gstAmount;
  final double roundOff = rawTotal.roundToDouble() - rawTotal;
  final double grandTotal = rawTotal + roundOff;

  // Convert total to words
  final formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
  final totalInWords =
      "INR ${NumberFormat.compact().format(grandTotal)} Only"; // optional: use a words converter

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(24),
      build: (context) => [
        // Header
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Image(pw.MemoryImage(logoBytes), width: 80),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text("Your Company Name",
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    )),
                pw.Text("GSTIN: 27ABCDE1234F1Z5"),
                pw.Text("Phone: +91-9999999999"),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 20),

        // Invoice and customer info
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Invoice No: ${tx.invoiceId}"),
                pw.Text("Date: ${tx.date}"),
                pw.Text("Transaction Type: ${tx.transactionType.name}"),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text("Customer: ${tx.custName}",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("Customer Type: ${tx.custType.name}"),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 20),

        // Item Table Header
        pw.TableHelper.fromTextArray(
          border: pw.TableBorder.all(),
          headerStyle:
              pw.TextStyle(fontWeight: pw.FontWeight.bold, font: robotoFont),
          cellStyle: pw.TextStyle(
            font: robotoFont,
            fontSize: 10,
          ),
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
              tx.productName ?? 'N/A',
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
              '0.25 %',
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

        // Footer total row
        pw.Container(
          alignment: pw.Alignment.centerRight,
          padding: pw.EdgeInsets.only(top: 12),
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

        // Amount in words
        pw.SizedBox(height: 16),
        pw.Text("Amount Chargeable (in words)",
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        pw.Text(convertNumberToWords(grandTotal.round()),
            style: pw.TextStyle(fontSize: 10, font: robotoFont)),

        pw.SizedBox(height: 20),
        pw.Text("E. & O.E",
            style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic)),

        pw.SizedBox(height: 30),
        pw.Text("Thank you for your business!",
            style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
      ],
    ),
  );

  // Preview and Save
  await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Invoice ${tx.invoiceId} Created')),
  );
}

String convertNumberToWords(int number) {
  if (number == 0) return 'Zero Rupees Only';

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

  String convertBelowThousand(int n) {
    String str = '';

    if (n >= 100) {
      str += '${units[n ~/ 100]} Hundred ';
      n %= 100;
    }

    if (n >= 10 && n <= 19) {
      str += '${teens[n - 10]} ';
    } else if (n >= 20) {
      str += '${tens[n ~/ 10]} ';
      if (n % 10 > 0) str += '${units[n % 10]} ';
    } else if (n > 0) {
      str += '${units[n]} ';
    }

    return str.trim();
  }

  final parts = <String>[];

  if ((number ~/ 10000000) > 0) {
    parts.add('${convertBelowThousand(number ~/ 10000000)} Crore');
    number %= 10000000;
  }
  if ((number ~/ 100000) > 0) {
    parts.add('${convertBelowThousand(number ~/ 100000)} Lakh');
    number %= 100000;
  }
  if ((number ~/ 1000) > 0) {
    parts.add('${convertBelowThousand(number ~/ 1000)} Thousand');
    number %= 1000;
  }
  if ((number ~/ 100) > 0) {
    parts.add('${convertBelowThousand(number ~/ 100)} Hundred');
    number %= 100;
  }
  if (number > 0) {
    parts.add(convertBelowThousand(number));
  }

  return parts.join(' ') + ' Rupees Only';
}
