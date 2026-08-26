import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/memorial_profile.dart';
import '../../../domain/repositories/memorial_repository.dart';

part 'memorial_state.dart';

class MemorialCubit extends Cubit<MemorialState> {
  final MemorialRepository _repository;

  MemorialCubit(this._repository) : super(const MemorialLoading());

  Future<void> loadMemorial() async {
    emit(const MemorialLoading());
    try {
      final profile = await _repository.getMemorialProfile('mem1');
      emit(MemorialLoaded(profile));
    } catch (e) {
      emit(const MemorialError('加载失败，请稍后重试'));
    }
  }

  Future<void> interact(String type) async {
    if (state is! MemorialLoaded) return;
    try {
      final updated = await _repository.interact('mem1', type);
      emit(MemorialLoaded(updated));
    } catch (e) {
      // ignore
    }
  }
}
