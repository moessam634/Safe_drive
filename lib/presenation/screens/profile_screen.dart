import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safedrive/presenation/components/custom_teel_container.dart';

import '../../app/app_colors.dart';
import '../../app/app_texts.dart';
import '../components/custom_editing_profile_container.dart';

class ProfileScreen extends StatefulWidget {
  final Function(int) navigateToPage;

  const ProfileScreen({
    super.key,
    required this.navigateToPage,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.latte0,
        title: Text('edit $field'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(hintText: 'Enter New $field'),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(user!.uid).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('No user is currently signed in'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.latte0,
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No user data found.'));
          }
          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      const CustomTeelContainer(),
                      Text(
                        AppText.editProfile,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 26,
                          height: 4.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 130.h,
                        ),
                        child: CircleAvatar(
                          backgroundColor: AppColors.latte0,
                          backgroundImage:
                          NetworkImage('${userData['image_url']}'),
                          radius: 75.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomEditingProfileContainer(
                          text: ' ${userData['username']}',
                          label:AppText.userName,
                          onPressed: () => editField('username'),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomEditingProfileContainer(
                          text: '${userData['email']}',
                          label: AppText.email,
                          onPressed: () => editField('email'),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomEditingProfileContainer(
                          text: '${userData['phone_number']}',
                          label: AppText.PhoneNumber,
                          onPressed: () => editField('phone_number'),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomEditingProfileContainer(
                          text: '${userData['age']}',
                          label: AppText.Age,
                          onPressed:  () => editField('age'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}