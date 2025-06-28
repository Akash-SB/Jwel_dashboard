import 'package:mobx/mobx.dart';
import 'package:sales_data_dashboard/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'transaction_store.g.dart';

class TransactionStore = _TransactionStore with _$TransactionStore;

abstract class _TransactionStore with Store {
  @observable
  ObservableList<TransactionModel> transactions =
      ObservableList<TransactionModel>();

  @action
  Future<void> fetchTransactions() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('transactions').get();
    transactions = ObservableList.of(
      snapshot.docs.map((doc) => TransactionModel.fromDocument(doc)),
    );
  }

  @action
  Future<void> addTransaction(TransactionModel transaction) async {
    final docRef = await FirebaseFirestore.instance
        .collection('transactions')
        .add(transaction.toMap());

    final newTx = transaction.copyWith(id: docRef.id);
    transactions.add(newTx);
  }
}
