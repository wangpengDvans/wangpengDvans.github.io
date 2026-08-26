part of 'tomb_detail_cubit.dart';

sealed class TombDetailState extends Equatable {
  const TombDetailState();

  @override
  List<Object?> get props => [];
}

final class TombDetailLoading extends TombDetailState {
  const TombDetailLoading();
}

final class TombDetailLoaded extends TombDetailState {
  final Tomb tomb;

  const TombDetailLoaded({required this.tomb});

  @override
  List<Object?> get props => [tomb];
}

final class TombDetailError extends TombDetailState {
  final String message;

  const TombDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
