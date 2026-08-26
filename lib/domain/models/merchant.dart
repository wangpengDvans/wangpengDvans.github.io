import 'package:equatable/equatable.dart';

class Merchant extends Equatable {
  final String id;
  final String name;
  final String city;
  final double distance;
  final double rating;
  final int reviewCount;
  final int servedCount;
  final String responseTime;
  final List<String> tags;
  final String? imageUrl;

  const Merchant({
    required this.id,
    required this.name,
    required this.city,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.servedCount,
    required this.responseTime,
    required this.tags,
    this.imageUrl,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      distance: (json['distance'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      servedCount: json['servedCount'] as int,
      responseTime: json['responseTime'] as String,
      tags: (json['tags'] as List<dynamic>).cast<String>(),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'city': city,
        'distance': distance,
        'rating': rating,
        'reviewCount': reviewCount,
        'servedCount': servedCount,
        'responseTime': responseTime,
        'tags': tags,
        'imageUrl': imageUrl,
      };

  @override
  List<Object?> get props => [id, name, city, distance, rating, reviewCount, servedCount, responseTime, tags, imageUrl];
}
