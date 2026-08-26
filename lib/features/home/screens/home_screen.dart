import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/widgets/gt_card.dart';
import '../../../shared/widgets/gt_search_bar.dart';
import '../cubit/home_cubit.dart';
import '../widgets/funeral_guide_card.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/nearby_merchant_section.dart';
import '../widgets/service_category_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..loadHome(),
      child: Scaffold(
        appBar: const HomeAppBar(location: '上海'),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return switch (state) {
              HomeLoading() => const Center(child: GtLoadingIndicator()),
              HomeLoaded(data: final data) => CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const GtSearchBar(),
                            const SizedBox(height: 16),
                            FuneralGuideCard(
                              completedSteps: data.guideCompletedSteps,
                              totalSteps: data.guideTotalSteps,
                            ),
                            const SizedBox(height: 20),
                            ServiceCategoryGrid(categories: data.categories),
                            const SizedBox(height: 20),
                            const _TransparencyBanner(),
                            const SizedBox(height: 24),
                            NearbyMerchantSection(merchants: data.nearbyMerchants),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              HomeError(message: final message) => Center(
                  child: Text(message, style: AppTextStyles.body),
                ),
            };
          },
        ),
      ),
    );
  }
}

class _TransparencyBanner extends StatelessWidget {
  const _TransparencyBanner();

  @override
  Widget build(BuildContext context) {
    return GtCard(
      backgroundColor: AppColors.surface,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.verified_user, color: AppColors.gold, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '价格透明承诺：平台内所有商户资质、服务套餐与单项价格均前置公示，「常见加项」逐条列明，无隐藏费用。墓位交易定金由合作银行托管。',
              style: AppTextStyles.caption.copyWith(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
