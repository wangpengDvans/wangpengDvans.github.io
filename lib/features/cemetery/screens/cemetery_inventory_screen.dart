import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/gt_card.dart';
import '../../../shared/widgets/gt_chip.dart';

class CemeteryInventoryScreen extends StatefulWidget {
  const CemeteryInventoryScreen({super.key});

  @override
  State<CemeteryInventoryScreen> createState() => _CemeteryInventoryScreenState();
}

class _CemeteryInventoryScreenState extends State<CemeteryInventoryScreen> {
  String _selectedFilter = '全部';
  final List<String> _filters = ['全部', '可售', '已售', '预留', 'VR已拍'];

  final List<Map<String, String>> _tombs = [
    {'id': 'A-01-08', 'area': 'A区', 'type': '双穴墓', 'status': '可售', 'price': '128000', 'vr': 'true'},
    {'id': 'A-02-03', 'area': 'A区', 'type': '双穴墓', 'status': '已售', 'price': '135000', 'vr': 'true'},
    {'id': 'B-01-12', 'area': 'B区', 'type': '生态葬', 'status': '可售', 'price': '38000', 'vr': 'false'},
    {'id': 'B-03-05', 'area': 'B区', 'type': '家族墓', 'status': '预留', 'price': '288000', 'vr': 'true'},
    {'id': 'C-02-09', 'area': 'C区', 'type': '双穴墓', 'status': '可售', 'price': '98000', 'vr': 'true'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredTombs = _selectedFilter == '全部'
        ? _tombs
        : _tombs.where((t) => t['status'] == _selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('墓位库存')),
      body: Column(
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GtChip(
                      label: filter,
                      isSelected: _selectedFilter == filter,
                      onTap: () => setState(() => _selectedFilter = filter),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredTombs.length,
              itemBuilder: (context, index) {
                final tomb = filteredTombs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GtCard(
                    child: Row(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.terrain, color: AppColors.gold, size: 32),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(tomb['id']!, style: AppTextStyles.heading3),
                                  _StatusBadge(status: tomb['status']!),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text('${tomb['area']} · ${tomb['type']}', style: AppTextStyles.caption),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('¥${tomb['price']}', style: AppTextStyles.priceSmall),
                                  if (tomb['vr'] == 'true')
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.gold.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text('VR', style: AppTextStyles.caption.copyWith(color: AppColors.gold, fontSize: 10)),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case '已售':
        color = AppColors.success;
      case '预留':
        color = AppColors.error;
      case 'VR已拍':
        color = AppColors.gold;
      default:
        color = AppColors.gold;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(status, style: AppTextStyles.caption.copyWith(color: color)),
    );
  }
}
