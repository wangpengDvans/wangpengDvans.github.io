import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../domain/models/guide_step.dart';
import '../../../domain/repositories/guide_repository.dart';

class MockGuideRepository implements GuideRepository {
  List<GuideStep>? _steps;

  Future<void> _loadData() async {
    if (_steps != null) return;
    await Future.delayed(const Duration(milliseconds: 500));
    final jsonString = await rootBundle.loadString('assets/mock/guide_steps.json');
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    _steps = (json['steps'] as List<dynamic>)
        .map((e) => GuideStep.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<GuideStep>> getGuideSteps() async {
    await _loadData();
    return List.unmodifiable(_steps!);
  }

  @override
  Future<void> updateStepCompletion(int index, bool isCompleted) async {
    await _loadData();
    final stepIndex = _steps!.indexWhere((s) => s.index == index);
    if (stepIndex >= 0) {
      _steps![stepIndex] = _steps![stepIndex].copyWith(isCompleted: isCompleted);
    }
  }
}
