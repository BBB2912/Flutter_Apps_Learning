import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key,required this.onAddImage});

  final void Function(File image) onAddImage;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _image;
  final ImagePicker _imagePicker = ImagePicker();

  void _takePicture() async {
    final takenPicture = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (takenPicture == null) {
      return;
    }

    setState(() {
      _image = File(takenPicture.path);
    });

    widget.onAddImage(_image!);
  }

  void _choosePicture()async{
    final choosenPicture=await _imagePicker.pickImage(source: ImageSource.gallery,maxWidth: 600);
    if (choosenPicture == null) {
      return;
    }

    setState(() {
      _image = File(choosenPicture.path);
    });

    widget.onAddImage(_image!);
  }

  @override
  Widget build(BuildContext context) {
    Widget? content;
    if (_image == null) {
      content = 
         Align(
          alignment: Alignment.bottomCenter,
           child: Padding(
             padding: const EdgeInsets.only(bottom: 80),
             child: Text(
              'Pick an Image',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
                     ),
           ),
         );
    } else {
      content = Image.file(
        _image!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          alignment: Alignment.center,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(
              width: 5,
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: content,
        ),
        Positioned(
          child: Container(
            height: 300,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(20)),
               color:  Colors.black.withValues(alpha: 0.35),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _takePicture,
                    label: Text('Camera'),
                    icon: Icon(Icons.camera_alt_outlined),
                    style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(41, 0, 0, 0),
              foregroundColor: Theme.of(context).colorScheme.onSurface,
            ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _choosePicture,
                    label: Text('File'),
                    icon: Icon(Icons.folder_copy_outlined),
                    style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(41, 0, 0, 0),
              foregroundColor: Theme.of(context).colorScheme.onSurface,
            ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
