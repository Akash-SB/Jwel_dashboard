import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/activity_model.dart';

part 'activity_store.g.dart';

class ActivityStore = _ActivityStore with _$ActivityStore;

abstract class _ActivityStore with Store {
  final _collection = FirebaseFirestore.instance.collection('activities');

  // 🔹 Observable list of activities
  @observable
  ObservableList<Activity> activities = ObservableList<Activity>();

  // 🔹 Observable loading state
  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  // 🔹 Load all activities (one-time)
  @action
  Future<void> loadActivities() async {
    try {
      isLoading = true;
      final snapshot =
          await _collection.orderBy('date', descending: true).get();
      activities = ObservableList.of(
        snapshot.docs.map((doc) => Activity.fromDocument(doc)),
      );
    } finally {
      isLoading = false;
    }
  }

  // 🔹 Listen to activities (realtime)
  Future listenToActivities() {
    return _collection.orderBy('date', descending: true).snapshots().listen(
      (snapshot) {
        activities = ObservableList.of(
          snapshot.docs.map((doc) => Activity.fromDocument(doc)),
        );
      },
    ).asFuture(); // optional if you want to await, otherwise ignore
  }

  // 🔹 Add a new activity
  @action
  Future<void> addActivity(Activity activity) async {
    isLoading = true;
    errorMessage = null;
    try {
      await _collection.add(activity.toMap());
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  // 🔹 Delete an activity
  @action
  Future<void> deleteActivity(String id) async {
    isLoading = true;
    errorMessage = null;
    try {
      await _collection.doc(id).delete();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
