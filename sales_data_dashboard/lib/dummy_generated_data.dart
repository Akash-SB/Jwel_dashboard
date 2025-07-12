import 'dart:math';

import 'package:sales_data_dashboard/models/invoice_model.dart';

import 'models/app_enum.dart';

List<InvoiceModel> generateDummyTransactions() {
  final now = DateTime.now();
  final random = Random();

  List<InvoiceModel> dummy = [];

  for (int i = 0; i < 6; i++) {
    final date = DateTime(now.year, now.month - i, 15);
    dummy.addAll([
      InvoiceModel(
        invoiceId: "INV${i}A",
        date: date.toIso8601String(),
        size: "10",
        rate: "500",
        amount: (10000 + i * 1000).toString(),
        productIds: [1, 2],
        transactionType: TransactionTypeEnum.sell,
        custType: UsertypeEnum.company,
        custName: "Client $i",
        paymentStatus: PaymentStatusEnum.paid,
        paymentType: PaymentTypeEnum.cash,
        note: "Sell note",
      ),
      InvoiceModel(
        invoiceId: "INV${i}B",
        date: date.toIso8601String(),
        size: "5",
        rate: "300",
        amount: (7000 + i * 800).toString(),
        productIds: [3],
        transactionType: TransactionTypeEnum.purchase,
        custType: UsertypeEnum.broker,
        custName: "Vendor $i",
        paymentStatus: PaymentStatusEnum.unpaid,
        paymentType: PaymentTypeEnum.online,
        note: "Purchase note",
      ),
    ]);
  }

  return dummy;
}
