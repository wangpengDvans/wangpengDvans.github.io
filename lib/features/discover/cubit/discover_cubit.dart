import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/constants/app_constants.dart';
import '../../../domain/models/merchant.dart';
import '../../../domain/repositories/merchant_repository.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  final MerchantRepository _repository;

  DiscoverCubit(this._repository) : super(const DiscoverLoading());

  Future<void> loadMerchants({String sortBy = 'recommend'}) async {
    emit(const DiscoverLoading());
    try {
      final merchants = await _repository.getNearbyMerchants(
        city: AppConstants.defaultCity,
        sortBy: sortBy == 'recommend' ? null : sortBy,
      );
      emit(DiscoverLoaded(merchants: merchants, selectedSort: sortBy));
    } catch (e) {
      emit(const DiscoverError('加载失败，请稍后重试'));
    }
  }

  void selectSort(String sortBy) {
    if (state is DiscoverLoaded) {
      final current = state as DiscoverLoaded;
      if (current.selectedSort == sortBy) return;
      loadMerchants(sortBy: sortBy);
    }
  }
}
