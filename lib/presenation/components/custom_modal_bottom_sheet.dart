import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safedrive/presenation/components/custom_elevated_button.dart';
import 'package:safedrive/presenation/components/custom_text_email_field.dart';
import '../../app/app_colors.dart';
import '../../app/app_texts.dart';

final _firebase = FirebaseAuth.instance;

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    try {
      await _firebase.sendPasswordResetEmail(
        email: _enteredEmail,
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.latte1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.r),
              ),
            ),
            content: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Password reset link sent! \n Check your email',
                textAlign: TextAlign.center,
              ),
            ),
            actions: [
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48.h,
                    width: 267.w,
                    decoration: BoxDecoration(
                      color: AppColors.teel,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Center(
                      child: Text(
                        'OK',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 15.w,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
    _formKey.currentState!.save();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height.h),
              backgroundColor: AppColors.latte1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(70.r),
                ),
              ),
              context: context,
              builder: (context) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 8.w,
                      right: 8.w,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 28.h),
                                    child: const Text(
                                      textAlign: TextAlign.center,
                                      AppText.forgetPassword,
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    textAlign: TextAlign.center,
                                    AppText.enterYourEmail,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 25.h),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    child: CustomTextEmailField(
                                      onChanged: (value) =>
                                          _enteredEmail = value,
                                      type: TextInputType.emailAddress,
                                      hintText: AppText.email,
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: AppColors.teel,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 35.h),
                                    child: CustomElevatedButton(
                                      text: AppText.submit,
                                      onPressed: _submit,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Text(
            AppText.forgetPassword,
            style: TextStyle(
              color: AppColors.black,
              decoration: TextDecoration.underline,
              fontSize: 14,
            ),
          )),
    );
  }
}
