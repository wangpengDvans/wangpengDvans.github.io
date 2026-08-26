import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/gt_card.dart';

class FuneralGuideCard extends StatelessWidget {
  final int completedSteps;
  final int totalSteps;

  const FuneralGuideCard({
    super.key,
    required this.completedSteps,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final progress = completedSteps / totalSteps;
    return GtCard(
      onTap: () => context.push('/guide'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('治丧指南', style: AppTextStyles.heading2),
          const SizedBox(height: 6),
          Text('从临终到入土 · 6大环节 18步全流程', style: AppTextStyles.bodySmall),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.gold),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '已完成 $completedSteps/$totalSteps · 继续我的治丧计划',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold),
              ),
              const Icon(Icons.chevron_right, color: AppColors.gold, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
