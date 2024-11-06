import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/app_colors.dart';

class CustomTextPasswordField extends StatefulWidget {
  final EdgeInsetsGeometry? contentPadding;
  final bool? isVisible;
  final TextInputType? type;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const CustomTextPasswordField({
    super.key,
    this.contentPadding,
    this.isVisible,
    required this.type,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.controller,
    this.onChanged,
  });

  @override
  State<CustomTextPasswordField> createState() =>
      _CustomTextPasswordFieldState();
}

class _CustomTextPasswordFieldState extends State<CustomTextPasswordField> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      child: TextFormField(
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        //onSaved: (value) => _enteredPassword = value!,
        onChanged: widget.onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required.';
          }
          if (value.length < 8) {
            return 'Password must be at least 8 characters long.';
          }
          if (!value.contains(RegExp(r'[A-Z]'))) {
            return 'Password must contain at least one uppercase letter.';
          }
          if (!value.contains(RegExp(r'[a-z]'))) {
            return 'Password must contain at least one lowercase letter.';
          }
          if (!value.contains(RegExp(r'[0-9]'))) {
            return 'Password must contain at least one digit.';
          }
          if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
            return 'Password must contain at least one special character.';
          }
          return null;
        },
        controller: widget.controller,
        obscureText: widget.isVisible ?? false,
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
