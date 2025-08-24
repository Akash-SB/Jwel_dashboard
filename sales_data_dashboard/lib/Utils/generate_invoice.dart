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
  const double cgstRate = 0.00125; // 0.125% for CGST
  const double sgstRate = 0.00125; // 0.125% for SGST
  final double gstAmount = baseAmount * gstRate;
  final double cgst = baseAmount * cgstRate;
  final double sgst = baseAmount * sgstRate;
  final double rawTotal = baseAmount + gstAmount;
  final double roundOff = rawTotal.roundToDouble() - rawTotal;
  final double grandTotal = rawTotal + roundOff;

  final formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(16),
      header: (context) {
        // ✅ HEADER with logo and company name
        return pw.Container(
          color: PdfColor.fromInt(0xFF5D639E), // Light navy blue shade
          padding: const pw.EdgeInsets.all(8),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Row(children: [
                pw.Image(pw.MemoryImage(logoBytes), width: 50, height: 50),
                pw.SizedBox(width: 8),
                pw.Text(
                  selectedParentCompany.name,
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    font: robotoFont,
                    color: PdfColor.fromInt(0xFFFFD700),
                  ),
                ),
              ]),
              pw.SizedBox(
                width: 150,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Dealers in :",
                        style: pw.TextStyle(
                          fontSize: 7,
                          font: robotoFont,
                          color: PdfColor.fromInt(0xFFFFD700),
                        )),
                    pw.SizedBox(height: 8),
                    pw.Text(
                        "Real Diamond & Colour Stones Jewellery, Precious Stones, Semi Precious Stones Jewellery, Fancy Gold Ornament, Wholesale Temple Jewellery",
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 7,
                          font: robotoFont,
                          color: PdfColors.white,
                        )),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      build: (context) => [
        pw.SizedBox(height: 10),
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(),
          ),
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Center(
                    child: pw.Text('GST INVOICE',
                        style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                            font: robotoFont))),
                pw.Text('(U/S - 31(1) of CGST Act, 2017 read with Rule 1)',
                    style: pw.TextStyle(fontSize: 8, font: robotoFont)),
              ]),
        ),
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(),
          ),
          child: pw.Center(
            child: pw.Text('Cash / Credit',
                style: pw.TextStyle(fontSize: 8, font: robotoFont)),
          ),
        ),

        // ✅ INVOICE INFO BLOCK
        pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Left block
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black))),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Invoice No : ${tx.invoiceId}",
                          style: pw.TextStyle(font: robotoFont, fontSize: 9)),
                      pw.Text("Invoice Date : ${tx.date}",
                          style: pw.TextStyle(font: robotoFont, fontSize: 9)),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("State : Maharashtra",
                                style: pw.TextStyle(
                                    font: robotoFont, fontSize: 9)),
                            pw.Text("State Code : 27",
                                style: pw.TextStyle(
                                    font: robotoFont, fontSize: 9)),
                          ]),
                    ],
                  ),
                ),
              ),
              // Right block
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("GSTIN NO : ${selectedParentCompany.gstin}",
                          style: pw.TextStyle(font: robotoFont, fontSize: 9)),
                      pw.Text("PAN NO : ${selectedParentCompany.panNumber}",
                          style: pw.TextStyle(font: robotoFont, fontSize: 9)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // ✅ RECIPIENT BLOCK
        pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black))),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Detail of Recipient :",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: robotoFont,
                              fontSize: 9)),
                      pw.SizedBox(height: 4),
                      pw.Text(tx.custName,
                          style: pw.TextStyle(
                            font: robotoFont,
                            fontSize: 9,
                            fontWeight: pw.FontWeight.bold,
                          )),
                      pw.SizedBox(height: 4),
                      pw.SizedBox(
                        width: 200,
                        child: pw.Text('Address: ${tx.custAddress ?? ''}',
                            style: pw.TextStyle(font: robotoFont, fontSize: 9)),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text('GSTIN: ${tx.custGst ?? ''}',
                          style: pw.TextStyle(font: robotoFont, fontSize: 9)),
                      pw.SizedBox(height: 4),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("State : Maharashtra",
                                style: pw.TextStyle(
                                    font: robotoFont, fontSize: 9)),
                            pw.Text("State Code : 27",
                                style: pw.TextStyle(
                                    font: robotoFont, fontSize: 9)),
                          ]),
                    ],
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // pw.Text("PAYMENT TERMS: 30 DAYS",
                      //     style: pw.TextStyle(font: robotoFont, fontSize: 9)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // ✅ TABLE
        pw.Table(
          border: pw.TableBorder.all(width: 0.8),
          columnWidths: {
            0: const pw.FlexColumnWidth(0.6),
            1: const pw.FlexColumnWidth(3),
            2: const pw.FlexColumnWidth(1),
            3: const pw.FlexColumnWidth(0.8),
            4: const pw.FlexColumnWidth(0.8),
            5: const pw.FlexColumnWidth(1),
            6: const pw.FlexColumnWidth(1.2),
            7: const pw.FlexColumnWidth(1.2),
          },
          children: [
            // header
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey300),
              children: [
                headerCell('Sr. No', robotoFont),
                headerCell('Description of Goods/Services', robotoFont),
                headerCell('HSN/SAC', robotoFont),
                headerCell('Rate Per', robotoFont),
                headerCell('Quantity', robotoFont),
                headerCell('Rate', robotoFont),
                headerCell('Value', robotoFont),
                headerCell('Taxable Value', robotoFont),
              ],
            ),
            // single row
            pw.TableRow(
              children: [
                dataCell(
                  '1',
                  robotoFont,
                  contentPadding: const pw.EdgeInsets.only(
                      top: 4, bottom: 150, left: 4, right: 4),
                ),
                dataCell(
                  'CUT & POLISHED EMERALD',
                  robotoFont,
                  contentPadding: const pw.EdgeInsets.only(
                      top: 4, bottom: 150, left: 4, right: 4),
                ),
                dataCell(
                  tx.hsnCode,
                  robotoFont,
                  contentPadding: const pw.EdgeInsets.only(
                      top: 4, bottom: 150, left: 4, right: 4),
                ),
                dataCell(
                  'CTS.',
                  robotoFont,
                  contentPadding: const pw.EdgeInsets.only(
                      top: 4, bottom: 150, left: 4, right: 4),
                ),
                dataCell(
                  tx.size,
                  robotoFont,
                  contentPadding: const pw.EdgeInsets.only(
                      top: 4, bottom: 150, left: 4, right: 4),
                ),
                dataCell(
                  tx.rate,
                  robotoFont,
                  contentPadding: const pw.EdgeInsets.only(
                      top: 4, bottom: 150, left: 4, right: 4),
                ),
                dataCell(
                  tx.amount,
                  robotoFont,
                  contentPadding: const pw.EdgeInsets.only(
                      top: 4, bottom: 150, left: 4, right: 4),
                ),
                dataCell(
                  tx.amount,
                  robotoFont,
                  contentPadding: const pw.EdgeInsets.only(
                      top: 4, bottom: 150, left: 4, right: 4),
                ),
              ],
            ),
            // total row
            pw.TableRow(
              children: [
                dataCell('', robotoFont),
                dataCell('', robotoFont),
                dataCell('', robotoFont),
                dataCell('Total', robotoFont),
                dataCell(tx.size, robotoFont, bold: true),
                dataCell('', robotoFont),
                dataCell(formatter.format(baseAmount), robotoFont, bold: true),
                dataCell(formatter.format(baseAmount), robotoFont, bold: true),
              ],
            ),
          ],
        ),
        pw.Container(
          height: 20,
          width: double.infinity,
          decoration: pw.BoxDecoration(border: pw.Border.all()),
        ),
        pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Text(
                      "TOTAL INVOICE VALUE IN WORDS : ${convertNumberToWords(grandTotal)}",
                      style: pw.TextStyle(font: robotoFont, fontSize: 9),
                    ),
                  ),
                  pw.Container(
                      width: double.infinity,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: pw.BoxDecoration(border: pw.Border.all()),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('Bank Details:',
                                style: pw.TextStyle(
                                    font: robotoFont,
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 9)),
                            pw.Text(
                                'Bank Name : ${selectedParentCompany.bankName}',
                                style: pw.TextStyle(
                                    font: robotoFont, fontSize: 9)),
                            pw.Text(
                                'Bank Account No : ${selectedParentCompany.bankAccountNo}',
                                style: pw.TextStyle(
                                    font: robotoFont, fontSize: 9)),
                            pw.Text(
                                'Bank IFSC Code : ${selectedParentCompany.bankIfscCode}',
                                style: pw.TextStyle(
                                    font: robotoFont, fontSize: 9)),
                            pw.Text(
                                'Bank Branch : ${selectedParentCompany.bankBranch}',
                                style: pw.TextStyle(
                                    font: robotoFont, fontSize: 9)),
                          ])),
                  pw.Container(
                      width: double.infinity,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: pw.BoxDecoration(border: pw.Border.all()),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('Terms & Conditions:',
                                style: pw.TextStyle(
                                  font: robotoFont,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 8,
                                )),
                            pw.SizedBox(height: 8),
                            pw.Text(
                              'Certified that the particulars in given above are true and correct\nSubject to MUMBAI Jurisdiction',
                              style:
                                  pw.TextStyle(fontSize: 8, font: robotoFont),
                            ),
                          ]))
                ]),
              ),
              pw.Container(
                width: 200,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                  children: [
                    rowTax('TAXABLE VALUE', formatter.format(baseAmount),
                        robotoFont),
                    rowTax(
                        'Add CGST 0.125%', formatter.format(cgst), robotoFont),
                    rowTax(
                        'Add SGST 0.125%', formatter.format(sgst), robotoFont),
                    rowTax('Add IGST 0.25%', formatter.format(gstAmount),
                        robotoFont),
                    rowTax(
                        'Rounding Off', formatter.format(roundOff), robotoFont),
                    rowTax(
                        'TOTAL VALUE', formatter.format(grandTotal), robotoFont,
                        bold: true),
                    pw.Container(
                      height: 80,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: pw.BoxDecoration(border: pw.Border.all()),
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text('For ${selectedParentCompany.name}',
                              style: pw.TextStyle(
                                  font: robotoFont,
                                  fontSize: 9,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(height: 4),
                          pw.Text('Partner',
                              style:
                                  pw.TextStyle(font: robotoFont, fontSize: 9)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      footer: (context) {
        return pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.only(top: 8),
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              top: pw.BorderSide(width: 0.5, color: PdfColors.grey),
            ),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text('${selectedParentCompany.address}',
                  style: pw.TextStyle(
                      fontSize: 9, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 4),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text('Phone: ${selectedParentCompany.phone}',
                      style: pw.TextStyle(fontSize: 9)),
                  pw.SizedBox(width: 20),
                  pw.Text('Email: ${selectedParentCompany.email}',
                      style: pw.TextStyle(fontSize: 9)),
                ],
              ),
              pw.SizedBox(height: 8),
              // pw.Container(
              //   width: double.infinity,
              //   padding: const pw.EdgeInsets.only(top: 8),
              //   decoration: const pw.BoxDecoration(
              //     border: pw.Border(
              //       top: pw.BorderSide(width: 0.5, color: PdfColors.grey),
              //     ),
              //   ),
              //   child: pw.Text(
              //     'Bank Name : ${selectedParentCompany.bankName} | Bank Account No : ${selectedParentCompany.bankAccountNo} | Bank IFSC Code : ${selectedParentCompany.bankIfscCode} | Bank Branch : ${selectedParentCompany.bankBranch}',
              //     style: pw.TextStyle(fontSize: 8, font: robotoFont),
              //     textAlign: pw.TextAlign.center,
              //   ),
              // ),
            ],
          ),
        );
      },
    ),
  );

  return pdf.save();
}

pw.Widget headerCell(String text, pw.Font font) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(4),
    alignment: pw.Alignment.center,
    child: pw.Text(text,
        style: pw.TextStyle(
            font: font, fontSize: 8, fontWeight: pw.FontWeight.bold),
        textAlign: pw.TextAlign.center),
  );
}

pw.Widget dataCell(String text, pw.Font font,
    {bool bold = false, pw.EdgeInsetsGeometry? contentPadding}) {
  return pw.Container(
    padding: contentPadding ??
        const pw.EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
    alignment: pw.Alignment.topLeft,
    child: pw.Text(text,
        style: pw.TextStyle(
            font: font,
            fontSize: 8,
            fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal)),
  );
}

pw.Widget rowTax(String label, String value, pw.Font font,
    {bool bold = false}) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(4),
    decoration: pw.BoxDecoration(border: pw.Border.all()),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label,
            style: pw.TextStyle(
                font: font,
                fontSize: 8,
                fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal)),
        pw.Text(value,
            style: pw.TextStyle(
                font: font,
                fontSize: 8,
                fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal)),
      ],
    ),
  );
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
                    final downloadsPath = getDownloadsPath();
                    final file =
                        File('$downloadsPath/invoice_${tx.invoiceId}.pdf');
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

String getDownloadsPath() {
  final home =
      Platform.environment['USERPROFILE'] ?? Platform.environment['HOME'] ?? '';
  return '$home/Downloads';
}

/// Convert to words (handles rupees and paise)
String convertNumberToWords(double number) {
  int rupees = number.floor();
  int paise = ((number - rupees) * 100).round();
  String words = '${_convertIntToWords(rupees)} Rupees';
  if (paise > 0) {
    words += ' and ${_convertIntToWords(paise)} Paise';
  }
  return '$words Only';
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Text(
          'Select Company',
          style: TextStyle(
            fontSize: 20.dp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
        ),
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
          InkWell(
            onTap: () => Navigator.of(ctx).pop(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(
                  0xFFF3F4F6,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.dp),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8.dp,
                horizontal: 16.dp,
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 14.dp,
                  fontWeight: FontWeight.w600,
                  color: const Color(
                    0xFF374151,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12.dp,
          ),
          InkWell(
            onTap: () {
              if (selectedCompany != null) {
                Navigator.of(ctx).pop(selectedCompany);
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.dp),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8.dp,
                horizontal: 16.dp,
              ),
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 14.dp,
                  fontWeight: FontWeight.w700,
                  color: const Color(
                    0xFFFFFFFF,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
