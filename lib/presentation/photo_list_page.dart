import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mouthpiece/const/const.dart';
import 'package:mouthpiece/domain/photo.dart';
import 'package:mouthpiece/presentation/photo_list_body.dart';
import 'package:mouthpiece/repository/image_repository.dart';

class PhotoListPage extends StatefulWidget {
  const PhotoListPage({super.key});

  @override
  State<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  final imageRepo = ImageRepository();
  List<Photo>? photoList;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPhotoList();
  }

  @override
  Widget build(BuildContext context) {
    final photoList = this.photoList;

    if (photoList == null || isLoading) {
      return const Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Const.mainBlueColor,
      ),
      body: PhotoListBody(
        photoList: photoList,
        onTapAdd: () async {
          startLoading();

          // カメラ起動
          final bool isUploaded = await openCamera();

          if (!mounted) return;

          if (isUploaded) {
            await fetchPhotoList();
          }
          endLoading();
        },
        onTapPhoto: (photo) {
          // 写真押した時の挙動
        },
      ),
    );
  }

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void endLoading() {
    setState(() {
      isLoading = false;
    });
  }

  Future fetchPhotoList() async {
    final photoList = await imageRepo.fetchFacePhotoList();
    setState(() {
      this.photoList = photoList;
    });
  }

  Future<bool> openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    final path = pickedFile?.path;

    if (path != null) {
      final image = File(path);
      await imageRepo.uploadAndSaveFaceLogImage(image);
      return true;
    } else {
      return false;
    }
  }
}
