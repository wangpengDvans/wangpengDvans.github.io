import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/models/memorial_profile.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/widgets/gt_button.dart';
import '../../../shared/widgets/gt_card.dart';
import '../cubit/memorial_cubit.dart';

class MemorialScreen extends StatelessWidget {
  const MemorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MemorialCubit>()..loadMemorial(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('数字纪念'),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('分享'),
            ),
          ],
        ),
        body: BlocBuilder<MemorialCubit, MemorialState>(
          builder: (context, state) {
            return switch (state) {
              MemorialLoading() => const Center(child: GtLoadingIndicator()),
              MemorialLoaded(profile: final profile) => CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _ProfileCard(profile: profile),
                            const SizedBox(height: 16),
                            _ActionGrid(profile: profile),
                            const SizedBox(height: 24),
                            _SectionHeader(title: '生平时间轴', actionText: '可由 AI 辅助撰写'),
                            const SizedBox(height: 12),
                            ...profile.timeline.map((event) => _TimelineItem(event: event)),
                            const SizedBox(height: 24),
                            _SectionHeader(
                              title: '亲友留言',
                              actionText: '全部',
                              onTap: () => context.push('/memorial/guestbook'),
                            ),
                            const SizedBox(height: 12),
                            ...profile.messages.take(2).map((message) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: _MessageItem(message: message),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              MemorialError(message: final message) => Center(
                  child: Text(message, style: AppTextStyles.body),
                ),
            };
          },
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onTap;

  const _SectionHeader({required this.title, this.actionText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.heading2),
        if (actionText != null)
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text(actionText!, style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
                if (onTap != null) const Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 18),
              ],
            ),
          ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final MemorialProfile profile;

  const _ProfileCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return GtCard(
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gold.withOpacity(0.3), width: 2),
            ),
            child: const Icon(Icons.emoji_objects, color: AppColors.gold, size: 36),
          ),
          const SizedBox(height: 16),
          Text(profile.name, style: AppTextStyles.heading1),
          const SizedBox(height: 6),
          Text(
            '${profile.birthDate} — ${profile.deathDate} · 享年 ${profile.age} 岁',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              profile.epitaph,
              style: AppTextStyles.bodySmall.copyWith(height: 1.6),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CountItem(label: '献花', count: profile.flowerCount),
              Container(width: 1, height: 30, color: AppColors.surfaceVariant, margin: const EdgeInsets.symmetric(horizontal: 20)),
              _CountItem(label: '点烛', count: profile.candleCount),
              Container(width: 1, height: 30, color: AppColors.surfaceVariant, margin: const EdgeInsets.symmetric(horizontal: 20)),
              _CountItem(label: '留言', count: profile.messageCount),
            ],
          ),
        ],
      ),
    );
  }
}

class _CountItem extends StatelessWidget {
  final String label;
  final int count;

  const _CountItem({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$count', style: AppTextStyles.heading2.copyWith(color: AppColors.gold)),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}

class _ActionGrid extends StatelessWidget {
  final MemorialProfile profile;

  const _ActionGrid({required this.profile});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {'icon': Icons.local_florist, 'label': '献花', 'type': 'flower', 'badge': '免费'},
      {'icon': Icons.whatshot, 'label': '点烛', 'type': 'candle', 'badge': '免费'},
      {'icon': Icons.mail_outline, 'label': '留言', 'type': 'message', 'badge': '亲友可见'},
      {'icon': Icons.music_note, 'label': '放音乐', 'type': 'music', 'badge': '送别'},
    ];

    return GtCard(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GtButton(
                  label: '一键转发朋友圈',
                  icon: const Icon(Icons.share, size: 16),
                  onPressed: () => context.read<MemorialCubit>().interact('share'),
                ),
              ),
              const SizedBox(width: 12),
              GtButton(
                label: '邀请亲友',
                variant: GtButtonVariant.outline,
                width: 110,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('已被 ${profile.shareCount} 位亲友转发 · 扫码即可进入献花', style: AppTextStyles.caption),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.85,
            ),
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final action = actions[index];
              return InkWell(
                onTap: () {
                  final type = action['type'] as String;
                  if (type != 'music') {
                    context.read<MemorialCubit>().interact(type);
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(action['icon'] as IconData, color: AppColors.gold, size: 28),
                      const SizedBox(height: 6),
                      Text(action['label'] as String, style: AppTextStyles.caption),
                      const SizedBox(height: 2),
                      Text(action['badge'] as String, style: AppTextStyles.caption.copyWith(fontSize: 9, color: AppColors.textTertiary)),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final TimelineEvent event;

  const _TimelineItem({required this.event});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: AppColors.gold,
                shape: BoxShape.circle,
              ),
            ),
            Container(width: 1, height: 50, color: AppColors.surfaceVariant),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${event.year} · ${event.title}', style: AppTextStyles.heading3),
              if (event.subtitle != null)
                Text(event.subtitle!, style: AppTextStyles.caption),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class _MessageItem extends StatelessWidget {
  final GuestbookMessage message;

  const _MessageItem({required this.message});

  @override
  Widget build(BuildContext context) {
    return GtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(message.author, style: AppTextStyles.heading3.copyWith(color: AppColors.gold)),
              Text(message.date, style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: 8),
          Text(message.content, style: AppTextStyles.bodySmall.copyWith(height: 1.5)),
        ],
      ),
    );
  }
}
