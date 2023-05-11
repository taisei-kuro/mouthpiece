import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mouthpiece/domain/project.dart';
import 'package:mouthpiece/repository/auth_repository.dart';
import 'package:uuid/uuid.dart';

class ProjectRepository {
  String get uid => AuthRepository().userId;
  Future<Project> fetchProject() async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('projects')
        .orderBy('createdAt', descending: true);
    final docSnapshot = await docRef.get();
    final docs = docSnapshot.docs;

    if (docs.isEmpty) {
      throw '目標が取得できません';
    }
    final doc = docs.first;
    return Project.fromDoc(doc);
  }

  Future fetchNewestProjectDocumentId() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('projects')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
    final queryDocSnapshotId = querySnapshot.docs.first.id;
    return queryDocSnapshotId;
  }

  Future<List<Project>> fetchProjectList() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('projects')
        .orderBy('createdAt', descending: true)
        .get();
    final documentList = snapshot.docs;
    return documentList.map((snapshot) {
      return Project.fromDoc(snapshot);
    }).toList();
  }

  Future setProject(int quantity, String reason) async {
    final projectId = const Uuid().v4();
    final docRef = FirebaseFirestore.instance;
    return docRef
        .collection('users')
        .doc(uid)
        .collection('projects')
        .doc(projectId)
        .set(
      {
        'quantity': quantity,
        'reason': reason,
        'id': projectId,
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future setMeasure(String measure, int elapsedDays) async {
    final projectId = await fetchNewestProjectDocumentId();
    final docRef = FirebaseFirestore.instance;
    await docRef
        .collection('users')
        .doc(uid)
        .collection('projects')
        .doc(projectId)
        .update(
      {
        'measure': measure,
        'elapsedDays': elapsedDays,
      },
    );
  }
}
