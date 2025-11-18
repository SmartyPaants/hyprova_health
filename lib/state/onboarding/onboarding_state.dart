import 'package:flutter/material.dart';

class OnboardingState extends ChangeNotifier {
  List<dynamic> selectedReasons = [];
  Map<String, dynamic> goals = {};
  // Map<String, dynamic> personalData = {};

  // Save reasons
  void setSelectedReasons(List<dynamic> reasons) {
    selectedReasons = reasons;
    notifyListeners();
  }

  // Save goals
  void setGoals(Map<String, dynamic> newGoals) {
    goals = newGoals;
    notifyListeners();
  }

  // // Save personal data
  // void setPersonalData(Map<String, dynamic> data) {
  //   personalData = data;
  //   notifyListeners();
  // }
}
