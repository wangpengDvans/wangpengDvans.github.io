import 'package:equatable/equatable.dart';
import 'merchant.dart';

class HomeData extends Equatable {
  final String city;
  final int guideCompletedSteps;
  final int guideTotalSteps;
  final List<Map<String, dynamic>> categories;
  final List<Merchant> nearbyMerchants;

  const HomeData({
    required this.city,
    required this.guideCompletedSteps,
    required this.guideTotalSteps,
    required this.categories,
    required this.nearbyMerchants,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      city: json['city'] as String,
      guideCompletedSteps: json['guideCompletedSteps'] as int,
      guideTotalSteps: json['guideTotalSteps'] as int,
      categories: (json['categories'] as List<dynamic>).cast<Map<String, dynamic>>(),
      nearbyMerchants: (json['nearbyMerchants'] as List<dynamic>)
          .map((e) => Merchant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'city': city,
        'guideCompletedSteps': guideCompletedSteps,
        'guideTotalSteps': guideTotalSteps,
        'categories': categories,
        'nearbyMerchants': nearbyMerchants.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [city, guideCompletedSteps, guideTotalSteps, categories, nearbyMerchants];
}
