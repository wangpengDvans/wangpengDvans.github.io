import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class GtLoadingIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;

  const GtLoadingIndicator({super.key, this.size = 36, this.strokeWidth = 3});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: AppColors.gold,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
