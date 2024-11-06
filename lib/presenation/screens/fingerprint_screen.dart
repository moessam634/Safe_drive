import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../../app/app_colors.dart';
import 'onbaording.dart';

class FingerPrint extends StatefulWidget {
  const FingerPrint({super.key});

  @override
  State<FingerPrint> createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {
  final FingerprintAuthentication _fingerprintAuth =
      FingerprintAuthentication();

  bool _authenticationFailed = false;

  void _authenticateUser(BuildContext context) async {
    bool isAuthenticated = await _fingerprintAuth.authenticate();
    if (isAuthenticated) {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const OnBaordingScreen(),
        ),
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
