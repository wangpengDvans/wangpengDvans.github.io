import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/constants/app_constants.dart';
import '../../../domain/models/home_data.dart';
import '../../../domain/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeCubit(this._repository) : super(const HomeLoading());

  Future<void> loadHome() async {
    emit(const HomeLoading());
    try {
      final data = await _repository.loadHomeData(city: AppConstants.defaultCity);
      emit(HomeLoaded(data));
    } catch (e) {
      emit(HomeError('加载失败，请稍后重试'));
    }
  }
}
