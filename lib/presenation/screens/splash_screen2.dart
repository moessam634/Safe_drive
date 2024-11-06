import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../app/app_images.dart';
import 'fingerprint_screen2.dart';


class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const FingerPrint2(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.latte0,
      body: Center(
        child: Image(
          image: AssetImage(AppImages.pic1),
          width: 320,
          height: 320,
        ),
      ),
    );
  }
}
