import 'package:flutter/material.dart';

abstract final class AppConstants {
  static const String appName = '归途 GUITU';
  static const String defaultCity = '上海';

  // Service categories
  static const List<Map<String, dynamic>> serviceCategories = [
    {'icon': Icons.local_hospital_outlined, 'label': '殡仪服务'},
    {'icon': Icons.terrain_outlined, 'label': '墓地选购'},
    {'icon': Icons.memory_outlined, 'label': '数字纪念'},
    {'icon': Icons.assignment_outlined, 'label': '身后事'},
    {'icon': Icons.eco_outlined, 'label': '生态安葬'},
    {'icon': Icons.description_outlined, 'label': '生前契约'},
    {'icon': Icons.shopping_bag_outlined, 'label': '用品商城'},
    {'icon': Icons.help_outline, 'label': '帮助中心'},
  ];
}
