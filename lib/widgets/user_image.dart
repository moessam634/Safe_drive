import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safedrive/app/app_colors.dart';
import 'package:safedrive/app/app_texts.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickedImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }
    setState(() => _pickedImageFile = File(pickedImage.path));

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40.r,
          backgroundColor: AppColors.latte0,
          foregroundImage:
              _pickedImageFile == null ? null : FileImage(_pickedImageFile!),
          child: IconButton(
            onPressed: _pickedImage,
            icon: const Icon(Icons.add_photo_alternate_rounded),
            iconSize: 60,
            color: AppColors.teel,
          ),
        ),
        const SizedBox(height: 10,),
        const Text(
          textAlign: TextAlign.center,
          AppText.addface,
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
