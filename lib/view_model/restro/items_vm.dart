import 'dart:io';

import 'package:dineease/data/repo/restro/item_repo.dart';
import 'package:dineease/model/restro/item.dart';
import 'package:flutter/material.dart';

class ItemViewModel extends ChangeNotifier {
  final ItemRepo _itemRepo = ItemRepo();

  List<Item> items = [];
  String errorMessage = '';

  Future<void> fetchItems() async {
    try {
      items = await _itemRepo.fetchItems();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> addItem(
    String name,
    String price,
    String description,
    File image,
    String category,
  ) async {
    try {
      await _itemRepo.addItem(name, price, description, image, category);
      items.add(
        Item(
          name: name,
          price: price,
          department: category,
          description: description,
          image:
              'https://www.creativefabrica.com/wp-content/uploads/2020/02/11/Food-Logo-Graphics-1-71-580x386.jpg',
        ),
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> editItem(String id, String name, String price,
      String description, File image, String category) async {
    try {
      await _itemRepo.editItem(id, name, price, description, image, category);
      final itemIndex = items.indexWhere((item) => item.id == int.parse(id));
      items[itemIndex].name = name;
      items[itemIndex].price = price;
      items[itemIndex].description = description;
      items[itemIndex].image =
          'https://www.creativefabrica.com/wp-content/uploads/2020/02/11/Food-Logo-Graphics-1-71-580x386.jpg';
      items[itemIndex].department = category;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _itemRepo.deleteItem(id);
      items.removeWhere((item) => item.id == int.parse(id));
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
