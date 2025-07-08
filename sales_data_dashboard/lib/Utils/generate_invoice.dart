import 'dart:io';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../Models/product_model.dart';
import '../models/invoice_model.dart';

Future<void> generateTransactionInvoicePdf(
    InvoiceModel tx, List<ProductModel> products) async {
  final pdf = pw.Document();
  final ByteData bytes = await rootBundle.load('assets/images/logo.png');
  final Uint8List logoBytes = bytes.buffer.asUint8List();

  double totalAmount = 0;

  for (var p in products) {
    totalAmount += double.tryParse(p.amount) ?? 0;
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (context) => [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Image(pw.MemoryImage(logoBytes), width: 80),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text("Your Company Name",
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.Text("123 Business Street"),
                pw.Text("City, State, ZIP"),
                pw.Text("Phone: +91 9999999999"),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Divider(),

        // Invoice & Customer Info
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Invoice ID: ${tx.invoiceId}"),
                pw.Text("Date: ${tx.date}"),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text("Customer: ${tx.custName}",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("Type: ${tx.custType.name}"),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 20),

        // Products Table
        pw.Text("Products",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16)),
        pw.TableHelper.fromTextArray(
          border: pw.TableBorder.all(),
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          headers: ['Name', 'HSN', 'Size', 'Carat', 'Rate', 'Amount'],
          data: products
              .map((p) => [
                    p.prodName,
                    p.hsnCode,
                    p.size,
                    p.rate,
                    p.amount,
                  ])
              .toList(),
        ),

        pw.SizedBox(height: 20),

        // Totals
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Total Amount: ₹${totalAmount.toStringAsFixed(2)}",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 20),

        // Payment Info
        pw.Text("Payment Status: ${tx.paymentStatus.name}"),
        if (tx.paymentType != null)
          pw.Text("Payment Type: ${tx.paymentType!.name}"),

        pw.SizedBox(height: 30),
        pw.Text("Thank you for your business!",
            style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
      ],
    ),
  );

  // Show preview (print or save)
  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );

  // Optional: Save as file on Windows
  final file = File('invoice_${tx.invoiceId}.pdf');
  await file.writeAsBytes(await pdf.save());
}
