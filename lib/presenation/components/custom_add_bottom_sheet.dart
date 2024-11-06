import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safedrive/data/cubit/add_emergency_number_cubit/add_emergency_number_cubit.dart';
import 'package:safedrive/data/cubit/emergency_item_cubit/emergency_item_cubit.dart';
import 'package:safedrive/presenation/components/custom_add_emergency_form.dart';

class CustomAddBottomSheet extends StatelessWidget {
  const CustomAddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEmergencyNumberCubit(),
      child: BlocConsumer<AddEmergencyNumberCubit, AddEmergencyNumberState>(
        listener: (context, state) {
          if (state is AddEmergencyNumberError) {}
          if (state is AddEmergencyNumberSuccess) {
            BlocProvider.of<EmergencyItemCubit>(context)
                .fetchAllEmergencyItem();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return  AbsorbPointer(
            absorbing: state is AddEmergencyNumberLoading ? true : false,
            child: const AddEmergencyForm(),
          );
        },
      ),
    );
  }
}
