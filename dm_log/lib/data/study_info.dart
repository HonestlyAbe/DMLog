import 'package:flutter/material.dart';

/// Represents detailed information about a study.
class StudyInfo extends ChangeNotifier {
  // Studyinfo constructor with default values for flexibility
  StudyInfo({
    this.studyName = "",
    List<String>? studyParticipants,
    List<String>? studyActivities,
    this.adultCount = 2,
    this.childCount = 3,
    List<String>? quickComments,
  })  : this.studyParticipants = studyParticipants ?? [],
        this.studyActivities = studyActivities ?? ["T", "A", "G", "F", "PC"],
        this.quickComments = quickComments ?? [];

  final String studyName;
  final List<String> studyParticipants;
  final List<String> studyActivities;
  final int adultCount;
  final int childCount;
  final List<String> quickComments;

  void addParticipant(String participant) {
    studyParticipants.add(participant);
    notifyListeners();
  }

  void removeParticipant(String participant) {
    studyParticipants.remove(participant);
    notifyListeners();
  }

  void addComment(String comment) {
    quickComments.add(comment);
    notifyListeners();
  }

  // Using Dart's built-in setter mechanism
  set studyName(String value) {
    this.studyName = value;
    notifyListeners();
  }

  set studyParticipants(List<String> values) {
    this.studyParticipants = values;
    notifyListeners();
  }

  set studyActivities(List<String> values) {
    this.studyActivities = values;
    notifyListeners();
  }

  set adultCount(int value) {
    this.adultCount = value;
    notifyListeners();
  }

  set childCount(int value) {
    this.childCount = value;
    notifyListeners();
  }
}
