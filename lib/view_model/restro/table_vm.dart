import 'package:dineease/data/repo/restro/table_repo.dart';
import 'package:dineease/model/restro/table.dart';
import 'package:flutter/material.dart' show ChangeNotifier;

class TableViewModel extends ChangeNotifier {
  final TableRepo _tableRepo = TableRepo();

  List<Table> tables = [];
  String errorMessage = '';

  Future<void> fetchTables() async {
    try {
      tables = await _tableRepo.fetchTables();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> addTable(String name, String capacity) async {
    try {
      await _tableRepo.addTable(name, capacity);
      tables.add(
        Table(
          id: tables.length + 1,
          number: name,
          seats: capacity.toString(),
          isOccupied: false,
        ),
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> editTable(String id, String name, String capacity) async {
    try {
      await _tableRepo.editTable(id, name, capacity);
      final tableIndex =
          tables.indexWhere((table) => table.id == int.parse(id));
      tables[tableIndex].number = name;
      tables[tableIndex].seats = capacity.toString();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteTable(String id) async {
    try {
      await _tableRepo.deleteTable(id);
      tables.removeWhere((table) => table.id == num.parse(id));
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> changeTableStatus(String id, bool isOccupied) async {
    try {
      await _tableRepo.changeTableStatus(id, isOccupied);
      final tableIndex =
          tables.indexWhere((table) => table.id == num.parse(id));
      tables[tableIndex].isOccupied = isOccupied;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
