import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ServiceCategoryGrid extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const ServiceCategoryGrid({super.key, required this.categories});

  static final Map<String, IconData> _iconMap = {
    'local_hospital_outlined': Icons.local_hospital_outlined,
    'terrain_outlined': Icons.terrain_outlined,
    'memory_outlined': Icons.memory_outlined,
    'assignment_outlined': Icons.assignment_outlined,
    'eco_outlined': Icons.eco_outlined,
    'description_outlined': Icons.description_outlined,
    'shopping_bag_outlined': Icons.shopping_bag_outlined,
    'help_outline': Icons.help_outline,
  };

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final iconName = category['icon'] as String;
        final label = category['label'] as String;
        return InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.surfaceVariant, width: 0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_iconMap[iconName] ?? Icons.apps, color: AppColors.gold, size: 28),
                const SizedBox(height: 8),
                Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
        );
      },
    );
  }
}
