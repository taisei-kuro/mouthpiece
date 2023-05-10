import 'package:cloud_firestore/cloud_firestore.dart';

class Photo {
  final Timestamp createdAt;
  final String imageUrl;

  Photo._({
    required this.createdAt,
    required this.imageUrl,
  });

  factory Photo.fromDoc(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;

    return Photo._(
      createdAt: data['createdAt'],
      imageUrl: data['imageUrl'],
    );
  }
}
