import 'package:dineease/data/repo/restro/payment_repo.dart';
import 'package:dineease/model/restro/payment.dart';
import 'package:flutter/material.dart' show ChangeNotifier;

class PaymentViewModel extends ChangeNotifier {
  final PaymentRepo _paymentRepo = PaymentRepo();

  List<Payment> _payments = [];
  List<Payment> _filteredPayments = [];

  List<Payment> get payments => _filteredPayments;
  String errorMessage = '';

  Future<void> fetchPayments() async {
    try {
      _payments = await _paymentRepo.fetchPayments();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  bool isPaymentDone(int orderId) {
    bool isPresent = false;
    for (Payment payment in payments) {
      if (payment.order == orderId) {
        isPresent = true;
      }
    }
    return isPresent;
  }

  Future<void> addPayment(Payment payment) async {
    try {
      await _paymentRepo.postPayment(payment);
      payments.add(payment);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void setPayments(List<Payment> payments) {
    _payments = payments;
    _filteredPayments = payments;
    notifyListeners();
  }

  void filterPayments(String department, String period) {
    DateTime now = DateTime.now();
    DateTime startDate;

    switch (period) {
      case 'Today':
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case '7 days':
        startDate = now.subtract(const Duration(days: 7));
        break;
      case 'Monthly':
        startDate = DateTime(now.year, now.month, 1);
        break;
      case 'yearly':
        startDate = DateTime(now.year, 1, 1);
        break;
      default:
        startDate =
            DateTime(1970, 1, 1); // Default to all time if period is unknown
    }

    _filteredPayments = _payments.where((payment) {
      bool matchesDepartment =
          department == 'All' || payment.paymentMethod == department;
      bool matchesPeriod = payment.createdAt!.isAfter(startDate);
      return matchesDepartment && matchesPeriod;
    }).toList();

    notifyListeners();
  }
}
