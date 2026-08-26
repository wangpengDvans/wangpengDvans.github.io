import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/models/guide_step.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/widgets/gt_card.dart';
import '../cubit/guide_cubit.dart';

class FuneralGuideScreen extends StatelessWidget {
  const FuneralGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GuideCubit>()..loadGuide(),
      child: Scaffold(
        appBar: AppBar(title: const Text('治丧指南')),
        body: BlocBuilder<GuideCubit, GuideState>(
          builder: (context, state) {
            return switch (state) {
              GuideLoading() => const Center(child: GtLoadingIndicator()),
              GuideLoaded(steps: final steps, completedCount: final completedCount) => CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              '已根据「父亲 · 78岁 · 上海 · 无宗教 · 预算5万内」为您生成个性化流程',
                              style: AppTextStyles.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            _ProgressHeader(completed: completedCount, total: steps.length),
                            const SizedBox(height: 16),
                            ...steps.map((step) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _StepCard(step: step),
                                )),
                            const SizedBox(height: 8),
                            Text(
                              '每一步都可点开查看「操作指引 + 所需材料 + 费用参考」。勾选右侧 ✓ 标记完成，家人可通过邀请码加入协作。',
                              style: AppTextStyles.caption.copyWith(height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              GuideError(message: final message) => Center(
                  child: Text(message, style: AppTextStyles.body),
                ),
            };
          },
        ),
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  final int completed;
  final int total;

  const _ProgressHeader({required this.completed, required this.total});

  @override
  Widget build(BuildContext context) {
    final progress = completed / total;
    return GtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('治丧进度', style: AppTextStyles.heading3),
              Text('$completed/$total 已完成', style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.gold),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final GuideStep step;

  const _StepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    return GtCard(
      onTap: () => context.push('/guide/step/${step.index}'),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: step.isCompleted ? AppColors.success.withOpacity(0.15) : AppColors.gold.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: step.isCompleted
                ? const Icon(Icons.check, color: AppColors.success, size: 18)
                : Text('${step.index}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step.title, style: AppTextStyles.heading3),
                const SizedBox(height: 4),
                Text(step.subtitle, style: AppTextStyles.caption),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              step.isCompleted ? Icons.check_circle : Icons.check_circle_outline,
              color: step.isCompleted ? AppColors.success : AppColors.textTertiary,
            ),
            onPressed: () => context.read<GuideCubit>().toggleStep(step.index),
          ),
        ],
      ),
    );
  }
}
