import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/models/order.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/widgets/gt_card.dart';
import '../cubit/orders_cubit.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrdersCubit>()..loadOrders(),
      child: Scaffold(
        appBar: AppBar(title: const Text('我的订单')),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            return switch (state) {
              OrdersLoading() => const Center(child: GtLoadingIndicator()),
              OrdersLoaded(orders: final orders) => ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _OrderCard(order: order),
                    );
                  },
                ),
              OrdersError(message: final message) => Center(
                  child: Text(message, style: AppTextStyles.body),
                ),
            };
          },
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final isCompleted = order.status == '已完成';
    return GtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.title, style: AppTextStyles.heading3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.success.withOpacity(0.15) : AppColors.gold.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  order.status,
                  style: AppTextStyles.caption.copyWith(
                    color: isCompleted ? AppColors.success : AppColors.gold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(order.merchantName, style: AppTextStyles.bodySmall),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.date, style: AppTextStyles.caption),
              Text('¥${order.amount.toStringAsFixed(0)}', style: AppTextStyles.price),
            ],
          ),
        ],
      ),
    );
  }
}
