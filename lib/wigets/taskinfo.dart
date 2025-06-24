import 'package:flutter/material.dart';

import '../constants/appcolor.dart' show AppColors;

class TaskInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  final Color titleColor;

  const TaskInfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: titleColor)),
          const SizedBox(height: 6),
          Text(description,
                style: const TextStyle(fontSize: 14, color:AppColors.black)),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor:AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Start"),
            ),
          ),
        ],
      ),
    );
  }
}
