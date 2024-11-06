import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safedrive/app/app_colors.dart';

class CustomTeelContainer extends StatelessWidget {
  const CustomTeelContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .3,
      decoration: BoxDecoration(
        color: AppColors.teel,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(
            MediaQuery.of(context).size.width,
            100.0,
          ),
        ),
      ),
    );
  }
}