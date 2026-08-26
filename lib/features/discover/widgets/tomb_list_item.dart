import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/models/tomb.dart';
import '../../../shared/widgets/gt_card.dart';

class TombListItem extends StatelessWidget {
  final Tomb tomb;

  const TombListItem({super.key, required this.tomb});

  @override
  Widget build(BuildContext context) {
    return GtCard(
      onTap: () => context.push('/discover/tomb/${tomb.id}'),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.terrain, color: AppColors.gold, size: 36),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${tomb.cemeteryName} ${tomb.id}',
                        style: AppTextStyles.heading3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _StatusBadge(status: tomb.status),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${tomb.area} · ${tomb.type} · ${tomb.size}㎡ · ${tomb.direction ?? ''}',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (tomb.finalPrice != null)
                      Row(
                        children: [
                          Text(
                            '¥${tomb.finalPrice!.toStringAsFixed(0)}',
                            style: AppTextStyles.price,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '¥${tomb.price.toStringAsFixed(0)}',
                            style: AppTextStyles.caption.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      )
                    else
                      Text('¥${tomb.price.toStringAsFixed(0)}', style: AppTextStyles.price),
                    Row(
                      children: [
                        if (tomb.hasVr)
                          Container(
                            margin: const EdgeInsets.only(right: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('VR', style: AppTextStyles.caption.copyWith(color: AppColors.gold, fontSize: 10)),
                          ),
                        if (tomb.hasPhoto)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('实拍', style: AppTextStyles.caption.copyWith(fontSize: 10)),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(status, style: AppTextStyles.caption.copyWith(color: color)),
    );
  }
}
