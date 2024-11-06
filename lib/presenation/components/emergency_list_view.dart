import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/cubit/emergency_item_cubit/emergency_item_cubit.dart';
import '../../domain/models/emergency_model.dart';
import 'custom_emergency_container.dart';

class EmergencyListView extends StatelessWidget {
  const EmergencyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<EmergencyItemCubit, EmergencyItemState>(
        builder: (BuildContext context, state) {
          List<EmergencyModel> emergencyItem =
              BlocProvider.of<EmergencyItemCubit>(context).emergencyItem!;
          return ListView.builder(
            itemCount: emergencyItem.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 7.h),
              child: CustomEmergencyContainer(
                emergencyModel: emergencyItem[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
