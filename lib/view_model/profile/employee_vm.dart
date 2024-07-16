import 'package:dineease/data/repo/restro/employee_repo.dart';
import 'package:dineease/model/restro/employee.dart';
import 'package:flutter/material.dart';

class EmployeeViewModel extends ChangeNotifier {
  final EmployeeRepo _repo = EmployeeRepo();

  List<Employee> employees = [];
  String errorMessage = '';

  Future<void> fetchEmployee() async {
    try {
      employees = await _repo.fetchEmployee();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> changeRole(String id, String role, bool isActive) async {
    try {
      await _repo.changeRole(id, role, isActive);
      final employeeIndex = employees.indexWhere((employee) => employee.id == num.parse(id));
      employees[employeeIndex].role = role;
      employees[employeeIndex].isActive = isActive;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
