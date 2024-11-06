import 'package:flutter/material.dart';
import 'package:safedrive/app/app_colors.dart';
import '../domain/models/Place_suggestion.dart';

class PlaceItem extends StatelessWidget {
  final PlaceSuggestion suggestion;

  const PlaceItem({
    super.key,
    required this.suggestion,
  });

  @override
  Widget build(BuildContext context) {
    var subTitle = '';
    var descriptionParts = suggestion.description.split(',');
    if (descriptionParts.length > 1) {
      subTitle = suggestion.description.replaceAll(descriptionParts[0], '').trim();
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.all(8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.latte0,
              ),
              child: const Icon(
                Icons.place,
                color: AppColors.teel,
              ),
            ),
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${descriptionParts[0]}\n',
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: subTitle.length > 2 ? subTitle.substring(2) : '',
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
