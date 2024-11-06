import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safedrive/app/app_colors.dart';
import 'package:safedrive/app/app_texts.dart';
import 'package:safedrive/presenation/components/custom_text_email_field.dart';
import 'package:safedrive/presenation/components/custom_text_password_field.dart';
import 'package:safedrive/presenation/components/custom_text_phone_field.dart';
import 'package:safedrive/presenation/components/custom_text_user_field.dart';
import 'package:safedrive/presenation/screens/verification_screen.dart';
import 'package:safedrive/widgets/user_image.dart';
import '../components/custom_elevated_button.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You should add your face data'),
        ),
      );
    }
    if (!isValid || selectedImage == null) {
      return;
    }
    try {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (builder) =>
              VerificationScreen(
                username: usernamec.text,
                email: emailc.text,
                password: passwordc.text,
                phone: phonec.text,
                selectedImage: selectedImage!,
              ),
        ),
            (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
    _formKey.currentState!.save();
  }

  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUserphone = '';
  var _enteredUsername = '';
  File? selectedImage;
  final TextEditingController usernamec = TextEditingController();
  final TextEditingController emailc = TextEditingController();
  final TextEditingController passwordc = TextEditingController();
  final TextEditingController phonec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.latte1,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.latte1,
        centerTitle: true,
        title: const Text(
          AppText.safe,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: const Text(
                    AppText.letsGetStart,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                UserImagePicker(
                  onPickImage: (File pickedImage) {
                    selectedImage = pickedImage;
                  },
                ),
                SizedBox(height: 10.h),
                CustomTextUserField(
                  controller: usernamec,
                  onChanged: (value) => _enteredUsername = value,
                  type: TextInputType.name,
                  hintText: AppText.name,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: AppColors.teel,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextEmailField(
                  controller: emailc,
                  onChanged: (value) => _enteredEmail = value,
                  type: TextInputType.emailAddress,
                  hintText: AppText.email,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: AppColors.teel,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextPhoneField(
                  controller: phonec,
                  onChanged: (value) => _enteredUserphone = value,
                  type: TextInputType.phone,
                  hintText: AppText.phone,
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: AppColors.teel,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextPasswordField(
                  controller: passwordc,
                  onChanged: (value) => _enteredPassword = value,
                  type: TextInputType.visiblePassword,
                  hintText: AppText.password,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppColors.teel,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextPasswordField(
                  onChanged: (value) => _enteredPassword = value,
                  type: TextInputType.visiblePassword,
                  hintText: AppText.confirmPassword,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppColors.teel,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomElevatedButton(
                  text: AppText.create,
                  onPressed: () {
                    _submit();
                  },
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      AppText.alreadyHaveAcc,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        AppText.loginHere,
                        style: TextStyle(
                          color: AppColors.teel,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernamec.dispose();
    emailc.dispose();
    passwordc.dispose();
    phonec.dispose();
    super.dispose();
  }
}

