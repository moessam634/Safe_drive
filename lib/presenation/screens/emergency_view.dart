import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/app_colors.dart';
import '../../app/app_texts.dart';
import '../components/custom_add_bottom_sheet.dart';
import '../components/emergency_body.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.latte0,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            backgroundColor: AppColors.latte1,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const CustomAddBottomSheet(),
              );
            },
          );
        },
        backgroundColor: AppColors.teel,
        child: const Icon(CupertinoIcons.add, color: AppColors.white),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppText.emergency,
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
        backgroundColor: AppColors.teel,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              CupertinoIcons.phone_fill,
              color: AppColors.latte0,
              size: 30,
            ),
          )
        ],
      ),
      body: const EmergencyBody(),
    );
  }
}

// Center(
// child: Padding(
// padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
// child: Column(
// children: [
// Padding(
// padding: const EdgeInsets.only(top: 50),
// child: InkWell(
// child: CircleAvatar(
// radius: 100.r,
// backgroundColor: AppColors.white,
// child: const Padding(
// padding: EdgeInsets.only(top: 3),
// child: Icon(
// CupertinoIcons.person_alt_circle,
// size: 225,
// color: AppColors.black,
// ),
// ),
// ),
// onTap: () {},
// ),
// ),
// SizedBox(height: 20.h),
// const Text(
// AppText.there,
// style: TextStyle(
// fontSize: 16,
// fontWeight: FontWeight.w500,
// ),
// ),
// const Text(
// AppText.wants,
// style: TextStyle(
// fontSize: 16,
// fontWeight: FontWeight.w500,
// ),
// ),
// SizedBox(height: 10.h),
// const Padding(
// padding: EdgeInsets.all(8),
// child: CustomEmergencyContainer1(),
// ),
// SizedBox(height: 10.h),
// const Padding(
// padding: EdgeInsets.all(8),
// child: CustomEmergencyContainer2(),
// ),
// SizedBox(height: 10.h),
// const Padding(
// padding: EdgeInsets.all(8),
// child: CustomEmergencyContainer3(),
// ),
// SizedBox(height: 10.h),
// const Padding(
// padding: EdgeInsets.all(8),
// child: CustomEmergencyContainer4(),
// ),
// ],
// ),
// ),
// ),

// void _showFrom(BuildContext ctx, int? itemKey) async {
//   showModalBottomSheet(
//     context: ctx,
//     builder: (context) => Container(
//       child: Column(
//         children: [
//           CustomTextField(
//             controller: _nameController,
//             type: TextInputType.name,
//             hintText: AppText.name,
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//           CustomTextField(
//             controller: _numberController,
//             type: TextInputType.number,
//             hintText: AppText.phoneNumber,
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               _createItem({
//                 'name': _nameController.text,
//                 'number': _numberController.text
//               });
//               _nameController.text = '';
//               _numberController.text = '';
//               Navigator.of(context).pop();
//             },
//             child: const Text(AppText.add),
//           )
//         ],
//       ),
//     ),
//   );
// }
//

// Future<void> _createItem(Map<String, dynamic> newItem) async {
//   await _emergencyBox.add(newItem);
//   // print('number of record is $_emergencyBox');
//   _refreshItems();
// }

// void _refreshItems() {
//   final data = _emergencyBox.keys.map((key) {
//     final item = _emergencyBox.get(key);
//     return {'key': key, 'name': item['name'], 'number': item['number']};
//   }).toList();
//   setState(() {
//     _items = data.reversed.toList();
//   });
// }
