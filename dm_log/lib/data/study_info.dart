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

  String ubiStartTime = "";
  String beepTime = "";
  String observer = "";
  String techPerson = "";
  String ubiRunning = "Yes";
  String ubiEndTime = "";
  String picTaken = "No";
  String classDimensionUnchanged = "Yes";
  String trackStart = "";
  String trackEnd = "";
  String timeTracked = "";
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

  set setUbiStartTime(String value) {
    ubiStartTime = value;
    notifyListeners();
  }

  set setBeepTime(String value) {
    beepTime = value;
    notifyListeners();
  }

  set setObserver(String value) {
    observer = value;
    notifyListeners();
  }

  set setTechPerson(String value) {
    techPerson = value;
    notifyListeners();
  }

  set setUbiRunning(String value) {
    ubiRunning = value;
    notifyListeners();
  }

  set setUbiEndTime(String value) {
    ubiEndTime = value;
    notifyListeners();
  }

  set setPicTaken(String value) {
    picTaken = value;
    notifyListeners();
  }

  set setClassDimensionUnchanged(String value) {
    classDimensionUnchanged = value;
    notifyListeners();
  }

  set setTrackStart(String value) {
    trackStart = value;
    notifyListeners();
  }

  set setTrackEnd(String value) {
    trackEnd = value;
    notifyListeners();
  }

  set setTimeTracked(String value) {
    timeTracked = value;
    notifyListeners();
  }
}
