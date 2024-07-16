import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;

  const NoData({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 70),
          Icon(
            icon,
            size: 150,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: MyTextStyle.title,
          ),
          Text(
            subtitle,
            style: MyTextStyle.body,
          ),
        ],
      ),
    );
  }
}
