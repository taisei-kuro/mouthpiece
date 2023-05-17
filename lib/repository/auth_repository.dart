import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthRepository {
  String get userId {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    assert(uid != null, 'currentUserがnullです');
    return uid!;
  }

  Future<void> signInAnonymously() async {
    final firebaseAuthInstance = FirebaseAuth.instance;
    User? currentUser = firebaseAuthInstance.currentUser;
    if (currentUser == null) {
      try {
        // 匿名認証
        final userCredential = await firebaseAuthInstance.signInAnonymously();
        // firestoreにUserを登録
        final user = userCredential.user;
        if (user != null) {
          final uid = user.uid;
          await FirebaseFirestore.instance.collection('users').doc(uid).set(
            {
              'id': uid,
              'createdAt': DateTime.now(),
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        debugPrint(e.toString());
        throw (_convertToErrorMessageFromErrorCode(e.code));
      }
    }
  }

  Future deleteUser() async {
    final uid = userId;
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    await FirebaseAuth.instance.currentUser?.delete();
  }

  String _convertToErrorMessageFromErrorCode(String errorCode) {
    //↓ログイン機能つけた時に使用する。今のところは匿名認証だから使わない
    switch (errorCode) {
      case 'email-already-exists':
        return '指定されたメールアドレスは既に使用されています。';
      case 'wrong-password':
        return 'パスワードが違います。';
      case 'invalid-email':
        return 'メールアドレスが不正です。';
      case 'user-not-found':
        return '指定されたユーザーは存在しません。';
      case 'user-disabled':
        return '指定されたユーザーは無効です。';
      case 'operation-not-allowed':
        return '指定されたユーザーはこの操作を許可していません。';
      case 'too-many-requests':
        return '指定されたユーザーはこの操作を許可していません。';
      default:
        return '不明なエラーが発生しました。';
    }
  }
}
