import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';

part 'transaction_store.g.dart';

class TransactionStore = _TransactionStore with _$TransactionStore;

abstract class _TransactionStore with Store {
  @observable
  ObservableList<InvoiceModel> transactions = ObservableList<InvoiceModel>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @action
  Future<void> fetchTransactions() async {
    final snapshot = await _firestore.collection('transactions').get();
    transactions = ObservableList.of(
      snapshot.docs.map((doc) => InvoiceModel.fromDocument(doc)),
    );
  }

  @action
  Future<void> addTransaction(InvoiceModel transaction) async {
    final docRef = await FirebaseFirestore.instance
        .collection('transactions')
        .add(transaction.toMap());

    final newTx = transaction.copyWith(id: docRef.id, invoiceId: docRef.id);
    transactions.add(newTx);
  }

  @observable
  bool isUploading = false;

  @action
  Future<void> uploadTransactionList(List<InvoiceModel> sampleData) async {
    isUploading = true;
    try {
      final collection = _firestore.collection('transactions');

      for (final tx in sampleData) {
        final txModel = _mapToInvoiceModel(tx);
        await collection.add(txModel.toMap());
      }

      print('✅ Transactions uploaded successfully');
    } catch (e) {
      print('❌ Upload error: $e');
    } finally {
      isUploading = false;
    }
  }

  InvoiceModel _mapToInvoiceModel(InvoiceModel tx) {
    return InvoiceModel(
      invoiceId: tx.invoiceId,
      date: tx.date,
      size: tx.size.toString(),
      rate: tx.rate.toString(),
      amount: tx.amount.toString(),
      transactionType: tx.transactionType,
      custType: tx.custType,
      custName: tx.custName,
      paymentStatus: tx.paymentStatus,
      paymentType: tx.paymentType,
      productIds: [...tx.productIds],
    );
  }
}
