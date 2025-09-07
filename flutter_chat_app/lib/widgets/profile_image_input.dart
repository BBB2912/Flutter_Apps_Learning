import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as PathProvider;

class ProfileImageInput extends StatefulWidget {
  const ProfileImageInput({super.key,required this.onPickImage});
  final void Function(String pickedImagePath) onPickImage;

  @override
  State<ProfileImageInput> createState() => _ProfileImageInputState();
}

class _ProfileImageInputState extends State<ProfileImageInput> {
  File? _pickedImage;

  void _takeProfilePicure() async {
    final imagePicker = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 150,
    );
    if (imagePicker == null) {
      return;
    }

    setState(() {
      _pickedImage = File(imagePicker.path);
    });

    final appDir=await PathProvider.getApplicationDocumentsDirectory();
    final fileName=path.basename(_pickedImage!.path);
    final savedImage=await _pickedImage!.copy('${appDir.path}/$fileName');

    widget.onPickImage(savedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImage != null
              ? FileImage(_pickedImage!)
              : null,
          child: Icon(
            Icons.person_4,
            color: Theme.of(context).colorScheme.primary,
            size: 70,
          ),
        ),
        TextButton(
          onPressed: _takeProfilePicure,
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: Text(_pickedImage == null ? 'Upload +' : 'Change'),
        ),
      ],
    );
  }
}
