import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/network_api_services.dart';
import 'package:dineease/model/restro/order.dart';

class OrderRepo {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<List<Order>> fetchOrders() async {
    try {
      final response = await _apiServices.getApi(AppUrl.orders);

      if (response is List<dynamic>) {
        final List<Order> orders =
            response.map((order) => Order.fromJson(order)).toList();
        return orders;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }

  Future<void> createOrder(
      int tableId, List<Map<String, dynamic>> orderItems) async {
    await _apiServices.postApi(
      {
        'table': tableId,
        'status': 'placed ',
        'order_items': orderItems,
      },
      AppUrl.orders,
    );
  }

  Future<void> addOrderItems(
      String orderId, List<Map<String, dynamic>> itemsData) async {
    await _apiServices.postApi({
      'items': itemsData,
    }, '${AppUrl.orders}/$orderId/add_items/');
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _apiServices.patchApi({
      'status': status,
    }, '${AppUrl.orders}$orderId/');
  }

  Future<void> deleteOrder(String orderId) async {
    await _apiServices.deleteApi('${AppUrl.orders}$orderId/');
  }
}
