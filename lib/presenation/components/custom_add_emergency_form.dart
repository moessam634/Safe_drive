import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safedrive/app/app_texts.dart';
import 'package:safedrive/data/cubit/add_emergency_number_cubit/add_emergency_number_cubit.dart';
import 'package:safedrive/domain/models/emergency_model.dart';
import 'package:safedrive/presenation/components/custom_elevated_button.dart';

import 'custom_text_form_field.dart';

class AddEmergencyForm extends StatefulWidget {
  const AddEmergencyForm({super.key});

  @override
  State<AddEmergencyForm> createState() => _AddEmergencyFormState();
}

class _AddEmergencyFormState extends State<AddEmergencyForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? name;
  int? number;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 32.h),
              child: CustomTextFormField(
                label: AppText.name,
                onSaved: (value) {
                  name = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: CustomTextFormField(
                label: AppText.phoneNumber,
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  number = int.parse(value!);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child:
                  BlocBuilder<AddEmergencyNumberCubit, AddEmergencyNumberState>(
                builder: (context, state) {
                  return CustomElevatedButton(
                    isLoading:
                        state is AddEmergencyNumberLoading ? true : false,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        var emergencyModel =
                            EmergencyModel(name: name!, number: number!);
                        BlocProvider.of<AddEmergencyNumberCubit>(context)
                            .addEmergencyNumber(emergencyModel);
                      } else {
                        autoValidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
