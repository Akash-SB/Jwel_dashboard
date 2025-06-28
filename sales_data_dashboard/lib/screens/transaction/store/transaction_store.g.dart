// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransactionStore on _TransactionStore, Store {
  late final _$transactionsAtom =
      Atom(name: '_TransactionStore.transactions', context: context);

  @override
  ObservableList<TransactionModel> get transactions {
    _$transactionsAtom.reportRead();
    return super.transactions;
  }

  @override
  set transactions(ObservableList<TransactionModel> value) {
    _$transactionsAtom.reportWrite(value, super.transactions, () {
      super.transactions = value;
    });
  }

  late final _$fetchTransactionsAsyncAction =
      AsyncAction('_TransactionStore.fetchTransactions', context: context);

  @override
  Future<void> fetchTransactions() {
    return _$fetchTransactionsAsyncAction.run(() => super.fetchTransactions());
  }

  late final _$addTransactionAsyncAction =
      AsyncAction('_TransactionStore.addTransaction', context: context);

  @override
  Future<void> addTransaction(TransactionModel transaction) {
    return _$addTransactionAsyncAction
        .run(() => super.addTransaction(transaction));
  }

  @override
  String toString() {
    return '''
transactions: ${transactions}
    ''';
  }
}
