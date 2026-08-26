import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/gt_card.dart';

class MerchantReviewsScreen extends StatelessWidget {
  const MerchantReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reviews = <Map<String, dynamic>>[
      {
        'author': '张先生',
        'rating': '5.0',
        'date': '2026-07-20',
        'content': '服务很周到，工作人员耐心细致，整个流程都很顺利。',
        'tags': ['态度好', '专业'],
      },
      {
        'author': '李女士',
        'rating': '4.8',
        'date': '2026-07-18',
        'content': '价格透明，没有隐形消费，值得信赖。',
        'tags': ['明码标价'],
      },
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('评价管理')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GtCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(review['author']!, style: AppTextStyles.heading3),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, color: AppColors.gold, size: 14),
                              const SizedBox(width: 2),
                              Text(review['rating']!, style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold)),
                            ],
                          ),
                        ],
                      ),
                      Text(review['date']!, style: AppTextStyles.caption),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(review['content']!, style: AppTextStyles.bodySmall.copyWith(height: 1.5)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    children: (review['tags']! as List<String>)
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
          );
        },
      ),
    );
  }
}
