import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/tomb.dart';
import '../../../domain/repositories/tomb_repository.dart';

part 'tomb_detail_state.dart';

class TombDetailCubit extends Cubit<TombDetailState> {
  final TombRepository _repository;

  TombDetailCubit(this._repository) : super(const TombDetailLoading());

  Future<void> loadDetail(String id) async {
    emit(const TombDetailLoading());
    try {
      final tomb = await _repository.getTombDetail(id);
      emit(TombDetailLoaded(tomb: tomb));
    } catch (e) {
      emit(const TombDetailError('加载墓位详情失败，请稍后重试'));
    }
  }
}
