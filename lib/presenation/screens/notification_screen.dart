import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:safedrive/app/app_colors.dart';
import 'package:safedrive/app/app_texts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'emergency_view.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  List<String> imageUrls = [];
  List<String> imageDates = [];
  List<Color> acceptButtonColors = [];
  List<Color> rejectButtonColors = [];
  List<bool> isAcceptDisabled = [];
  List<bool> isRejectDisabled = [];
  bool isLoading = true;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    setupFlutterNotifications();
    fetchLatestImages();

    // Setup a listener for Firebase Storage changes
    setupStorageListener();
  }

  void setupFlutterNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> fetchLatestImages() async {
    final ListResult result =
        await FirebaseStorage.instance.ref('notification_images').listAll();
    final List<Reference> allFiles = result.items;

    List<Map<String, String>> filesWithDates = [];
    for (var file in allFiles) {
      String url = await file.getDownloadURL();

      // Fetching metadata
      FullMetadata metadata = await file.getMetadata();
      DateTime? timeCreated = metadata.timeCreated;
      String date = timeCreated != null
          ? DateFormat('yyyy-MM-dd HH:mm').format(timeCreated)
          : 'Unknown date';

      filesWithDates.add({'url': url, 'date': date});
    }

    // Sort files by date, newest first
    filesWithDates.sort((a, b) => b['date']!.compareTo(a['date']!));

    setState(() {
      imageUrls = filesWithDates.map((file) => file['url']!).toList();
      imageDates = filesWithDates.map((file) => file['date']!).toList();
      acceptButtonColors =
          List<Color>.filled(imageUrls.length, Colors.transparent);
      rejectButtonColors =
          List<Color>.filled(imageUrls.length, Colors.transparent);
      isAcceptDisabled = List<bool>.filled(imageUrls.length, false);
      isRejectDisabled = List<bool>.filled(imageUrls.length, false);
      isLoading = false;
    });
    await loadButtonStates();
  }

  void setupStorageListener() {
    FirebaseStorage.instance
        .ref('notification_images')
        .listAll()
        .then((ListResult result) {
      for (var ref in result.items) {
        ref.getMetadata().then((metadata) {
          ref.getDownloadURL().then((url) {
            // Display notification for each new image
            _showNotification(url);
          });
        });
      }
    });
  }

  void _showNotification(String imageUrl) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
      0,
      'Safe Drive',
      'There is someone who wants to drive your car. Go to notifications to see him',
      platformChannelSpecifics,
      payload: imageUrl,
    );
  }

  void handleAcceptPress(int index) {
    setState(() {
      acceptButtonColors[index] = AppColors.teel;
      rejectButtonColors[index] = Colors.transparent;
      isAcceptDisabled[index] = false;
      isRejectDisabled[index] = true;
    });
    saveButtonStates();
  }

  void handleRejectPress(int index) {
    setState(() {
      rejectButtonColors[index] = AppColors.red;
      acceptButtonColors[index] = Colors.transparent;
      isAcceptDisabled[index] = true;
      isRejectDisabled[index] = false;
    });
    saveButtonStates();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Emergency()),
    );
  }

  Future<void> saveButtonStates() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < imageUrls.length; i++) {
      await prefs.setBool('accept_disabled_$i', isAcceptDisabled[i]);
      await prefs.setBool('reject_disabled_$i', isRejectDisabled[i]);
      await prefs.setInt('accept_color_$i', acceptButtonColors[i].value);
      await prefs.setInt('reject_color_$i', rejectButtonColors[i].value);
    }
  }

  Future<void> loadButtonStates() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < imageUrls.length; i++) {
      setState(() {
        isAcceptDisabled[i] = prefs.getBool('accept_disabled_$i') ?? false;
        isRejectDisabled[i] = prefs.getBool('reject_disabled_$i') ?? false;
        acceptButtonColors[i] = Color(
          prefs.getInt('accept_color_$i') ?? Colors.transparent.value,
        );
        rejectButtonColors[i] = Color(
          prefs.getInt('reject_color_$i') ?? Colors.transparent.value,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.latte0,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.teel,
        centerTitle: true,
        title: const Text(
          AppText.notifications,
          style: TextStyle(
            color: AppColors.latte0,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.latte0,
            size: 30.w,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.notifications_none,
              color: AppColors.latte0,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : imageUrls.isEmpty
                ? Center(
                    child: Text(
                      'NO Images',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.black,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.h,
                          horizontal: 15.w,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: Container(
                                    width: 125.w,
                                    height: 165.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(15.r),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(imageUrls[index]),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      AppText.doYouKnow,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    ElevatedButton(
                                      onPressed: isAcceptDisabled[index]
                                          ? null
                                          : () => handleAcceptPress(index),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5.h,
                                          horizontal: 5.w,
                                        ),
                                        backgroundColor:
                                            acceptButtonColors[index],
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          side: BorderSide(
                                            color: AppColors.teel,
                                            width: 3.w,
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        width: 200.w,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                          vertical: 6.h,
                                        ),
                                        child: Center(
                                          child: Text(
                                            AppText.accept,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.w,
                                              color:
                                                  acceptButtonColors[index] ==
                                                          AppColors.teel
                                                      ? AppColors.white
                                                      : AppColors.black,
                                              // AppColors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: isRejectDisabled[index]
                                          ? null
                                          : () => handleRejectPress(index),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5.h,
                                          horizontal: 5.w,
                                        ),
                                        backgroundColor:
                                            rejectButtonColors[index],
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          side: BorderSide(
                                            color: AppColors.red,
                                            width: 3.w,
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        width: 200.w,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                          vertical: 6.h,
                                        ),
                                        child: Center(
                                          child: Text(
                                            AppText.reject,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.w,
                                              color:
                                                  rejectButtonColors[index] ==
                                                          AppColors.red
                                                      ? Colors.white
                                                      : AppColors.black,
                                              // AppColors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      imageDates[
                                          index], // Displaying the image date
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Divider(
                              thickness: 2,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
