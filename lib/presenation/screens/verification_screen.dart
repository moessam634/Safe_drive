import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../app/app_colors.dart';
import '../../app/app_images.dart';
import '../../app/app_texts.dart';
import '../components/custom_elevated_button.dart';
import 'congrats_screen.dart';

final _firebase = FirebaseAuth.instance;

class VerificationScreen extends StatefulWidget {
  final String? username;
  final String? email;
  final String? password;
  final String? phone;
  final File? selectedImage;

  const VerificationScreen({
    super.key,
    required String this.username,
    required String this.email,
    required String this.password,
    required String this.phone,
    required File this.selectedImage,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  void initState() {
    phoneAuth();
    startTimer();
    super.initState;
  }

  int counter = 120;
  late Timer _timer;
  String? verifId;

  void startTimer() {
    setState(() {
      counter = 120;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || counter == 0) {
        timer.cancel();
      } else {
        setState(() {
          if (counter > 0) {
            counter--;
          }
        });
      }
    });
  }

  Future<void> _submit2() async {
    try {
      correct = true;
      _isLoading = true;
      await signUser(widget.email!, widget.password!);
    } on FirebaseAuthException {}
  }

  Future<void> signUser(String email, String passward) async {
    try {
      final UserCredential userCredential =
          await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: passward,
      );
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${userCredential.user!.uid}.jpg');
      await storageRef.putFile(widget.selectedImage!);
      final imageUrl = await storageRef.getDownloadURL(); // مه


      // م جدا
      setState(() {
        _isLoading = false;
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (builder) => const CongratsScreen(),
        ),
        (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication success.'),
        ),
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': widget.username,
        'email': email,
        'image_url': imageUrl,
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authentication failed.'),
        ),
      );
    }
    // setState(() {
    //   _isLoading = false;
    // });
  }

  bool _isLoading = false;
  bool correct = true;
  TextEditingController txt1 = TextEditingController();
  TextEditingController txt2 = TextEditingController();
  TextEditingController txt3 = TextEditingController();
  TextEditingController txt4 = TextEditingController();
  TextEditingController txt5 = TextEditingController();
  TextEditingController txt6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        backgroundColor: AppColors.latte1,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.teel,
          title: const Text(
            AppText.verificationCode,
            style: TextStyle(color: AppColors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 40.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  AppImages.otp,
                  height: 250.h,
                  width: MediaQuery.of(context).size.width.w,
                  fit: BoxFit.contain,
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.h),
                  child: const Text(
                    AppText.otpHasSentToYourPhoneNum,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      myInputBox(context, txt1, correct),
                      myInputBox(context, txt2, correct),
                      myInputBox(context, txt3, correct),
                      myInputBox(context, txt4, correct),
                      myInputBox(context, txt5, correct),
                      myInputBox(context, txt6, correct),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  correct ? '' : 'Invalid otp!',
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.red,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 18.h),
                  child: Text(
                    '${AppText.resendInSec}$counter sec',
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(fontSize: 14, color: AppColors.grey1),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: CustomElevatedButton(
                    text: AppText.verify,
                    onPressed: () {
                      sentCode();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    txt1.dispose();
    txt2.dispose();
    txt3.dispose();
    txt4.dispose();
    txt5.dispose();
    txt6.dispose();
    _timer.cancel();
    super.dispose();
  }

  void phoneAuth() async {
    try {
      await _firebase.verifyPhoneNumber(
        phoneNumber: widget.phone!,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) {
          if (kDebugMode) {
            print('Verification completed: $credential');
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (kDebugMode) {
            print('Verification failed: ${e.message}');
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) async {
          if (kDebugMode) {
            print('Code sent to ${widget.phone}');
          }
          verifId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (kDebugMode) {
            print('Auto retrieval timeout for verificationId: $verificationId');
          }
          verifId = verificationId;
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  sentCode() async {
    try {
      String smsCode =
          txt1.text + txt2.text + txt3.text + txt4.text + txt5.text + txt6.text;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifId!,
        smsCode: smsCode,
      );
      await _firebase.signInWithCredential(credential).then((value) {
        if (value.user != null) {
          setState(() {
            _submit2();
          });
        }
      });
    } catch (ex) {
      setState(() {
        correct = false;
      });
    }
  }
}

Widget myInputBox(
    BuildContext context, TextEditingController controller, bool correct) {
  return Container(
    width: 53.w,
    height: 53.h,
    decoration: BoxDecoration(
      border: Border.all(
        width: 0.75.w,
      ),
      boxShadow: [
        BoxShadow(
          color: correct ? AppColors.grey1 : AppColors.red,
          blurRadius: .2, // soften the shadow
          spreadRadius: .2, //extend the shadow
          offset: const Offset(
            0.5, // Move to right 5  horizontally
            0.5, // Move to bottom 5 Vertically
          ),
        )
      ],
      color: AppColors.kOtpColor,
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: TextField(
      inputFormatters: [LengthLimitingTextInputFormatter(1)],
      controller: controller,
      maxLength: 1,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 30),
      decoration: const InputDecoration(
        border: InputBorder.none,
        counterText: '',
      ),
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        } else if (value.isEmpty) {
          FocusScope.of(context).previousFocus();
        }
      },
    ),
  );
}
