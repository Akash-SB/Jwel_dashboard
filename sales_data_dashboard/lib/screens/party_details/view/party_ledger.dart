import '../../../models/app_enum.dart';
import '../../../models/payment_model.dart';

class LedgerEntry {
  final String id;
  final DateTime date;
  final double amount;
  final PaymentNature nature; // credit/debit

  LedgerEntry({
    required this.id,
    required this.date,
    required this.amount,
    required this.nature,
  });
}

LedgerEntry toLedger(PaymentModel payment) {
  return LedgerEntry(
    id: payment.id,
    date: payment.date ?? DateTime.now(),
    amount: payment.amount,
    nature: payment.paymentNature, // credit / debit
  );
}

class LedgerCalculator {
  /// Input: List of ALL payments of a specific party
  /// Output: Map<YYYY-MM, MonthlyLedger>
  static Map<String, MonthlyLedger> calculateLedger(
      List<PaymentModel> payments) {
    payments.sort((a, b) => a.date!.compareTo(b.date!));

    double runningBalance = 0;
    final Map<String, MonthlyLedger> ledger = {};

    for (final p in payments) {
      final entry = toLedger(p);

      // month key: "2025-03"
      final monthKey =
          "${entry.date.year}-${entry.date.month.toString().padLeft(2, '0')}";

      ledger.putIfAbsent(
        monthKey,
        () => MonthlyLedger(
          month: monthKey,
          entries: [],
          openingBalance: runningBalance,
          closingBalance: 0,
        ),
      );

      ledger[monthKey]!.entries.add(entry);

      // update balance
      if (entry.nature == PaymentNature.credit) {
        runningBalance += entry.amount;
      } else {
        runningBalance -= entry.amount;
      }

      ledger[monthKey]!.closingBalance = runningBalance;
    }

    return ledger;
  }
}

class MonthlyLedger {
  final String month; // "2025-03"
  final List<LedgerEntry> entries;
  final double openingBalance;
  double closingBalance;

  MonthlyLedger({
    required this.month,
    required this.entries,
    required this.openingBalance,
    required this.closingBalance,
  });
}
