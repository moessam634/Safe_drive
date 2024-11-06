import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/app_colors.dart';

class CustomEditingProfileContainer extends StatelessWidget {
  const CustomEditingProfileContainer({
    super.key,
    required this.text,
    required this.label,
    required this.onPressed,
  });

  final String text;
  final String label;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 7.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.latte0,
        border: Border.all(
          color: AppColors.grey,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 6.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 16.w, color: AppColors.grey),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.w,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  color: AppColors.teel,
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.edit,
                    size: 28.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}