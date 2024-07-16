import 'package:dineease/data/repo/restro/order_repo.dart';
import 'package:dineease/model/restro/item.dart';
import 'package:dineease/model/restro/order.dart';
import 'package:flutter/material.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepo _orderRepository = OrderRepo();

  final Map<String, int> _orderItems = {};
  Map<String, int> get orderItems => _orderItems;

  List<Order> orders = [];
  String errorMessage = '';

  Future<void> fetchOrders() async {
    try {
      orders = await _orderRepository.fetchOrders();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void addItemToOrder(String itemId, int quantity) {
    if (quantity == 0) {
      _orderItems.remove(itemId);
    } else {
      _orderItems[itemId] = quantity;
    }
    notifyListeners();
  }

  Future<void> placeOrder(int tableId, Map<Item, int> selectedItems) async {
    List<Map<String, dynamic>> orderItems = selectedItems.entries.map((entry) {
      return {
        'item': entry.key.id,
        'quantity': entry.value.toString(),
      };
    }).toList();

    return await _orderRepository.createOrder(tableId, orderItems);
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _orderRepository.updateOrderStatus(orderId, status);
    final orderIndex =
        orders.indexWhere((order) => order.id == num.parse(orderId));
    orders[orderIndex].status = status;
  }

  Future<void> deleteOrder(String orderId) async {
    await _orderRepository.deleteOrder(orderId);
    orders.removeWhere((order) => order.id == num.parse(orderId));
  }
}
