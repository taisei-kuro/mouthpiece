import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String id;
  final String? reason;
  final int? quantity;
  final DateTime? createdAt;
  final int? elapsedDays;

  Project._({
    required this.id,
    required this.reason,
    required this.quantity,
    required this.createdAt,
    required this.elapsedDays,
  });

  factory Project.fromDoc(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;

    return Project._(
      id: data['id'],
      reason: data['reason'],
      quantity: data['quantity'],
      createdAt: data['createdAt'].toDate(),
      elapsedDays: data['elapsedDays'],
    );
  }

  //経過日数を取得している
  int get currentElapsedDays {
    if (createdAt == null) {
      return 0;
    }
    return DateTime.now().difference(createdAt!).inDays;
  }
}
