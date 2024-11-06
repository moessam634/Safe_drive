import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/app_colors.dart';
import '../../app/app_texts.dart';
import '../../data/cubit/emergency_item_cubit/emergency_item_cubit.dart';
import 'emergency_list_view.dart';

class EmergencyBody extends StatefulWidget {
  const EmergencyBody({super.key});

  @override
  State<EmergencyBody> createState() => _EmergencyBodyState();
}

class _EmergencyBodyState extends State<EmergencyBody> {
  @override
  void initState() {
    BlocProvider.of<EmergencyItemCubit>(context).fetchAllEmergencyItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 50),
            //   child: CircleAvatar(
            //     radius: 100.r,
            //     backgroundColor: AppColors.white,
            //     child: const Icon(
            //       CupertinoIcons.person_alt_circle,
            //       size: 210,
            //       color: AppColors.black,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20.h),
            // const Text(
            //   AppText.there,
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // const Text(
            //   AppText.wants,
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 7.w,
              ),
              decoration: BoxDecoration(
                color: AppColors.latte1,
                border: Border.all(
                  color: AppColors.black,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppText.emergency,
                          style: TextStyle(
                            fontSize: 15.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          AppText.call112,
                          style:
                          TextStyle(fontSize: 18.h, color: AppColors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          color: AppColors.teel,
                          onPressed: () async =>
                          await FlutterPhoneDirectCaller.callNumber(
                              AppText.call123),
                          icon: Icon(
                            CupertinoIcons.phone_fill,
                            size: 31.h,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 7.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 7.w,
              ),
              decoration: BoxDecoration(
                color: AppColors.latte1,
                border: Border.all(
                  color: AppColors.black,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppText.ambulance,
                          style: TextStyle(
                            fontSize: 15.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          AppText.call123,
                          style:
                          TextStyle(fontSize: 18.h, color: AppColors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          color: AppColors.teel,
                          onPressed: () async =>
                          await FlutterPhoneDirectCaller.callNumber(
                              AppText.call123),
                          icon: Icon(
                            CupertinoIcons.phone_fill,
                            size: 31.h,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const EmergencyListView(),
          ],
        ),
      ),
    );
  }
}
