import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../domain/models/tomb.dart';
import '../../../domain/repositories/tomb_repository.dart';

class MockTombRepository implements TombRepository {
  List<Tomb>? _tombs;

  Future<void> _loadData() async {
    if (_tombs != null) return;
    await Future.delayed(const Duration(milliseconds: 500));
    final jsonString = await rootBundle.loadString('assets/mock/cemeteries.json');
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    _tombs = (json['tombs'] as List<dynamic>)
        .map((e) => Tomb.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Tomb>> getAvailableTombs({String? city, String? status, String? sortBy}) async {
    await _loadData();
    var result = _tombs!;
    if (city != null) {
      result = result.where((t) => t.city == city).toList();
    }
    if (status != null && status != '全部') {
      result = result.where((t) => t.status == status).toList();
    }
    switch (sortBy) {
      case 'price_asc':
        result = List.of(result)..sort((a, b) => a.price.compareTo(b.price));
      case 'price_desc':
        result = List.of(result)..sort((a, b) => b.price.compareTo(a.price));
      case 'size':
        result = List.of(result)..sort((a, b) => b.size.compareTo(a.size));
    }
    return result;
  }

  @override
  Future<Tomb> getTombDetail(String id) async {
    await _loadData();
    return _tombs!.firstWhere((t) => t.id == id);
  }

  @override
  Future<List<String>> getCemeteryAreas(String cemeteryId) async {
    await _loadData();
    return _tombs!
        .where((t) => t.cemeteryId == cemeteryId)
        .map((t) => t.area)
        .toSet()
        .toList();
  }
}
