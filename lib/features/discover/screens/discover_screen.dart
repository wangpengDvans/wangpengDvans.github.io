import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/widgets/gt_chip.dart';
import '../cubit/discover_cubit.dart';
import '../cubit/tomb_discovery_cubit.dart';
import '../widgets/merchant_list_item.dart';
import '../widgets/tomb_list_item.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<DiscoverCubit>()..loadMerchants(),
        ),
        BlocProvider(
          create: (context) => getIt<TombDiscoveryCubit>()..loadTombs(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('发现'),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.gold,
            labelColor: AppColors.gold,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
            unselectedLabelStyle: AppTextStyles.body,
            tabs: const [
              Tab(text: '殡仪商户'),
              Tab(text: '墓位陵园'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            _MerchantTab(),
            _TombTab(),
          ],
        ),
      ),
    );
  }
}

class _MerchantTab extends StatelessWidget {
  const _MerchantTab();

  final List<Map<String, String>> _sortOptions = const [
    {'value': 'recommend', 'label': '推荐'},
    {'value': 'distance', 'label': '距离最近'},
    {'value': 'price', 'label': '价格最低'},
    {'value': 'rating', 'label': '评分最高'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FilterBar(sortOptions: _sortOptions),
        Expanded(
          child: BlocBuilder<DiscoverCubit, DiscoverState>(
            builder: (context, state) {
              return switch (state) {
                DiscoverLoading() => const Center(child: GtLoadingIndicator()),
                DiscoverLoaded(merchants: final merchants) => ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: merchants.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: MerchantListItem(merchant: merchants[index]),
                    ),
                  ),
                DiscoverError(message: final message) => Center(
                    child: Text(message, style: AppTextStyles.body),
                  ),
              };
            },
          ),
        ),
      ],
    );
  }
}

class _FilterBar extends StatelessWidget {
  final List<Map<String, String>> sortOptions;

  const _FilterBar({required this.sortOptions});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: BlocBuilder<DiscoverCubit, DiscoverState>(
        builder: (context, state) {
          final selectedSort = state is DiscoverLoaded ? state.selectedSort : 'recommend';
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...sortOptions.map((option) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GtChip(
                      label: option['label']!,
                      isSelected: selectedSort == option['value'],
                      onTap: () => context.read<DiscoverCubit>().selectSort(option['value']!),
                    ),
                  );
                }),
                GtChip(
                  label: '更多筛选 ▾',
                  isSelected: false,
                  onTap: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TombTab extends StatelessWidget {
  const _TombTab();

  final List<Map<String, String>> _sortOptions = const [
    {'value': 'recommend', 'label': '推荐'},
    {'value': 'price_asc', 'label': '价格最低'},
    {'value': 'price_desc', 'label': '价格最高'},
    {'value': 'size', 'label': '面积最大'},
  ];

  final List<String> _statuses = const ['全部', '可售', '已售', '预留'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.surface,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: BlocBuilder<TombDiscoveryCubit, TombDiscoveryState>(
            builder: (context, state) {
              final selectedStatus = state is TombDiscoveryLoaded ? state.selectedStatus : '全部';
              final selectedSort = state is TombDiscoveryLoaded ? state.selectedSort : 'recommend';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _statuses.map((status) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GtChip(
                            label: status,
                            isSelected: selectedStatus == status,
                            onTap: () => context.read<TombDiscoveryCubit>().selectStatus(status),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _sortOptions.map((option) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GtChip(
                            label: option['label']!,
                            isSelected: selectedSort == option['value'],
                            onTap: () => context.read<TombDiscoveryCubit>().selectSort(option['value']!),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<TombDiscoveryCubit, TombDiscoveryState>(
            builder: (context, state) {
              return switch (state) {
                TombDiscoveryLoading() => const Center(child: GtLoadingIndicator()),
                TombDiscoveryLoaded(tombs: final tombs) => ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: tombs.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TombListItem(tomb: tombs[index]),
                    ),
                  ),
                TombDiscoveryError(message: final message) => Center(
                    child: Text(message, style: AppTextStyles.body),
                  ),
              };
            },
          ),
        ),
      ],
    );
  }
}
