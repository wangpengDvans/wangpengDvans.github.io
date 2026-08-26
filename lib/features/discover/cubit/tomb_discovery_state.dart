part of 'tomb_discovery_cubit.dart';

sealed class TombDiscoveryState extends Equatable {
  const TombDiscoveryState();

  @override
  List<Object?> get props => [];
}

final class TombDiscoveryLoading extends TombDiscoveryState {
  const TombDiscoveryLoading();
}

final class TombDiscoveryLoaded extends TombDiscoveryState {
  final List<Tomb> tombs;
  final String selectedStatus;
  final String selectedSort;

  const TombDiscoveryLoaded({
    required this.tombs,
    required this.selectedStatus,
    required this.selectedSort,
  });

  @override
  List<Object?> get props => [tombs, selectedStatus, selectedSort];
}

final class TombDiscoveryError extends TombDiscoveryState {
  final String message;

  const TombDiscoveryError(this.message);

  @override
  List<Object?> get props => [message];
}
