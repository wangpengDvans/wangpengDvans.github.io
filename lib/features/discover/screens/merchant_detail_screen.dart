import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/models/merchant.dart';
import '../../../domain/models/service_package.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/widgets/gt_button.dart';
import '../../../shared/widgets/gt_card.dart';
import '../cubit/merchant_detail_cubit.dart';

class MerchantDetailScreen extends StatelessWidget {
  final String merchantId;

  const MerchantDetailScreen({super.key, required this.merchantId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MerchantDetailCubit>()..loadDetail(merchantId),
      child: Scaffold(
        appBar: AppBar(title: const Text('商户详情')),
        body: BlocBuilder<MerchantDetailCubit, MerchantDetailState>(
          builder: (context, state) {
            return switch (state) {
              MerchantDetailLoading() => const Center(child: GtLoadingIndicator()),
              MerchantDetailLoaded(merchant: final merchant, packages: final packages) => CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _MerchantHeader(merchant: merchant),
                            const SizedBox(height: 20),
                            Text('服务套餐', style: AppTextStyles.heading2),
                            const SizedBox(height: 12),
                            ...packages.map((package) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _PackageCard(package: package),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              MerchantDetailError(message: final message) => Center(
                  child: Text(message, style: AppTextStyles.body),
                ),
            };
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GtButton(
              label: '立即咨询',
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}

class _MerchantHeader extends StatelessWidget {
  final Merchant merchant;

  const _MerchantHeader({required this.merchant});

  @override
  Widget build(BuildContext context) {
    return GtCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.storefront, color: AppColors.gold, size: 40),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(merchant.name, style: AppTextStyles.heading2),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.gold, size: 16),
                    const SizedBox(width: 4),
                    Text('${merchant.rating}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold)),
                    const SizedBox(width: 8),
                    Text('${merchant.reviewCount}条评价', style: AppTextStyles.caption),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '${merchant.distance}km · 已服务${merchant.servedCount}+ · ${merchant.responseTime}',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
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
          ),
        ],
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final ServicePackage package;

  const _PackageCard({required this.package});

  @override
  Widget build(BuildContext context) {
    return GtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(package.name, style: AppTextStyles.heading3),
              Row(
                children: [
                  if (package.badge != null)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        package.badge!,
                        style: AppTextStyles.caption.copyWith(color: AppColors.gold, fontSize: 10),
                      ),
                    ),
                  Text('¥${package.price.toStringAsFixed(0)}', style: AppTextStyles.price),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...package.items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('· ', style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold)),
                    Expanded(child: Text(item, style: AppTextStyles.bodySmall)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
