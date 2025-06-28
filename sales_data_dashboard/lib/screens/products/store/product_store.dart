import 'package:mobx/mobx.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_data_dashboard/models/product_model.dart';

part 'product_store.g.dart';

class ProductStore = _ProductStore with _$ProductStore;

abstract class _ProductStore with Store {
  @observable
  ObservableList<ProductModel> products = ObservableList<ProductModel>();

  @action
  Future<void> fetchProducts() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    products = ObservableList.of(
      snapshot.docs.map((doc) => ProductModel.fromDocument(doc)),
    );
  }

  @action
  Future<void> addProduct(ProductModel product) async {
    final docRef = await FirebaseFirestore.instance
        .collection('products')
        .add(product.toMap());

    final newProduct = product.copyWith(id: docRef.id);
    products.add(newProduct);
  }
}
