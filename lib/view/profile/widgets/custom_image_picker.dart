import 'dart:io';
import 'package:flutter/material.dart';

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker({
    super.key,
    required File? image,
    required this.pic,
  }) : _image = image;

  final File? _image;
  final String? pic;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      child: Stack(
        children: [
          if (pic != null)
            Positioned.fill(
              child: ClipOval(
                child: Image.network(
                  pic!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          if (_image != null)
            Positioned.fill(
              child: ClipOval(
                child: Image.file(
                  (_image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          if (_image == null && pic == null)
            const Positioned.fill(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
