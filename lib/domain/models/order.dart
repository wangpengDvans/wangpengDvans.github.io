import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final String title;
  final String merchantName;
  final double amount;
  final String status;
  final String date;

  const Order({
    required this.id,
    required this.title,
    required this.merchantName,
    required this.amount,
    required this.status,
    required this.date,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      title: json['title'] as String,
      merchantName: json['merchantName'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'merchantName': merchantName,
        'amount': amount,
        'status': status,
        'date': date,
      };

  @override
  List<Object?> get props => [id, title, merchantName, amount, status, date];
}
