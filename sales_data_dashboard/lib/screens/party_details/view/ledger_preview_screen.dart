import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sales_data_dashboard/screens/party_details/view/party_ledger.dart';

import '../../../models/app_enum.dart';
import '../../../models/party_model.dart';

class LedgerPreviewScreen extends StatelessWidget {
  final Party party;
  final Map<String, MonthlyLedger> ledgerMap;

  const LedgerPreviewScreen({
    super.key,
    required this.party,
    required this.ledgerMap,
  });

  @override
  Widget build(BuildContext context) {
    final months = ledgerMap.keys.toList();

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${party.name} Ledger",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.download),
                label: const Text("Download Month PDF"),
                onPressed: () async {
                  final months = ledgerMap.keys.toList();
                  final selected = await pickMonth(context, months);

                  if (selected != null) {
                    final ledger = ledgerMap[selected]!;
                    await saveSingleMonthLedgerPdf(
                        party, selected, ledger, context);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: months.length,
              itemBuilder: (context, index) {
                final monthKey = months[index];
                final monthLedger = ledgerMap[monthKey]!;

                return Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Month Title
                      Text(
                        monthKey,
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// Opening Balance
                      Text(
                        "Opening Balance: ₹${monthLedger.openingBalance.toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),

                      const SizedBox(height: 12),

                      /// Transactions
                      ...monthLedger.entries.map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${e.date.day}-${e.date.month}-${e.date.year}",
                                  style: const TextStyle(color: Colors.black87),
                                ),
                                Text(
                                  (e.nature == PaymentNature.credit
                                          ? "+ ₹"
                                          : "- ₹") +
                                      e.amount.toStringAsFixed(2),
                                  style: TextStyle(
                                    color: e.nature == PaymentNature.credit
                                        ? Colors.green.shade700
                                        : Colors.red.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),

                      const Divider(height: 22),

                      /// Closing Balance
                      Text(
                        "Closing Balance: ₹${monthLedger.closingBalance.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<String?> pickMonth(BuildContext context, List<String> months) async {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Select Month"),
        content: SizedBox(
          width: 300,
          child: ListView(
            shrinkWrap: true,
            children: months.map((m) {
              return ListTile(
                title: Text(m),
                onTap: () => Navigator.pop(context, m),
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}

Future<void> saveSingleMonthLedgerPdf(
  Party party,
  String monthName,
  MonthlyLedger ledger,
  BuildContext context,
) async {
  final pdf = pw.Document();
  final robotoFont =
      pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf'));
  final formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      build: (pw.Context ctx) {
        return [
          pw.Center(
            child: pw.Text(
              "${party.name} – $monthName Ledger",
              style: pw.TextStyle(
                fontSize: 22,
                fontWeight: pw.FontWeight.bold,
                font: robotoFont,
              ),
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "Opening Balance: ${formatter.format(ledger.openingBalance)}",
            style: pw.TextStyle(fontSize: 14, font: robotoFont),
          ),
          pw.SizedBox(height: 12),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(6),
                    child:
                        pw.Text("Date", style: pw.TextStyle(font: robotoFont)),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(6),
                    child:
                        pw.Text("Type", style: pw.TextStyle(font: robotoFont)),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(6),
                    child: pw.Text("Amount",
                        style: pw.TextStyle(font: robotoFont)),
                  ),
                ],
              ),
              ...ledger.entries.map((e) {
                return pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.all(6),
                      child: pw.Text(
                        "${e.date.day}-${e.date.month}-${e.date.year}",
                        style: pw.TextStyle(font: robotoFont),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(6),
                      child: pw.Text(
                        e.nature == PaymentNature.credit ? "Credit" : "Debit",
                        style: pw.TextStyle(font: robotoFont),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(6),
                      child: pw.Text(
                        (e.nature == PaymentNature.credit ? "+" : "-") +
                            formatter.format(e.amount),
                        style: pw.TextStyle(font: robotoFont),
                      ),
                    ),
                  ],
                );
              })
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "Closing Balance: ${formatter.format(ledger.closingBalance)}",
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              font: robotoFont,
            ),
          ),
        ];
      },
    ),
  );

  // SAVE TO DOWNLOAD FOLDER
  Directory? downloads;

  if (Platform.isAndroid) {
    downloads = Directory("/storage/emulated/0/Download");
  } else if (Platform.isWindows) {
    downloads = await getDownloadsDirectory();
  } else {
    downloads = await getApplicationDocumentsDirectory();
  }

  final filePath = "${downloads!.path}/${party.name}_${monthName}_ledger.pdf"
      .replaceAll(" ", "_");

  final file = File(filePath);
  await file.writeAsBytes(await pdf.save()).then((value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'PDF saved to Downloads as ${party.name}_${monthName}_ledger.pdf')),
    );
  });
}
