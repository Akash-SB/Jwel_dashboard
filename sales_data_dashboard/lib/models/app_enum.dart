enum UsertypeEnum { broker, company }

enum TransactionTypeEnum {
  purchase,
  sell,
  all;
}

enum PaymentStatusEnum {
  paid,
  unpaid,
  all;

  String get name {
    switch (this) {
      case PaymentStatusEnum.paid:
        return "Paid";
      case PaymentStatusEnum.unpaid:
        return "Unpaid";
      case PaymentStatusEnum.all:
        return "All";
    }
  }
}

enum PaymentTypeEnum { cash, cheque, online, all }

enum LedgerTransactionType { credit, debit, openingBalance }
