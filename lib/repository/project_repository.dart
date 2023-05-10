import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mouthpiece/domain/project.dart';
import 'package:mouthpiece/repository/auth_repository.dart';
import 'package:uuid/uuid.dart';

class ProjectRepository {
  // 当初は、「final String uid = AuthRepository().userId」としていたが、以下経緯によりget関数に変更したもの
  // 「final String uid = AuthRepository().userId」の場合、
  // アプリ初回起動時のSetGoalPageでProjectRepositoryをインスタンス化した際、
  // ProjectRepositoryのインスタンス変数でAuthRepository.userIdを呼び出すことになるが、
  // 初回起動時のこのタイミングでは匿名認証前のため、AuthRepositoryのuserIdメソッドでuidにnullが入りassertが発動する
  // get関数にすることで、userIdを使う時にしか呼び出されなくなる (＝アプリ初回起動時のSetGoalPageでProjectRepositoryをインスタンス化した際には呼び出されない）
  // ため、uidにnullが入ることを回避できる
  // 参考 → https://github.com/flutteruniv/obi-wan/pull/111#discussion_r1111669512
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
