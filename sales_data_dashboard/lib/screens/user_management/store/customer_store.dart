import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

import '../../../models/customer_model.dart';

part 'customer_store.g.dart';

class CustomerStore = _CustomerStore with _$CustomerStore;

abstract class _CustomerStore with Store {
  @observable
  ObservableList<CustomerModel> customers = ObservableList<CustomerModel>();

  @action
  Future<void> fetchCustomers() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('customers').get();
    customers = ObservableList.of(
      snapshot.docs.map((doc) => CustomerModel.fromDocument(doc)),
    );
  }

  @action
  Future<void> addCustomer(CustomerModel customer) async {
    final docRef = await FirebaseFirestore.instance
        .collection('customers')
        .add(customer.toMap());

    final newCustomer = customer.copyWith(id: docRef.id);
    customers.add(newCustomer);
  }
}
