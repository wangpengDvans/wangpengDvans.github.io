import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class GtAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? location;
  final VoidCallback? onLocationTap;
  final List<Widget>? actions;
  final bool showBackButton;

  const GtAppBar({
    super.key,
    this.title,
    this.location,
    this.onLocationTap,
    this.actions,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasLocation = location != null && location!.isNotEmpty;
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      title: title != null
          ? Text(title!, style: AppTextStyles.heading1.copyWith(color: AppColors.textPrimary))
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('归途', style: AppTextStyles.heading1.copyWith(color: AppColors.gold)),
                const SizedBox(width: 6),
                Text('GUITU', style: AppTextStyles.body.copyWith(color: AppColors.textTertiary, letterSpacing: 1)),
                if (hasLocation) ...[
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: onLocationTap,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on, color: AppColors.gold, size: 16),
                        const SizedBox(width: 2),
                        Text(location!, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                        const Icon(Icons.keyboard_arrow_down, color: AppColors.textTertiary, size: 16),
                      ],
                    ),
                  ),
                ],
              ],
            ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
