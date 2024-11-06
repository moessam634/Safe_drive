import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safedrive/app/app_images.dart';
import 'package:safedrive/presenation/components/custom_text_password_field.dart';

import '../../app/app_colors.dart';
import '../../app/app_texts.dart';
import '../components/custom_elevated_button.dart';
import 'login.dart';

class ResetPasswordBottomSheet extends StatefulWidget {
  const ResetPasswordBottomSheet({super.key});

  @override
  State<ResetPasswordBottomSheet> createState() =>
      _ResetPasswordBottomSheetState();
}

class _ResetPasswordBottomSheetState extends State<ResetPasswordBottomSheet> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 28.h),
                child: const Text(
                  textAlign: TextAlign.center,
                  AppText.resetPassword,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const Text(
                textAlign: TextAlign.center,
                AppText.setNewPassword,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: CustomTextPasswordField(
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                  isVisible: isVisible,
                  type: TextInputType.visiblePassword,
                  hintText: AppText.password,
                  prefixIcon:
                      Icon(Icons.lock, color: AppColors.teel, size: 24.h),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Icon(
                      isVisible
                          ? CupertinoIcons.eye_slash_fill
                          : CupertinoIcons.eye_fill,
                      color: AppColors.teel,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: CustomTextPasswordField(
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                  isVisible: isVisible,
                  type: TextInputType.visiblePassword,
                  hintText: AppText.confirmPassword,
                  prefixIcon:
                      Icon(Icons.lock, color: AppColors.teel, size: 24.h),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Icon(
                      isVisible
                          ? CupertinoIcons.eye_slash_fill
                          : CupertinoIcons.eye_fill,
                      color: AppColors.teel,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: CustomElevatedButton(
                  text: AppText.resetPassword,
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.latte1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.r),
                            ),
                          ),
                          title: const Text(
                            AppText.congratulation,
                            textAlign: TextAlign.center,
                          ),
                          content: const Text(
                            AppText.passwordreset,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
                          ),
                          actions: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 20.h,
                              ),
                              child: Image(
                                image: const AssetImage(AppImages.pic8),
                                fit: BoxFit.fill,
                                height: 250.h,
                                width: 250.w,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: InkWell(
                                child: Container(
                                  height: 48.h,
                                  width: 267.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.teel,
                                    borderRadius: BorderRadius.circular(24.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 80.w, vertical: 14.h),
                                    child: const Center(
                                      child: Text(
                                        AppText.done,
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const LoginScreen()));
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
