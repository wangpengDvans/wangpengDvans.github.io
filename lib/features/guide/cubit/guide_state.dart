part of 'guide_cubit.dart';

sealed class GuideState extends Equatable {
  const GuideState();

  @override
  List<Object?> get props => [];
}

final class GuideLoading extends GuideState {
  const GuideLoading();
}

final class GuideLoaded extends GuideState {
  final List<GuideStep> steps;

  const GuideLoaded({required this.steps});

  int get completedCount => steps.where((s) => s.isCompleted).length;

  @override
  List<Object?> get props => [steps];
}

final class GuideError extends GuideState {
  final String message;

  const GuideError(this.message);

  @override
  List<Object?> get props => [message];
}
