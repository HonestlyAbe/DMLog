import 'package:flutter/material.dart';
import 'dart:io';

class StudyInfo extends ChangeNotifier {
  // Studyinfo constructor
  StudyInfo({
    required this.studyName,
    required this.studyParticipants,
    required this.studyActivities,
    required this.adultCount,
    required this.childCount,
    required this.quickComments,
  });

  // Studyinfo variables
  String studyName;
  List<String> studyParticipants;
  List<String> studyActivities;
  int adultCount;
  int childCount;
  List<String> quickComments;

  // Default studyinfo
  static StudyInfo defaultStudyInfo() {
    return StudyInfo(
        studyName: "",
        studyParticipants: [],
        studyActivities: ["T", "A", "G", "F", "PC"],
        adultCount: 2,
        childCount: 3,
        quickComments: []);
  }

  // Add participant to studyinfo
  void addParticipant(String participant) {
    studyParticipants.add(participant);
    notifyListeners();
  }

  // Remove participant from studyinfo
  void removeParticipant(String participant) {
    studyParticipants.remove(participant);
    notifyListeners();
  }

  // Add comment
  void addComment(String comment) {
    quickComments.add(comment);
    notifyListeners();
  }

  // Studyinfo setters
  setStudyName(String studyName) {
    this.studyName = studyName;
    notifyListeners();
  }

  setStudyParticipants(List<String> studyParticipants) {
    this.studyParticipants = studyParticipants;
    notifyListeners();
  }

  setStudyActivities(List<String> studyActivities) {
    this.studyActivities = studyActivities;
    notifyListeners();
  }

  setAdultCount(int adultCount) {
    this.adultCount = adultCount;
    notifyListeners();
  }

  setChildCount(int childCount) {
    this.childCount = childCount;
    notifyListeners();
  }
}
