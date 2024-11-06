import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safedrive/app/app_colors.dart';
import 'package:safedrive/app/app_texts.dart';
import 'package:safedrive/presenation/components/custom_setting_container3.dart';

import '../components/custom_setting_container1.dart';
import '../components/custom_setting_container2.dart';

class SettingsScreen extends StatelessWidget {
  final Function(int) navigateToPage;

  const SettingsScreen({
    super.key,
    required this.navigateToPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.latte0,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.teel,
        centerTitle: true,
        title: Text(
          AppText.settings,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 24.w,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.settings,
              color: AppColors.latte0,
              size: 26.w,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              AppText.account,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: CustomSettingContainer1(
                firstIcon: Icons.person,
                firstText: AppText.editProfile,
                secondIcon: Icons.security,
                secondText: AppText.security,
                thirdIcon: CupertinoIcons.bell_fill,
                thirdText: AppText.notification,
                navigateToPage: navigateToPage,
              ),
            ),
            SizedBox(height: 20.h),
            const Text(
              AppText.support,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: const CustomSettingContainer2(
                firstIcon: Icons.language_sharp,
                firstText: AppText.language,
                secondIcon: CupertinoIcons.doc_checkmark_fill,
                secondText: AppText.terms,
                thirdIcon: CupertinoIcons.exclamationmark_circle_fill,
                thirdText: AppText.about,
              ),
            ),
            SizedBox(height: 20.h),
            const Text(
              AppText.actions,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: const CustomSettingContainer3(
                firstIcon: CupertinoIcons.doc_text_fill,
                firstText: AppText.report,
                secondIcon: Icons.logout,
                secondText: AppText.log,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
