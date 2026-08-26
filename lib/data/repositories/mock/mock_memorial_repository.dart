import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../domain/models/memorial_profile.dart';
import '../../../domain/repositories/memorial_repository.dart';

class MockMemorialRepository implements MemorialRepository {
  MemorialProfile? _profile;

  Future<void> _loadData() async {
    if (_profile != null) return;
    await Future.delayed(const Duration(milliseconds: 500));
    final jsonString = await rootBundle.loadString('assets/mock/memorials.json');
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    _profile = MemorialProfile.fromJson(json);
  }

  @override
  Future<MemorialProfile> getMemorialProfile(String id) async {
    await _loadData();
    return _profile!;
  }

  @override
  Future<MemorialProfile> interact(String id, String type) async {
    await _loadData();
    switch (type) {
      case 'flower':
        _profile = _profile!.copyWith(flowerCount: _profile!.flowerCount + 1);
      case 'candle':
        _profile = _profile!.copyWith(candleCount: _profile!.candleCount + 1);
      case 'message':
        _profile = _profile!.copyWith(messageCount: _profile!.messageCount + 1);
      case 'share':
        _profile = _profile!.copyWith(shareCount: _profile!.shareCount + 1);
    }
    return _profile!;
  }
}
