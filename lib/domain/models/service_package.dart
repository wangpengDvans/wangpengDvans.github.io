import 'package:equatable/equatable.dart';

class ServicePackage extends Equatable {
  final String id;
  final String name;
  final double price;
  final String? badge;
  final List<String> items;

  const ServicePackage({
    required this.id,
    required this.name,
    required this.price,
    this.badge,
    required this.items,
  });

  factory ServicePackage.fromJson(Map<String, dynamic> json) {
    return ServicePackage(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      badge: json['badge'] as String?,
      items: (json['items'] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'badge': badge,
        'items': items,
      };

  @override
  List<Object?> get props => [id, name, price, badge, items];
}
