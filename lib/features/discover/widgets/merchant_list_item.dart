import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/models/merchant.dart';
import '../../../shared/widgets/gt_card.dart';

class MerchantListItem extends StatelessWidget {
  final Merchant merchant;

  const MerchantListItem({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    return GtCard(
      onTap: () => context.push('/discover/merchant/${merchant.id}'),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.storefront, color: AppColors.gold, size: 36),
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
                        merchant.name,
                        style: AppTextStyles.heading3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.gold, size: 14),
                        const SizedBox(width: 2),
                        Text('${merchant.rating}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${merchant.distance}km · ${merchant.reviewCount}条评价 · ${merchant.responseTime}',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: merchant.tags
                      .map((tag) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(tag, style: AppTextStyles.caption.copyWith(fontSize: 10)),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
