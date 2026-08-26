import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/gt_button.dart';

class CemeteryMapScreen extends StatelessWidget {
  const CemeteryMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('陵园地图')),
      body: Stack(
        children: [
          // Stylized map background
          Positioned.fill(
            child: Container(
              color: const Color(0xFF1E1E1E),
              child: CustomPaint(
                painter: _MapPainter(),
              ),
            ),
          ),
          // Map markers
          ..._buildMarkers(),
          // Legend / info card
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.surfaceVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('墓位分布', style: AppTextStyles.heading3),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _LegendItem(color: AppColors.gold, label: '可售'),
                      _LegendItem(color: AppColors.error, label: '预留'),
                      _LegendItem(color: AppColors.success, label: '已售'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GtButton(
                    label: '查看墓位库存',
                    onPressed: () => context.push('/cemetery/inventory'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMarkers() {
    final markers = [
      {'x': 0.25, 'y': 0.35, 'status': '可售', 'label': 'A-01'},
      {'x': 0.45, 'y': 0.28, 'status': '已售', 'label': 'A-02'},
      {'x': 0.65, 'y': 0.42, 'status': '预留', 'label': 'B-03'},
      {'x': 0.35, 'y': 0.58, 'status': '可售', 'label': 'C-05'},
      {'x': 0.72, 'y': 0.62, 'status': '可售', 'label': 'D-08'},
    ];
    return markers.map((m) {
      Color color;
      switch (m['status']) {
        case '已售':
          color = AppColors.success;
        case '预留':
          color = AppColors.error;
        default:
          color = AppColors.gold;
      }
      final x = m['x'] as double;
      final y = m['y'] as double;
      return Align(
        alignment: Alignment(x * 2 - 1, y * 2 - 1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                m['label'] as String,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.scaffoldBackground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              width: 2,
              height: 8,
              color: color,
            ),
          ],
        ),
      );
    }).toList();
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pathPaint = Paint()
      ..color = const Color(0xFF2A2A2A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw grid-like paths
    for (var i = 0; i < 5; i++) {
      final y = size.height * (0.2 + i * 0.15);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), pathPaint);
    }
    for (var i = 0; i < 4; i++) {
      final x = size.width * (0.15 + i * 0.22);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), pathPaint);
    }

    // Draw some "green" areas
    final greenPaint = Paint()
      ..color = const Color(0xFF252E25)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.22), 48, greenPaint);
    canvas.drawCircle(Offset(size.width * 0.18, size.height * 0.72), 64, greenPaint);

    // Draw water
    final waterPaint = Paint()
      ..color = const Color(0xFF1A2632)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.55, size.height * 0.75), 56, waterPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.bodySmall),
      ],
    );
  }
}
