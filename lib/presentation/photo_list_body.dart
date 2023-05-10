import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mouthpiece/const/const.dart';
import 'package:mouthpiece/domain/photo.dart';

class PhotoListBody extends StatelessWidget {
  final List<Photo> photoList;
  final void Function()? onTapAdd;
  final void Function(Photo photo) onTapPhoto;

  const PhotoListBody({
    Key? key,
    required this.photoList,
    required this.onTapAdd,
    required this.onTapPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: photoList.length + 1,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        if (index == photoList.length) {
          return InkWell(
            onTap: onTapAdd,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                border: Border.all(
                  color: Const.mainBlueColor,
                  width: 3,
                ),
              ),
              child: const Icon(
                Icons.add,
                color: Const.mainBlueColor,
              ),
            ),
          );
        }
        final photo = photoList[index];
        final imageUrl = photo.imageUrl;

        return InkWell(
          onTap: () {
            onTapPhoto(photo);
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      border: Border.all(
                        color: Const.mainBlueColor,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      DateFormat.yMMMd('ja').format(photo.createdAt.toDate()),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Const.mainBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
