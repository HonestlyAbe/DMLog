import 'dart:ffi';

import 'package:dm_log/data/participant_entry.dart';
import 'package:dm_log/data/study_info.dart';

/// Represents detailed information about a participant.
class ParticipantInfo {
  String name;
  String timeEntered;
  String altId;
  String lenaID;
  String lenaNum;
  String vestOn;
  String vestOff;
  bool lenaOff;
  String status;
  String ULeft;
  String URight;
  String notes;
  final StudyInfo study;
  final ParticipantEntry provider;
  ParticipantType type; // Adding enum for typ
  ParticipantInfo({
    required this.study,
    required this.provider,
    this.name = "",
    this.timeEntered = "",
    this.altId = "",
    this.lenaID = "",
    this.lenaNum = "",
    this.vestOn = "",
    this.vestOff = "",
    this.lenaOff = false,
    this.status = "",
    this.ULeft = "",
    this.URight = "",
    this.notes = "",
    this.type = ParticipantType.student,
  });



  /// Create a copy of this [ParticipantInfo] but with the given fields replaced with the new values.
  ParticipantInfo copyWith({
    String? name,
    String? timeEntered,
    String? altId,
    String? lenaID,
    String? lenaNum,
    String? vestOn,
    String? vestOff,
    bool? lenaOff,
    String? status,
    String? ULeft,
    String? URight,
    ParticipantType? type,
  }) {
    return ParticipantInfo(
      study: study,
      provider: provider,
      name: name ?? this.name,
      timeEntered: timeEntered ?? this.timeEntered,
      altId: altId ?? this.altId,
      lenaID: lenaID ?? this.lenaID,
      lenaNum: lenaNum ?? this.lenaNum,
      vestOn: vestOn ?? this.vestOn,
      vestOff: vestOff ?? this.vestOff,
      lenaOff: lenaOff ?? this.lenaOff,
      status: status ?? this.status,
      ULeft: ULeft ?? this.ULeft,
      URight: URight ?? this.URight,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return '[name: $name, timeEntered: $timeEntered, altId: $altId, type: ${type.toString().split('.').last}]';
  }
}

/// Defines the type of participant.
enum ParticipantType { student, adult }
