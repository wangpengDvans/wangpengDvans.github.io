import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class FamilyTreeScreen extends StatelessWidget {
  const FamilyTreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('家族树')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_tree, color: AppColors.gold.withOpacity(0.5), size: 64),
            const SizedBox(height: 16),
            Text('家族树', style: AppTextStyles.heading2),
            const SizedBox(height: 8),
            Text('四代同堂 · 9位家庭成员', style: AppTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }
}
