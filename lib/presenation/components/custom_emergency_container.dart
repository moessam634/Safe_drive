import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safedrive/data/cubit/emergency_item_cubit/emergency_item_cubit.dart';
import 'package:safedrive/domain/models/emergency_model.dart';
import '../../app/app_colors.dart';

class CustomEmergencyContainer extends StatelessWidget {
  const CustomEmergencyContainer({super.key, required this.emergencyModel});

  final EmergencyModel emergencyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  emergencyModel.name,
                  style: TextStyle(
                    fontSize: 15.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  emergencyModel.number.toString(),
                  style: TextStyle(fontSize: 18.h, color: AppColors.grey),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  color: AppColors.teel,
                  onPressed: () async {
                    String number = emergencyModel.number.toString();
                    if (!number.startsWith('0')) {
                      number = '0$number';
                    }
                    await FlutterPhoneDirectCaller.callNumber(number);
                  },
                  // async => await FlutterPhoneDirectCaller.callNumber(
                  //         emergencyModel.number.toString()),
                  icon: Icon(
                    CupertinoIcons.phone_fill,
                    size: 31.h,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    emergencyModel.delete();

                    BlocProvider.of<EmergencyItemCubit>(context)
                        .fetchAllEmergencyItem();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: AppColors.teel,
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
