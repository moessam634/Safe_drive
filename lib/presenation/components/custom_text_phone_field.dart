import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/app_colors.dart';

class CustomTextPhoneField extends StatefulWidget {
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? type;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextEditingController? controller;
  final Function? validator;
  final Function(String)? onChanged;

  const CustomTextPhoneField({
    super.key,
    this.contentPadding,
    required this.type,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.validator,
  });

  @override
  State<CustomTextPhoneField> createState() => _CustomTextPhoneFieldState();
}

class _CustomTextPhoneFieldState extends State<CustomTextPhoneField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      child: TextFormField(
        onChanged: widget.onChanged,
        validator: (value) {
          if (value == null || value.isEmpty ) {
            return 'Please enter a valid phone number.';
          }
          if (!RegExp(r'^\+20\s?\d{10}$').hasMatch(value)) {
            return 'Please enter a valid Egyptian phone number starting with +20.';
          }
          return null;
        },
        controller: widget.controller,
        keyboardType: widget.type ?? TextInputType.emailAddress,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.teel, width: 2.w),
          ),
          filled: true,
          fillColor: AppColors.latte0,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.w),
          labelText: widget.hintText,
          hoverColor: AppColors.latte1,
          labelStyle: const TextStyle(color: AppColors.grey1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }
}
