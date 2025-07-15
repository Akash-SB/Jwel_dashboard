import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String id;
  final DateTime date;
  final String title;
  final double amount;

  Activity({
    required this.id,
    required this.date,
    required this.title,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'title': title,
      'amount': amount,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map, String documentId) {
    return Activity(
      id: documentId,
      date: (map['date'] as Timestamp).toDate(),
      title: map['title'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
    );
  }

  factory Activity.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Activity.fromMap(data, doc.id);
  }
}
