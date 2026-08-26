import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/gt_card.dart';

class MerchantAnalyticsScreen extends StatelessWidget {
  const MerchantAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('经营分析')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _KpiRow(),
            const SizedBox(height: 20),
            Text('近 7 日订单趋势', style: AppTextStyles.heading2),
            const SizedBox(height: 12),
            const _BarChartCard(),
            const SizedBox(height: 20),
            Text('套餐销量占比', style: AppTextStyles.heading2),
            const SizedBox(height: 12),
            const _PieChartCard(),
            const SizedBox(height: 20),
            Text('客户来源', style: AppTextStyles.heading2),
            const SizedBox(height: 12),
            _SourceList(),
          ],
        ),
      ),
    );
  }
}

class _KpiRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kpis = [
      {'label': '本周营收', 'value': '¥45,800', 'delta': '+12%'},
      {'label': '成交订单', 'value': '12', 'delta': '+3'},
      {'label': '转化率', 'value': '28%', 'delta': '+2%'},
    ];
    return Row(
      children: kpis.map((kpi) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GtCard(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(kpi['label']!, style: AppTextStyles.caption),
                  const SizedBox(height: 8),
                  Text(kpi['value']!, style: AppTextStyles.heading3.copyWith(color: AppColors.gold)),
                  const SizedBox(height: 4),
                  Text(kpi['delta']!, style: AppTextStyles.caption.copyWith(color: AppColors.success)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _BarChartCard extends StatelessWidget {
  const _BarChartCard();

  @override
  Widget build(BuildContext context) {
    final data = [
      {'day': '周一', 'value': 2},
      {'day': '周二', 'value': 4},
      {'day': '周三', 'value': 3},
      {'day': '周四', 'value': 5},
      {'day': '周五', 'value': 7},
      {'day': '周六', 'value': 6},
      {'day': '周日', 'value': 8},
    ];
    final max = data.map((d) => d['value'] as int).reduce((a, b) => a > b ? a : b);
    return GtCard(
      child: SizedBox(
        height: 180,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: data.map((d) {
            final value = d['value'] as int;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('$value', style: AppTextStyles.caption),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      height: 100 * (value / max),
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(d['day'] as String, style: AppTextStyles.caption),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _PieChartCard extends StatelessWidget {
  const _PieChartCard();

  @override
  Widget build(BuildContext context) {
    final segments = [
      {'label': '标准告别套餐', 'value': 0.45, 'color': AppColors.gold},
      {'label': '基础告别套餐', 'value': 0.30, 'color': AppColors.goldLight},
      {'label': '骨灰盒', 'value': 0.15, 'color': AppColors.goldDark},
      {'label': '其他', 'value': 0.10, 'color': AppColors.surfaceVariant},
    ];
    return GtCard(
      child: Row(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CustomPaint(
              painter: _PiePainter(segments: segments),
              size: const Size(120, 120),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: segments.map((s) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: s['color'] as Color,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${s['label']} ${((s['value'] as double) * 100).toStringAsFixed(0)}%',
                          style: AppTextStyles.bodySmall,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PiePainter extends CustomPainter {
  final List<Map<String, Object>> segments;

  _PiePainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    var startAngle = -90.0;
    for (final segment in segments) {
      final value = segment['value'] as double;
      final sweepAngle = value * 360;
      final paint = Paint()
        ..color = segment['color'] as Color
        ..style = PaintingStyle.fill;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle * 3.141592653589793 / 180,
        sweepAngle * 3.141592653589793 / 180,
        true,
        paint,
      );
      startAngle += sweepAngle;
    }
    // Donut hole
    final holePaint = Paint()
      ..color = AppColors.cardBackground
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.55, holePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SourceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sources = [
      {'label': '平台搜索', 'value': '45%', 'icon': Icons.search},
      {'label': '老客户推荐', 'value': '30%', 'icon': Icons.people_outline},
      {'label': '公墓导流', 'value': '15%', 'icon': Icons.terrain},
      {'label': '其他渠道', 'value': '10%', 'icon': Icons.more_horiz},
    ];
    return GtCard(
      child: Column(
        children: sources.map((s) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Icon(s['icon'] as IconData, color: AppColors.gold, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(s['label'] as String, style: AppTextStyles.bodySmall)),
                Text(s['value'] as String, style: AppTextStyles.bodySmall.copyWith(color: AppColors.gold)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
