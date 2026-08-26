part of 'discover_cubit.dart';

sealed class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object?> get props => [];
}

final class DiscoverLoading extends DiscoverState {
  const DiscoverLoading();
}

final class DiscoverLoaded extends DiscoverState {
  final List<Merchant> merchants;
  final String selectedSort;

  const DiscoverLoaded({
    required this.merchants,
    required this.selectedSort,
  });

  @override
  List<Object?> get props => [merchants, selectedSort];
}

final class DiscoverError extends DiscoverState {
  final String message;

  const DiscoverError(this.message);

  @override
  List<Object?> get props => [message];
}
