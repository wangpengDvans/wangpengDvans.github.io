import 'package:equatable/equatable.dart';

class Tomb extends Equatable {
  final String id;
  final String cemeteryId;
  final String cemeteryName;
  final String city;
  final String area;
  final String type;
  final String status;
  final double price;
  final double? finalPrice;
  final double size;
  final String? direction;
  final String? landscape;
  final bool hasVr;
  final bool hasPhoto;
  final List<String> tags;
  final List<String> features;
  final String? imageUrl;

  const Tomb({
    required this.id,
    required this.cemeteryId,
    required this.cemeteryName,
    required this.city,
    required this.area,
    required this.type,
    required this.status,
    required this.price,
    this.finalPrice,
    required this.size,
    this.direction,
    this.landscape,
    required this.hasVr,
    required this.hasPhoto,
    required this.tags,
    required this.features,
    this.imageUrl,
  });

  factory Tomb.fromJson(Map<String, dynamic> json) {
    return Tomb(
      id: json['id'] as String,
      cemeteryId: json['cemeteryId'] as String,
      cemeteryName: json['cemeteryName'] as String,
      city: json['city'] as String,
      area: json['area'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      price: (json['price'] as num).toDouble(),
      finalPrice: json['finalPrice'] != null ? (json['finalPrice'] as num).toDouble() : null,
      size: (json['size'] as num).toDouble(),
      direction: json['direction'] as String?,
      landscape: json['landscape'] as String?,
      hasVr: json['hasVr'] as bool,
      hasPhoto: json['hasPhoto'] as bool,
      tags: (json['tags'] as List<dynamic>).cast<String>(),
      features: (json['features'] as List<dynamic>).cast<String>(),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'cemeteryId': cemeteryId,
        'cemeteryName': cemeteryName,
        'city': city,
        'area': area,
        'type': type,
        'status': status,
        'price': price,
        'finalPrice': finalPrice,
        'size': size,
        'direction': direction,
        'landscape': landscape,
        'hasVr': hasVr,
        'hasPhoto': hasPhoto,
        'tags': tags,
        'features': features,
        'imageUrl': imageUrl,
      };

  @override
  List<Object?> get props => [
        id,
        cemeteryId,
        cemeteryName,
        city,
        area,
        type,
        status,
        price,
        finalPrice,
        size,
        direction,
        landscape,
        hasVr,
        hasPhoto,
        tags,
        features,
        imageUrl,
      ];
}
