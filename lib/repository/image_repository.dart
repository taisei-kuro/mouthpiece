import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mouthpiece/domain/photo.dart';
import 'package:mouthpiece/repository/auth_repository.dart';
import 'package:mouthpiece/repository/project_repository.dart';

class ImageRepository {
  final projectRepo = ProjectRepository();
  final uid = AuthRepository().userId;

  Future uploadAndSaveFaceLogImage(File image) async {
    final projectId = await projectRepo.fetchNewestProjectDocumentId();
    final newDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('projects')
        .doc(projectId)
        .collection('photos')
        .doc();
    final imgId = 'faces/$projectId/${newDoc.id}'; // FIXME:
    final imageUrl = await _uploadImage(image, imgId);

    await newDoc.set({
      'imageUrl': imageUrl,
      'createdAt': Timestamp.now(),
    });
  }

  Future uploadAndSaveBackgroundImage(File image) async {
    final newDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('backgroundPhotos')
        .doc();
    final imgId = 'backgroundImages/${newDoc.id}';
    final imageUrl = await _uploadImage(image, imgId);

    await newDoc.set({
      'imageUrl': imageUrl,
      'createdAt': Timestamp.now(),
    });
  }

  Future<String> _uploadImage(File image, String imgId) async {
    final task =
        await FirebaseStorage.instance.ref('users/$uid/$imgId').putFile(image);
    final imageUrl = await task.ref.getDownloadURL();
    return imageUrl;
  }

  Future<List<Photo>> fetchFacePhotoList() async {
    final projectId = await projectRepo.fetchNewestProjectDocumentId();
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('projects')
        .doc(projectId)
        .collection('photos')
        .orderBy('createdAt', descending: false)
        .get();
    final documentList = snapshot.docs;
    final photoList = documentList.map((document) {
      return Photo.fromDoc(document);
    }).toList();
    return photoList;
  }

  Future<List<Photo>> fetchBackgroundImageList() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('backgroundPhotos')
        .orderBy('createdAt', descending: true)
        .get();
    final documentList = snapshot.docs;
    final photoList = documentList.map((document) {
      return Photo.fromDoc(document);
    }).toList();
    return photoList;
  }
}
