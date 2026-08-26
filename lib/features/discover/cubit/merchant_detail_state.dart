part of 'merchant_detail_cubit.dart';

sealed class MerchantDetailState extends Equatable {
  const MerchantDetailState();

  @override
  List<Object?> get props => [];
}

final class MerchantDetailLoading extends MerchantDetailState {
  const MerchantDetailLoading();
}

final class MerchantDetailLoaded extends MerchantDetailState {
  final Merchant merchant;
  final List<ServicePackage> packages;

  const MerchantDetailLoaded({
    required this.merchant,
    required this.packages,
  });

  @override
  List<Object?> get props => [merchant, packages];
}

final class MerchantDetailError extends MerchantDetailState {
  final String message;

  const MerchantDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
