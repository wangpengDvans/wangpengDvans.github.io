import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTextStyles {
  static const _base = TextStyle(color: AppColors.textPrimary);

  static final heading1 = _base.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static final heading2 = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static final heading3 = _base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final body = _base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static final bodySmall = _base.copyWith(
    fontSize: 13,
    color: AppColors.textSecondary,
  );

  static final caption = _base.copyWith(
    fontSize: 12,
    color: AppColors.textTertiary,
  );

  static final price = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.gold,
  );

  static final priceSmall = _base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.gold,
  );

  static final button = _base.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
}
