import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/models/merchant.dart';
import '../../../shared/widgets/gt_card.dart';

class MerchantCard extends StatelessWidget {
  final Merchant merchant;

  const MerchantCard({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    return GtCard(
      onTap: () => context.push('/discover/merchant/${merchant.id}'),
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
          const SizedBox(height: 6),
          Text(
            '${merchant.distance}km · 好评率${(merchant.rating * 20).toInt()}% · 已服务${merchant.servedCount}+ · ${merchant.responseTime}',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: merchant.tags
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
        ],
      ),
    );
  }
}
