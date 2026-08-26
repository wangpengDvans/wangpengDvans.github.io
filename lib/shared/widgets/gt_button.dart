import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

enum GtButtonVariant { primary, outline, text }

class GtButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final GtButtonVariant variant;
  final double? width;
  final double height;
  final Widget? icon;

  const GtButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = GtButtonVariant.primary,
    this.width,
    this.height = 44,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[icon!, const SizedBox(width: 8)],
        Text(label, style: AppTextStyles.button),
      ],
    );

    Widget button;
    switch (variant) {
      case GtButtonVariant.primary:
        button = ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(width ?? double.infinity, height),
            backgroundColor: AppColors.gold,
            foregroundColor: AppColors.scaffoldBackground,
          ),
          child: child,
        );
      case GtButtonVariant.outline:
        button = OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: Size(width ?? double.infinity, height),
            side: const BorderSide(color: AppColors.gold),
          ),
          child: child,
        );
      case GtButtonVariant.text:
        button = TextButton(
          onPressed: onPressed,
          child: child,
        );
    }

    if (width != null) {
      return SizedBox(width: width, child: button);
    }
    return button;
  }
}
