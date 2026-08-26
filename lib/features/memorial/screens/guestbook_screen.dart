import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/widgets/gt_card.dart';
import '../cubit/memorial_cubit.dart';

class GuestbookScreen extends StatelessWidget {
  const GuestbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MemorialCubit>()..loadMemorial(),
      child: Scaffold(
        appBar: AppBar(title: const Text('亲友留言')),
        body: BlocBuilder<MemorialCubit, MemorialState>(
          builder: (context, state) {
            return switch (state) {
              MemorialLoading() => const Center(child: GtLoadingIndicator()),
              MemorialLoaded(profile: final profile) => ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: profile.messages.length,
                  itemBuilder: (context, index) {
                    final message = profile.messages[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GtCard(
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
                      ),
                    );
                  },
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
