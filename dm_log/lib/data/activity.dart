import 'package:dm_log/data/participant_provider.dart';
import 'package:flutter/material.dart';
import 'participant_provider.dart';
import 'activity_provider.dart';
import 'study_info.dart';
import 'package:uuid/uuid.dart';

class Activity {
  Activity({
    required this.provider,
    required this.study,
    required this.participants,
    this.timeStarted = "",
    this.timeEnded = "",
    Map<String, bool>? involved,
    this.type = "G",
    this.adultCount = 0,
    this.childCount = 0,
    this.comment = "",
    String? ID,
  })  : this.involved = involved ??
            Map.fromIterable(participants.participants, value: (v) => false),
        this.ID = ID ?? idGenerator();

  String timeStarted;
  String timeEnded;
  Map<String, bool> involved;
  String type;
  int adultCount;
  int childCount;
  String comment;
  final ParticipantProvider participants;
  final StudyInfo study;
  final ActivityProvider provider;
  String ID;

  static Activity defaultActivity(ActivityProvider provider, StudyInfo study, ParticipantProvider participants) {
    return Activity(
      provider: provider,
      study: study,
      participants: participants,
      // map participants.participants.map((p) => p.ID).toList() to true
      involved: Map.fromIterable(participants.participants.map((p) => p.name), value: (v) => true), 
      adultCount: participants.participants.where((p) => p.type == "adult").length,
      childCount: participants.participants.where((p) => p.type == "student").length,
      // set timeStarted to current time in HH:MM format
      timeStarted: "${DateTime.now().hour}:${DateTime.now().minute}",
    );
  }

  static Activity blankActivity(ActivityProvider provider, StudyInfo study) {
    return Activity(
      provider: provider,
      study: study,
      participants: ParticipantProvider(),
      timeStarted: "${DateTime.now().hour}:${DateTime.now().minute}",
    );
  }

  static String idGenerator() {
    var uuid = Uuid();
    return uuid.v4();
  }

  @override
  String toString() {
    return "\n[\n"
        "Time started: $timeStarted\n"
        "Time ended: $timeEnded\n"
        "Involved: $involved\n"
        "Type: $type\n"
        "Adult count: $adultCount\n"
        "Child count: $childCount\n"
        "Comment: $comment\n]";
  }
}
