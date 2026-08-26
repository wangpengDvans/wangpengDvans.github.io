import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/order.dart';
import '../../../domain/repositories/order_repository.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrderRepository _repository;

  OrdersCubit(this._repository) : super(const OrdersLoading());

  Future<void> loadOrders() async {
    emit(const OrdersLoading());
    try {
      final orders = await _repository.getOrders();
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(const OrdersError('加载失败，请稍后重试'));
    }
  }
}
