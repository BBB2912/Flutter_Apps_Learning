import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/profile_image_input.dart';
import 'package:logger/logger.dart';


var logger = Logger();

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String? _enteredEmail;
  String? _enteredPassword;
  String? _enteredUserName;
  String? _selectedImage;

  var isSignIn = false;
  final _formKey = GlobalKey<FormState>();

  // void _signIN() {}
  // void _signUp() {}
  void _onSubmit() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (isSignIn) {
          final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail!,
            password: _enteredPassword!,
          );
          logger.i(userCredentials);
          logger.i(userCredentials);
          logger.i(_enteredUserName);
        } else {
          if (_selectedImage == null) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please pick an image'),
                duration: Duration(milliseconds: 400),
              ),
            );
            return;
          }
          final userCredentials = await _firebase
              .createUserWithEmailAndPassword(
                email: _enteredEmail!,
                password: _enteredPassword!,
              );
          logger.i(userCredentials);
          logger.i(_enteredUserName);
          logger.i(_selectedImage);

          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredentials.user!.uid)
              .set({
                'userName': _enteredUserName,
                'email': _enteredEmail,
                'profileImageUrl': _selectedImage,
              });
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          // ...
        }
        logger.e(error);
        if (!mounted) return;
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication Failed!'),
            duration: Duration(milliseconds: 400),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20.0),
          clipBehavior: Clip.hardEdge,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    isSignIn ? 'SignIn' : 'SignUp',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (!isSignIn)
                    ProfileImageInput(
                      onPickImage: (String onPickImagePath) {
                        _selectedImage = onPickImagePath;
                      },
                    ),
                  if (!isSignIn) const SizedBox(height: 10),
                  if (!isSignIn)
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        label: Text(
                          'User Name',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        hintText: 'Panther2912',
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 4 ||
                            value.trim().length >= 10) {
                          return 'Enter User Name Between 4-10 characters';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredUserName = newValue!;
                      },
                    ),
                  const SizedBox(height: 10),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: Text(
                        'Email',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      hintText: 'example@gmail.com',
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _enteredEmail = newValue!;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text(
                        'Password',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 6 ||
                          value.trim().length >= 10) {
                        return 'Password should be atleast 6-10 characters only';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _enteredPassword = newValue!;
                    },
                  ),
                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: _onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                    ),
                    child: Text(isSignIn ? 'SignIn' : 'SignUp'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isSignIn ? 'Create Account?' : 'Already I have Account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isSignIn = !isSignIn;
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          // fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                        child: Text(isSignIn ? 'SignUp' : 'SignIn'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
