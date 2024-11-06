import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../../app/app_colors.dart';
import '../components/custom_bottom_nav_bar.dart';

class FingerPrint2 extends StatefulWidget {
  const FingerPrint2({super.key});

  @override
  State<FingerPrint2> createState() => _FingerPrint2State();
}

class _FingerPrint2State extends State<FingerPrint2> {
  final FingerprintAuthentication _fingerprintAuth =
      FingerprintAuthentication();

  bool _authenticationFailed = false;

  void _authenticateUser(BuildContext context) async {
    bool isAuthenticated = await _fingerprintAuth.authenticate();
    if (isAuthenticated) {
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ),
            (route) => false,
      );
    } else {
      setState(() {
        _authenticationFailed = true;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Authentication failed'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticateUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.latte0,
    );
  }
}

class FingerprintAuthentication {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Authenticate to continue',
      );
    } catch (e) {
      print(e);
      return false;
    }
  }
}
