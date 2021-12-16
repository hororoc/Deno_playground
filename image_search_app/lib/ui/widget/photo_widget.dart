import 'package:flutter/material.dart';
import 'package:image_search_app/model/photo.dart';

class PhotoWidget extends StatelessWidget {
  final Photo photo;

  const PhotoWidget({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(photo.previewURL),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}
