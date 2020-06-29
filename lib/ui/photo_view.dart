import 'package:flutter/cupertino.dart';

class PhotoView extends StatelessWidget {
  final String image;

  PhotoView({this.image});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'photo',
      child: Image.network('$image', fit: BoxFit.cover),
    );
  }
}
