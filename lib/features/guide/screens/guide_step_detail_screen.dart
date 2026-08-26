import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/models/guide_step.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/widgets/gt_button.dart';
import '../../../shared/widgets/gt_card.dart';
import '../cubit/guide_cubit.dart';

class GuideStepDetailScreen extends StatelessWidget {
  final int stepIndex;

  const GuideStepDetailScreen({super.key, required this.stepIndex});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GuideCubit>()..loadGuide(),
      child: Scaffold(
        appBar: AppBar(title: const Text('步骤详情')),
        body: BlocBuilder<GuideCubit, GuideState>(
          builder: (context, state) {
            return switch (state) {
              GuideLoading() => const Center(child: GtLoadingIndicator()),
              GuideLoaded(steps: final steps) => _buildContent(context, steps),
              GuideError(message: final message) => Center(
                  child: Text(message, style: AppTextStyles.body),
                ),
            };
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<GuideStep> steps) {
    final step = steps.firstWhere((s) => s.index == stepIndex);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: step.isCompleted ? AppColors.success.withOpacity(0.15) : AppColors.gold.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: step.isCompleted
                          ? const Icon(Icons.check, color: AppColors.success, size: 22)
                          : Center(child: Text('${step.index}', style: AppTextStyles.heading3.copyWith(color: AppColors.gold))),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(step.title, style: AppTextStyles.heading1),
                          Text(step.subtitle, style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _SectionCard(
                  title: '操作指引',
                  child: Text(step.description, style: AppTextStyles.bodySmall.copyWith(height: 1.6)),
                ),
                const SizedBox(height: 12),
                _SectionCard(
                  title: '所需材料',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: step.materials
                        .map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('· ', style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold)),
                                  Expanded(child: Text(item, style: AppTextStyles.bodySmall)),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 12),
                _SectionCard(
                  title: '费用参考',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: step.costReferences
                        .map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('· ', style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold)),
                                  Expanded(child: Text(item, style: AppTextStyles.bodySmall)),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 24),
                GtButton(
                  label: step.isCompleted ? '标记为未完成' : '标记为已完成',
                  variant: step.isCompleted ? GtButtonVariant.outline : GtButtonVariant.primary,
                  onPressed: () {
                    context.read<GuideCubit>().toggleStep(step.index);
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return GtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.heading3.copyWith(color: AppColors.gold)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
