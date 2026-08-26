import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../domain/models/merchant.dart';
import '../../../domain/models/service_package.dart';
import '../../../domain/repositories/merchant_repository.dart';

class MockMerchantRepository implements MerchantRepository {
  List<Merchant>? _merchants;
  Map<String, List<ServicePackage>>? _packages;

  Future<void> _loadData() async {
    if (_merchants != null) return;
    await Future.delayed(const Duration(milliseconds: 600));
    final jsonString = await rootBundle.loadString('assets/mock/merchants.json');
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    _merchants = (json['merchants'] as List<dynamic>)
        .map((e) => Merchant.fromJson(e as Map<String, dynamic>))
        .toList();
    _packages = (json['packages'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(
        key,
        (value as List<dynamic>)
            .map((e) => ServicePackage.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
  }

  @override
  Future<List<Merchant>> getNearbyMerchants({String? city, String? sortBy}) async {
    await _loadData();
    var result = _merchants!;
    if (city != null) {
      result = result.where((m) => m.city == city).toList();
    }
    switch (sortBy) {
      case 'distance':
        result = List.of(result)..sort((a, b) => a.distance.compareTo(b.distance));
      case 'price':
      // Mock: sort by rating as proxy
        result = List.of(result)..sort((a, b) => a.rating.compareTo(b.rating));
      case 'rating':
        result = List.of(result)..sort((a, b) => b.rating.compareTo(a.rating));
    }
    return result;
  }

  @override
  Future<Merchant> getMerchantDetail(String id) async {
    await _loadData();
    return _merchants!.firstWhere((m) => m.id == id);
  }

  @override
  Future<List<ServicePackage>> getMerchantPackages(String merchantId) async {
    await _loadData();
    return _packages![merchantId] ?? [];
  }
}
