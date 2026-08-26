import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/gt_card.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contracts = [
      {'title': '殡仪服务合同', 'merchant': '永安殡仪服务', 'date': '2026-07-18', 'status': '生效中'},
      {'title': '骨灰盒购买收据', 'merchant': '永安殡仪服务', 'date': '2026-07-16', 'status': '已完成'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('合同与收据')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: contracts.length,
        itemBuilder: (context, index) {
          final contract = contracts[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GtCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(contract['title']!, style: AppTextStyles.heading3),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          contract['status']!,
                          style: AppTextStyles.caption.copyWith(color: AppColors.gold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(contract['merchant']!, style: AppTextStyles.bodySmall),
                  const SizedBox(height: 8),
                  Text(contract['date']!, style: AppTextStyles.caption),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
