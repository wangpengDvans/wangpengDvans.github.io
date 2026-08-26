import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../domain/models/home_data.dart';
import '../../../domain/repositories/home_repository.dart';

class MockHomeRepository implements HomeRepository {
  @override
  Future<HomeData> loadHomeData({required String city}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final jsonString = await rootBundle.loadString('assets/mock/home_data.json');
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return HomeData.fromJson(json).copyWith(city: city);
  }
}

extension on HomeData {
  HomeData copyWith({String? city}) => HomeData(
        city: city ?? this.city,
        guideCompletedSteps: guideCompletedSteps,
        guideTotalSteps: guideTotalSteps,
        categories: categories,
        nearbyMerchants: nearbyMerchants,
      );
}
