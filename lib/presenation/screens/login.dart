import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safedrive/app/app_colors.dart';
import 'package:safedrive/app/app_images.dart';
import 'package:safedrive/app/app_texts.dart';
import 'package:safedrive/presenation/components/custom_button.dart';
import 'package:safedrive/presenation/components/custom_text_email_field.dart';
import 'package:safedrive/presenation/components/custom_bottom_nav_bar.dart';
import 'package:safedrive/presenation/screens/sign_up_screen.dart';

import '../components/custom_elevated_button.dart';
import '../components/custom_modal_bottom_sheet.dart';
import '../components/custom_text_password_field.dart';

final _firebase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    setState(() {});
    if (!isValid) {
      return;
    }
    try {
      _isLoading = true;
      await loginUser();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (builder) => const BottomNavBar(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authentication failed.'),
        ),
      );
    }
    _isLoading = false;
    setState(() {});
    _formKey.currentState!.save();
  }

  Future<void> loginUser() async {
    final UserCredential userCredential =
        await _firebase.signInWithEmailAndPassword(
      email: _enteredEmail,
      password: _enteredPassword,
    );
  }

  bool isVisible = true;
  bool isObscureText = true;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';
  final _isSignup1 = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.latte1,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.latte1,
          centerTitle: true,
          title: const Text(
            AppText.safe,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            //image
            Container(
              width: double.infinity.w,
              height: double.infinity.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.busPic,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //Email TextFormField
                        Padding(
                          padding: EdgeInsets.only(
                              top: 85.h, right: 25.w, left: 25.w),
                          child: CustomTextEmailField(
                            onChanged: (value) => _enteredEmail = value,
                            type: TextInputType.emailAddress,
                            hintText: AppText.email,
                            prefixIcon: const Icon(
                              Icons.email,
                              color: AppColors.teel,
                              size: 24,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        //Password TextFormField
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: CustomTextPasswordField(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.h),
                            onChanged: (value) => _enteredPassword = value,
                            isVisible: isObscureText,
                            type: TextInputType.visiblePassword,
                            hintText: AppText.password,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: AppColors.teel,
                              size: 24,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObscureText = !isObscureText;
                                });
                              },
                              child: Icon(
                                isObscureText
                                    ? CupertinoIcons.eye_slash_fill
                                    : CupertinoIcons.eye_fill,
                                color: AppColors.teel,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //forget password
                  const CustomBottomSheet(),
                  SizedBox(height: 20.h),
                  Center(
                    child: CustomElevatedButton(
                      text: AppText.login,
                      onPressed: _submit,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Divider(
                  //         thickness: 1.w,
                  //         color: AppColors.black,
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(
                  //           vertical: 100.h, horizontal: 10.w),
                  //       child: const Text(
                  //         AppText.or,
                  //         style: TextStyle(
                  //           color: AppColors.white,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Divider(
                  //         thickness: 1.w,
                  //         color: AppColors.black,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 280.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          AppText.doNotHaveAcc,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.w,
                          ),
                        ),
                        CustomButton(
                          valid: _isSignup1,
                          navScreen: const SignUpScreen(),
                          selectText: AppText.signUp,
                          width: 80.w,
                          height: 50.h,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
