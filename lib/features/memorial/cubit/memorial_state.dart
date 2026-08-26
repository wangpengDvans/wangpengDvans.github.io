part of 'memorial_cubit.dart';

sealed class MemorialState extends Equatable {
  const MemorialState();

  @override
  List<Object?> get props => [];
}

final class MemorialLoading extends MemorialState {
  const MemorialLoading();
}

final class MemorialLoaded extends MemorialState {
  final MemorialProfile profile;

  const MemorialLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

final class MemorialError extends MemorialState {
  final String message;

  const MemorialError(this.message);

  @override
  List<Object?> get props => [message];
}
