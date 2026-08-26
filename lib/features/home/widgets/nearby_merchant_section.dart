import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/models/merchant.dart';
import '../../../shared/widgets/gt_card.dart';

class NearbyMerchantSection extends StatelessWidget {
  final List<Merchant> merchants;

  const NearbyMerchantSection({super.key, required this.merchants});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('附近推荐', style: AppTextStyles.heading2),
                const SizedBox(width: 8),
                Text('按距离', style: AppTextStyles.caption),
              ],
            ),
            GestureDetector(
              onTap: () => context.push('/discover'),
              child: Row(
                children: [
                  Text('全部', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                  const Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 18),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...merchants.map((merchant) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _MerchantListItem(merchant: merchant),
            )),
      ],
    );
  }
}

class _MerchantListItem extends StatelessWidget {
  final Merchant merchant;

  const _MerchantListItem({required this.merchant});

  @override
  Widget build(BuildContext context) {
    return GtCard(
      onTap: () => context.push('/discover/merchant/${merchant.id}'),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.storefront, color: AppColors.gold, size: 32),
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
                  '${merchant.distance}km · 已服务${merchant.servedCount}+ · ${merchant.responseTime}',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: merchant.tags
                      .take(3)
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
