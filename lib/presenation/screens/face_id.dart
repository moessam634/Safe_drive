import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safedrive/app/app_colors.dart';
import 'package:safedrive/app/app_texts.dart';

import '../../app/app_images.dart';


class FaceId extends StatefulWidget {
  const FaceId({super.key});

  @override
  State<FaceId> createState() => _FaceIdState();
}

class _FaceIdState extends State<FaceId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.latte0,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppText.face,
          style: TextStyle(
            color: AppColors.latte0,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.latte0,
            size: 30.w,
          ),
        ),
        backgroundColor: AppColors.teel,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              CupertinoIcons.camera_viewfinder,
              color: AppColors.latte0,
              size: 40,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: InkWell(
                child: CircleAvatar(
                  radius: 100.r,
                  backgroundColor: AppColors.white,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Icon(
                      CupertinoIcons.camera_circle,
                      size: 225,
                      color: AppColors.black,
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
            const Image(
              image: AssetImage(AppImages.pic7),
            ),
            InkWell(
              child: Container(
                height: 48.h,
                width: 267.w,
                decoration: BoxDecoration(
                  color: AppColors.teel,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 60.w, vertical: 12.h),
                  child: const Center(
                    child: Text(
                      AppText.addNewFaceId,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
