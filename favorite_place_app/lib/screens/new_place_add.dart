import 'dart:io';

import 'package:favorite_place_app/providers/places_provider.dart';
import 'package:favorite_place_app/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _NewItemAddScreenState();
}

class _NewItemAddScreenState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _enteredName;
  File? image;

  void _savePlace() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref
          .read(placesProvider.notifier)
          .addPlace(_enteredName!,image!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Place')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                key: ValueKey(_enteredName),
                decoration: InputDecoration(
                  label: Text('Place Name'),
                  hintText: 'Enter place Name(eg:-TajMahal,Kerala )',
                ),
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length > 30 ||
                      value.trim().length < 3) {
                    return 'Enter place Name between 3-30 characters only..';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _enteredName = newValue!;
                },
              ),
              const SizedBox(height: 10,),
              ImageInput(onAddImage:(newImage){
                image=newImage;
              }),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: Text('Reset'),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(onPressed: _savePlace, child: Text('Add Place')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
