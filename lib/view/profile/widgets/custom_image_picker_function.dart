import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/view/profile/manager/edit_profile_data_cubit/edit_profile_data_cubit.dart';
import 'custom_image_picker.dart';

class CustomImagePickerFunction extends StatefulWidget {
  final Function(File)? onImageSelected;
  final String? pic;

  const CustomImagePickerFunction({
    super.key,
    this.onImageSelected,
    this.pic,
  });

  @override
  State<CustomImagePickerFunction> createState() =>
      _CustomImagePickerFunctionState();
}

class _CustomImagePickerFunctionState extends State<CustomImagePickerFunction> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _pickImageFromGallery();
        if (_image == null) return;
        widget.onImageSelected!(_image!);

        EditProfileDataCubit.get(context).uploadProfilePic(pic: _image);
      },
      child: CustomImagePicker(
        image: _image,
        pic: widget.pic,
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _image = File(image.path);
    });
  }
}
