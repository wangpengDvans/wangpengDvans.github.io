import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../domain/models/order.dart';
import '../../../domain/repositories/order_repository.dart';

class MockOrderRepository implements OrderRepository {
  @override
  Future<List<Order>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 400));
    final jsonString = await rootBundle.loadString('assets/mock/orders.json');
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return (json['orders'] as List<dynamic>)
        .map((e) => Order.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
