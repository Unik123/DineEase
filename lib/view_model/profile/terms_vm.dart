import 'package:dineease/data/repo/profile/terms_repo.dart';
import 'package:dineease/model/profile/terms_condition.dart';
import 'package:flutter/material.dart';

class TACViewModel extends ChangeNotifier {
  final TermsRepo _termsRepo = TermsRepo();

  List<Terms> infos = [];
  String errorMessage = '';

  Future<void> fetchItems() async {
    try {
      infos = await _termsRepo.fetchterms();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
