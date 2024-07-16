import 'package:dineease/data/repo/profile/profile_repo.dart';
import 'package:dineease/model/profile/profile.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepo _profileRepo = ProfileRepo();

  Profile user = Profile();
  String errorMessage = '';

  Future<void> fetchProfile() async {
    try {
      user = await _profileRepo.fetchProfile();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateProfile(Profile profile) async {
    try {
      await _profileRepo.updateProfile(profile);
      user = profile;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
