import '../models/merchant.dart';
import '../models/service_package.dart';

abstract class MerchantRepository {
  Future<List<Merchant>> getNearbyMerchants({String? city, String? sortBy});
  Future<Merchant> getMerchantDetail(String id);
  Future<List<ServicePackage>> getMerchantPackages(String merchantId);
}
