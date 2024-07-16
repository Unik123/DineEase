import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/network_api_services.dart';
import 'package:dineease/model/restro/payment.dart';

class PaymentRepo {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<List<Payment>> fetchPayments() async {
    try {
      final response = await _apiServices.getApi(AppUrl.payment);

      if (response is List<dynamic>) {
        return response.map((order) => Payment.fromJson(order)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }

  Future<void> postPayment(Payment payment) async {
    try {
      await _apiServices.postApi(
        payment.toJson(),
        AppUrl.payment,
      );
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }
}
