import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/guide_step.dart';
import '../../../domain/repositories/guide_repository.dart';

part 'guide_state.dart';

class GuideCubit extends Cubit<GuideState> {
  final GuideRepository _repository;

  GuideCubit(this._repository) : super(const GuideLoading());

  Future<void> loadGuide() async {
    emit(const GuideLoading());
    try {
      final steps = await _repository.getGuideSteps();
      emit(GuideLoaded(steps: steps));
    } catch (e) {
      emit(const GuideError('加载失败，请稍后重试'));
    }
  }

  Future<void> toggleStep(int index) async {
    if (state is! GuideLoaded) return;
    final current = state as GuideLoaded;
    final step = current.steps.firstWhere((s) => s.index == index);
    await _repository.updateStepCompletion(index, !step.isCompleted);
    final updatedSteps = current.steps.map((s) {
      if (s.index == index) return s.copyWith(isCompleted: !s.isCompleted);
      return s;
    }).toList();
    emit(GuideLoaded(steps: updatedSteps));
  }
}
