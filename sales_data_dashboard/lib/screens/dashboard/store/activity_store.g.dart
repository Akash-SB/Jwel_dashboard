// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ActivityStore on _ActivityStore, Store {
  late final _$activitiesAtom =
      Atom(name: '_ActivityStore.activities', context: context);

  @override
  ObservableList<Activity> get activities {
    _$activitiesAtom.reportRead();
    return super.activities;
  }

  @override
  set activities(ObservableList<Activity> value) {
    _$activitiesAtom.reportWrite(value, super.activities, () {
      super.activities = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ActivityStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loadActivitiesAsyncAction =
      AsyncAction('_ActivityStore.loadActivities', context: context);

  @override
  Future<void> loadActivities() {
    return _$loadActivitiesAsyncAction.run(() => super.loadActivities());
  }

  late final _$addActivityAsyncAction =
      AsyncAction('_ActivityStore.addActivity', context: context);

  @override
  Future<void> addActivity(Activity activity) {
    return _$addActivityAsyncAction.run(() => super.addActivity(activity));
  }

  late final _$deleteActivityAsyncAction =
      AsyncAction('_ActivityStore.deleteActivity', context: context);

  @override
  Future<void> deleteActivity(String id) {
    return _$deleteActivityAsyncAction.run(() => super.deleteActivity(id));
  }

  @override
  String toString() {
    return '''
activities: ${activities},
isLoading: ${isLoading}
    ''';
  }
}
