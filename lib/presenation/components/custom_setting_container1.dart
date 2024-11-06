import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safedrive/app/app_texts.dart';
import '../../app/app_colors.dart';
import '../screens/notification_screen.dart';


class CustomSettingContainer1 extends StatelessWidget {
  const CustomSettingContainer1({
    super.key,
    required this.firstIcon,
    required this.secondIcon,
    required this.thirdIcon,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
    required this.navigateToPage,
  });

  final IconData firstIcon;
  final IconData secondIcon;
  final IconData thirdIcon;
  final String firstText;
  final String secondText;
  final String thirdText;
  final Function(int) navigateToPage;

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
            child: GestureDetector(
              onTap: () {
                navigateToPage(1);
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
                        secondText,
                        textAlign: TextAlign.center,
                      ),
                      content: const Padding(
                        padding: EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text(
                                AppText.security1,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(AppText.security11),
                              Text(AppText.security12),
                              Text(AppText.security13),
                              Text(AppText.security14),
                              SizedBox(height: 10),
                              Text(
                                AppText.security2,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(AppText.security21),
                              Text(AppText.security22),
                              Text(AppText.security23),
                              SizedBox(height: 10),
                              Text(
                                AppText.security3,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(AppText.security31),
                              Text(AppText.security32),
                              Text(AppText.security33),
                              Text(AppText.security34),
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
                    secondIcon,
                    size: 25.w,
                  ),
                  SizedBox(width: 75.w),
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const NotificationScreen(),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(
                    thirdIcon,
                    size: 25.w,
                  ),
                  SizedBox(
                    width: 75.w,
                  ),
                  Text(
                    thirdText,
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
// content: SingleChildScrollView(
// child: ListBody(
// children: <Widget>[
// Text('1. Road Safety Guidelines:'),
// Text('- Always follow traffic rules and regulations.'),
// Text('- Do not use your phone while driving.'),
// Text('- Wear a seatbelt at all times.'),
// Text('- Be cautious of pedestrians and other vehicles.'),
// SizedBox(height: 10),
// Text('2. Application Security:'),
// Text('- Never share your email or password with anyone.'),
// Text('- Always verify the identity of individuals before accepting friend requests or notifications.'),
// Text('- Use strong, unique passwords for your account.'),
// Text('- Enable two-factor authentication for added security.'),
// SizedBox(height: 10),
// Text('3. General Safety Tips:'),
// Text('- Be aware of your surroundings.'),
// Text('- Report any suspicious activity to the authorities.'),
// Text('- Keep your personal information private.'),
// Text('- Update your app regularly to receive the latest security updates.'),
// ],
// ),
// ),
