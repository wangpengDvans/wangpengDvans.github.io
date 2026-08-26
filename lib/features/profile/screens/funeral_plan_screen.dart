import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/gt_button.dart';
import '../../../shared/widgets/gt_card.dart';

class FuneralPlanScreen extends StatefulWidget {
  const FuneralPlanScreen({super.key});

  @override
  State<FuneralPlanScreen> createState() => _FuneralPlanScreenState();
}

class _FuneralPlanScreenState extends State<FuneralPlanScreen> {
  final List<Map<String, dynamic>> _tasks = [
    {'title': '确认死亡证明与户口注销', 'done': true, 'date': '2026-07-18'},
    {'title': '联系殡仪馆接运遗体', 'done': true, 'date': '2026-07-18'},
    {'title': '选定告别厅与火化时间', 'done': false, 'date': null},
    {'title': '选购寿衣、骨灰盒与祭品', 'done': false, 'date': null},
    {'title': '发布讣告并通知亲友', 'done': false, 'date': null},
    {'title': '举行告别仪式', 'done': false, 'date': null},
    {'title': '骨灰寄存或安葬', 'done': false, 'date': null},
  ];

  int get _completedCount => _tasks.where((t) => t['done'] as bool).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('治丧计划')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProgressCard(completed: _completedCount, total: _tasks.length),
                  const SizedBox(height: 20),
                  Text('待办事项', style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                  ..._tasks.asMap().entries.map((entry) {
                    final index = entry.key;
                    final task = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GtCard(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => setState(() => task['done'] = !(task['done'] as bool)),
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: task['done'] as bool ? AppColors.gold : Colors.transparent,
                                  border: Border.all(color: AppColors.gold),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: task['done'] as bool
                                    ? const Icon(Icons.check, color: AppColors.scaffoldBackground, size: 16)
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}. ${task['title']}',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      decoration: task['done'] as bool ? TextDecoration.lineThrough : null,
                                      color: task['done'] as bool ? AppColors.textTertiary : AppColors.textPrimary,
                                    ),
                                  ),
                                  if (task['date'] != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        '完成于 ${task['date']}',
                                        style: AppTextStyles.caption,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  GtButton(
                    label: '同步到治丧指南',
                    variant: GtButtonVariant.outline,
                    onPressed: () => context.push('/guide'),
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

class _ProgressCard extends StatelessWidget {
  final int completed;
  final int total;

  const _ProgressCard({required this.completed, required this.total});

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
              Text('$completed / $total', style: AppTextStyles.heading3.copyWith(color: AppColors.gold)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.surface,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.gold),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '已完成 $completed 项，剩余 ${total - completed} 项。保持与家属沟通，按指南逐步推进。',
            style: AppTextStyles.caption.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}
