import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/app_colors.dart';
import '../../app/app_texts.dart';
import '../screens/login.dart';


class CustomSettingContainer3 extends StatelessWidget {
  const CustomSettingContainer3({
    super.key,
    required this.firstIcon,
    required this.secondIcon,
    //required this.thirdIcon,
    required this.firstText,
    required this.secondText,
    //required this.thirdText,
  });

  final IconData firstIcon;
  final IconData secondIcon;

  //final IconData thirdIcon;
  final String firstText;
  final String secondText;

  //final String thirdText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.latte1,
        border: Border.all(
          color: AppColors.black,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.r),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 6.w,
              vertical: 6.h,
            ),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: AppColors.latte1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.r),
                        ),
                      ),
                      title: Text(
                        firstText,
                        textAlign: TextAlign.center,
                      ),
                      content: const Padding(
                        padding: EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text(
                                AppText.report1,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(AppText.report11),
                              Text(AppText.report12),
                              Text(AppText.report13),
                              SizedBox(height: 10),
                              Text(AppText.report14),
                              SizedBox(height: 10),
                            ],
                          ),
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
              },
              child: Row(
                children: [
                  Icon(
                    firstIcon,
                    size: 26.w,
                  ),
                  SizedBox(
                    width: 75.w,
                  ),
                  Text(
                    firstText,
                    style: TextStyle(
                      fontSize: 15.w,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            child: InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Row(
                children: [
                  Icon(
                    secondIcon,
                    size: 25.w,
                  ),
                  SizedBox(
                    width: 75.w,
                  ),
                  Text(
                    secondText,
                    style: TextStyle(
                      fontSize: 15.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
