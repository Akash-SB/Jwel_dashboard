import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sales_data_dashboard/models/party_model.dart';
import 'package:sales_data_dashboard/models/stock_party_ledger.dart';

/// Ledger Entry Model
class LedgerEntry {
  final DateTime date;
  final String particulars;
  final double? debit; // Money owed to you
  final double? credit; // Money you paid or received
  final String voucherNo;
  final String voucherType;

  LedgerEntry({
    required this.date,
    required this.particulars,
    this.debit,
    this.credit,
    required this.voucherNo,
    required this.voucherType,
  });

  Map<String, dynamic> toMap() => {
        'date': date.toIso8601String(),
        'particulars': particulars,
        'debit': debit,
        'credit': credit,
        'voucherNo': voucherNo,
        'voucherType': voucherType,
      };
}

/// Ledger Model
class Ledger {
  final String customerId;
  final String customerName;
  final DateTime fromDate;
  final DateTime toDate;
  final double openingBalance;
  final double closingBalance;
  final List<LedgerEntry> entries;

  Ledger({
    required this.customerId,
    required this.customerName,
    required this.fromDate,
    required this.toDate,
    this.openingBalance = 0.0,
    this.closingBalance = 0.0,
    required this.entries,
  });

  Map<String, dynamic> toMap() => {
        'customerId': customerId,
        'customerName': customerName,
        'fromDate': fromDate.toIso8601String(),
        'toDate': toDate.toIso8601String(),
        'openingBalance': openingBalance,
        'closingBalance': closingBalance,
        'entries': entries.map((e) => e.toMap()).toList(),
      };
}

/// Ledger Service
class LedgerService {
  /// Calculate opening balance before the given period
  static double calculateOpeningBalance({
    required String customerId,
    required DateTime fromDate,
    required List<StockPartyLedger> allEntries,
  }) {
    double balance = 0.0;

    for (var entry in allEntries.where(
        (e) => e.customerId == customerId && e.createdAt.isBefore(fromDate))) {
      final amount = double.tryParse(entry.amount) ?? 0.0;

      if (entry.transType == TransType.sale.name) {
        balance += amount;
        if (entry.paymentStatus.toLowerCase() == "paid") {
          balance -= amount;
        }
      } else if (entry.transType == TransType.purchase.name) {
        balance -= amount;
      }
    }

    return balance;
  }

  /// Generate ledger for a specific customer
  static Ledger generateLedger({
    required String customerId,
    required String customerName,
    required DateTime fromDate,
    required DateTime toDate,
    required List<StockPartyLedger> allEntries,
  }) {
    double openingBalance = calculateOpeningBalance(
      customerId: customerId,
      fromDate: fromDate,
      allEntries: allEntries,
    );

    List<LedgerEntry> entries = [];

    for (var entry in allEntries.where((e) =>
        e.customerId == customerId &&
        e.createdAt.isAfter(fromDate.subtract(const Duration(days: 1))) &&
        e.createdAt.isBefore(toDate.add(const Duration(days: 1))))) {
      final amount = double.tryParse(entry.amount) ?? 0.0;

      if (entry.transType == TransType.sale.name) {
        // Sale → Debit
        entries.add(LedgerEntry(
          date: entry.createdAt,
          particulars: "Sale: ${entry.productId}",
          debit: amount,
          credit: null,
          voucherNo: entry.id,
          voucherType: "Sale",
        ));

        if (entry.paymentStatus.toLowerCase() == "paid") {
          entries.add(LedgerEntry(
            date: entry.createdAt,
            particulars: "Payment Received (${entry.paymentOption ?? 'N/A'})",
            debit: null,
            credit: amount,
            voucherNo: entry.id,
            voucherType: "Receipt",
          ));
        }
      } else if (entry.transType == TransType.purchase.name) {
        // Purchase → Credit
        entries.add(LedgerEntry(
          date: entry.createdAt,
          particulars: "Purchase: ${entry.productId}",
          debit: null,
          credit: amount,
          voucherNo: entry.id,
          voucherType: "Purchase",
        ));
      }
    }

    // Sort by date
    entries.sort((a, b) => a.date.compareTo(b.date));

    // Calculate closing balance
    double runningBalance = openingBalance;
    for (var e in entries) {
      if (e.debit != null) runningBalance += e.debit!;
      if (e.credit != null) runningBalance -= e.credit!;
    }

    return Ledger(
      customerId: customerId,
      customerName: customerName,
      fromDate: fromDate,
      toDate: toDate,
      openingBalance: openingBalance,
      closingBalance: runningBalance,
      entries: entries,
    );
  }
}

Future<void> generateStyledLedgerPDF({
  required Party party,
  required List<StockPartyLedger> allEntries,
  required DateTime fromDate,
  required DateTime toDate,
  required String firmName,
  required String firmAddress,
}) async {
  final ledger = LedgerService.generateLedger(
    customerId: party.id,
    customerName: party.name,
    fromDate: fromDate,
    toDate: toDate,
    allEntries: allEntries,
  );

  final pdf = pw.Document();
  final dateFormatter = DateFormat('dd-MMM-yyyy');

  double runningBalance = ledger.openingBalance;
  double totalDebit = 0;
  double totalCredit = 0;

  final tableData = <List<String>>[];

  // Opening Balance
  tableData.add([
    dateFormatter.format(fromDate),
    'Opening Balance',
    '',
    runningBalance > 0 ? runningBalance.toStringAsFixed(2) : '',
    runningBalance < 0 ? (-runningBalance).toStringAsFixed(2) : '',
    '',
    '',
  ]);

  // Ledger entries
  for (var entry in ledger.entries) {
    if (entry.debit != null) {
      runningBalance += entry.debit!;
      totalDebit += entry.debit!;
    }
    if (entry.credit != null) {
      runningBalance -= entry.credit!;
      totalCredit += entry.credit!;
    }

    tableData.add([
      dateFormatter.format(entry.date),
      entry.particulars,
      entry.credit?.toStringAsFixed(2) ?? '',
      entry.debit?.toStringAsFixed(2) ?? '',
      entry.voucherNo,
      entry.voucherType,
      runningBalance.toStringAsFixed(2),
    ]);
  }

  // Closing Balance
  tableData.add([
    dateFormatter.format(toDate),
    'Closing Balance',
    '',
    runningBalance > 0 ? runningBalance.toStringAsFixed(2) : '',
    runningBalance < 0 ? (-runningBalance).toStringAsFixed(2) : '',
    '',
    '',
  ]);

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            pw.Text(firmName,
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.Text(firmAddress),
            pw.SizedBox(height: 10),
            pw.Text("${party.name} - Ledger Account",
                style: pw.TextStyle(fontSize: 14)),
            if (party.address != null) pw.Text(party.address!),
            pw.SizedBox(height: 5),
            pw.Text(
                "${dateFormatter.format(fromDate)} to ${dateFormatter.format(toDate)}"),
            pw.SizedBox(height: 20),

            // Table
            pw.Table.fromTextArray(
              border: pw.TableBorder.all(width: 0.5),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey300),
              cellAlignment: pw.Alignment.centerLeft,
              headers: [
                'Date',
                'Particulars',
                'Credit',
                'Debit',
                'Vch No.',
                'Vch Type',
                'Balance'
              ],
              data: tableData,
              cellAlignments: {
                2: pw.Alignment.centerRight, // Credit
                3: pw.Alignment.centerRight, // Debit
                6: pw.Alignment.centerRight, // Balance
              },
            ),

            pw.SizedBox(height: 15),
            pw.Text(
              "Total Debit: ${totalDebit.toStringAsFixed(2)}    |    Total Credit: ${totalCredit.toStringAsFixed(2)}",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              "Closing Balance: ${runningBalance.toStringAsFixed(2)}",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ],
        )
      ],
    ),
  );

  final dir = await getTemporaryDirectory();
  final file = File("${dir.path}/Ledger_${party.name}.pdf");
  await file.writeAsBytes(await pdf.save());
  await Printing.sharePdf(
      bytes: await pdf.save(), filename: "Ledger_${party.name}.pdf");
}
