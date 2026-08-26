import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/gt_card.dart';
import '../../../shared/widgets/gt_list_tile.dart';

class MerchantDashboardScreen extends StatelessWidget {
  const MerchantDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商户工作台'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/profile'),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('今日数据', style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                  const _KpiGrid(),
                  const SizedBox(height: 20),
                  _MenuCard(
                    items: [
                      _MenuItem(
                        icon: Icons.receipt_long,
                        title: '订单管理',
                        subtitle: '待处理 3 笔',
                        onTap: () => context.push('/merchant/orders'),
                      ),
                      _MenuItem(
                        icon: Icons.rate_review,
                        title: '评价管理',
                        subtitle: '新增 2 条',
                        onTap: () => context.push('/merchant/reviews'),
                      ),
                      _MenuItem(
                        icon: Icons.trending_up,
                        title: '经营分析',
                        onTap: () => context.push('/merchant/analytics'),
                      ),
                      _MenuItem(
                        icon: Icons.verified_user,
                        title: '民政数据上报',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _MenuCard(
                    items: [
                      _MenuItem(
                        icon: Icons.campaign,
                        title: '推广通',
                        onTap: () {},
                      ),
                      _MenuItem(
                        icon: Icons.settings,
                        title: '店铺设置',
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiGrid extends StatelessWidget {
  const _KpiGrid();

  @override
  Widget build(BuildContext context) {
    final kpis = [
      {'label': '今日订单', 'value': '5'},
      {'label': '今日成交额', 'value': '¥3.2万'},
      {'label': '待处理', 'value': '3'},
      {'label': '好评率', 'value': '98%'},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemCount: kpis.length,
      itemBuilder: (context, index) {
        final kpi = kpis[index];
        return GtCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(kpi['value']!, style: AppTextStyles.heading1.copyWith(color: AppColors.gold)),
              const SizedBox(height: 6),
              Text(kpi['label']!, style: AppTextStyles.caption),
            ],
          ),
        );
      },
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  _MenuItem({required this.icon, required this.title, this.subtitle, required this.onTap});
}

class _MenuCard extends StatelessWidget {
  final List<_MenuItem> items;

  const _MenuCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return GtCard(
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Column(
            children: [
              GtListTile(
                leading: Icon(item.icon, color: AppColors.gold, size: 22),
                title: item.title,
                subtitle: item.subtitle,
                onTap: item.onTap,
              ),
              if (index < items.length - 1)
                const Divider(height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }
}
