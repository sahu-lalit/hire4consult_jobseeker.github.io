import 'package:flutter/material.dart';
import 'package:hire4consult/model/jobs_model/jobs_model.dart';

class JobsDropdownsController extends ChangeNotifier{
  String? selectedDepartment;
  String? selectedSpecialization;
  bool isSelectionMade = false;
  List<String> selectedSkills = [];
  List<String> selectedRegions = [];

  static List<String> department = [
    'Software Development',
    'HR',
    'Accounts',
    'Engineering',
    'Business Development',
    'Marketing',
    'Sales',
    'Operations'
  ];

  static List<String> specializations = [
    'Flutter',
    'Android',
    'React',
    'GO',
    'iOS',
    'Javascript',
    "HR Recruitment"
  ];

  static List<String> skills = [
    'bloc',
    'redux',
    'stripe',
    'viper architecture',
    'clean architecture',
    'mvvm',
    'api',
  ];

  static List<String> region = [
    'EMEA',
    'APAC',
    'NA',
    'LATAM',
  ];


  // Update selected department
  void updateDepartment(String? department) {
    selectedDepartment = department;
    _checkIfSelectionMade(); // Check if both dropdowns have been selected
  }

  // Update selected skill
  void updateSpecialization(String? specialization) {
    selectedSpecialization = specialization;
    _checkIfSelectionMade(); // Check if both dropdowns have been selected
  }

  // Private method to check if both dropdowns have been selected
  void _checkIfSelectionMade() {
    if (selectedDepartment != null && selectedSpecialization != null) {
      isSelectionMade = true;
    } else {
      isSelectionMade = false;
    }
    notifyListeners(); // Notify listeners to rebuild the UI
  }

   void toggleSkillSelection(String skill, bool isSelected) {
    if (isSelected) {
      selectedSkills.add(skill);
    } else {
      selectedSkills.remove(skill);
    }
    notifyListeners();
  }


    // Function to update the selected regions
  void updateRegions(List<String> newSelectedRegions) {
    selectedRegions = newSelectedRegions;
    notifyListeners();
  }
}
