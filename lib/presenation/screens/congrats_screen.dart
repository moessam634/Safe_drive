import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safedrive/app/app_colors.dart';
import 'package:safedrive/app/app_images.dart';
import 'package:safedrive/app/app_texts.dart';

import '../components/custom_bottom_nav_bar.dart';
import '../components/custom_button2.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.latte1,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 75.h, horizontal: 20.w),
            child: Center(
              child: Image.asset(
                AppImages.congrats,
                width: MediaQuery.of(context).size.width.w,
                height: 300.h,
              ),
            ),
          ),
          const Text(
            AppText.congratulation,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16.h),
          const Text(
            AppText.yourAccVerified,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Image.asset(
              AppImages.pic9,
              width: 70.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: CustomButton2(
              navScreen: const BottomNavBar(),
              selectText: AppText.done,
            ),
          ),
        ],
      ),
    );
  }
}
