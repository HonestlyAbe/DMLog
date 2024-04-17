import 'package:flutter/material.dart';

/// Represents detailed information about a study.
class StudyInfo extends ChangeNotifier {
  // Studyinfo constructor with default values for flexibility
  StudyInfo({
    this.studyName = "",
    List<String>? studyParticipants,
    List<String>? studyActivities,
    List<String>? lenaIDs,
    this.adultCount = 2,
    this.childCount = 3,
    List<String>? quickComments,
  })  : this.studyParticipants = studyParticipants ?? [],
        this.studyActivities = studyActivities ?? ["T", "A", "G", "F", "PC"],
        this.lenaIDs = lenaIDs ?? ["1", "2", "3", "4", "5"],
        this.quickComments = quickComments ?? [];

  String studyName;
  List<String> studyParticipants;
  List<String> studyActivities;
  List<String> lenaIDs;
  int adultCount;
  int childCount;
  List<String> quickComments;

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
  set setStudyName(String value) {
    studyName = value;
    notifyListeners();
  }

  set setStudyParticipants(List<String> values) {
    studyParticipants = values;
    notifyListeners();
  }

  set setStudyActivities(List<String> values) {
    studyActivities = values;
    notifyListeners();
  }

  set setAdultCount(int value) {
    adultCount = value;
    notifyListeners();
  }

  set setChildCount(int value) {
    childCount = value;
    notifyListeners();
  }
}
