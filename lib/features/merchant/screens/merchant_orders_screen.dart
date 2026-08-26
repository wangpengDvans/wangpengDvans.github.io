import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/gt_card.dart';
import '../../../shared/widgets/gt_chip.dart';

class MerchantOrdersScreen extends StatefulWidget {
  const MerchantOrdersScreen({super.key});

  @override
  State<MerchantOrdersScreen> createState() => _MerchantOrdersScreenState();
}

class _MerchantOrdersScreenState extends State<MerchantOrdersScreen> {
  String _selectedStatus = '全部';

  final List<String> _statuses = ['全部', '待处理', '进行中', '已完成'];
  final List<Map<String, String>> _orders = [
    {'title': '标准告别套餐', 'customer': '张先生', 'date': '2026-07-18', 'status': '进行中', 'amount': '15800'},
    {'title': '基础告别套餐', 'customer': '李女士', 'date': '2026-07-17', 'status': '待处理', 'amount': '9800'},
    {'title': '骨灰盒（楠木）', 'customer': '王先生', 'date': '2026-07-16', 'status': '已完成', 'amount': '2800'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredOrders = _selectedStatus == '全部'
        ? _orders
        : _orders.where((o) => o['status'] == _selectedStatus).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('订单管理')),
      body: Column(
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _statuses.map((status) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GtChip(
                      label: status,
                      isSelected: _selectedStatus == status,
                      onTap: () => setState(() => _selectedStatus = status),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GtCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(order['title']!, style: AppTextStyles.heading3),
                            _StatusBadge(status: order['status']!),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('客户：${order['customer']}', style: AppTextStyles.bodySmall),
                        const SizedBox(height: 4),
                        Text(order['date']!, style: AppTextStyles.caption),
                        const SizedBox(height: 12),
                        Text('¥${order['amount']}', style: AppTextStyles.price),
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
      case '已完成':
        color = AppColors.success;
      case '待处理':
        color = AppColors.error;
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
