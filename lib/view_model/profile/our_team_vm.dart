import 'dart:io';

import 'package:dineease/data/repo/profile/our_team_repo.dart';
import 'package:dineease/model/profile/team.dart';
import 'package:flutter/material.dart';

class OurTeamViewModel extends ChangeNotifier {
  final OurTeamRepo _teamRepo = OurTeamRepo();

  List<Team> teams = [];
  String errorMessage = '';

  Future<void> fetchTeams() async {
    try {
      teams = await _teamRepo.fetchTeams();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> addTeamMember(String name, File image, String role) async {
    try {
      await _teamRepo.addMember(name, image, role);
      teams.add(
        Team(
          id: 659,
          name: name,
          role: role,
          image: image.path,
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateTeamMember(
      String id, String name, File image, String description) async {
    try {
      await _teamRepo.updateMember(id, name, image, description);
      final index = teams.indexWhere((element) => element.id == int.parse(id));
      teams[index] = Team(
        id: int.parse(id),
        name: name,
        role: description,
        image: image.path,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteTeamMember(String id) async {
    try {
      await _teamRepo.deleteMember(id);
      teams.removeWhere((element) => element.id == int.parse(id));
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
