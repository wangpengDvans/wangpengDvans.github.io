import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/constants/app_constants.dart';
import '../../../domain/models/tomb.dart';
import '../../../domain/repositories/tomb_repository.dart';

part 'tomb_discovery_state.dart';

class TombDiscoveryCubit extends Cubit<TombDiscoveryState> {
  final TombRepository _repository;

  TombDiscoveryCubit(this._repository) : super(const TombDiscoveryLoading());

  Future<void> loadTombs({String? status, String sortBy = 'recommend'}) async {
    emit(const TombDiscoveryLoading());
    try {
      final tombs = await _repository.getAvailableTombs(
        city: AppConstants.defaultCity,
        status: status,
        sortBy: sortBy == 'recommend' ? null : sortBy,
      );
      emit(TombDiscoveryLoaded(tombs: tombs, selectedStatus: status ?? '全部', selectedSort: sortBy));
    } catch (e) {
      emit(const TombDiscoveryError('加载墓位失败，请稍后重试'));
    }
  }

  void selectStatus(String status) {
    if (state is TombDiscoveryLoaded) {
      final current = state as TombDiscoveryLoaded;
      if (current.selectedStatus == status) return;
      loadTombs(status: status, sortBy: current.selectedSort);
    }
  }

  void selectSort(String sortBy) {
    if (state is TombDiscoveryLoaded) {
      final current = state as TombDiscoveryLoaded;
      if (current.selectedSort == sortBy) return;
      loadTombs(status: current.selectedStatus, sortBy: sortBy);
    }
  }
}
