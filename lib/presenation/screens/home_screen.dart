import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/app_colors.dart';
import '../../app/app_texts.dart';
import '../components/custom_home_container.dart';
import 'emergency_view.dart';
import 'location.dart';
import 'notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required void Function(int index) navigateToPage,
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
          AppText.safe,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 24.w,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomHomeContainer(
                name: AppText.location,
                icon: Icon(
                  Icons.location_on,
                  color: AppColors.teel,
                  size: 40.w,
                ),
                navScreen: const Location(),
              ),
              SizedBox(width: 50.w),
              CustomHomeContainer(
                name: AppText.notification,
                icon: Icon(
                  CupertinoIcons.bell_fill,
                  color: AppColors.teel,
                  size: 40.w,
                ),
                navScreen: const NotificationScreen(),
              ),
            ],
          ),
          SizedBox(height: 50.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CustomHomeContainer(
              //   name: AppText.faceId,
              //   icon: Icon(
              //     CupertinoIcons.camera_viewfinder,
              //     color: AppColors.teel,
              //     size: 40.w,
              //   ),
              //   navScreen: const FaceId(),
              // ),
              //SizedBox(width: 50.w),
              CustomHomeContainer(
                name: AppText.emergency,
                icon: Icon(
                  CupertinoIcons.exclamationmark_triangle_fill,
                  color: AppColors.teel,
                  size: 40.w,
                ),
                navScreen: const Emergency(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
