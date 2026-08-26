import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/gt_card.dart';
import '../../../shared/widgets/gt_list_tile.dart';
import '../../auth/cubit/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('我的')),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const _UserHeader(),
                    const SizedBox(height: 16),
                    const _StatsRow(),
                    const SizedBox(height: 20),
                    const _RoleSwitcher(),
                    const SizedBox(height: 20),
                    _MenuCard(
                      items: [
                        _MenuItem(icon: Icons.receipt_long, title: '我的订单', onTap: () => context.push('/profile/orders')),
                        _MenuItem(icon: Icons.account_tree, title: '治丧计划', onTap: () => context.push('/profile/funeral-plan')),
                        _MenuItem(icon: Icons.checklist, title: '身后事清单', onTap: () {}),
                        _MenuItem(icon: Icons.description, title: '生前契约', onTap: () {}),
                        _MenuItem(icon: Icons.folder_open, title: '合同与收据', onTap: () => context.push('/profile/contracts')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _MenuCard(
                      items: [
                        _MenuItem(icon: Icons.settings, title: '设置', onTap: () {}),
                        _MenuItem(icon: Icons.help_outline, title: '帮助与客服', onTap: () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  const _UserHeader();

  @override
  Widget build(BuildContext context) {
    return GtCard(
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: AppColors.gold, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('张先生', style: AppTextStyles.heading2),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('已实名认证', style: AppTextStyles.caption.copyWith(color: AppColors.success)),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textTertiary),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    final stats = [
      {'label': '订单', 'value': '2'},
      {'label': '进度', 'value': '2/6'},
      {'label': '纪念', 'value': '1'},
    ];
    return GtCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: stats.map((stat) {
          return Column(
            children: [
              Text(stat['value']!, style: AppTextStyles.heading1.copyWith(color: AppColors.gold)),
              const SizedBox(height: 4),
              Text(stat['label']!, style: AppTextStyles.caption),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _RoleSwitcher extends StatelessWidget {
  const _RoleSwitcher();

  @override
  Widget build(BuildContext context) {
    final roles = [
      {'role': UserRole.family, 'label': '丧属'},
      {'role': UserRole.merchant, 'label': '商户'},
      {'role': UserRole.cemetery, 'label': '公墓'},
    ];
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state.userRole) {
          case UserRole.family:
            context.go('/home');
          case UserRole.merchant:
            context.go('/merchant/dashboard');
          case UserRole.cemetery:
            context.go('/cemetery/dashboard');
        }
      },
      builder: (context, state) {
        return GtCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('切换身份', style: AppTextStyles.heading3),
              const SizedBox(height: 12),
              Row(
                children: roles.map((roleMap) {
                  final role = roleMap['role'] as UserRole;
                  final label = roleMap['label'] as String;
                  final isSelected = state.userRole == role;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: InkWell(
                        onTap: () => context.read<AuthCubit>().switchRole(role),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.gold.withOpacity(0.15) : AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected ? AppColors.gold : AppColors.surfaceVariant,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              label,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: isSelected ? AppColors.gold : AppColors.textSecondary,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
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
  final VoidCallback onTap;

  _MenuItem({required this.icon, required this.title, required this.onTap});
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
