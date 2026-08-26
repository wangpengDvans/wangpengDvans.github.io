import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/gt_card.dart';
import '../../../shared/widgets/gt_list_tile.dart';

class CemeteryDashboardScreen extends StatelessWidget {
  const CemeteryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('公墓管理'),
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
                  Text('园区概览', style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                  const _KpiGrid(),
                  const SizedBox(height: 20),
                  _MenuCard(
                    items: [
                      _MenuItem(
                        icon: Icons.grid_on,
                        title: '墓位库存',
                        subtitle: '可售 128 个',
                        onTap: () => context.push('/cemetery/inventory'),
                      ),
                      _MenuItem(
                        icon: Icons.map,
                        title: 'GIS 地图',
                        onTap: () => context.push('/cemetery/map'),
                      ),
                      _MenuItem(
                        icon: Icons.trending_up,
                        title: '销售分析',
                        onTap: () {},
                      ),
                      _MenuItem(
                        icon: Icons.panorama,
                        title: 'VR 拍摄管理',
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
      {'label': '总墓位', 'value': '1,256'},
      {'label': '已售', 'value': '892'},
      {'label': '可售', 'value': '128'},
      {'label': '本月成交', 'value': '15'},
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
