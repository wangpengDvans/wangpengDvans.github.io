import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/merchant.dart';
import '../../../domain/models/service_package.dart';
import '../../../domain/repositories/merchant_repository.dart';

part 'merchant_detail_state.dart';

class MerchantDetailCubit extends Cubit<MerchantDetailState> {
  final MerchantRepository _repository;

  MerchantDetailCubit(this._repository) : super(const MerchantDetailLoading());

  Future<void> loadDetail(String merchantId) async {
    emit(const MerchantDetailLoading());
    try {
      final merchant = await _repository.getMerchantDetail(merchantId);
      final packages = await _repository.getMerchantPackages(merchantId);
      emit(MerchantDetailLoaded(merchant: merchant, packages: packages));
    } catch (e) {
      emit(const MerchantDetailError('加载失败，请稍后重试'));
    }
  }
}
