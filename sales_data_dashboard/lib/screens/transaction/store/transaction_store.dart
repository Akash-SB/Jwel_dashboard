import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:sales_data_dashboard/models/transaction_model.dart';

part 'transaction_store.g.dart';

class TransactionStore = _TransactionStore with _$TransactionStore;

abstract class _TransactionStore with Store {
  @observable
  ObservableList<TransactionModel> transactions =
      ObservableList<TransactionModel>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @action
  Future<void> fetchTransactions() async {
    final snapshot = await _firestore.collection('transactions').get();
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

  @observable
  bool isUploading = false;

  @action
  Future<void> uploadTransactionList(List<TransactionModel> sampleData) async {
    isUploading = true;
    try {
      final collection = _firestore.collection('transactions');

      for (final tx in sampleData) {
        final txModel = _mapToTransactionModel(tx);
        await collection.add(txModel.toJson());
      }

      print('✅ Transactions uploaded successfully');
    } catch (e) {
      print('❌ Upload error: $e');
    } finally {
      isUploading = false;
    }
  }

  TransactionModel _mapToTransactionModel(TransactionModel tx) {
    return TransactionModel(
      invoiceId: tx.invoiceId,
      date: tx.date,
      carat: tx.carat.toString(),
      rate: tx.rate.toString(),
      amount: tx.amount.toString(),
      products: tx.products,
      transactionType: tx.transactionType,
      custType: tx.custType,
      custName: tx.custName,
      paymentStatus: tx.paymentStatus,
      paymentType: tx.paymentType,
      id: tx.id,
    );
  }
}
