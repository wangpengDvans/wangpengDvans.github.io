import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/models/tomb.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/widgets/gt_button.dart';
import '../../../shared/widgets/gt_card.dart';
import '../cubit/tomb_detail_cubit.dart';

class TombDetailScreen extends StatelessWidget {
  final String tombId;

  const TombDetailScreen({super.key, required this.tombId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TombDetailCubit>()..loadDetail(tombId),
      child: Scaffold(
        appBar: AppBar(title: const Text('墓位详情')),
        body: BlocBuilder<TombDetailCubit, TombDetailState>(
          builder: (context, state) {
            return switch (state) {
              TombDetailLoading() => const Center(child: GtLoadingIndicator()),
              TombDetailLoaded(tomb: final tomb) => CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _TombHeader(tomb: tomb),
                            const SizedBox(height: 20),
                            _InfoGrid(tomb: tomb),
                            const SizedBox(height: 20),
                            Text('墓位特点', style: AppTextStyles.heading2),
                            const SizedBox(height: 12),
                            ...tomb.features.map((feature) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('· ', style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold)),
                                      Expanded(child: Text(feature, style: AppTextStyles.bodySmall)),
                                    ],
                                  ),
                                )),
                            const SizedBox(height: 20),
                            Text('价格说明', style: AppTextStyles.heading2),
                            const SizedBox(height: 12),
                            _PriceCard(tomb: tomb),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              TombDetailError(message: final message) => Center(
                  child: Text(message, style: AppTextStyles.body),
                ),
            };
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<TombDetailCubit, TombDetailState>(
              builder: (context, state) {
                final canBook = state is TombDetailLoaded && state.tomb.status == '可售';
                return GtButton(
                  label: canBook ? '预约看墓' : '暂不可售',
                  onPressed: canBook ? () {} : null,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _TombHeader extends StatelessWidget {
  final Tomb tomb;

  const _TombHeader({required this.tomb});

  @override
  Widget build(BuildContext context) {
    return GtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${tomb.cemeteryName} ${tomb.id}', style: AppTextStyles.heading2),
              _StatusBadge(status: tomb.status),
            ],
          ),
          const SizedBox(height: 8),
          Text('${tomb.area} · ${tomb.type}', style: AppTextStyles.bodySmall),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: tomb.tags
                .map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(tag, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.terrain, color: AppColors.gold, size: 64),
                ),
              ),
            ],
          ),
          if (tomb.hasVr)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  const Icon(Icons.view_in_ar, color: AppColors.gold, size: 18),
                  const SizedBox(width: 8),
                  Text('支持 VR 实景看墓', style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final Tomb tomb;

  const _InfoGrid({required this.tomb});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': '面积', 'value': '${tomb.size}㎡'},
      {'label': '朝向', 'value': tomb.direction ?? '待定'},
      {'label': '景观', 'value': tomb.landscape ?? '标准'},
      {'label': '类型', 'value': tomb.type},
    ];
    return GtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('墓位信息', style: AppTextStyles.heading3),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.8,
            children: items.map((item) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['label']!, style: AppTextStyles.caption),
                  const SizedBox(height: 4),
                  Text(item['value']!, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  final Tomb tomb;

  const _PriceCard({required this.tomb});

  @override
  Widget build(BuildContext context) {
    return GtCard(
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '¥${(tomb.finalPrice ?? tomb.price).toStringAsFixed(0)}',
                style: AppTextStyles.heading1.copyWith(color: AppColors.gold),
              ),
              const SizedBox(width: 8),
              if (tomb.finalPrice != null)
                Text(
                  '¥${tomb.price.toStringAsFixed(0)}',
                  style: AppTextStyles.body.copyWith(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '含墓位费、碑材费、20年管理费；不含刻字费与随葬品。最终价格以现场签约为准。',
            style: AppTextStyles.caption.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case '已售':
        color = AppColors.success;
      case '预留':
        color = AppColors.error;
      default:
        color = AppColors.gold;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(status, style: AppTextStyles.caption.copyWith(color: color)),
    );
  }
}
